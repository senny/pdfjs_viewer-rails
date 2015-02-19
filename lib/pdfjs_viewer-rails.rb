require "pdfjs_viewer-rails/version"
require "pdfjs_viewer-rails/helpers"

module PdfjsViewer
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
