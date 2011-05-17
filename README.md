ResqueSendLater
============

A [Resque][rq] plugin. Requires Resque 1.9.10.

Implements an approximation of DelayedJob's send_later on resque.


Usage / Examples
================

Usage 1: Delaying an instance method call for any object that has a class find(id) method
(e.g., Rails ActiveRecord):

The class itself:

    class TestThing < ActiveRecord::Base
      include Resque::Plugins::SendLater
    
      def method_to_delay(arg1, arg2)
        <some code>
      end
    end

Delaying a method call on any instance of the class:

  t = TestThing.find(_id_)
  t.send_later(:method_to_delay, a1, a2)
  
Usage 2: Delaying a class method call on any class

The class itself:

    class TestThing
      include Resque::Plugins::SendLater
    
      def TestThing.class_method_to_delay(arg1, arg2)
        <some code>
      end
    end

Delaying a method call:

  TestThing.send_later(:class_method_to_delay, a1, a2)


Customize & Extend
==================

No options for now.


Install
=======

### As a gem

    $ gem install resque-send-later

### In a Rails app, as a plugin

    $ rails plugin install git://github.com/Mechaferret/resque-send-later.git


Acknowledgements
================

Copyright (c) 2011 Monica McArthur, released under the MIT license.

[rq]: http://github.com/defunkt/resque
