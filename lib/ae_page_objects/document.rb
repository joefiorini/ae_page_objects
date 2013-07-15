module AePageObjects
  class Document < Node
    include Concerns::Visitable

    attr_reader :site

    def initialize(site)
      @site = site

      super(Capybara.current_session)
    end

    def document
      self
    end
  end
end