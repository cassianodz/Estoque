class CreateTransacaos < ActiveRecord::Migration[6.1]
  def change
    create_table :transacaos do |t|
      t.references :material_id
      t.references :user_id
      t.integer :quantidade

      t.timestamps
    end
  end
end
