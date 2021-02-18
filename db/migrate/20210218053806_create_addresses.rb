class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string     :add_num,    null: false
      t.integer    :area,       null: false, index: true
      t.string     :city,       null: false
      t.string     :add_line,   null: false
      t.string     :add_build
      t.string     :tel_num,    null: false
      t.references :management, null: false, foreign_key: true
      t.timestamps
    end
  end
end
