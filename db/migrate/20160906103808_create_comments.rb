# frozen_string_literal: true
class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :text
      t.references :task, foreign_key: true
      t.string :attachment

      t.timestamps
    end
  end
end
