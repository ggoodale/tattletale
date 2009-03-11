module NotRaiseMatcher
  class NotRaise
    def initialize(*expected)
      @expected = expected || []
    end
    
    def matches?(&block)
      @block = block

      if @expected.empty? # This could should raise nothing
        
      !@expected.index(@target).nil?
    end
    def failure_message
      "expected #{@target.class} not to be raised" unless @
    end
    def negative_failure_message
      "expected #{@target.inspect} not to be in Zone #{@expected}"
    end
    
  end
  def not_raise(attr)
    NotRaise.new(attr)
  end
end