require "pdfjs_viewer-rails/version"
require "pdfjs_viewer-rails/helpers"

module PdfjsViewer
  # When the viewer is loaded on these origins, files can be loaded
  # from any origin, otherwise only same-origin files are allowed.
  mattr_accessor :hosted_viewer_origins do
    ['null', 'http://mozilla.github.io', 'https://mozilla.github.io']
  end
  
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace PdfjsViewer

      initializer 'pdfjs_viewer-rails.load_static_assets' do |app|
        app.middleware.unshift ::ActionDispatch::Static, "#{root}/public"
      end

      initializer "pdfjs_viewer-rails.view_helpers" do
        ActionView::Base.send :include, ViewHelpers
      end
    end
  end
end
