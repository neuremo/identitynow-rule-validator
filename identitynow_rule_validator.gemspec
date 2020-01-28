lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "identitynow_rule_validator"
  spec.version       = "1.0.0b"
  spec.authors       = ["neil-mcglennon-sp"]
  spec.email         = ["neil.mcglennon@sailpoint.com"]
  spec.licenses      = ['MIT']
  spec.summary       = "IdentityNow Rule Validator"
  spec.description   = "A tool to validate IdentityNow rules."
  spec.homepage      = "http://www.sailpoint.com"
  spec.cert_chain    = ["certs/neil-mcglennon-sp.pem"]
  spec.signing_key   = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/
  spec.files         = Dir.glob("{bin,lib}/**/*")
  spec.require_paths = ["lib"]
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
