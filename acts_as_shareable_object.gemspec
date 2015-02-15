$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_shareable_object/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acts_as_shareable_object"
  s.version     = ActsAsShareableObject::VERSION
  s.authors     = ["Jure Žove"]
  s.email       = ["jure.zove@gmail.com"]
  s.homepage    = "https://github.com/jurezove/acts_as_shareable_object"
  s.summary     = "ActiveRecord extension for Twitter Cards and Open Graph."
  s.description = "This ActiveRecord extension provides the capability to define or map attributes in your ActiveRecord models that can be easily represented with the necessary Open Graph, Twitter Cards or any other custom meta tags."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "sqlite3"
end
