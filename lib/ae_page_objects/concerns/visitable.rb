module AePageObjects
  module Concerns
    module Visitable

      def self.included(target)
        target.extend ClassMethods
      end

    private
    
      def ensure_loaded!
        unless can_load_from_current_url?
          raise LoadingFailed, "#{self.class.name} cannot be loaded with url '#{current_url_without_params}'"
        end
      
        super
      end

      def can_load_from_current_url?
        return true if self.class.paths.empty?

        url = current_url_without_params

        self.class.paths.any? do |path|
          site.path_recognizes_url?(path, url)
        end
      end

      module ClassMethods

        def visitable_path
          paths.first
        end

        def paths
          @paths ||= []
        end

      private

        def path(path_method)
          raise ArgumentError, "path must be a symbol or string" if ! path_method.is_a?(Symbol) && ! path_method.is_a?(String)

          paths << path_method
        end
      end
    end
  end
end
