class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: []

  def home
  binding.pry
    if not params[:search].nil?
      query = params[:search][:busca].downcase
      @materials = Material.where('lower(descricao) like ? OR lower(lote) like ? OR lower(observacao) like ? AND quantidade > 0', "%#{query}%", "%#{query}%", "%#{query}%")
      @materials = @materials.sort_by(&:vencimento)
    elsif not params[:filter].nil?
      case params[:filter]
        when "M"
          @materials = Material.where("area = 'Médico-Hospitalar'", "quantidade > 0" )
        when "O"
          @materials = Material.where("area ='Odontologia'", "quantidade > 0" )
        when "F"
          @materials = Material.where("area= 'Farmácia'", "quantidade > 0" )
        end
        @materials =  @materials.sort_by(&:vencimento)
    elsif not params[:sort].nil?
      @materials = Material.where('quantidade > 0')
      @materials = @materials.order(params[:sort])
    end
  end
end
