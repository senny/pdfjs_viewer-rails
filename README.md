# pdfjs_viewer-rails

[![Build Status](https://travis-ci.org/senny/pdfjs_viewer-rails.svg?branch=master)](https://travis-ci.org/senny/pdfjs_viewer-rails)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pdfjs_viewer-rails'
```

*Note: pdfjs_viewer-rails is still in early development. Please report if you encounter any issues along the way.*

## Viewer Styles

This gem ships with three viewer styles:

**full**

<p align="center">
  <img
  src="https://raw.githubusercontent.com/senny/pdfjs_viewer-rails/master/doc/files/viewer_full.png"
  alt="full style"/>
</p>

**reduced**

<p align="center">
  <img
  src="https://raw.githubusercontent.com/senny/pdfjs_viewer-rails/master/doc/files/viewer_reduced.png"
  alt="reduced style"/>
</p>

**minimal**

<p align="center">
  <img
  src="https://raw.githubusercontent.com/senny/pdfjs_viewer-rails/master/doc/files/viewer_minimal.png"
  alt="minimal style"/>
</p>

## Usage

### Using the mountable Engine

The mountable engine makes it extremely simple to integrate the PDF.js viewer
into your application:

*config/routes.rb*
```ruby
mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'
```

Now you can use a link in your templates to open up the viewer:

```erb
<%= link_to "display using the full viewer", pdfjs.full_path(file: "/sample.pdf") %>
<%= link_to "display using the minimal viewer", pdfjs.minimal_path(file: "/sample.pdf") %>
```

### Using the helper

If your integration scenario is more complex you may want to consider using the
`pdfjs_viewer` helper. This allows you to embed the viewer into a container like
an iframe.

```erb
<%= pdfjs_viewer pdf_url: "/sample.pdf", style: :full %>
<%= pdfjs_viewer pdf_url: "/sample.pdf", style: :minimal %>
```

NOTE: The helper will render a full HTML document and should not be used in a layout.

### Verbosity of PDF.js

The verbosity of PDF.js can be set with:

```
$ export PDFJS_VIEWER_VERBOSITY=warnings
```

Verbosity levels:

* errors (default)
* warnings
* infos

### Customizing the viewer

If you're not happy with the 3 different styles with which pdfjs_viewer-rails is shipped, you can make your own adjustments by creating a file in `app/views/pdfjs_viewer/viewer/_extra_head.html.erb`. This file will be appended to the viewer's `<head>` tag.

So for example, if you'd like to hide the print icon:

```erb
<!-- app/views/pdfjs_viewer/viewer/_extra_head.html.erb -->

<style>
  #print { display: none; }
</style>
```

NOTE: You can use the parameters you passed into `pdfjs_viewer` (if you're using the helper):

```erb
<!-- Somewhere in a view in your project -->
<%= pdfjs_viewer style: "reduced", something: "sick!" %>
```

and then access them:

```erb
<!-- app/views/pdfjs_viewer/viewer/_extra_head.html.erb -->

<%= tag.meta name: "something", content: something %>
```

### Setting up CORS

If you plan to load PDFs from that are hosted on another domain from the
PDF.js viewer, you may need to set up a Cross-Origin Resource Sharing (CORS)
Policy to allow PDF.js to read PDFs from your domain. If you're serving PDFs
straight from Amazon S3 (e.g. `bucket.s3-us-west-1.amazonaws.com`), you will
need to add a CORS policy to the S3 bucket. This CORS configuration has been
tested on S3:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01">
    <CORSRule>
        <AllowedOrigin>*</AllowedOrigin>
        <AllowedMethod>GET</AllowedMethod>
        <AllowedMethod>HEAD</AllowedMethod>
        <MaxAgeSeconds>3000</MaxAgeSeconds>
        <AllowedHeader>Range</AllowedHeader>
        <AllowedHeader>Authorization</AllowedHeader>
        <ExposeHeader>Accept-Ranges</ExposeHeader>
        <ExposeHeader>Content-Encoding</ExposeHeader>
        <ExposeHeader>Content-Length</ExposeHeader>
        <ExposeHeader>Content-Range</ExposeHeader>
    </CORSRule>
</CORSConfiguration>
```

## Development

Tests can be executed with:

```
$ bundle exec rake
```

This will render the sample.pdf using phantomjs and save screenshots into `test/sandbox`.

## License

pdfjs_viewer-rails is released under the [MIT License](http://www.opensource.org/licenses/MIT).
