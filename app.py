#!/usr/bin/env python

import base64
from glob import glob
import json
from mimetypes import guess_type
import urllib

import envoy
from flask import Flask, Markup, abort, render_template_string

import app_config
import copytext
from render_utils import flatten_app_config

app = Flask(app_config.PROJECT_NAME)


# Render tumblr theme
@app.route('/<string:slug>/index.html')
def _render_tumblr_theme(slug, target=None):
    """
    Render out the tumblr theme.
    When handled as an URL, gets target=None.
    When called from fabfile as part of render(),
    gets target from env.settings.

    production: Renders files inline.
    staging/development: Points files to 127.0.0.1
    """
    context = flatten_app_config()
    context['static'] = {}
    context['copy'] = {}

    for item in copytext.Copy()[slug]:
        context['copy'][item.key] = item.value

    for extension in ['*.js', '*.css', '*.png']:
        for path in glob('tumblrs/%s/%s' % (slug, extension)):
            filename = path.split('/')[2]
            if target == 'production':
                template = {
                    '*.js': '<script type="text/javascript">%s</script>',
                    '*.css': '<style type="text/css">%s</style>',
                    '*.png': '<img src="data:image/png;base64,%s" />',
                }
                with open(path, "rb") as readfile:
                    if extension == '*.png':
                        output = base64.b64encode(readfile.read())
                    else:
                        output = readfile.read()
                context['static'][filename] = template[extension] % output

            else:
                template = {
                    '*.js': '<script src="http://127.0.0.1:8000/%s"></script>"' % path.replace('tumblrs/', ''),
                    '*.css': '<link rel="stylesheet" href="http://127.0.0.1:8000/%s" />' % path.replace('tumblrs/', ''),
                    '*.png': '<img src="http://127.0.0.1:8000/%s" />' % path.replace('tumblrs/', ''),
                }
                context['static'][filename] = template[extension]

    with open('tumblrs/%s/theme.html.tpl' % slug, 'rb') as readfile:
        template_string = readfile.read()

    return render_template_string(template_string, **context)

# Render LESS files on-demand
@app.route('/<string:slug>/<string:filename>.less.css')
def _less(slug, filename):
    lessfile = 'tumblrs/%s/%s.less' % (slug, filename)

    try:
        with open(lessfile, 'rb') as readfile:
            pass
    except IOError:
        abort(404)

    r = envoy.run('node_modules/bin/lessc %s %s' % (lessfile, lessfile + '.css'))

    with open(lessfile + '.css', 'rb') as readfile:
        output = readfile.read()

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
