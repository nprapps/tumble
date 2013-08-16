#!/usr/bin/env python

import copy
from glob import glob
import os

from fabric.api import *
from jinja2 import Template

import app
import app_config
import copytext
from etc import github

"""
Base configuration
"""
env.user = app_config.SERVER_USER
env.forward_agent = True

env.hosts = []
env.settings = None

"""
Environments

Changing environment requires a full-stack test.
An environment points to both a server and an S3
bucket.
"""
def production():
    """
    Run as though on production.
    """
    env.settings = 'production'
    app_config.configure_targets(env.settings)
    env.hosts = app_config.SERVERS

def staging():
    """
    Run as though on staging.
    """
    env.settings = 'staging'
    app_config.configure_targets(env.settings)
    env.hosts = app_config.SERVERS

def development():
    env.settings = 'development'
    app_config.configure_targets(None)
    env.hosts = app_config.SERVERS

"""
Fabcasting! Run commands on the remote server.
"""
def fabcast(command):
    """
    Actually run specified commands on the server specified
    by staging() or production().
    """
    require('settings', provided_by=[production, staging])

    if not app_config.DEPLOY_TO_SERVERS:
        print 'You must set DEPLOY_TO_SERVERS = True in your app_config.py and setup a server before fabcasting..'

        return

    run('cd %s && bash run_on_server.sh fab %s $DEPLOYMENT_TARGET %s' % (app_config.SERVER_REPOSITORY_PATH, env.branch, command))

"""
Branches

Changing branches requires deploying that branch to a host.
"""
def stable():
    """
    Work on stable branch.
    """
    env.branch = 'stable'

def master():
    """
    Work on development branch.
    """
    env.branch = 'master'

def branch(branch_name):
    """
    Work on any specified branch.
    """
    env.branch = branch_name

"""
Template-specific functions

Changing the template functions should produce output
with fab render without any exceptions. Any file used
by the site templates should be rendered by fab render.
"""
def less(initial_path=None):
    """
    Render LESS files to CSS.
    """
    if initial_path:
        glob_string = 'tumblrs/%s/*.less' % initial_path
    else:
        glob_string = 'less/*.less'

    for path in glob(glob_string):
        filename = os.path.split(path)[-1]
        name = os.path.splitext(filename)[0]
        out_path = '%s.css' % path

        local('node_modules/bin/lessc %s %s' % (path, out_path))

def jst():
    """
    Render Underscore templates to a JST package.
    """
    local('node_modules/bin/jst --template underscore jst www/js/templates.js')

def download_copy():
    """
    Downloads a Google Doc as an .xls file.
    """
    base_url = 'https://docs.google.com/spreadsheet/pub?key=%s&output=xls'
    doc_url = base_url % app_config.COPY_GOOGLE_DOC_KEY
    local('curl -o data/copy.xls "%s"' % doc_url)

def update_copy():
    """
    Fetches the latest Google Doc and updates local JSON.
    """
    download_copy()

def app_config_js():
    """
    Render app_config.js to file.
    """
    from app import _app_config_js

    response = _app_config_js()
    js = response[0]

    local('mkdir -p www/js')
    with open('www/js/app_config.js', 'wb') as f:
        f.write(js)

def copy_js():
    """
    Render copy.js to file.
    """
    from app import _copy_js

    response = _copy_js()
    js = response[0]

    with open('www/js/copy.js', 'w') as f:
        f.write(js)

def render(slug=None):
    """
    Render out all (or one) of the slugged tumblrs.
    If a slug is passed (render:tumblr-slug) will limit to a single folder.
    """

    # Need to know what you want.
    # Staging/development point to localhost.
    # Production bakes files into the template.
    require('settings', provided_by=[production, staging, development])

    # Better update copy. The first sheet contains all of the tumblrs we know of.
    update_copy()

    # Prepare a list of slugs to render.
    slugs = []

    # If there's just one slug, add it to the list.
    if slug:
        slugs.append(slug)

    # If there's no slug specified, loop over the copytext's 'tumblr-index' sheet
    # and append the slugs to our list.
    if not slug:
        for row in copytext.Copy()['tumblr-index']:
            slugs.append(str(row.value))

    # Please, God, let us have slugs.
    if len(slugs) > 0:

        # Loop over the list of slug.s
        for slug in slugs:

            # Run less() against the folder. Important for those CSS/LESS files.
            less(initial_path="%s" % slug)

            # Flask is fun. We need to create a fake request with the appropriate path.
            # Then, we can call the view.
            with app.app.test_request_context(path=slug):

                # Grab the _render_tumblr_theme view.
                view = app.__dict__['_render_tumblr_theme']

                # Pass the slug and get the response.
                content = view(slug)

                # Write the response to a file in the tumbrs/<slug>/ directory.
                # Always be encoding.
                with open('tumblrs/%s/theme.html' % slug, 'wb') as writefile:
                    writefile.write(content.encode('utf-8'))

"""
Setup

Changing setup commands requires a test deployment to a server.
Setup will create directories, install requirements and set up logs.
"""
def setup_server():
    """
    Setup servers for deployment.

    NB: This does not setup services or push to S3. Run deploy() next.
    """
    require('settings', provided_by=[production, staging])
    require('branch', provided_by=[stable, master, branch])

    if not app_config.DEPLOY_TO_SERVERS:
        print 'You must set DEPLOY_TO_SERVERS = True in your app_config.py before setting up the servers.'

        return

    setup_directories()
    setup_virtualenv()
    clone_repo()
    checkout_latest()
    install_requirements()
    create_log_file()

def setup_directories():
    """
    Create server directories.
    """
    require('settings', provided_by=[production, staging])

    run('mkdir -p %(SERVER_PROJECT_PATH)s' % app_config.__dict__)
    run('mkdir -p /var/www/uploads/%(PROJECT_FILENAME)s' % app_config.__dict__)

    sudo('chmod -R 777 /var/www/uploads')
    run('mkdir -p /var/www/uploads/%(PROJECT_FILENAME)s' % app_config.__dict__)

def setup_virtualenv():
    """
    Setup a server virtualenv.
    """
    require('settings', provided_by=[production, staging])

    run('virtualenv -p %(SERVER_PYTHON)s --no-site-packages %(SERVER_VIRTUALENV_PATH)s' % app_config.__dict__)
    run('source %(SERVER_VIRTUALENV_PATH)s/bin/activate' % app_config.__dict__)

def clone_repo():
    """
    Clone the source repository.
    """
    require('settings', provided_by=[production, staging])

    run('git clone %(REPOSITORY_URL)s %(SERVER_REPOSITORY_PATH)s' % app_config.__dict__)

    if app_config.REPOSITORY_ALT_URL:
        run('git remote add bitbucket %(REPOSITORY_ALT_URL)s' % app_config.__dict__)

def checkout_latest(remote='origin'):
    """
    Checkout the latest source.
    """
    require('settings', provided_by=[production, staging])
    require('branch', provided_by=[stable, master, branch])

    run('cd %s; git fetch %s' % (app_config.SERVER_REPOSITORY_PATH, remote))
    run('cd %s; git checkout %s; git pull %s %s' % (app_config.SERVER_REPOSITORY_PATH, env.branch, remote, env.branch))

def install_requirements():
    """
    Install the latest requirements.
    """
    require('settings', provided_by=[production, staging])

    run('%(SERVER_VIRTUALENV_PATH)s/bin/pip install -U -r %(SERVER_REPOSITORY_PATH)s/requirements.txt' % app_config.__dict__)
    run('cd %(SERVER_REPOSITORY_PATH)s; npm install less universal-jst -g --prefix node_modules' % app_config.__dict__)

def uninstall_crontab():
    """
    Remove a previously install cron jobs script from cron.d
    """
    require('settings', provided_by=[production, staging])

    sudo('rm /etc/cron.d/%(PROJECT_FILENAME)s' % app_config.__dict__)

def bootstrap_issues():
    """
    Bootstraps Github issues with default configuration.
    """
    auth = github.get_auth()
    github.delete_existing_labels(auth)
    github.create_labels(auth)
    github.create_tickets(auth)
    github.create_milestones(auth)

"""
Bits about the Tumblr theme.
"""

def copy_theme(slug):
    require('settings', provided_by=[production, staging, development])

    render(slug)
    local('pbcopy < tumblrs/%s/theme.html' % slug)

def deploy(remote='origin'):
    """
    Deploy the latest app to S3 and, if configured, to our servers.
    """
    require('settings', provided_by=[production, staging])

    if app_config.DEPLOY_TO_SERVERS:
        require('branch', provided_by=[stable, master, branch])

    if (app_config.DEPLOYMENT_TARGET == 'production' and env.branch != 'stable'):
        _confirm("You are trying to deploy the '%s' branch to production.\nYou should really only deploy a stable branch.\nDo you know what you're doing?" % env.branch)

    if app_config.DEPLOY_TO_SERVERS:
        checkout_latest(remote)

        if app_config.DEPLOY_CRONTAB:
            install_crontab()

        if app_config.DEPLOY_SERVICES:
            deploy_confs()

    render()
    _gzip_www()
    _deploy_to_s3()

def bootstrap():
    """
    If they don't exist, create/copy the files for this tumblog.
    """
    update_copy()
    for row in copytext.Copy()['tumblr-index']:
        local('mkdir -p tumblrs/%s' % row.value)

        for path, filename in [
            ('www/js', 'app.js'),
            ('www/js/lib', 'modernizr.js'),
            ('www/js/lib', 'jquery.fitvids.js'),
            ('less', 'app.less'),
            ('templates', 'theme.html.tpl'),
        ]:
            try:
                with open('tumblrs/%s/%s' % (row.value, filename)):
                    pass
            except IOError:
                local('cp %s/%s tumblrs/%s/%s' % (path, filename, row.value, filename))

"""
Destruction

Changes to destruction require setup/deploy to a test host in order to test.
Destruction should remove all files related to the project from both a remote
host and S3.
"""
def _confirm(message):
    answer = prompt(message, default="Not at all")

    if answer.lower() not in ('y', 'yes', 'buzz off', 'screw you'):
        exit()

def shiva_the_destroyer():
    """
    Deletes the app from s3
    """
    require('settings', provided_by=[production, staging])

    _confirm("You are about to destroy everything deployed to %s for this project.\nDo you know what you're doing?" % app_config.DEPLOYMENT_TARGET)

    with settings(warn_only=True):
        s3cmd = 's3cmd del --recursive %s'

        for bucket in app_config.S3_BUCKETS:
            local(s3cmd % ('s3://%s/%s' % (bucket, app_config.PROJECT_SLUG)))

        if app_config.DEPLOY_TO_SERVERS:
            run('rm -rf %(SERVER_PROJECT_PATH)s' % app_config.__dict__)

            if app_config.DEPLOY_CRONTAB:
                uninstall_crontab()

            if app_config.DEPLOY_SERVICES:
                nuke_confs()

"""
App-template specific setup. Not relevant after the project is running.
"""
def app_template_bootstrap(project_name=None, repository_name=None):
    """
    Execute the bootstrap tasks for a new project.
    """
    config_files = ' '.join(['PROJECT_README.md', 'app_config.py'])

    config = {}
    config['$NEW_PROJECT_SLUG'] = os.getcwd().split('/')[-1]
    config['$NEW_PROJECT_NAME'] = project_name or config['$NEW_PROJECT_SLUG']
    config['$NEW_REPOSITORY_NAME'] = repository_name or config['$NEW_PROJECT_SLUG']
    config['$NEW_PROJECT_FILENAME'] = config['$NEW_PROJECT_SLUG'].replace('-', '_')

    _confirm("Have you created a Github repository named \"%s\"?" % config['$NEW_REPOSITORY_NAME'])

    for k, v in config.items():
        local('sed -i "" \'s|%s|%s|g\' %s' % (k, v, config_files))

    local('rm -rf .git')
    local('git init')
    local('mv PROJECT_README.md README.md')
    local('rm *.pyc')
    local('git add * .gitignore')
    local('git commit -am "Initial import from app-template."')
    local('git remote add origin https://github.com/nprapps/%s.git' % config['$NEW_REPOSITORY_NAME'])
    local('git push -u origin master')

    local('npm install less universal-jst -g --prefix node_modules')

    update_copy()
