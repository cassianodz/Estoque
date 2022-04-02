class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if !params[:search].nil?
      query = params[:search][:busca].downcase
      @materials_copy = Material.where('lower(descricao) like ? OR lower(lote) like ? OR lower(observacao) like?',
                                       "%#{query}%", "%#{query}%", "%#{query}%")
    end

    if params[:sort].nil? && !params[:search].nil?
      @materials = @materials_copy.order(:vencimento)
    elsif params[:sort].nil? && params[:search].nil?
      @materials = Material.order(:vencimento)
    elsif !params[:sort].nil? && params[:search].nil?
      @materials = Material.order(params[:sort])
    elsif !params[:sort].nil? && !params[:search].nil?
      @materials = @materials_copy.order(params[:sort])
    end
  end
end
