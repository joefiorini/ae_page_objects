module PageObjects
  module Authors
    class IndexPage < AePageObjects::Document
      path :authors

      class Table < AePageObjects::Collection
        self.item_class = AePageObjects::Element.new_subclass do
        private
          def configure(*)
            super
            @name = nil
          end
        end

      private
        def configure(*)
          super
          @name = nil
        end
      end

      collection :authors,
                 :is => Table,
                 :locator => "table",
                 :item_locator => [:xpath, ".//tr"] do

        element :first_name, :locator => '.first_name'
        element :last_name, :locator => '.last_name'

        def show_in_new_window
          node.click_link("Show In New Window")
        end

        def delayed_show!
          node.find(".js-delay-show").click
          stale!

          ShowPage.new
        end

        def show!
          node.click_link("Show")
          stale!

          ShowPage.new
        end
      end
    end
  end
end
