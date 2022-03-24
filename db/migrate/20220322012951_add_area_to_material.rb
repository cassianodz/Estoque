class AddAreaToMaterial < ActiveRecord::Migration[6.1]
  def change
    add_column :materials, :area, :string
  end
end
