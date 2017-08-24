Copyright 2013 NPR.  All rights reserved.  No part of these materials may be reproduced, modified, stored in a retrieval system, or retransmitted, in any form or by any means, electronic, mechanical or otherwise, without prior written permission from NPR.

(Want to use this code? Send an email to nprapps@npr.org!)

TUMBLE
========================

* [What is this?](#what-is-this)
* [Assumptions](#assumptions)
* [What's in here?](#whats-in-here)
* [Install requirements](#install-requirements)
* [Editing workflow](#editing-workflow)
* [Run the project locally](#run-the-project-locally)
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

Editing workflow
-------------------

**1. If this is a completely new project, create your Tumblog account(s).**

Create staging and production Tumblr accounts for your project in the following order:

* Create a new Tumblr account with a staging account name (for example, `staging-ari-whitehouse`).

* In the account settings, require a password to be able to view the page.

* Create a new Tumblr on this account for your production account name (for example, `ari-whitehouse`). This is the account that the public will actually see.

* You can invite multiple users to contribute to your production Tumblog (but not the staging one). Use this to manage contributors (rather than have everyone share the same login).

* Make note of the URLs and login information for the staging and production accounts.

**2. Define your project in the [Google Spreadsheet](https://docs.google.com/spreadsheets/d/1Ez-ttHoLvD8bNrlhh-kSvrDWNlgxBpLSHkEBntilMhY/edit#gid=0).**

* In the sheet `tumblr-index`: Add the project's name -- ideally the Tumblr account name, but it doesn't have to be (for example, `ari-whitehouse`) -- to both the `key` and `value` columns. This will be used to create folders that will hold assets for this project. (More on this further down.)

* Optionally, you can use this Google Spreadsheet to store key/value text related to this project, which you can then reference in your template. (For example, descriptive text or Open Graph image links.) Duplicate the sheet `returntoiowa` and give it the same name you added in the previous step (for example, `ari-whitehouse`).

*Note: The Google Spreadsheet used with this project is specified in `app_config.py` with the variable ``COPY_GOOGLE_DOC_KEY``. To use your own spreadsheet, change this value to reflect your document's key (found in the Google Docs URL after ``&key=``).*

**4. Bootstrap the new Tumblog.**

In the terminal, run `fab bootstrap`. This command will run through the list of projects in the `tumblr-index` sheet of the Google Spreadsheet and, for any new project, do the following things:

* Create a folder for template-related files in the `tumblrs/` folder. (For example: `tumblrs/ari-whitehouse`)

* Copy files needed for our default template (based on the [On The Road](https://nprontheroad.tumblr.com) Tumblog). The originals of these default files live here in the repo:

    * www/js/app.js
    * www/js/lib/modernizr.js
    * www/js/lib/jquery.fitvids.js
    * less/app.less
    * templates/theme.html.tpl

* Create a folder for Open Graph image files in the `www/img/` folder. (For example: `www/img/ari-whitehouse/`)

**5. Start editing and previewing locally.**

The `theme.html.tpl` file in your project folder (for example, `tumblrs/ari-whitehouse/theme.html.tpl`) contains the template code for your Tumblog -- but with a mix of [Tumblr template tags](https://www.tumblr.com/docs/en/custom_themes) and [special template tags specific to this rig](#template-tags). Do not copy and paste this file directly into Tumblr.

Instead, [render out a version of the theme for local development](#render-theme-local-development) (with all asset links pointing to your localhost) and paste the result into Tumblr.

If your changes are primarily to the CSS and Javascript, you can [run the project webserver locally](#run-the-project-locally), edit your CSS and Javascript on your own computer, and refresh the Tumblr URL to preview the changes.

If you are also making changes to the template markup, your workflow will be something like this:

* Make changes to the `theme.html.tpl` file
* Render out the theme for local development
* Paste the updated code into Tumblr
* Start up the local project webserver
* Refresh the Tumblr URL to preview changes
* Edit local CSS/Javascript
* Repeat as needed

**6. Render production-ready files for the staging version of the Tumblog.**

[Render out a version of the theme for production](#render-theme-production) and paste the result into your staging Tumblr. This will bake all images and external files added using the [static file template tags](#template-tags) into the page, so it will no longer refer to files on your local machine.

**7. Add the new template to the production version of the Tumblog.**

Once you're ready to make this live, repeat step 6 -- but with the production version of the Tumblog.

If there are any external resources that could not be baked into the template (for example, an image referenced in an Open Graph image tag), be sure to deploy those to a production webserver (defined in `app_config.py`).

```
fab production master deploy
```

(This will redeploy the assets in `www/img/` for ALL Tumblr projects in the rig.)

And you're live!


Run the project locally
-----------------------

A flask app is used to run the project locally. It will automatically recompile templates and assets on demand.

```
workon tumble
./app.py
```

Visit ``localhost:8000/<tumblr-slug>/index.html`` in your browser. Here's Ari Shapiro's Tumblog: [localhost:8000/ari-whitehouse/index.html](http://localhost:8000/ari-whitehouse/index.html).

This will appear messy and filled with Tumblr template tags, but you should be able to get a general idea of how your template will lay out.


Template tags
--------------
You'll have two basic needs for injecting content into the Tumblr theme.

First, you might want to inject a static file, e.g., CSS/JS or a PNG image from the Tumblr's folder. You can do that with the ``{{ static }}`` template tag. To inject an image called ``header.png``, copy that image into the ``tumblrs/<tumblr-slug>/`` folder and then add a template tag in the template like this:

```
{{ static['header.png'] }}
```

This template tag will insert a reference to localhost if you're developing locally, or it will insert a rendered out version of the file if you're preparing for production.

(Note: If you want to use an image in your LESS file, you'll have to base64 encode it yourself &mdash; but keep a copy of the original image in the ``tumblrs/<tumblr-slug>/`` folder.)

Second, you might want a key/value from this Tumblr's sheet in the Google doc. You can do that with the ``{{ copy }}`` template tag. To inject a key called ``og_description`` containing the social media description for this Tumblr, add the key/value you want to the correct Google doc sheet. Then, use this tag: ``{{ copy.og_description }}``. You can also use ``{{ copy['og_description'] }}`` if you have a key with a ``.`` in the name.

The app template is outfitted with a few ``fab`` utility functions that make pulling changes and updating your local data easy.

To update the latest document, simply run:

```
fab update_copy
```

Note: ``update_copy`` runs automatically whenever ``fab render`` is called.

Render a theme for local development
-------------------------------------
To render a theme for local development, you'll just do:

```
fab copy_theme:$SLUG
```

For example, to create a local development theme for Ari's Tumblr, you'd do this:

```
fab copy_theme:ari-whitehouse
```

This will create a Tumblr theme file (and paste it to your clipboard, natch) that you can paste into Tumblr's admin. The CSS and JS will point to your local app.less and app.js, so you can develop against the Tumblr URL but with local assets.

Render a theme for production
------------------------------
To render a theme for production, you'll just do:

```
fab production copy_theme:$SLUG
```

For example, to create a production theme for Ari's Tumblr, you'd do this:

```
fab production copy_theme:ari-whitehouse
```

This will create a Tumblr theme file (and paste it to your clipboard, natch) that you can paste into Tumblr's admin. The CSS and JS will be fully baked into the Template HTML. Images will be baked as base64 strings and CSS/JS files will be rendered and inserted as ``<script>`` and ``<style>`` tags.
