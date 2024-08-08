class HomeController < ApplicationController
  def index
  end

  def show
    render inertia: 'Show', props: {user: {name: 'Nathan'}}
  end
end
