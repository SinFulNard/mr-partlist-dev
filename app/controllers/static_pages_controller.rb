class StaticPagesController < ApplicationController
  def home
  end

	def all
		@projects = Project.paginate(page: params[:page], per_page: 30).order('created_at DESC')
	end

  def help
  end
end
