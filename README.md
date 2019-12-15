Detect Language API Client 
========

[![Gem Version](https://badge.fury.io/rb/detect_language.svg)](https://badge.fury.io/rb/detect_language)
[![Build Status](https://secure.travis-ci.org/detectlanguage/detectlanguage-ruby.svg)](http://travis-ci.org/detectlanguage/detectlanguage-ruby)

Detects language of given text. Returns detected language codes and scores.

Before using Detect Language API client you have to setup your personal API key.
You can get it by signing up at https://detectlanguage.com

## Installation

Add this line to your application's Gemfile:

```
gem 'detect_language'
```

Or install it yourself as:

```
gem install detect_language
```

### Configuration

If you are using Rails, create initializer `config/initializers/detect_language.rb` and add following code there.
Otherwise just integrate following code into your apps configuration.

```ruby
DetectLanguage.configure do |config|
  config.api_key = "YOUR API KEY"

  # enable secure mode (SSL) if you are passing sensitive data
  # config.secure = true
end
```

## Usage

### Language detection

```ruby
DetectLanguage.detect("Buenos dias señor")
```

#### Result

```ruby
[ {"language"=>"es", "isReliable"=>false, "confidence"=>0.3271028037383178},
  {"language"=>"pt", "isReliable"=>false, "confidence"=>0.08356545961002786} ]
```

### Simple language detection

If you need just a language code you can use `simple_detect`. It returns just the language code.

```ruby
DetectLanguage.simple_detect("Buenos dias señor")
```

#### Result

```ruby
"es"
```

### Batch detection

It is possible to detect language of several texts with one request.
This method is significantly faster than doing one request per text.
To use batch detection just pass array of texts to `detect` method.

```ruby
DetectLanguage.detect(["Buenos dias señor", "Labas rytas"])
```

#### Result

Result is array of detections in the same order as the texts were passed.

```ruby
[ [ {"language"=>"es", "isReliable"=>false, "confidence"=>0.3271028037383178},
    {"language"=>"pt", "isReliable"=>false, "confidence"=>0.08356545961002786} ],
  [ {"language"=>"lt", "isReliable"=>false, "confidence"=>0.04918032786885246},
    {"language"=>"lv", "isReliable"=>false, "confidence"=>0.03350083752093803} ] ]
```

### Getting your account status

```ruby
DetectLanguage.user_status
```

#### Result

```ruby
{"date"=>"2013-11-17", "requests"=>95, "bytes"=>2223, "plan"=>"FREE", "plan_expires"=>nil,
 "daily_requests_limit"=>5000, "daily_bytes_limit"=>1048576, "status"=>"ACTIVE"}
```

### Getting list supported languages

```ruby
DetectLanguage.languages
```

#### Result

Array of language codes and names.

## License

Detect Language API Client is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
