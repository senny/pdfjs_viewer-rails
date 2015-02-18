module PdfjsViewer
  module Rails
    module ViewHelpers
      def pdfjs_viewer(style:, pdf_url: nil, title: nil)
        render "/pdfjs_viewer/viewer/viewer", style: style, pdf_url: pdf_url, title: title
      end
    end
  end
end
