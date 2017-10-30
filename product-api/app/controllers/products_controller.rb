class ProductsController < ApplicationController
  def initialize
    @@products ||= {}
  end

  def create
    unless params['product']['title'] && params['product']['price']
      render json: { product: 'Title and price needed' }, status: 422
      return
    end

    product = params['product']
    id = SecureRandom.uuid
    product['id'] = id
    @@products[id] = product

    render json: product, status: 201
  end

  def index
    render json: @@products.values
  end


  def show
    if product = @@products[params[:id]]
      render json: product
    else
      render json: {product: "Not found"}, status: 404
    end
  end
end
