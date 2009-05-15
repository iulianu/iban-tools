Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.summary = "IBAN validator"
  s.name = 'iban-tools'
  s.version = '0.0.1.1'
  s.authors = ["Iulian Dogariu"]
  s.email   = ["code@iuliandogariu.com"]
  s.requirements << 'none'
  s.require_path = 'lib'
  s.files      = [ "README", 
                   "lib/iban-tools.rb", 
		   "lib/iban-tools/iban.rb" 
		 ]
  s.description = <<EOF
Validates IBAN account numbers
EOF
end

