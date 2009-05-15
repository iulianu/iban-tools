require 'rake'

PKG_VERSION='0.0.1'

Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.summary = "IBAN validator"
  s.name = 'iban-tools'
  s.version = PKG_VERSION
  s.requirements << 'none'
  s.require_path = 'lib'
  s.autorequire = 'iban-tools.rb'
  s.files      = FileList["{lib,spec}/**/*"].exclude("rdoc").to_a
  s.description = <<EOF
Validates IBAN account numbers
EOF
end

