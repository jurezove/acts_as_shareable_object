require 'acts_as_shareable_object/active_record/acts/shareable_object/default_properties'

module ActiveRecord
  module Acts
    module ShareableObject
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_shareable_object(options = {})
          cattr_accessor :shareable_options
          self.shareable_options = [options].flatten
          # delegate :url_helpers, to: 'Rails.application.routes'

          include InstanceMethods
        end
      end

      module InstanceMethods
        def social_meta_properties
          properties = values_for(ActiveRecord::Acts::ShareableObject::DefaultProperties.all)
          properties.merge! values_for(shareable_options) unless shareable_options.nil?
          properties
        end

        private

        def values_for(properties, namespace = nil)
          Array(properties).inject({}) do |memo, property|
            if property.is_a?(Hash)
              property.map do |k, v|
                method = [namespace, k].compact.join("_")
                memo[k] = respond_to?(method) ? send(method) : values_for(v, method)
              end
            else
              method = [namespace, property].compact.join("_")
              memo[property] = send(method) if respond_to?(method)
            end
            memo
          end.reject{ |k, v| v.empty? }
        end
      end
    end
  end
end
