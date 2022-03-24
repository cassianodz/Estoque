class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @materials = Material.order(params[:sort])
  end

end
