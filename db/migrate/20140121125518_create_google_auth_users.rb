class CreateGoogleAuthUsers < ActiveRecord::Migration
  def change
    create_table :google_auth_users do |t|
      t.integer "user_id"
      t.string  "provider"
      t.string  "uid"
    end
  end
end
