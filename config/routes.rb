PdfjsViewer::Rails::Engine.routes.draw do
  get "minimal" => "viewer#minimal", as: :minimal
  get "reduced" => "viewer#reduced", as: :reduced
  get "full" => "viewer#full", as: :full
  get "netsoft" => "viewer#netsoft", as: :netsoft
  get "netsoft-minimal" => "viewer#netsoft_minimal", as: :netsoft_minimal
end
