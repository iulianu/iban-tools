# iban-tools

iban-tools is a Ruby library for manipulating and validating IBAN account numbers. You can [read more about IBAN](http://en.wikipedia.org/wiki/International_Bank_Account_Number) on Wikipedia

## Credit

[Iulianu](https://github.com/iulianu) wrote [iban-tools](https://github.com/iulianu/iban-tools). We just removed use of `String#ord` for compatibility with Ruby 1.8 and 1.9 and of course pushed the built gem to gemcutter.

You'll find the [source code](https://github.com/iulianu/iban-tools) on Github. [Our fork](https://github.com/alphasights/iban-tools) is also available on GitHub

The gem should be compatible with Ruby 1.8.6, 1.8.7 and 1.9.1.

## INSTALLATION

    gem install iban-tools

## USAGE

```ruby
require 'iban-tools'

IBANTools::IBAN.valid?("GB82 WEST 1234 5698 7654 32")
=> true
```

Advanced usage, gives more detailed error messages

```ruby
IBANTools::IBAN.new("XQ75 BADCODE 666").validation_errors
=> [:unknown_country_code, :bad_check_digits]
```

Pretty print, canonicalize, and extract fields from an IBAN code

```ruby
iban = IBANTools::IBAN.new(" ro49  aaaa 1B31007593840000")

iban.code
# => "RO49AAAA1B31007593840000"

iban.country_code
# => "RO"

iban.prettify
# => "RO49 AAAA 1B31 0075 9384 0000"
```
