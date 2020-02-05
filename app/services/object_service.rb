# frozen_string_literal: true

# Superclass of all ObjectServices that provides error and succes class
class ObjectService
  # Default error class that will inherit all ObjectServices
  class Error
    attr_reader :error_message, :error_code
    def initialize(error = nil, code = nil)
      @error_message = error
      @error_code = code
    end

    def success?
      false
    end
  end

  # Default success class that will inherit all ObjectServices
  class Success
    attr_reader :data
    def initialize(data)
      @data = data
    end

    def success?
      true
    end
  end
end
