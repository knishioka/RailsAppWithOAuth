class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :uid, null: false
      t.string :provider, null: false
      t.references :user, null: false

      t.timestamps
    end
    add_index :identities, :user_id
    add_index :identities, [:provider, :uid], unique: true
  end
end
