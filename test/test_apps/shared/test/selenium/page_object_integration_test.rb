require 'selenium_helper'

class PageObjectIntegrationTest < Selenium::TestCase
  attr_reader :site

  setup :setup_site

  def test_load_ensuring
    visit("/books/new")
    
    exception = assert_raises AePageObjects::LoadingFailed do
      PageObjects::Authors::NewPage.new(site)
    end

    assert_equal "PageObjects::Authors::NewPage cannot be loaded with url '/books/new'", exception.message

    visit("/authors/new")

    assert_nothing_raised do
      PageObjects::Authors::NewPage.new(site)
    end
  end
  
  def test_simple_form
    new_page = site.visit(PageObjects::Books::NewPage)
    assert_equal "", new_page.title.value
    assert_equal "", new_page.index.pages.value

    new_page.title.set "Tushar's Dilemma"
    new_page.index.pages.set "132"
 
    assert_equal "Tushar's Dilemma", new_page.title.value
    assert_equal "132", new_page.index.pages.value
  rescue => e
    puts e.backtrace.join("\n")
    raise e      
  end
  
  def test_complex_form
    new_author_page = site.visit(PageObjects::Authors::NewPage)
    assert_equal "", new_author_page.first_name.value
    assert_equal "", new_author_page.last_name.value
    assert_equal "", new_author_page.books.first.title.value
    assert_equal "", new_author_page.books.last.title.value

    new_author_page.first_name.set "Michael"
    new_author_page.last_name.set "Pollan"
    new_author_page.books.first.title.set "In Defense of Food"
    new_author_page.books.last.title.set "The Omnivore's Dilemma"
 
    assert_equal "Michael", new_author_page.first_name.value
    assert_equal "Pollan", new_author_page.last_name.value
    assert_equal "In Defense of Food", new_author_page.books.first.title.value
    assert_equal "The Omnivore's Dilemma", new_author_page.books.last.title.value
  rescue => e
    puts e.backtrace.join("\n")
    raise e      
  end
  
  def test_element_proxy
    author = site.visit(PageObjects::Authors::NewPage)

    Capybara.using_wait_time(1) do
      assert author.rating.star.present?
      assert author.rating.star.visible?
      assert_false author.rating.star.not_present?
      assert_false author.rating.star.not_visible?

      author.rating.hide_star
      assert author.rating.star.present?
      assert_false author.rating.star.visible?
      assert_false author.rating.star.not_present?
      assert author.rating.star.not_visible?

      author.rating.show_star
      assert author.rating.star.present?
      assert author.rating.star.visible?
      assert_false author.rating.star.not_present?
      assert_false author.rating.star.not_visible?

      author.rating.remove_star
      assert_false author.rating.star.present?
      assert_false author.rating.star.visible?
      assert author.rating.star.not_present?
      assert author.rating.star.not_visible?
    end
  rescue => e
    puts e.backtrace.join("\n")
    raise e      
  end
  
  def test_element_proxy__not_present
    author = site.visit(PageObjects::Authors::NewPage)
    assert_false author.missing.present?
    assert author.missing.not_present?
  rescue => e
    puts e.backtrace.join("\n")
    raise e      
  end
  
  def test_element_proxy__nested
    author = site.visit(PageObjects::Authors::NewPage)

    Capybara.using_wait_time(1) do
      assert author.nested_rating.star.present?

      author.nested_rating.hide_star
      assert author.nested_rating.star.present?
      assert_false author.nested_rating.star.visible?

      author.nested_rating.show_star
      assert author.nested_rating.star.present?
      assert author.nested_rating.star.visible?

      author.nested_rating.remove_star
      assert_false author.nested_rating.star.present?
      assert_false author.nested_rating.star.visible?
    end
  rescue => e
    puts e.backtrace.join("\n")
    raise e      
  end

private

  def setup_site
    @site = PageObjects::Site.new
  end
end
