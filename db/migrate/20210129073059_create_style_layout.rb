class CreateStyleLayout < ActiveRecord::Migration[6.0]
  def change
    create_table :style_layouts do |t|
      t.integer :company_id
      t.string :brand_colour
    end
  end
end
