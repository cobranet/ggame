class CreateGameapplications < ActiveRecord::Migration
  def change
    create_table :gameapplications do |t|
      t.column :gameinv_id , :integer
      t.column :user_id, :integer
      t.column :state, :integer # 0 - not accepted , 1 - accepted
      t.timestamps
    end
  end
end
