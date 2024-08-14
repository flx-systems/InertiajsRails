class Product < ApplicationRecord
  has_one_attached :image

  include Rails.application.routes.url_helpers

  def get_image_url
    url_for(self.image)
  end
end
