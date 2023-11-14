# frozen_string_literal: true

class CategoryComponent < ViewComponent::Base
  def initialize(category: nil)
    @category = category
  end

  def title 
    @category ? @category.name : 'Todo'
  end

  def link 
    @category ? products_path(category_id: @category.id) : products_path
  end 

  def active?
    return true if !@category && !params[:category_id]
    @category&.id == params[:category_id].to_i
  end 
  def background 
    active? ? "bg-gray-300 text-teal-200" : "bg-white border-gray-600"
  end

  def classes
    "text-teal-800 px-4 py-1 rounded-2xl drop-shadow-sm  hover:border-gray-500 hover:bg-gray-300 hover:text-blue-500 #{background}" 
  end
end
