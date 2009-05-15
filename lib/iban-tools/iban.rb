# vim:ts=2:sw=2:et:

module IBANTools
  class IBAN

    def self.valid?( code )
      new(code).validate.empty?
    end

    def initialize( code )
      @code = code.gsub /\s+/, ''
    end

    def validate
      errors = []
      return [:too_short] if @code.size < 5
      errors << :bad_checksum unless valid_checksum?
      errors
    end

    def valid_checksum?
      numerify.to_i % 97 == 1
    end

    def numerify
      (@code[4..-1] + @code[0..3]).chars.map do |ch|
      	case ch.upcase
	when '0'..'9'
	  ch
	when 'A'..'Z'
	  (ch[0] - ?A + 10).to_s
	end
      end.join
    end

  end
end
