class AdminServices::Invite::CreateInvite

  attr_reader :success, :user, :link, :errors
  alias_method :success?, :success

  def initialize(url_building_proc: nil, email: nil, shop_id: nil)
    @user = User.new
    @url_building_proc = url_building_proc
    @email = email
    @shop_id = shop_id
  end

  def run
    User.connection.transaction do
      begin
        _create_user_with_email_and_token
        _generate_link_for_user
        _send_mail_invite
        @success = true
      rescue RuntimeError
        raise ActiveRecord::Rollback
      end
    end
    self
  end

  private

  def _generate_link_for_user
    @link = @url_building_proc.call(@user)
  end

  def _create_user_with_email_and_token
    @user.update_attributes(email: @email, shop_id: @shop_id)
    @user.invite_token = Digest::SHA1.hexdigest([@user.id, Time.now, rand].join)
    if @user.valid?(:invite)
      @user.save!(validate: false)
    else
      @success = false
      @errors = @user.errors
      fail
    end
  end

  def _send_mail_invite
    UserMailer.invite_new_user(@user, link).deliver_now || fail
  end
end
