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
    end

    it "should numerify IBAN code" do
      IBAN.new("GB82 WEST 1234 5698 7654 32").numerify.
        should == "3214282912345698765432161182"
    end
  
  end
end
