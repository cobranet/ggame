class CreateGameinvs < ActiveRecord::Migration
  def change
    create_table :gameinvs do |t|
      t.column :user_id, :integer
      t.timestamps
    end
  end
end
