# pdf.js update guide

This guide describes how to update the pdf.js javascript library.

1. Download the latest pdf.js stable release from https://mozilla.github.io/pdf.js/getting_started/#download

2. Extract the `.zip` file

3. Replace all the files and folders marked with a `*` with the corresponding ones from  the new release
```
├── app
│   ├── assets
│   │   ├── javascripts
│   │   │   └── pdfjs_viewer
│   │   │       ├── application.js
│   │   │       ├── pdfjs
│   │   │       │   ├── compatibility.js *
│   │   │       │   ├── l10n.js *
│   │   │       │   └── pdf.js *
│   │   │       ├── viewer.js *
│   │   │       └── viewer_configurations.js
│   │   └── stylesheets
│   │       └── pdfjs_viewer
│   │           ├── application.css
│   │           ├── full.scss
│   │           ├── minimal.scss
│   │           ├── pdfjs
│   │           │   └── viewer.css *
│   │           └── reduced.scss
├── public
│   └── pdfjs
│       └── web
│           ├── cmaps *
│           ├── images *
│           ├── locale *
│           └── pdf.worker.js *
```

4. Apply the patches

## `app/assets/javascripts/pdfjs_viewer/viewer.js`:

Replace
``` javascript
var DEFAULT_URL = 'compressed.tracemonkey-pldi-09.pdf';
```
with
``` javascript
var DEFAULT_URL = window.resourceURL;
```

##

Replace
``` javascript
PDFJS.imageResourcesPath = './images/';
PDFJS.workerSrc = '../build/pdf.worker.js';
PDFJS.cMapUrl = '../web/cmaps/';
```
with
``` javascript
PDFJS.imageResourcesPath = '/pdfjs/web/images/';
PDFJS.workerSrc = '/pdfjs/web/pdf.worker.js';
PDFJS.cMapUrl = '/pdfjs/web/cmaps/';
```

## `app/assets/stylesheets/pdfjs_viewer/pdfjs/viewer.css`

Replace all `url(images/` with `url(/pdfjs/web/images/`

## `app/views/pdfjs_viewer/viewer/_viewer.html.erb`

Replace the whole content of `app/views/pdfjs_viewer/viewer/_viewer.html.erb` with `web/viewer.html` from the new pdf.js release.

##

Insert
```html
<% title = local_assigns[:title] || "PDF.js viewer" %>
<% pdf_url = local_assigns[:pdf_url] %>
```
at the top of the file before `<!DOCTYPE html>`

##

Replace all children of `<head>` except the `<meta>` tags with
```html
<%= render "pdfjs_viewer/viewer/head", title: title, pdf_url: pdf_url %>
```

##

At the bottom of the file insert `<%= render "pdfjs_viewer/viewer/printcontainer" %>` after `<div id="printContainer"></div>`
