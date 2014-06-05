require 'spec_helper'

module IBANTools
  describe Conversion do

    IBAN_FOR_TEST = {
      'AD1200012030200359100100' => {bank_code: '1', branch_code: '2030', account_number: '200359100100'},
      'AE070331234567890123456' => {bank_code: '33', account_number: '1234567890123456'},
      'AL47212110090000000235698741' => {bank_code: '212', branch_code: '1100', check_digit: '9', account_number: '235698741'},
      'AT611904300234573201' => {bank_code: '19043', account_number: '234573201'},
      'AZ21NABZ00000000137010001944' => {bank_code: 'NABZ', account_number: '137010001944'},
      'BA391290079401028494' => {bank_code: '129', branch_code: '7', account_number: '94010284', check_digits: '94'},
      'BE68539007547034' => {bank_code: '539', account_number: '75470', check_digits: '34'},
      'BG80BNBG96611020345678' => {bank_code: 'BNBG', branch_code: '9661', account_type: '10', account_number: '20345678'},
      'BH67BMAG00001299123456' => {bank_code: 'BMAG', account_number: '1299123456'},
      'CH9300762011623852957' => {bank_code: '762', account_number: '11623852957'},
      'CY17002001280000001200527600' => {bank_code: '2', branch_code: '128', account_number: '1200527600'},
      'CZ6508000000192000145399' => {bank_code: '800', account_prefix: '19', account_number: '2000145399'},
      'DE89370400440532013000' => {blz: '37040044', account_number: '532013000'},
      'DK5000400440116243' => {bank_code: '40', account_number: '440116243'},
      'DO28BAGR00000001212453611324' => {bank_code: 'BAGR', account_number: '1212453611324'},
      'EE382200221020145685' => {bank_code: '22', branch_code: '0', account_number: '2210201456', check_digits: '85'},
      'ES9121000418450200051332' => {account_number: '21000418450200051332'},
      'FI2112345600000785' => {bank_code: '123456', account_number: '78', check_digit: '5'},
      'FO7630004440960235' => {bank_code: '3000', account_number: '444096023', check_digit: '5'},
      'FR1420041010050500013M02606' => {bank_code: '20041', branch_code: '1005', account_number: '500013M026', check_digits: '6'},
      'GB29NWBK60161331926819' => {bank_code: 'NWBK', branch_code: '601613', account_number: '31926819'},
      'GE29NB0000000101904917' => {bank_code: 'NB', account_number: '101904917'},
      'GI75NWBK000000007099453' => {bank_code: 'NWBK',account_number: '7099453'},
      'GL4330003330229543' => {bank_code: '3000', account_number: '3330229543'},
      'GR1601101250000000012300695' => {bank_code: '11', branch_code: '125', account_number: '12300695'},
      'HR1210010051863000160' => {bank_code: '1001005', account_number: '1863000160'},
      'HU42117730161111101800000000' => {bank_code: '117', branch_code: '7301', account_prefix: '6', account_number: '111110180000000', check_digit: '0'},
      'IE29AIBK93115212345678' => {bank_code: 'AIBK', branch_code: '931152', account_number: '12345678'},
      'IL620108000000099999999' => {bank_code: '10', branch_code: '800', account_number: '99999999'},
      'IS140159260076545510730339' => {bank_code: '159', branch_code: '26', account_number: '7654', kennitala: '5510730339'},
      'IT60X0542811101000000123456' => {check_char: 'X', bank_code: '5428', branch_code: '11101', account_number: '123456'},
      'JO94CBJO0010000000000131000302' => {bank_code: 'CBJO', branch_code: '10', zeros: '0', account_number: '131000302'},
      'KW81CBKU0000000000001234560101' => {bank_code: 'CBKU', account_number: '1234560101'},
      'KZ86125KZT5004100100' => {bank_code: '125', account_number: 'KZT5004100100'},
      'LB62099900000001001901229114' => {bank_code: '999', account_number: '1001901229114'},
      'LI21088100002324013AA' => {bank_code: '8810', account_number: '2324013AA'},
      'LT121000011101001000' => {bank_code: '10000', account_number: '11101001000'},
      'LU280019400644750000' => {bank_code: '1', account_number: '9400644750000'},
      'LV80BANK0000435195001' => {bank_code: 'BANK', account_number: '435195001'},
      'MC1112739000700011111000H79' => {bank_code: '12739',branch_code: '70', account_number: '11111000H', check_digits: '79'},
      'MD24AG000225100013104168' => {bank_code: 'AG', account_number: '225100013104168'},
      'ME25505000012345678951' => {bank_code: '505', account_number: '123456789', check_digits: '51'},
      'MK07300000000042425' => {bank_code: '300', account_number: '424', check_digits: '25'},
      'MR1300020001010000123456753' => {bank_code: '20', branch_code: '101', account_number: '1234567', check_digits: '53'},
      'MT84MALT011000012345MTLCAST001S' => {bank_code: 'MALT', branch_code: '1100', account_number: '12345MTLCAST001S'},
      'NL91ABNA0417164300' => {bank_code: 'ABNA', account_number: '417164300'},
      'NO9386011117947' => {bank_code: '8601', account_number: '111794', check_digit: '7'},
      'PK36SCBL0000001123456702' => {bank_code: 'SCBL', account_number: '1123456702'},
      'PL27114020040000300201355387' => {bank_code: '114', branch_code: '200', check_digit: '4', account_number: '300201355387'},
      'PS92PALS000000000400123456702' => {bank_code: 'PALS', account_number: '400123456702'},
      'PT50000201231234567890154' => {bank_code: '2', branch_code: '123', account_number: '12345678901', check_digits: '54'},
      'QA58DOHB00001234567890ABCDEFG' => {bank_code: 'DOHB', account_number: '1234567890ABCDEFG'},
      'RO49AAAA1B31007593840000' => {bank_code: 'AAAA', account_number: '1B31007593840000'},
      'RS35260005601001611379' => {bank_code: '260', account_number: '56010016113', check_digits: '79'},
      'SA0380000000608010167519' => {bank_code: '80', account_number: '608010167519'},
      'SE3550000000054910000003' => {bank_code: '500', account_number: '5491000000', check_digit: '3'},
      'SI56191000000123438' => {bank_code: '19', branch_code: '100', account_number: '1234', check_digits: '38'},
      'SK3112000000198742637541' => {bank_code: '1200', account_prefix: '19', account_number: '8742637541'},
      'SM86U0322509800000000270100' => {check_char: 'U', bank_code: '3225', branch_code: '9800', account_number: '270100'},
      'TN5914207207100707129648' => {bank_code: '14', branch_code: '207', account_number: '207100707129648'},
      'TR330006100519786457841326' => {bank_code: '61', reserved: '0', account_number: '519786457841326'},
      'VG96VPVG0000012345678901' => {bank_code: 'VPVG', account_number: '12345678901'},
    }

    describe '::local2iban' do
      context 'given valid data' do
        it 'returns valid IBAN' do
          iban = Conversion.
            local2iban('DE', :blz => '1234123', :account_number => '12341234')
          iban.should be_valid_check_digits
        end
        it 'returns valid IBAN, when checksum is <10' do
          iban = Conversion.
            local2iban('DE', :blz => '32050000', :account_number => '46463055')
          iban.should be_valid_check_digits
        end
        it 'returns valid IBAN for SK' do
          iban = Conversion.
            local2iban('SK', :account_number => '123456789', :bank_code => "5200", :account_prefix => "000000")
          iban.should be_valid_check_digits
        end
        it 'returns valid IBAN for ES' do
          iban = Conversion.
            local2iban('ES', :account_number => '20811234761234567890')
          iban.should be_valid_check_digits
        end
	IBAN_FOR_TEST.each do |iban,local|
	  it "returns valid IBAN for #{iban}" do
	    Conversion.local2iban(iban[0..1], local).
	      should be_valid_check_digits
	  end
	  it "returns the correct IBAN for #{iban}" do
	    Conversion.local2iban(iban[0..1], local).code.
	      should == iban
	  end
	end
      end
      it 'returns valid IBAN when numeric-partial has leading zeroes' do
        iban = Conversion.local2iban('DE', :blz => '01234567', :account_number => '0123456789')
        iban.code.should == 'DE81012345670123456789'
        iban.should be_valid_check_digits
        iban.validation_errors.should eq([])
      end


      it 'returns valid IBAN when string-partials are included' do
        # pseudo conversion rule for ireland IE
        allow(Conversion).to receive(:load_config) do
          {
            prefix: ['\s{8}', "%08s"],
            numeric_suffix: ['\d{6}', "%010d"]
          }
        end
        iban = Conversion.local2iban('IE', :prefix => 'ABCD0123', :numeric_suffix => '0123456789')
        iban.code.should == 'IE83ABCD01230123456789'
        iban.should be_valid_check_digits
        iban.validation_errors.should eq([])
      end




    end

    describe '::iban2local' do
      context 'given valid data' do
        it 'returns valid local data' do
          local = Conversion.iban2local 'DE', '012341230012341234'
          local.should == { :blz => '1234123', :account_number => '12341234' }
        end
        it 'returns valid local data for SK' do
          local = Conversion.iban2local 'SK', '52000000000123456789'
          local.should == { :account_number => '123456789', :bank_code => "5200", :account_prefix => "0" }
        end
        it 'returns valid local data for ES' do
          local = Conversion.iban2local 'ES', '20811234761234567890'
          local.should == { :account_number => '20811234761234567890' }
        end
	IBAN_FOR_TEST.each do |iban,local|
	  it "returns valid local data for #{iban}" do
	    Conversion.iban2local(iban[0..1], iban[4..-1]).
	      should == local
	  end
	end
      end
    end

    describe '::checksum' do
      IBAN_FOR_TEST.each_key do |iban_code|
        it "calculates correct checksum for #{iban_code}" do
          iban = IBAN.new iban_code
          Conversion.send(:checksum, iban.country_code, iban.bban).
            should == iban.check_digits.to_i
        end
      end
    end

    describe '::bban_format_to_format_string' do
      {
        '12!n' => '%012d',
        '12n' => '%012d',
        '12!a' => '%012s',
        '12a' => '%012s',
        '12!c' => '%012s',
        '12c' => '%012s',
        '2!e' => '  ',
        '2e' => '  ',
      }.each do |format,regexp|
        it "should parse #{format}" do
          Conversion.send(:bban_format_to_format_string, format).
            should == regexp
        end
      end
      it "should raise exception for blah" do
        expect {
          Conversion.send(:bban_format_to_regexp, "blah")
        }.to raise_error(ArgumentError)
      end
    end

    describe '::bban_format_to_regexp' do
      {
        '12!n' => '[0-9]{12}',
        '12n' => '[0-9]{,12}',
        '12!a' => '[A-Z]{12}',
        '12a' => '[A-Z]{,12}',
        '12!c' => '[a-zA-Z0-9]{12}',
        '12c' => '[a-zA-Z0-9]{,12}',
        '2!e' => '[ ]{2}',
        '2e' => '[ ]{,2}',
      }.each do |format,regexp|
        it "should parse #{format}" do
          Conversion.send(:bban_format_to_regexp, format).
            should == regexp
        end
      end
      it "should raise exception for blah" do
        expect {
          Conversion.send(:bban_format_to_regexp, "blah")
        }.to raise_error(ArgumentError)
      end
    end
  end
end
