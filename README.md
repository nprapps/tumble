TUMBLE
========================

* [What is this?](#what-is-this)
* [Assumptions](#assumptions)
* [What's in here?](#whats-in-here)
* [Install requirements](#install-requirements)
* [Run the project locally](#run-the-project-locally)
* [Editing workflow](#editing-workflow)
* [Template tags](#template-tags)
* [Render a theme for local development](#render-theme-local-development)
* [Render a theme for production](#render-theme-production)

What is this?
-------------

Tumble is a project for managing the themes/static files behind our fleet of flat Tumblogs, e.g., the ones not backed by user-submission.

Specifically, Tumble maintains a folder containing static files for each Tumblr, based on a Google document. This document also contains a sheet for each Tumblr holding all of the relevant copytext.

Tumble will generate appropriate Tumblr theme files based on your desired deployment target and handle compressing/injecting dependencies like CSS/JS and images.

Assumptions
-----------

The following things are assumed to be true in this documentation.

* You are running OSX.
* You are using Python 2.7. (Probably the version that came OSX.)
* You have [virtualenv](https://pypi.python.org/pypi/virtualenv) and [virtualenvwrapper](https://pypi.python.org/pypi/virtualenvwrapper) installed and working.

What's in here?
---------------

The project contains the following folders and important files:

* ``data`` -- Data files, such as those used to generate HTML. Copy from the Google doc is written here.
* ``etc`` -- Miscellaneous scripts and metadata for project bootstrapping.
``less`` -- Contains the base app.less for our Tumblrs.
* ``tumblrs`` -- A folder for each Tumblog, named by its slug, containing an app.less, an app.js, some required javascript (Modernizr and a video plugin), and a template.html.tpl that will be rendered into a Tumblr template.
* ``templates`` -- HTML ([Jinja2](http://jinja.pocoo.org/docs/)) templates, to be compiled locally. Contains the base template.html.tpl.
* ``www`` -- Static and compiled assets to be deployed. (a.k.a. "the output") Contains the base JS files.
* ``app.py`` -- A [Flask](http://flask.pocoo.org/) app for rendering the project locally.
* ``app_config.py`` -- Global project configuration for scripts, deployment, etc.
* ``copytext.py`` -- Code supporting the [Editing workflow](#editing-workflow)
* ``fabfile.py`` -- [Fabric](http://docs.fabfile.org/en/latest/) commands automating setup and deployment.
* ``render_utils.py`` -- Code supporting template rendering.
* ``requirements.txt`` -- Python requirements.

Install requirements
--------------------

Node.js is required for the static asset pipeline. If you don't already have it, get it like this:

```
brew install node
curl https://npmjs.org/install.sh | sh
```

Then, clone the repository.
```
git clone git@github.com:nprapps/tumble.git
cd tumble
```

Next, install the project requirements:
```
npm install less universal-jst -g --prefix node_modules
mkvirtualenv tumble
pip install -r requirements.txt
```

Finally, bootstrap the app. This command will read the Google doc and create folders with base files for each Tumblr that doesn't already have a folder and files.
```
fab bootstrap
```

Project secrets
---------------

Project secrets should **never** be stored in ``app_config.py`` or anywhere else in the repository. They will be leaked to the client if you do. Instead, always store passwords, keys, etc. in environment variables and document that they are needed here in the README.

Run the project locally
-----------------------

A flask app is used to run the project locally. It will automatically recompile templates and assets on demand.

```
workon tumble
./app.py
```

Visit ``localhost:8000/<tumblr-slug>/index.html`` in your browser. Here's Ari Shapiro's Tumblog: [localhost:8000/ari-whitehouse/index.html](http://localhost:8000/ari-whitehouse/index.html).

Editing workflow
-------------------

The app is rigged up to Google Docs for a simple key/value store that provides an editing workflow.

View the sample copy spreadsheet [here](https://docs.google.com/spreadsheet/pub?key=0AlXMOHKxzQVRdHZuX1UycXplRlBfLVB0UVNldHJYZmc#gid=0). A few things to note:

* If there is a column called ``key``, there is expected to be a column called ``value`` and rows will be accessed in templates as key/value pairs
* Rows may also be accessed in templates by row index using iterators (see below)
* You should have one worksheet per Tumblog, named for the Tumblog's slug, e.g., ari-whitehouse.
* This document must be "published to the web" using Google Docs' interface

This document is specified in ``app_config`` with the variable ``COPY_GOOGLE_DOC_KEY``. To use your own spreadsheet, change this value to reflect your document's key (found in the Google Docs URL after ``&key=``).

The app template is outfitted with a few ``fab`` utility functions that make pulling changes and updating your local data easy.

To update the latest document, simply run:

```
fab update_copy
```

Note: ``update_copy`` runs automatically whenever ``fab render`` is called.

At the Tumblr template level, you can embed copytext like this:

```{{ copy.key_that_i_want }}```

In this case, ``copy`` is the slug of the current Tumblog, and ``key_that_i_want`` is the value of the first column.

Template tags
--------------
You'll have two basic needs for injecting content into the Tumblr theme.

First, you might want to inject a static file, e.g., CSS/JS or a PNG image from the Tumblr's folder. You can do that with the ``{{ static }}`` template tag. To inject an image called ``header.png``, copy that image into the ``tumblrs/<tumblr-slug>/`` folder and then add a template tag in the template like this: ``{{ static['header.png'] }}``. This template tag will insert a reference to localhost if you're developing locally, or it will insert a rendered out version of the file if you're preparing for production.

Second, you might want a key/value from this Tumblr's sheet in the Google doc. You can do that with the ``{{ copy }}`` template tag. To inject a key called ``og_description`` containing the social media description for this Tumblr, add the key/value you want to the correct Google doc sheet. Then, use this tag: ``{{ copy.og_description }}``. You can also use ``{{ copy['og_description'] }}`` if you have a key with a ``.`` in the name.

Render a theme for local development
-------------------------------------
To render a theme for local development, you'll just do:

```fab copy_theme:<tumblr_slug>```.

For example, to create a local development theme for Ari's Tumblr, you'd do this:

```fab copy_theme:ari-whitehouse```.

This will create a Tumblr theme file (and paste it to your clipboard, natch) that you can paste into Tumblr's admin. The CSS and JS will point to your local app.less and app.js, so you can develop against the Tumblr URL but with local assets.

Render a theme for production
------------------------------
To render a theme for production, you'll just do:

```fab production copy_theme:<tumblr_slug>```.

For example, to create a production theme for Ari's Tumblr, you'd do this:

```fab production copy_theme:ari-whitehouse```.

This will create a Tumblr theme file (and paste it to your clipboard, natch) that you can paste into Tumblr's admin. The CSS and JS will be fully baked into the Template HTML. Images will be baked as base64 strings and CSS/JS files will be rendered and inserted as ``<script>`` and ``<style>`` tags.