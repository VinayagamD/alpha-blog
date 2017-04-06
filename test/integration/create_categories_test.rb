require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "sports")
    @category2 = Category.create(name:"programming")
  end

  test "should show categories listing" do
    get categories_path
    assert_template 'categories/index'
=begin
    assert_select "a[href=?", category_path(@category), text: @category.name ,  class: "text-white"
    assert_select "a[href=?", category_path(@category2), text: @category2.name,  class: "text-white"
=end
  end

=begin
  test "get new category form and create category" do
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post categories_path, params: {  category:{ name: "sports"}}
      follow_redirect!
    end
    assert_template 'categories/index'
    assert_match "sports", response.body
  end

  test "invalid category submission results in failure" do
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count', 1 do
      post categories_path, params: {  category:{ name: ""}}
    end
    assert_template 'categories/new'

  end
=end

end