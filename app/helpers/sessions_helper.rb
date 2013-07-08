module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
		if signed_in?
	    user == current_user
		end
  end

  def signed_in?
    !current_user.nil?
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, :notice => "Please sign in."
    end
  end

  def correct_quad_user
    @quad_owner = Quad.find(params[:id]).user
    redirect_to(all_path) unless current_user?(@quad_owner)
  end

  def correct_user
    @quad_owner = Quad.find_by_name(params[:id]).user
    redirect_to(all_path) unless current_user?(@quad_owner)
  end

  def correct_part_user
    @part_owner = Part.find(params[:id]).quad.user
    redirect_to(all_path) unless current_user?(@part_owner)
  end

	def admin_in?
		current_user.admin?
	end

	def admin_user
		unless admin_in?
			store_location
			redirect_to all_path, notice: "Admins only area."
		end
	end

end
