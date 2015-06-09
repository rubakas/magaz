$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "magaz_theme_store/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "magaz_theme_store"
  s.version     = MagazThemeStore::VERSION
  s.authors     = ["Andriy Tyurnikov"]
  s.email       = ["Andriy.Tyurnikov@gmail.com"]
  s.homepage    = "http://github.com/andriytyurnikov/magaz"
  s.summary     = "Summary of MagazThemeStore."
  s.description = "Description of MagazThemeStore."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
end
