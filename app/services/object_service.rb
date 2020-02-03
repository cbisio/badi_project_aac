class ObjectService
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
