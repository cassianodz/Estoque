class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: []

  def home

    unless params[:search].nil?
      unless params[:search][:escolha_radio].nil?
        case params[:search][:escolha_radio]
        when "M"
          @materials = Material.where("area = 'Médico-Hospitalar'", "quantidade > 0" )
        when "O"
          @materials = Material.where("area ='Odontologia'", "quantidade > 0" )
        when "F"
          @materials = Material.where("area= 'Farmácia'", "quantidade > 0" )
        end
        @materials =  @materials.sort_by(&:vencimento)
        return @materials
      end
      query = params[:search][:busca].downcase
      @materials_copy = Material.where('lower(descricao) like ? OR lower(lote) like ? OR lower(observacao) like ? AND quantidade > 0', "%#{query}%", "%#{query}%", "%#{query}%")
    end
    select_dataset
  end


  private

  def select_dataset
    # TODO: Future update will store search params and it will be necessary to
    # sort between search and sort params
    if params[:sort].nil? && !params[:search].nil?
      @materials = @materials_copy.order(:vencimento)
    elsif params[:sort].nil? && params[:search].nil?
      @materials = Material.where('quantidade > 0')
      @materials = @materials.sort_by(&:vencimento)
    elsif !params[:sort].nil? && params[:search].nil?
      @materials = Material.where('quantidade > 0')
      @materials = @materials.order(params[:sort])
    elsif !params[:sort].nil? && !params[:search].nil?
      @materials = @materials_copy.order(params[:sort])
    end
    return @materials
  end
end
