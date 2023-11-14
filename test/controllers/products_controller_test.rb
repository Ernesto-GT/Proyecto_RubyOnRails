require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    gets products_path

    assert_response :success
    assert_select '.product', 2
      
    end
  end

  test 'render a ditailed product page' do 
    get product_path(products(:ps4)) #Pendiente Video 12

  end
end
