class RenameColumnCheckoutRefoundPolicyInSettings < ActiveRecord::Migration[4.2]
  def change
    rename_column :shops, :checkout_refound_policy, :checkout_refund_policy
  end
end
