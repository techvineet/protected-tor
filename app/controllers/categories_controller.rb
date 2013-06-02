class CategoriesController < ApplicationController
  
  def load
    if params[:category].present? and params[:subcategory].present?
      category = Category.find_by_name(params[:category])
      subcategory = category.children.where(:name => params[:subcategory]).first
    elsif params[:category].present?
      category = Category.find_by_name(params[:category])
      subcategory = nil
    end
    
    subcategories = category.children
    json = []
    subcategories.each do |subcategory|
      json << { id: subcategory.name,  text: subcategory.name }
    end
    json = { :results => json, :category => category.name, :subcategory => (subcategory.nil? ? "" : subcategory.name) }
    
    render :json => json
  end
  
end
