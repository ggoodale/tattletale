module Tattletale
  # Our exception bukkit.  We has it!
  @@tattles ||= []
  class Tattle
    attr_accessor :exception
    attr_accessor :timestamp

    def initialize(ex, ts = Time.now)
      @exception = ex
      @timestamp = ts
    end
  end

  def Tattletale.tattle(exception)
    @@tattles << Tattle.new(exception)
  end
  def Tattletale.clear
    @@tattles.clear
  end
  
  def Tattletale.tattles
    @@tattles
  end
  
  def Tattletale.report(format = :compact)
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
end

module Kernel
  alias :original_raise :raise
  def raise(*args)
    exception = args.empty? ? $! : args[0]
    if exception.is_a?(String)
      exception = RuntimeError.new(exception)
      exception.set_backtrace(caller)
    end
    Tattletale.tattle(exception)
    original_raise(*args)
  end
end

if defined? Test::Unit::TestCase
  require 'tattletale/test/unit/tattletale_assertions'
end