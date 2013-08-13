#!/usr/bin/env python

import base64
from glob import glob
import json
from mimetypes import guess_type
import os
import urllib

from flask import Flask, Markup, abort, render_template_string

import app_config
import copytext
from render_utils import flatten_app_config

app = Flask(app_config.PROJECT_NAME)


# Render tumblr theme
@app.route('/<string:slug>/index.html')
def _render_tumblr_theme(slug):
    """
    Render out the tumblr theme.
    When handled as an URL, gets target=None.
    When called from fabfile as part of render(),
    gets target from env.settings.

    production: Renders files inline.
    staging/development: Points files to 127.0.0.1

    Available in the template two ways:
    {{ static['file.extension'] }} for static files.
    {{ copy.key_name }} for bits of copy. Key name is the first column's value.
    """

    # Set up context bits.
    context = flatten_app_config()

    # For files in the tumblrs/<slug>/ folder.
    context['static'] = {}

    # For copytext.
    context['copy'] = {}

    # Loop over the copy in the sheet named for the slug.
    # Append it like it's a dict.
    for item in copytext.Copy()[slug]:
        context['copy'][item.key] = item.value

    # Loop over a few common file extensions.
    for extension in ['*.js', '*.css', '*.png']:

        # Loop over the globbed files in the directory matching this extension.
        for path in glob('tumblrs/%s/%s' % (slug, extension)):

            # Get the filename.
            filename = path.split('/')[2]

            # If it's production, we're going to just embed the stuff directly in the template.
            if app_config.DEPLOYMENT_TARGET == 'production':

                # Here's how we'll do that.
                template = {
                    '*.js': '<script type="text/javascript">%s</script>',
                    '*.css': '<style type="text/css">%s</style>',
                    '*.png': '<img src="data:image/png;base64,%s" />',
                }

                # Open the file as binary.
                with open(path, "rb") as readfile:

                    # If it's a PNG, base64 encode it.
                    if extension == '*.png':
                        output = base64.b64encode(readfile.read())
                    else:

                        # Otherwise, just read it to a string.
                        output = readfile.read()

                # Append the output to context via the template lookup.
                context['static'][filename] = template[extension] % output

            else:
                # If it's not production, do things slightly differently.
                # Point to app_config.S3_BASE_URL instead.
                template = {
                    '*.js': '<script src="%s/%s"></script>' % (app_config.S3_BASE_URL, path.replace('tumblrs/', '')),
                    '*.css': '<link rel="stylesheet" href="%s/%s" />' % (app_config.S3_BASE_URL, path.replace('tumblrs/', '')),
                    '*.png': '<img src="%s/%s" />' % (app_config.S3_BASE_URL, path.replace('tumblrs/', '')),
                }

                # Append the path to the context.
                context['static'][filename] = template[extension]

    # Open the theme's file.
    with open('tumblrs/%s/theme.html.tpl' % slug, 'rb') as readfile:
        template_string = readfile.read()

    # Render the template.
    return render_template_string(template_string, **context)


# Render a less file in the <slug> directory.
# This is a bit tricky because the browser asks for .less.css
# and we need to compile that file first because it may not
# exist yet.
@app.route('/<string:slug>/<string:filename>.less.css')
def _less(slug, filename):

    # Get the path to the less file.
    lessfile = 'tumblrs/%s/%s.less' % (slug, filename)

    # Try opening it. 404 if this fails.
    try:
        with open(lessfile, 'rb') as readfile:
            pass
    except IOError:
        abort(404)

    # Call lessc and compile this file to CSS.
    os.system('node_modules/bin/lessc %s %s' % (lessfile, lessfile + '.css'))

    # Read the compiled CSS file.
    with open(lessfile + '.css', 'rb') as readfile:
        output = readfile.read()

    # Return the file as a CSS file.
    return output, 200, {'Content-Type': 'text/css'}


# Render JST templates on-demand
@app.route('/js/templates.js')
def _templates_js():
    r = envoy.run('node_modules/.bin/jst --template underscore jst')

    return r.std_out, 200, {'Content-Type': 'application/javascript'}


# Render application configuration
@app.route('/js/app_config.js')
def _app_config_js():
    config = flatten_app_config()
    js = 'window.APP_CONFIG = ' + json.dumps(config)

    return js, 200, {'Content-Type': 'application/javascript'}


# Render copytext
@app.route('/js/copy.js')
def _copy_js():
    copy = 'window.COPY = ' + copytext.Copy().json()

    return copy, 200, {'Content-Type': 'application/javascript'}


# Server arbitrary static files on-demand
@app.route('/<path:path>')
def _static(path):
    try:
        with open('tumblrs/%s' % path) as f:
            return f.read(), 200, {'Content-Type': guess_type(path)[0]}
    except IOError:
        abort(404)


@app.template_filter('urlencode')
def urlencode_filter(s):
    """
    Filter to urlencode strings.
    """
    if type(s) == 'Markup':
        s = s.unescape()

    s = s.encode('utf8')
    s = urllib.quote_plus(s)

    return Markup(s)


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument('-p', '--port')
    args = parser.parse_args()
    server_port = 8000

    if args.port:
        server_port = int(args.port)

    app.run(host='0.0.0.0', port=server_port, debug=app_config.DEBUG)
