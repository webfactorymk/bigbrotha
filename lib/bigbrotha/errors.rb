module BigBrotha

  class Error < StandardError
    def error
      nil
    end

    def status
      :bad_request
    end

    def message
      nil
    end
  end

  class NotActiveRecordModel < Error
    def error
      'model_is_not_active_record'
    end

    def status
      :bad_request
    end
  end

  class MissingParam < Error
    def error
      'missing_param'
    end

    def status
      :bad_request
    end

  end

end

