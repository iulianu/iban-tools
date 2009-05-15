# vim:ts=2:sw=2:et:

module IBANTools
  class IBAN

    def self.valid?( code )
      new(code).validate.empty?
    end

    def initialize( code )
      @code = IBAN.canonicalize_code(code)
    end

    def validate
      errors = []
      return [:too_short] if @code.size < 5
      return [:bad_chars] unless @code =~ /^[A-Z0-9]+$/
      errors << :bad_checksum unless valid_checksum?
      errors
    end

    def valid_checksum?
      numerify.to_i % 97 == 1
    end

    def numerify
      (@code[4..-1] + @code[0..3]).chars.map do |ch|
      	case ch
	      when '0'..'9'
          ch
        when 'A'..'Z'
          (ch[0] - ?A + 10).to_s
        else
          raise RuntimeError.new("Unexpected char '#{ch}' in IBAN code '#{prettify}'")
        end
      end.join
    end

    def to_s
      "#<#{self.class}: #{prettify}>"
    end

    def prettify
      @code.gsub /(.{4})/, '\1 '
    end

    def self.canonicalize_code( code )
      code.strip.gsub(/\s+/, '').upcase
    end

  end
end
