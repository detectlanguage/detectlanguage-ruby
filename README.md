Detect Language API Client [![Build Status](https://secure.travis-ci.org/detectlanguage/detect_language.png)](http://travis-ci.org/detectlanguage/detect_language)
========

Detects language of given text. Returns detected language codes and scores.

Before using Detect Language API client you setup your personal API key.
You can get it by signing up at http://detectlanguage.com

## Installation

Add this line to your application's Gemfile:

    gem 'detect_language'

Or install it yourself as:

    $ gem install detect_language

### Configuration

If you are using Rails, create initializer `config/initializers/detect_language.rb` and add following code there.
Otherwise just integrate following code into your apps configuration.

    DetectLanguage.configure do |config|
      config.api_key = "YOUR API KEY"
    end

## Usage

### Language detection

    DetectLanguage.detect("Buenos dias señor")

#### Result

    [ {"language"=>"es", "isReliable"=>false, "confidence"=>0.3271028037383178},
      {"language"=>"pt", "isReliable"=>false, "confidence"=>0.08356545961002786} ]

### Simple language detection

If you need just a language code you can use `simple_detect`. It returns just the language code.

    DetectLanguage.simple_detect("Buenos dias señor")

#### Result

    "es"

## License

Detect Language API Client is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
