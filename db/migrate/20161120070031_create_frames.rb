class CreateFrames < ActiveRecord::Migration[5.0]
  def change
    create_table :frames do |t|
      t.belongs_to :game, foreign_key: true
      t.integer :number
      t.integer :ball1
      t.integer :ball2
      t.integer :ball3
      t.integer :score, default: 0, nill: false
      t.integer :lack, default: 0, nill: false
      t.belongs_to :previous

      t.timestamps
    end
  end
end
