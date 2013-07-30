class StaticPagesController < ApplicationController
  def home
  end

	def all
		#@projects = Project.all.reverse
		@projects = Project.paginate(page: params[:page], per_page: 30)
	end

  def help
  end
end
