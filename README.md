Detect Language API Ruby Client
========

[![Gem Version](https://badge.fury.io/rb/detect_language.svg)](https://badge.fury.io/rb/detect_language)
[![Build Status](https://github.com/detectlanguage/detectlanguage-ruby/actions/workflows/main.yml/badge.svg)](https://github.com/detectlanguage/detectlanguage-ruby/actions)

Detects language of the given text. Returns detected language codes and scores.


## Installation

Add this line to your application's Gemfile:

```
gem 'detect_language'
```

### Upgrading

When upgrading please check [changelog](CHANGELOG.md) for breaking changes.

### Configuration

Get your personal API key by signing up at https://detectlanguage.com

```ruby
DetectLanguage.configure do |config|
  config.api_key = 'YOUR API KEY'
end
```

## Usage

### Language detection

```ruby
DetectLanguage.detect('Dolce far niente')
```

#### Result

```ruby
[{"language" => "it", "score" => 0.5074}]
```

### Language code detection

If you need just a language code you can use `detect_code`.

```ruby
DetectLanguage.detect_code('Dolce far niente')
```

#### Result

```ruby
"it"
```

### Batch detection

It is possible to detect language of several texts with one request.
This method is significantly faster than doing one request per text.
To use batch detection just pass array of texts to `detect_batch` method.

```ruby
DetectLanguage.detect_batch(['Dolce far niente', 'Labas rytas'])
```

#### Result

Result is array of detections in the same order as the texts were passed.

```ruby
[[{"language" => "it", "score" => 0.5074}], [{"language" => "lt", "score" => 0.3063}]]
```

### Getting your account status

```ruby
DetectLanguage.account_status
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
