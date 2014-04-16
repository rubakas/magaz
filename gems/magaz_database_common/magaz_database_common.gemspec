$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "magaz_database_common/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "magaz_database_common"
  s.version     = MagazDatabaseCommon::VERSION
  s.authors     = ["Andriy Tyurnikov"]
  s.email       = ["Andriy.Tyurnikov@gmail.com"]
  s.homepage    = "http://github.com/andriytyurnikov/magaz"
  s.summary     = "Common database for magaz apps"
  s.description = "Common database for magaz apps"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # s.add_dependency "rails", "~> 4.2.0.alpha"

  s.add_development_dependency "pg"
end
