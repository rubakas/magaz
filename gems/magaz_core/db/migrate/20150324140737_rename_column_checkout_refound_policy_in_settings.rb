class RenameColumnCheckoutRefoundPolicyInSettings < ActiveRecord::Migration
  def change
    rename_column :shops, :checkout_refound_policy, :checkout_refund_policy
  end
end
