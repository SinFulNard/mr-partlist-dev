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

  def current_user?(project)
		if signed_in?
	    project.user == current_user
		else
			if request.remote_ip == project.remote_ip && project.created_at >= 60.minutes.ago
				true
			end
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

  def correct_project_user
		if signed_in?
	    @project = Project.find_by_name(params[:id])
	    redirect_to(all_path) unless current_user?(@project)
		else
      redirect_to(root_path) unless request.remote_ip == Project.find_by_name(params[:id]).remote_ip
		end
  end

  def correct_project_user_update
    if signed_in?
      @project = Project.find_by_name(params[:project][:name])
      redirect_to(all_path) unless current_user?(@project)
    else
      redirect_to(root_path) unless request.remote_ip == Project.find_by_name(params[:id]).remote_ip
    end
  end

  def correct_user
    @project_owner = Project.find_by_name(params[:id]).user
    redirect_to(all_path) unless current_user?(@project_owner)
  end

  def correct_part_user
		if signed_in?
	    @part_project = Part.find(params[:id]).project
  	  redirect_to(all_path) unless current_user?(@part_project)
		else
			redirect_to(root_path) unless request.remote_ip == Part.find(params[:id]).remote_ip
		end
  end

	def admin_in?
    if signed_in?
			current_user.admin?
		end
	end

	def admin_user
		unless admin_in?
			store_location
			redirect_to all_path, notice: "Admins only area."
		end
	end

end
