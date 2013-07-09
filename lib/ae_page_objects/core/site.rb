module AePageObjects
  class Site
    extend AePageObjects::Singleton

    class << self
      private :new

      def initialize!
        instance.initialize!
      end

      def router=(router)
        instance.router = router
      end

      def document
        @document_class ||= Class.new(Document).tap do |klazz|
          klazz.page_objects_site_class = self
        end
      end
    end

    attr_writer :router

    def path_recognizes_url?(*args)
      self.router.path_recognizes_url?(*args)
    end

    def generate_path(*args)
      self.router.generate_path(*args)
    end

    def router
      @router ||= ApplicationRouter.new
    end

    def initialize!
    end
  end
end
