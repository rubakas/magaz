class AddReferenceToInvite < ActiveRecord::Migration
  def change
    add_reference :invites, :shop
  end
end
