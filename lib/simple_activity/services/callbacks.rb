module SimpleActivity
  # The callback would be the module or class name.
  # It must be responsed to `process` method with argument of
  # activity.
  #
  #
  # Add option if need to process the callback in the backend.
  # The callback constant need to be responsible to add its own
  # backend worker which respond to `delay` as per backend_jobs
  # and sidekiq.
  #
  # @param const - the third party lib name in constant or string
  #
  #     SimpleActivity::Callbacks.add_callback('Foo')
  #     SimpleActivity::Callbacks.add_callback(Foo)
  #
  # @option backend: true 
  #         if true, will process the callback in backend by its own works
  class Callbacks
    @@callbacks = []

    def self.add_callback(name, options={})
      name = name.to_string unless name.kind_of?(String)
      @@callbacks << {name: name}.merge!(options)
    end

    def self.run_callbacks(activity)
      @@callbacks.each do |callback|
        const = Object.const_get callback[:name]
        if callback[:backend]
          const.delay.process(activity)
        else
          const.process(activity)
        end
      end
    end

    def self.delete_callback(name)
      @@callbacks.delete_if do |callback|
        callback[:name] == name
      end
    end

  end
end
