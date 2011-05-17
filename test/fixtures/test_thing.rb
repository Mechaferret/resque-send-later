class TestThing
  include Resque::Plugins::SendLater
  
  attr_accessor :id, :delayed_message
  @@delayed_class_message = nil
  @@delayed_message = nil

  def TestThing.find(_id)
    t = TestThing.new
    t.id = _id
    t
  end

  def ask_now(what)
    puts "You asked for #{what} from #{self.id} at #{Time.now}"
    self.send_later(:get_later, what)
  end
  
  def get_later(what)
    @@delayed_message = "You got #{what} from #{self.id}"
    puts "Do not panic. Thank you for your patience. #{@@delayed_message} at #{Time.now}!"
  end
  
  def self.ask_now(what)
    puts "You asked for #{what} from #{self.to_s} at #{Time.now}"
    TestThing.send_later(:get_later, what)
  end
  
  def self.get_later(what)
    @@delayed_class_message = "You got #{what} from #{self.to_s}"
    puts "Do not panic. Thank you for your patience. #{@@delayed_class_message} at #{Time.now}!"
  end
  
  def self.delayed_class_message
    @@delayed_class_message
  end

  def self.delayed_message
    @@delayed_message
  end

end
