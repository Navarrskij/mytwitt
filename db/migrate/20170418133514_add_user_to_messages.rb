class AddUserToMessages < ActiveRecord::Migration[5.0]
  def change
  	add_belongs_to :messages, :user, foreign_key: true
  end
end
