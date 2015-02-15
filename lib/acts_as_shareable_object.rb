require "acts_as_shareable_object/active_record/acts/shareable_object"
require "acts_as_shareable_object/action_view/shareable_object/view_helpers"

module ActsAsShareableObject
  if defined?(Rails::Railtie)
    class Railtie < Rails::Railtie
      initializer 'acts_as_shareable_object.include_in_active_record' do
        ActiveSupport.on_load :active_record do
          ActiveRecord::Base.send(:include, ActiveRecord::Acts::ShareableObject)
        end
      end

      initializer 'acts_as_shareable_object.view_helpers' do
        ActionView::Base.send(:include, ActionView::ShareableObject::ViewHelpers)
      end
    end
  else
    ActiveRecord::Base.send(:include, ActiveRecord::Acts::ShareableObject) if defined?(ActiveRecord)
    ActionView::Base.send(:include, ActionView::ShareableObject::ViewHelpers) if defined?(ActionView)
  end
end
