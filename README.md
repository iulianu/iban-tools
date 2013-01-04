# iban-tools

[![Code Coverage](https://coveralls.io/repos/opahk/iban-tools/badge.png?branch=master)](https://coveralls.io/r/opahk/iban-tools)
[![Build Status](https://travis-ci.org/opahk/iban-tools.png?branch=master)](https://travis-ci.org/opahk/iban-tools)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/opahk/iban-tools)
[![Dependency Status](https://gemnasium.com/opahk/iban-tools.png)](https://gemnasium.com/opahk/iban-tools)

iban-tools is a Ruby library for manipulating and validating IBAN account numbers. You can [read more about IBAN](http://en.wikipedia.org/wiki/International_Bank_Account_Number) on Wikipedia

## INSTALLATION

    gem install iban-tools

    The gem should be compatible with MRI 1.8 and 1.9.

## USAGE

    require 'iban-tools'

    IBANTools::IBAN.valid?("GB82 WEST 1234 5698 7654 32")
    => true

Advanced usage, gives more detailed error messages

    IBANTools::IBAN.new("XQ75 BADCODE 666").validation_errors
    => [:unknown_country_code, :bad_check_digits]

Pretty print, canonicalize, and extract fields from an IBAN code

    iban = IBANTools::IBAN.new(" ro49  aaaa 1B31007593840000")

    iban.code
    => "RO49AAAA1B31007593840000"

    iban.country_code
    => "RO"

    iban.prettify
    => "RO49 AAAA 1B31 0075 9384 0000"

## Credit

[Iulianu](http://github.com/iulianu) wrote [iban-tools](http://github.com/iulianu/iban-tools). ([AlphaSights](http://dev.alphasights.com)) is now maintaining the gem.
