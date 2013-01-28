# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'png_quantizator/version'

Gem::Specification.new do |gem|
  gem.name          = "png_quantizator"
  gem.version       = PngQuantizator::VERSION
  gem.authors       = ["Roger Campos"]
  gem.email         = ["roger@itnig.net"]
  gem.description   = %q{Small wrapper around pngquant}
  gem.summary       = %q{Small wrapper around pngquant}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
end
