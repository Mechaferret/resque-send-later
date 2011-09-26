require 'resque/plugins/send_later'

ActiveSupport::Notifications.subscribe(/resque-send-later/) do |name, start, finish, id, payload|
  puts "got resque data warehouse notification"
  to_redis = [name, start, finish, start.to_f, finish.to_f, finish.to_f-start.to_f, id, payload]
  puts to_redis.to_json
  Resque.redis.rpush("instrumentation", to_redis.to_json)
end
