class StaticPagesController < ApplicationController
  def home
  end

	def all
		@projects = Project.all.reverse
	end

  def help
  end
end
