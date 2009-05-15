Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.summary = "IBAN validator"
  s.name = 'iban-tools'
  s.version = '0.0.2'
  s.authors = ["Iulian Dogariu"]
  s.email   = ["code@iuliandogariu.com"]
  s.requirements << 'none'
  s.require_path = 'lib'
  s.files      = [ "README", 
                   "lib/iban-tools.rb", 
		   "lib/iban-tools/iban.rb",
		   "lib/iban-tools/iban_rules.rb",
		   "lib/iban-tools/rules.yml" 
		 ]
  s.description = <<EOF
Validates IBAN account numbers
EOF
end

