$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "magaz_style/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "magaz_style"
  s.version     = MagazStyle::VERSION
  s.authors     = ["Andriy Tyurnikov"]
  s.email       = ["Andriy.Tyurnikov@gmail.com"]
  s.homepage    = "http://github.com/andriytyurnikov/magaz"
  s.summary     = "Summary of MagazStyle."
  s.description = "Description of MagazStyle."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
end
