$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "magaz_store_admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "magaz_store_admin"
  s.version     = MagazStoreAdmin::VERSION
  s.authors     = ["Griminy"]
  s.email       = ["bozya003@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of MagazStoreAdmin."
  s.description = "TODO: Description of MagazStoreAdmin."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
end
