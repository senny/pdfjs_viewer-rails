PdfjsViewer::Rails::Engine.routes.draw do
  get "minimal" => "viewer#minimal", as: :minimal
  get "reduced" => "viewer#reduced", as: :reduced
  get "full" => "viewer#full", as: :full
end
