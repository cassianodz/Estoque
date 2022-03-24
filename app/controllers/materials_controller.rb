class MaterialsController < ApplicationController

  def index
    @materials = Material.all

    #@materials = Material.order(params[:sort])
  end

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(material_params)
    @material.save
  end

  def show
    @material = Material.find(params[:id])
  end

  def datepicker_input form, field
    content_tag :td, :data => {:provide => 'datepicker', 'date-format' => 'dd-mm-yyyy', 'date-autoclose' => 'true', 'language' => 'pt'} do
      form.text_field field, class: 'form-control', placeholder: 'DD-MM-YYYY'
    end
  end

  private

  def material_params
    params.require(:material).permit(:descricao, :lote, :vencimento,
      :quantidade, :observacao, :area, :sort)
  end
end
