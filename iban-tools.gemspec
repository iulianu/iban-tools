Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.summary      = "IBAN validator"
  s.name         = 'iban-tools'
  s.version      = '0.0.8'
  s.authors      = ["Iulian Dogariu", "Tor Erik Linnerud"]
  s.email        = ["code@iuliandogariu.com", 'tor@alphasights.com']
  s.requirements << 'none'
  s.require_path = 'lib'
  s.files        = [
    "README.md",
    "lib/iban-tools.rb",
    "lib/iban-tools/conversion.rb",
    "lib/iban-tools/conversion_rules.yml",
    "lib/iban-tools/iban.rb",
    "lib/iban-tools/iban_rules.rb",
    "lib/iban-tools/rules.yml"
  ]
  s.description  = "Validates IBAN account numbers"

  s.add_development_dependency "rspec"
  s.add_development_dependency "coveralls"
end
