Rails.application.routes.draw do
  root "sample#show"
  get "/helper" => "sample#helper", as: :helper
  mount PdfjsViewer::Rails::Engine => "/pdfjs_viewer", as: :pdfjs
end
