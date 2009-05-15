# vim:ts=2:sw=2:et:

require 'rubygems'
require 'rake/gempackagetask'

PKG_VERSION='0.0.1'

spec = Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.summary = "IBAN validator"
  s.name = 'iban-tools'
  s.version = PKG_VERSION
  s.requirements << 'none'
  s.require_path = 'lib'
  s.autorequire = 'iban-tools.rb'
  s.files      = FileList["{bin,docs,lib,test}/**/*"].exclude("rdoc").to_a
  s.description = <<EOF
Validates IBAN account numbers
EOF
end

Rake::GemPackageTask.new(spec) do |pkg|
#  pkg.need_zip = true
#  pkg.need_tar = true
end	

