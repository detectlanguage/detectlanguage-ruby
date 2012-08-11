# -*- encoding: utf-8 -*-
require File.expand_path('../lib/detect_language/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Laurynas Butkus"]
  gem.email         = ["laurynas.butkus@gmail.com"]
  gem.description   = %q{Language Detection API Client}
  gem.summary       = %q{Detects language of given text. Returns detected language codes and scores.}
  gem.homepage      = "https://github.com/detectlanguage/detect_language"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "detect_language"
  gem.require_paths = ["lib"]
  gem.version       = DetectLanguage::VERSION
end
