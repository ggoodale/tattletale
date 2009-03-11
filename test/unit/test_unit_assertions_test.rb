#!/usr/bin/env ruby
$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")
require 'rubygems'
require 'test/unit'
require 'tattletale'

class TattletaleTest < Test::Unit::TestCase
  def test_detecting_unrescued_exceptions
    assert_raises(Test::Unit::AssertionFailedError) do
      assert_never_raised(RuntimeError) do 
        raise "boom"
      end    
    end
    assert_equal 1, Tattletale.tattles.length
  end

  def test_detecting_rescued_exceptions
    assert_never_raised(ArgumentError) do 
      begin
        raise "boom"
      rescue => e
        # we rescue, but the tattling is done...
      end
    end    
    assert_equal 1, Tattletale.tattles.length
  end

  def test_raising_what_should_never_be_raised
    assert_raises(Test::Unit::AssertionFailedError) do
      assert_never_raised(RuntimeError) do 
        begin
          raise "boom"
        rescue => e
          # we rescue, but the tattling is done...
        end
      end    
    end
  end
  
  def test_raising_multiple_exceptions
    assert_raises(Test::Unit::AssertionFailedError) do
      assert_never_raised(RuntimeError) do 
        begin
          raise "boom"
        rescue => e
          # we rescue, but the tattling is done...
        end
        begin
          raise "bang"
        rescue => e
          # Again, we rescue but the tattling is done...
        end
      end
    end
  end
end