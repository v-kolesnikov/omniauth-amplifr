# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/amplifr/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-amplifr"
  spec.version       = OmniAuth::Amplifr::VERSION
  spec.authors       = ["Vasily Kolesnikov"]
  spec.email         = ["re.vkolesnikov@gmail.com"]

  spec.summary       = "OmniAuth OAuth2 strategy for Amplifr (amplifr.com)"
  spec.homepage      = "https://github.com/v-kolesnikov/omniauth-amplifr"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_dependency 'omniauth-oauth2'

  spec.add_development_dependency "bundler", "~> 1.0"
end
