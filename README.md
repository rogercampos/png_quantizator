# PngQuantizator
[![Build Status](https://secure.travis-ci.org/rogercampos/png_quantizator.png)](http://travis-ci.org/rogercampos/png_quantizator)


PngQuantizator is a little wrapper around [ pngquant ](http://pngquant.org/).
Gives you a nice API to interact with the binary and meaningful exceptions in
the ruby world if `pngquant` throws an error.

## Installation

Add this line to your application's Gemfile:

    gem 'png_quantizator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install png_quantizator

## Usage

```
file = PngQuantizator::Image.new("/path/to/image.png")

# Quantize to a new file
file.quantize_to("/path/to/destination.png")

# Quantize in place
file.quantize!
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
