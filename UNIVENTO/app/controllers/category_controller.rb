class CategoryController < ApplicationController
  def index
  	respond_to do |format|
	    format.html{
	    	render plain: Category.select([:categoryID, :name]).map {|e| {categoryID: e.categoryID, name: e.name} } .to_json
	    	return
		}
	    format.json { 
	    	render :json => Category.select([:categoryID, :name]).map {|e| {categoryID: e.categoryID, name: e.name} }.to_json
	    }
	end
  end
end
