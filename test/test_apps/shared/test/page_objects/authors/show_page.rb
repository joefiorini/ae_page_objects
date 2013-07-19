module TestApp
  module PageObjects
    module Authors
      class ShowPage < PageObjects::Site.document
        path :author

        element :first_name
        element :last_name
      end
    end
  end
end
