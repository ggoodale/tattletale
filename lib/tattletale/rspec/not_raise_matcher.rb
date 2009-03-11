# Shell Tattler for RSpec.  A work in progress.
module NotRaiseMatcher
  class NotRaise
    def initialize(*expected)
    end
    
    def matches?(&block)
    end
    def failure_message
    end
    def negative_failure_message
    end    
  end

  def not_raise(attr)
    NotRaise.new(attr)
  end
end