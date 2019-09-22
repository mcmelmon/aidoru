class CreateContactMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_messages do |t|
      t.string :email
      t.text :message

      t.timestamps
    end
  end
end
