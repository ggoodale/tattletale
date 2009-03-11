module Tattletale
  # Our exception bukkit.  We has it!
  @@tattles ||= []
  @@excluded_classes ||= []
  class Tattle
    attr_accessor :exception
    attr_accessor :timestamp
    def initialize(ex, ts = Time.now)
      @exception = ex
      @timestamp = ts
    end
  end

  class << self

    def tattle(exception)
      @@tattles << Tattle.new(exception) unless @@excluded_classes.include?(exception.class)
    end

    def clear
      @@tattles.clear
    end
  
    def tattles
      @@tattles
    end
  
    def report(format = :compact)
      puts "Exceptions raised:"
      @@tattles.each do |e|
        case format
        when :full
          backtrace_lines = e.exception.backtrace
        else  # Yes, I should have a specific case for :compact.  So sue me.
          backtrace_lines = e.exception.backtrace[0..4]
        end

        puts "  #{e.timestamp}: #{e.exception.class}"
        backtrace_lines.each do |line|
          next if line =~ /tattletale\.rb/
          puts "    #{line}"
        end
        puts "  --"
      end
    end
  
    def exclude(exception_class)
      @@excluded_classes << exception_class
    end
  end
end

module Kernel
  alias :original_raise :raise
  def raise(*args)
    exception = args.empty? ? $! : args[0]
    case exception
    when Class
      exception = exception.new
    when String
      exception = RuntimeError.new(exception)
    end

    exception.set_backtrace(caller)
    Tattletale.tattle(exception)
    original_raise(*args)
  end
end

if defined? Test::Unit::TestCase
  require 'tattletale/test/unit/tattletale_assertions'
  Tattletale.exclude(Test::Unit::AssertionFailedError)
end

