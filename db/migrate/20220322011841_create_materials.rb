class CreateMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :materials do |t|
      t.string :descricao
      t.string :lote
      t.date :vencimento
      t.integer :quantidade
      t.string :observacao

      t.timestamps
    end
  end
end
