class TransacaosController < ApplicationController

  def new
    @transacao = Transacao.new
  end

  def create
    @transacao = Transacao.new(transacao_params)
    @transacao.save
    redirect_to controller: 'pages', action: 'home'
  end

  def show
    @transacaos = Transacao.all
    @transacaos = @transacaos.order(created_at: :desc)
    cria_string_relatorio
    @transacaos = @resultado
  end

  private

  def transacao_params
    params.require(:transacao).permit(:material_id_id, :user_id_id, :quantidade)
  end

  def cria_string_relatorio
    @resultado = []
    formato_hora = "%d/%m/%Y-%H:%M"
    @transacaos.each do |transacao|
      material = Material.find(transacao.material_id_id)
      usuario = User.find(transacao.user_id_id)
      @resultado.append("Usuário #{usuario.email} alterou a quantidade do material
                       #{material.descricao} em #{transacao.quantidade} em
                       #{transacao.created_at.strftime(formato_hora)}")
    end
  end
end
