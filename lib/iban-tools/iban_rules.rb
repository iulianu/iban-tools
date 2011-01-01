# vim:ts=2:sw=2:et:

require 'yaml'

module IBANTools

  class IBANRules

    def initialize( rules = {} )
      @rules = rules
    end

    def [](key)
      @rules[key]
    end

    def self.defaults
      load_from_string( File.read(File.dirname(__FILE__) + "/rules.yml") )
    end

    def self.load_from_string( string )
      rule_hash = YAML.load(string)
      rule_hash.each do |country_code, specs|
        specs["bban_pattern"] = Regexp.new("^" + specs["bban_pattern"] + "$")
      end
      IBANRules.new(rule_hash)
    end

  end

end

