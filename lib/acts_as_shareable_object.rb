require "acts_as_shareable_object/active_record/acts/shareable_object"

module ActsAsShareableObject
  if defined?(Rails::Railtie)
    class Railtie < Rails::Railtie
      initializer 'acts_as_shareable_object.include_in_active_record' do
        ActiveSupport.on_load :active_record do
          ActiveRecord::Base.send(:include, ActiveRecord::Acts::ShareableObject)
        end
      end
    end
  else
    ActiveRecord::Base.send(:include, ActiveRecord::Acts::ShareableObject) if defined?(ActiveRecord)
  end
end
