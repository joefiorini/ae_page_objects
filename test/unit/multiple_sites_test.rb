require 'unit_helper'

class AePageObjects::MultipleSitesTest < Test::Unit::TestCase
  
  module TestApp1
    module AePageObjects
      class Site < ::AePageObjects::Site
      end
    end
  end
  
  module TestApp2
    module AePageObjects
      class Site < ::AePageObjects::Site
      end
    end
  end
  
  def test_initialize_works
    assert_nothing_raised do
      TestApp1::AePageObjects::Site.new
      TestApp2::AePageObjects::Site.new
      AePageObjects::Site.new
    end
  end
end
