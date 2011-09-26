module Resque
  module Plugins
    module SendLater
      begin
        include Spawn
      rescue
      end
    	def self.included(base)
        base.extend self
      end
      
      def send_later(method, *args)
        if self.instance_of? Class
          classname = self.to_s
          refid = nil
        else
          classname = self.class.to_s
          refid = self.id
        end
        Resque.enqueue(Resque::Plugins::SendLater::DelayedPerformer, classname, refid, method, *args)
      rescue Exception => ex
        handle_exception(ex, method, *args)
      end
      
      
      def handle_exception(ex, method, *args)
        # Try to spawn instead
        if defined? Spawn
          puts "transaction spawning due to exception #{ex.inspect} #{ex.backtrace.join("\n")}"
          spawn do
            self.send(method, *args)
          end
        else
          puts "no way to handle transaction with exception #{ex.inspect} #{ex.backtrace.join("\n")}"
        end
      end
      
      class DelayedPerformer
        @queue = :method

        def self.perform(klass, object_id, method, *args)
          ActiveSupport::Notifications.instrument("perform.resque-send-later", :method_info=>[klass, object_id, method, *args].to_json) do
            if object_id.nil? # class method delay
              klass.constantize.send(method, *args)
            else
              model = klass.constantize.send(:find, object_id)
              model.send(method, *args)
            end
          end
        end

      end

    end
  end
end
