module Verifiable
  extend ActiveSupport::Concern

  def detect_invalid_user
    unless current_user.admin_role?
      denied_action if @production.user_name != current_user.name
    end
  end

  def denied_action
    redirect_to root_path, alert: "У вас нет доступа к этой странице"
  end
end
