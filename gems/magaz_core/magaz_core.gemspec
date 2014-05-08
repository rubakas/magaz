$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "magaz_core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "magaz_core"
  s.version     = MagazCore::VERSION
  s.authors     = ["Andriy Tyurnikov"]
  s.email       = ["Andriy.Tyurnikov@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of MagazCore."
  s.description = "TODO: Description of MagazCore."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # s.add_dependency "rails", "~> 4.2.0.alpha"
  s.add_dependency "carrierwave"
  s.add_dependency "rmagick"
  s.add_dependency "friendly_id"
  s.add_dependency "liquid"
  s.add_dependency "bcrypt-ruby"

  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl"
  s.add_development_dependency "pg"
end
