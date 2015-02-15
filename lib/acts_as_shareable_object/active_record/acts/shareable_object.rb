require 'acts_as_shareable_object/active_record/acts/shareable_object/default_properties'

module ActiveRecord
  module Acts
    module ShareableObject
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_shareable_object(options = {})
          cattr_accessor :options
          self.options = options
          # delegate :url_helpers, to: 'Rails.application.routes'

          include InstanceMethods
        end
      end

      module InstanceMethods
        def social_meta_properties
          properties = values_for(ActiveRecord::Acts::ShareableObject::DefaultProperties.all)
          properties.merge! values_for(options) unless options.nil?
          properties
        end

        private

        def values_for(properties, namespace = nil)
          values = {}
          Array(properties).each do |property|
            if property.is_a?(Hash)
              property.map do |k, v|
                method = [namespace, k].compact.join("_")
                values[k] = respond_to?(method) ? send(method) : values_for(v, method)
              end
            else
              values[property] = send("#{namespace}_#{property}") if respond_to?("#{namespace}_#{property}")
            end
          end
          values.reject{ |k, v| v.empty? }
        end
      end
    end
  end
end
