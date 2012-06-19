class Retry
  def self.retryable(options = {})
    opts = {:tries => 1, :on => Exception}.merge(options)

    retry_exception, retries = opts[:on], opts[:tries]

    begin
      return yield
    rescue retry_exception
      if (retries -= 1) > 0
        retry
      else
        raise
      end
    end
  end
end