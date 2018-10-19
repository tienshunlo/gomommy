class AddUserThenRemoveRecipientAndSenderToMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :recipient_id
    remove_column :messages, :sender_id
    add_reference :messages, :user, index: true
  end
end
