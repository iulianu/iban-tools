# vim:ts=2:sw=2:et:

require 'iban-tools'

module IBANTools
  describe IBAN do
  
    it "should validate IBAN code using checksum" do
      # Using example from http://en.wikipedia.org/wiki/IBAN#Calculating_and_validating_IBAN_checksums
      IBAN.valid?( "GB82 WEST 1234 5698 7654 32" ).should be_true
      IBAN.valid?( "GB82WEST12345698765432" ).should be_true
    end

    it "should reject IBAN code with invalid checksum" do
      IBAN.valid?( "GB99 WEST 1234 5698 7654 32" ).should be_false

      IBAN.new("GB99 WEST 1234 5698 7654 32").validate.
        should include(:bad_checksum)
    end

    it "should reject IBAN code that is too short" do
      IBAN.new("abc").validate.
        should include(:too_short)
    end

    it "should reject IBAN code with invalid characters" do
      IBAN.new("gb99 %BC").validate.
        should include(:bad_chars)
    end

    it "should numerify IBAN code" do
      IBAN.new("GB82 WEST 1234 5698 7654 32").numerify.
        should == "3214282912345698765432161182"
    end

    it "should canonicalize IBAN code" do
      IBAN.canonicalize_code("  gb82 WeSt 1234 5698 7654 32").
        should == "GB82WEST12345698765432"
    end

    it "should pretty-print IBAN code" do
      IBAN.new(" GB82W EST12 34 5698 765432  ").to_s.
        should == "#<IBANTools::IBAN: GB82 WEST 1234 5698 7654 32>"
    end

  end
end
