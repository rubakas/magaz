class AddToSettingsNotificationsEmailOfUserSelect < ActiveRecord::Migration
  def change
    add_column :shops, :notificatification_user_email_selection, :string
    add_column :shops, :notificatification_selected_user_email,  :string
  end
end
