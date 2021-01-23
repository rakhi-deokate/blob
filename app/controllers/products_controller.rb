class ProductsController < ApplicationController
  include ProductsHelper
  helper_method :sort_column, :sort_direction

  def index
    @products = Product.search(product_params[:search])
                       .order(sort_column + " " + sort_direction)
                       .paginate(:per_page => 3, :page => product_params[:page])
  end

  def import
    # Validate inputs with block
    begin
      file = product_params[:file]
      file_path = file.path
      Product.import(file_path)
      redirect_to root_url, notice: "Products imported."
    rescue
      redirect_to root_url, notice: "Invalid CSV file format."
    end
  end

  private

  def sort_column
    Product.column_names.include?(product_params[:sort]) ? product_params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(product_params[:direction]) ? product_params[:direction] : "asc"
  end

  def product_params
    params.permit(:id, :uid, :name, :quantity, :price, :comments, :released_at,
                  :file, :search, :page, :sort, :utf8,
                  :authenticity_token, :commit, :direction, :_)
  end
end
