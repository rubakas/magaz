$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "magaz_theme_store/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "magaz_theme_store"
  s.version     = MagazThemeStore::VERSION
  s.authors     = ["Andriy Tyurnikov"]
  s.email       = ["Andriy.Tyurnikov@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of MagazThemeStore."
  s.description = "TODO: Description of MagazThemeStore."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # s.add_dependency "rails", "~> 4.2.0.alpha"

  s.add_development_dependency "sqlite3"
end
