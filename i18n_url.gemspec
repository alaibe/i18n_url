$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "i18n_url/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "i18n_url"
  s.version     = I18nUrl::VERSION
  s.authors     = ["Anthony Laibe"]
  s.email       = ["anthony.laibe@gmail.com"]
  s.homepage    = "https://github.com/alaibe/i18n_url"
  s.summary     = "I18n url module for Rails 3. Translate your routes easily"
  s.description = "I18n url module for Rails 3. Translate your routes easily"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.1.0"
end
