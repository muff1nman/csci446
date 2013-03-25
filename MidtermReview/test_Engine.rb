#!/usr/bin/env ruby

require_relative 'engine.rb'
require 'test/unit'

class TestEngine < Test::Unit::TestCase

  def test_attr
    object = Engine::new()
    assert_equal( true, object.respond_to?(:horsepower), "Missing horsepower attribute")
    assert_equal( true, object.respond_to?(:volume), "Missing volume attribute")
    assert_equal( true, object.respond_to?(:cylinder_count), "Missing cylinder_count attribute")
  end

  def test_go
    object = Engine::new
    object.go
  end

  def test_reverse
    object = Engine::new
    assert_equal( "MOOORV", object.reverse, "Wasn't reversed" )
  end

  def test_manufacture
    object = Engine::manufacture( "hello" )
    assert_equal( "putt-putt-putt", object.test_noise, "manufacture not working")
  end

  def test_respondTo
    hemi = Engine::new
    assert_equal(true, hemi.respond_to?("to_s"),"responds to string")
    puts hemi.to_s
  end

end
