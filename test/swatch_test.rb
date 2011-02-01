#!/usr/bin/env ruby

#
#------------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# <mayeu.tik@gmail.com> wrote this file. As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer in return. Matthieu Maury
#------------------------------------------------------------------------------
#

require_relative '../lib/swatch'
require 'FileUtils'
require 'test/unit'

class TestSwatch < Test::Unit::TestCase

  Swatch::TRACK_FILE = File.expand_path './swatch.txt'

  def setup
    open(Swatch::TRACK_FILE, 'w+'){}
  end

  def teardown
    FileUtils.rm(Swatch::TRACK_FILE)
  end

  # Testing running_task?
  def test_running_task?
    # No running task
    assert_equal false, Swatch::running_task?
    # Add a running task
    open(Swatch::TRACK_FILE, 'w+'){|f| f.print "Test\t#{Time.now.to_i}"}
    assert_equal true, Swatch::running_task?
    # Finish the task
    open(Swatch::TRACK_FILE, 'a+'){|f| f.print "\t#{Time.now.to_i}\n"}
    assert_equal false, Swatch::running_task?
  end

  # Testing get_last_task_name
  def test_get_last_task_name
    # No task in the file
    assert_equal false, Swatch::get_last_task_name
    # Add a running task
    open(Swatch::TRACK_FILE, 'w+'){|f| f.print "Test\t#{Time.now.to_i}"}
    assert_equal "Test", Swatch::get_last_task_name
    # End the running task
    open(Swatch::TRACK_FILE, 'a+'){|f| f.print "\t#{Time.now.to_i}\n"}
    assert_equal "Test", Swatch::get_last_task_name
  end

  # Testing task_in
  def test_task_in
    # No task given in argument
    assert_equal false, Swatch::task_in("")
    # Add a task
    assert_equal true, Swatch::task_in("Test")
    assert_equal "Test", Swatch::get_last_task_name
  end

  # Testing task_out
  def test_task_out
    # No task to finish
    assert_equal false, Swatch::task_out
    # We add a task
    assert_equal true, Swatch::task_in("Test")
    assert_equal true, Swatch::task_out
  end
end
