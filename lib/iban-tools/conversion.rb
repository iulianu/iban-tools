module IBANTools
  class Conversion

    def self.local2iban(country_code, data)
      config = load_config country_code

      bban = config.map do |key, value|
        value[1] % data[key.to_sym]
      end.join('')

      check_digits = checksum country_code, bban

      IBAN.new "#{country_code}#{check_digits}#{bban}"
    end


    def self.iban2local(country_code, bban)
      config = load_config country_code

      local = {}
      config.map do |key, value|
        local[key.to_sym] = bban.scan(/^#{value[0]}/).first.sub(/^0+/, '')
        bban.sub! /^#{value[0]}/, ''
      end
      local
    end

    private

    def self.load_config(country_code)
      default_config = YAML.
        load(File.read(File.dirname(__FILE__) + '/conversion_rules.yml'))
      default_config[country_code]
    end

    def self.checksum(country_code, bban)
      97 - (IBAN.new("#{country_code}00#{bban}").numerify.to_i % 97) + 1
    end
  end
end
