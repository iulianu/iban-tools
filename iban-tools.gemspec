Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.summary      = "IBAN validator"
  s.name         = 'iban-tools'
  s.version      = '0.0.7'
  s.authors      = ["Iulian Dogariu"]
  s.email        = ["code@iuliandogariu.com"]
  s.requirements << 'none'
  s.description  = "Validates IBAN account numbers"
  s.require_path = 'lib'

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec"
  s.add_development_dependency "pry"
end
