Gem::Specification.new do |s|
  s.name              = 'resque-send-later'
  s.version           = '0.1.0'
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "A Resque plugin that implements an approximation of DelayedJob's send_later on resque."
  s.homepage          = 'http://github.com/mechaferret/resque-send-later'
  s.email             = 'mechaferret@gmail.com'
  s.authors           = ['Monica McArthur']
  s.has_rdoc          = false

  s.files             = %w(README.md Rakefile MIT-LICENSE HISTORY.md)
  s.files            += Dir.glob('lib/**/*')
  s.files            += Dir.glob('test/**/*')

  s.add_dependency('resque', '>= 1.9.10')

  s.description       = <<-DESC
    A Resque plugin. Implements an approximation of DelayedJob's send_later on resque. Has a little more ease-of-use and features than the example provided with Resque.
  DESC
end
