#!/usr/bin/env python

import base64
import json
from mimetypes import guess_type
import os
import urllib

from flask import Flask, Markup, abort, render_template_string

import app_config
import copytext
from render_utils import flatten_app_config

app = Flask(app_config.PROJECT_NAME)


@app.context_processor
def static_processor():
    def static(file_path=None, classes='', alt=''):
        """
        Builds a context processor for handling static file embeds.

        {{ static(file_path="foo.js", classes="foo bar") }}

        Will find foo.js in the correct tumblrs/ directory and either
        embed a reference to 127.0.0.1:8000 (S3_BASE_URL) or embed
        the file itself if this is production.
        """
        # Request context is a global. Weird, huh?
        from flask import request

        # Get the path to the file's directory from the URL.
        path = 'tumblrs/' + request.path.split('/')[1]

        # Get the file extension.
        extension = file_path.split('.')[-1]

        # Make the file path the actual filesystem path to the file.
        file_path = path + '/' + file_path

        # If it's production, we're going to just embed the stuff directly in the template.
        if app_config.DEPLOYMENT_TARGET == 'production':

            # Here's how we'll do that.
            template = {
                'js': '<script type="text/javascript">%s</script>',
                'css': '<style type="text/css">%s</style>',
                'png': '<img class="%s" alt="%s" src="data:image/png;base64,%s" />',
            }

            # Open the file as binary.
            with open(file_path, "rb") as readfile:

                # If it's a PNG, base64 encode it.
                if extension == '*.png':
                    output = base64.b64encode(readfile.read())
                else:

                    # Otherwise, just read it to a string.
                    output = readfile.read()

            # Handle which strings need to get interpolated.
            strings = output

            # If it's an image, it needs classes and alt.
            if extension == 'png':
                strings = (classes, alt, output)

            # Send it to the template.
            return template[extension] % strings

        else:
            # If it's not production, do things slightly differently.
            # Point to app_config.S3_BASE_URL instead.
            template = {
                'js': '<script src="%s/%s"></script>' % (app_config.S3_BASE_URL, file_path.replace('tumblrs/', '')),
                'css': '<link rel="stylesheet" href="%s/%s" />' % (app_config.S3_BASE_URL, file_path.replace('tumblrs/', '')),
                'png': '<img class="%s" alt="%s" src="%s/%s" />' % (classes, alt, app_config.S3_BASE_URL, file_path.replace('tumblrs/', '')),
            }

            # Send it to the template.
            return template[extension]

    return dict(static=static)


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

    {{ copy.key_name }} for bits of copy. Key name is the first column's value.
    """

    # Set up context bits.
    context = flatten_app_config()

    # For copytext.
    context['copy'] = {}

    # Loop over the copy in the sheet named for the slug.
    # Append it like it's a dict.
    for item in copytext.Copy()[slug]:
        context['copy'][item.key] = item.value

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
