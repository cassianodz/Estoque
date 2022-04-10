class MaterialsController < ApplicationController
  def index
    @materials = Material.where('quantidade > 0')
  end

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(material_params)
    @material.save
    redirect_to controller: 'pages', action: 'home'
  end

  def show
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])
    @valor_altera = calcula_valor
    @material.quantidade += @valor_altera
    @material.save
    salva_transacao
    redirect_to controller: 'pages', action: 'home'
    # @material.update(material_params)
  end

  def datepicker_input(form, field)
    content_tag :td, data: { provide: 'datepicker',
                             'date-format' => 'dd-mm-yyyy',
                             'date-autoclose' => 'true',
                             'language' => 'pt'} do
      form.text_field field, class: 'form-control', placeholder: 'DD-MM-YYYY'
    end
  end

  private

  def material_params
    params.require(:material).permit(:descricao, :lote, :vencimento,
                                     :quantidade, :observacao, :area,
                                     :sort, :qtd, :id, :qt_altera, :busca)
  end

  def salva_transacao
    @transacao = Transacao.new
    @transacao.material_id_id = @material.id
    @transacao.user_id_id = current_user.id
    @transacao.quantidade = @valor_altera
    @transacao.save
  end

  def calcula_valor
    return -1 * params[:material][:qt_altera].to_i unless params[:qtd] == "add"

    return params[:material][:qt_altera].to_i
  end
end
