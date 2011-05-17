require File.expand_path('test_helper.rb', File.dirname(__FILE__))

class SendLaterTest < Test::Unit::TestCase

  def setup
    $success = $lock_failed = $lock_expired = 0
    Resque.redis.flushall
    @worker = Resque::Worker.new(:method)
  end

  def test_lint
    assert_nothing_raised do
      Resque::Plugin.lint(Resque::Plugins::SendLater)
    end
  end

  def test_instance_send_later
    t = TestThing.new
    t.id = 11
    t.ask_now('instance request')
    @worker.process
    assert_equal TestThing.delayed_message, "You got instance request from 11"
  end

  def test_class_send_later
    TestThing.ask_now('class request')
    @worker.process
    assert_equal TestThing.delayed_class_message, 'You got class request from TestThing'
  end

end