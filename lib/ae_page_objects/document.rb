module AePageObjects
  class Document < Node
    include Concerns::Visitable
    
    def initialize
      super(Capybara.current_session)
    end

    def document
      self
    end
    
    class << self
      attr_accessor :page_objects_site_class

    private
      def site
        @site ||= page_objects_site_class.instance
      end
    end
  end
end