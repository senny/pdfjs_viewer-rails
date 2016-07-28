# pdfjs_viewer-rails

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

**minimal**

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

## Development

Tests can be executed with:

```
$ bundle exec rake
```

This will render the sample.pdf using phantomjs and save screenshots into `test/sandbox`.

## License

pdfjs_viewer-rails is released under the [MIT License](http://www.opensource.org/licenses/MIT).
