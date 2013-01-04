# vim:ts=2:sw=2:et:

require 'spec_helper'

module IBANTools
  describe IBAN do

    describe "with test rules" do

      before(:each) do
        @rules = IBANRules.new({ "GB" => {"length" => 22, "bban_pattern" => /[A-Z]{4}.*/} })
      end

      it "should validate IBAN code" do
        # Using example from http://en.wikipedia.org/wiki/IBAN#Calculating_and_validating_IBAN_checksums
        IBAN.valid?( "GB82WEST12345698765432", @rules ).should be_true
      end

      it "should reject IBAN code with invalid characters" do
        IBAN.new("gb99 %BC").validation_errors(@rules).
          should include(:bad_chars)
      end

      it "should reject IBAN code from unknown country" do
        # Norway is not present in @rules
        IBAN.new("NO9386011117947").validation_errors(@rules).
          should == [:unknown_country_code]
      end

      it "should reject IBAN code that does not match the length for the respective country" do
        IBAN.new("GB88 WEST 1234 5698 7654 3").validation_errors(@rules).
          should == [:bad_length]
          # Length is 21, should be 22.
          # check digits are good though
      end

      it "should reject IBAN code that does not match the pattern for the selected country" do
        IBAN.new("GB69 7654 1234 5698 7654 32").validation_errors(@rules).
          should == [:bad_format]
          # Length and check digits are good,
          # but country pattern calls for chars 4-7 to be letters.
      end

      it "should reject IBAN code with invalid check digits" do
        IBAN.valid?( "GB99 WEST 1234 5698 7654 32", @rules ).should be_false

        IBAN.new("GB99 WEST 1234 5698 7654 32").validation_errors(@rules).
          should == [:bad_check_digits]
      end
    end

    it "should numerify IBAN code" do
      IBAN.new("GB82 WEST 1234 5698 7654 32").numerify.
        should == "3214282912345698765432161182"
    end

    it "should canonicalize IBAN code" do
      IBAN.new("  gb82 WeSt 1234 5698 7654 32").code.
        should == "GB82WEST12345698765432"
    end

    it "should pretty-print IBAN code" do
      IBAN.new(" GB82W EST12 34 5698 765432  ").prettify.
        should == "GB82 WEST 1234 5698 7654 32"

      IBAN.new(" GB82W EST12 34 5698 765432  ").to_s.
        should == "#<IBANTools::IBAN: GB82 WEST 1234 5698 7654 32>"
    end

    it "should extract ISO country code" do
      IBAN.new("NO9386011117947").country_code.should == "NO"
    end

    it "should extract check digits" do
      IBAN.new("NO6686011117947").check_digits.should == "66"
      # extract check digits even if they are invalid!
    end

    it "should extract BBAN (Basic Bank Account Number)" do
      IBAN.new("NO9386011117947").bban.should == "86011117947"
    end

    describe "with default rules" do

      # Rules are loaded from lib/iban-tools/rules.yml
      # Samples from http://www.tbg5-finance.org/?ibandocs.shtml/

      [ "AD1200012030200359100100",
        "AE070331234567890123456",
        "AL47212110090000000235698741",
        "AT611904300234573201",
        "BA391290079401028494",
        "BE68539007547034",
        "BG80BNBG96611020345678",
        "BH67BMAG00001299123456",
        "CH9300762011623852957",
        "CY17002001280000001200527600",
        "CZ6508000000192000145399",
        "DE89370400440532013000",
        "DK5000400440116243",
        "DO28BAGR00000001212453611324",
        "EE382200221020145685",
        "ES9121000418450200051332",
        "FI2112345600000785",
        "FO7630004440960235",
        "FR1420041010050500013M02606",
        "GB29NWBK60161331926819",
        "GE29NB0000000101904917",
        "GI75NWBK000000007099453",
        "GL4330003330229543",
        "GR1601101250000000012300695",
        "HR1210010051863000160",
        "HU42117730161111101800000000",
        "IE29AIBK93115212345678",
        "IL620108000000099999999",
        "IS140159260076545510730339",
        "IT60X0542811101000000123456",
        "KW81CBKU0000000000001234560101",
        "KZ86125KZT5004100100",
        "LB62099900000001001901229114",
        "LI21088100002324013AA",
        "LT121000011101001000",
        "LU280019400644750000",
        "LV80BANK0000435195001",
        "MC1112739000700011111000h79",
        "ME25505000012345678951",
        "MK07300000000042425",
        "MR1300020001010000123456753",
        "MT84MALT011000012345MTLCAST001S",
        "MU17BOMM0101101030300200000MUR",
        "NL91ABNA0417164300",
        "NO9386011117947",
        "PL27114020040000300201355387",
        "PT50000201231234567890154",
        "RO49AAAA1B31007593840000",
        "RS35260005601001611379",
        "SA0380000000608010167519",
        "SE3550000000054910000003",
        "SI56191000000123438",
        "SK3112000000198742637541",
        "SM86U0322509800000000270100",
        "TN5914207207100707129648",
        "TR330006100519786457841326"
      ].each do |iban_code|
        describe iban_code do
          it "should be valid" do
            IBAN.new(iban_code).validation_errors.should == []
          end
        end
      end

      it "should fail known pattern violations" do
        # This IBAN has valid check digits
        # but should fail because of pattern violation
        IBAN.valid?("RO7999991B31007593840000").should be_false
      end

    end

    describe '::from_local' do
      [[['DE', {
          :blz => '37040044',
          :account_number => '532013000' }],
        "DE89370400440532013000"]].
        each do |input, output|

        it "generates iban #{output} from #{input}" do
          IBAN.from_local(*input).code.should == output
        end
      end
    end
  end
end
