#!/usr/bin/env ruby

require 'rubygems'
require 'test/unit'
require 'tattletale'

class TattletaleTest < Test::Unit::TestCase
  def test_never_raised
    assert_never_raised(RuntimeError) do
      begin
        raise "boom"
      rescue => e
        # we rescue, but the tattling is done...
      end
    end
  end
end