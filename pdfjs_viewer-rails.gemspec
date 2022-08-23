$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pdfjs_viewer-rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pdfjs_viewer-rails"
  s.version     = PdfjsViewer::Rails::VERSION
  s.authors     = ["Yves Senn"]
  s.email       = ["yves.senn@gmail.com"]
  s.homepage    = "https://github.com/senny/pdfjs_viewer-rails"
  s.summary     = "PDF.js viewer packaged as a Rails engine."
  s.description = "Packages the viewer distributed with PDF.js and makes it available in two styles (full, minimal)."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,public}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "> 4.2.0"
  s.add_dependency "json", "> 1.8.4"

  s.add_development_dependency "sqlite3"
end
