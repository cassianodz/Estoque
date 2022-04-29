class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: []

  def home
    filtro = ''
    query = ''
    sort = ''
    ordem = ''
    if not params[:test].nil?
      if not params[:test].index("escolha_radio").nil?
        filtro = params[:test][params[:test].index('=')+1]
      end
      if not params[:test].index("?search").nil?
        query = params[:test][(params[:test].index('=')+1)..(params[:test].index('&commit')-1)]
      end
      if not params[:test].index("?sort").nil?
        ordem = params[:test][(params[:test].index('=')+1)..(params[:test].length-1)]
      end
    end
    if not params[:search].nil?
      query = params[:search][:busca].downcase
    end
    if not params[:sort].nil?
      ordem = params[:sort]
    end
    if not params[:filter].nil?
      filtro = params[:filter][:escolha_radio]
    end



    if not query == ''
      @materials = Material.where('lower(descricao) like ? OR lower(lote) like ? OR lower(observacao) like ? AND quantidade > 0', "%#{query}%", "%#{query}%", "%#{query}%")
      @materials = @materials.sort_by(&:vencimento)
    end

    if not filtro == ''
      case filtro
      when "M"
          @materials = Material.where("area = 'Médico-Hospitalar'", "quantidade > 0" )
      when "O"
          @materials = Material.where("area ='Odontologia'", "quantidade > 0" )
      when "F"
          @materials = Material.where("area= 'Farmácia'", "quantidade > 0" )
      end
        @materials =  @materials.order(:vencimento)
    end

    if  not ordem == ''
      @materials = Material.where('quantidade > 0')
      @materials = @materials.order(ordem)
    end

    if filtro == '' and ordem == '' and query == '' and sort == ''
      @materials = Material.where('quantidade > 0')
      @materials = @materials.order(:vencimento)
    end
      respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Posts: #{@materials.count}", template: "pages/pdf.html.erb"
      end
    end
  end

  def index
    binding.pry
    p "a"
  end


end
