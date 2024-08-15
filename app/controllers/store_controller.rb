class StoreController < ApplicationController
  def index
    render inertia: 'Store/Index', props: {}
  end
end
