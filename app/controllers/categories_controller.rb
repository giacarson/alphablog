class CategoriesController < ApplicationController

	before_action :require_admin, except: [:index, :show]

	def index
		@categories = Category.paginate(page: params[:page], per_page: 5)
		@page_title = "Categories"
	end

	def show
		@page_title = Category.name
	end

	def new
		@category = Category.new
		@page_title = "New Category"
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:success] = "Category added"
			redirect_to categories_path
		else
			render 'new'
		end
	end

	private

	def category_params
		params.require(:category).permit(:name)
	end

	def require_admin
		if !logged_in? || (logged_in? and !current_user.admin?) 
			flash[:danger] = "Only admins can create categories"
			redirect_to categories_path
		end
	end

end