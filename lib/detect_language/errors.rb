module DetectLanguage
  class Error < StandardError; end

  class ApiKeyError < Error; end

  # deprecated
  class Exception < Error; end
end
