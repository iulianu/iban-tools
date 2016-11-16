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
      load_from_string
    end

    def self.load_from_string
      hash_copy = rule_hash
      hash_copy.each do |country_code, specs|
        specs["bban_pattern"] = Regexp.new("^" + specs["bban_pattern"] + "$")
      end
      IBANRules.new(hash_copy)
    end
    
    def self.rule_hash
      YAML.load(file_path)
    end
    
    def self.file_path
      File.read(File.dirname(__FILE__) + "/rules.yml")
    end

  end

end

