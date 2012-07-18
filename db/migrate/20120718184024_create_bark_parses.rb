class CreateBarkParses < ActiveRecord::Migration
  def change
    create_table :bark_parses do |t|
      t.integer :bark_id
      t.text :x_choice
      t.string :x_hyper0
      t.string :x_hyper1
      t.text :x_hyper2plus
      t.string :x_loc_hyper0
      t.string :x_loc_hyper1
      t.text :x_loc_hyper2plus
      t.text :x_clause
      t.text :x_pp
      t.text :y_category
      t.string :y_hyper0
      t.string :y_hyper1
      t.text :y_hyper2plus
      t.string :y_loc_hyper0
      t.string :y_loc_hyper1
      t.text :y_loc_hyper2plus
      t.text :y_clause
      t.text :y_pp
      t.text :z_reason

      t.timestamps
    end
  end
end
