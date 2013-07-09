module AePageObjects
  class Site
    attr_accessor :router

    def initialize
      @router = ApplicationRouter.new
    end

    def visit(document_class, *args)
      raise ArgumentError, "Cannot pass block to visit()" if block_given?

      full_path = router.generate_path(document_class.visitable_path, *args)

      unless full_path
        raise PathNotResolvable,
              "#{document_class.name} not visitable via #{document_class.visitable_path}(#{args.inspect})"
      end

      Capybara.current_session.visit(full_path)
      document_class.new(self)
    end

    def path_recognizes_url?(*args)
      self.router.path_recognizes_url?(*args)
    end
  end
end
