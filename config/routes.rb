PdfjsViewer::Rails::Engine.routes.draw do
  get "minimal" => "viewer#minimal", as: :minimal
  get "full" => "viewer#full", as: :full
end
