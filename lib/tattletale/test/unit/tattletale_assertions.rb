module TattletaleAssertions

  def assert_raised_and_rescued(*args)
    message = (Module === args.last ? "" : args.pop)
    exception_classes = args
    _wrap_assertion do
      Tattletale.clear
      begin
        yield
        exceptions_of_interest = Tattletale.tattles.map{|tattle| tattle.exception} & exception_classes
        unless exceptions_of_interest === exception_classes
          missing_exceptions = exception_classes - exceptions_of_interest
          assert_block(build_message(message, 'Exception(s) ? were not raised', missing_exceptions.join(', '))){false}
        end                
      rescue Test::Unit::AssertionFailedError
        raise
      rescue => e
        assert_block(build_message(message, 'Unhandled exception(s): ?', e.class)){false} if exception_classes.include? e.class
      end
    end
  end

  def assert_never_raised(*args)
    message = (Module === args.last ? "" : args.pop)
    exception_classes = args
    _wrap_assertion do
      Tattletale.clear
      begin
        yield
        Tattletale.tattles.each do |tattle|
          e = tattle.exception
          next unless exception_classes.include?(e.class)
          assert_block(build_message(message, 'Raised exception ? at ?', e.class, e.backtrace[0])){false}                
        end
      rescue Test::Unit::AssertionFailedError
        raise
      rescue => e
        assert_block(build_message(message, 'Raised exception(s): ?', e.class)){false} if exception_classes.include? e.class
      end
    end
  end
end

module Test
  module Unit
    class TestCase
      include TattletaleAssertions
    end
  end
end

