class HomeController < ApplicationController
  def index
    products = Product.all.map do |p|
      { id: p.id, name: p.name, description: p.description, price: p.price, image: p.image.attached? ? url_for(p.image) : null }
    end
    render inertia: 'Home/Index', props: { products: products }
  end

  def show
    render inertia: 'Show', props: { user: { name: 'Nathan' } }
  end
end
