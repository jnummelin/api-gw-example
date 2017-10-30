class ImagesController < ApplicationController
  def initialize
    @@images ||= {}
  end

  def create
    unless params['image']['title'] && params['image']['link']
      render json: { platform: 'Title and link needed' }, status: 422
      return
    end

    image = params['image']
    id = SecureRandom.uuid
    image['id'] = id
    @@images[id] = image

    render json: image, status: 201
  end

  def index
    render json: @@images.values
  end


  def show
    render json: @@images[params[:id]]
  end
end
