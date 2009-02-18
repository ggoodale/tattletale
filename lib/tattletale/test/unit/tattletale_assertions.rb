module TattletaleAssertions
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
          assert_block(build_message(message, 'Raised exception ? at ?', e, e.backtrace[0])){false}                
        end
      rescue => e
        assert_block(build_message(message, 'Raised exception(s): ?', e)){false} if exception_classes.include? e.class
      end
    end
    nil
  end
end

module Test
  module Unit
    class TestCase
      include TattletaleAssertions
    end
  end
end

