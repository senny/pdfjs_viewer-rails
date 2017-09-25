module PdfjsViewer
  module Rails
    module ViewHelpers
      def pdfjs_viewer(**kwargs)
        raise ArgumentError, "style option is required." unless kwargs.key?(:style)
        render "/pdfjs_viewer/viewer/viewer", **kwargs
      end
    end
  end
end
