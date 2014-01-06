module SimpleActivity
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'simple_activity' do |_app|
      SimpleActivity::Hooks.init
    end
  end
end
