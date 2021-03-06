class ProjectsController < ApplicationController
  before_filter :admin_user, only: [:index]
  before_filter :correct_project_user, only: [:edit]
  before_filter :correct_project_user_update, only: [:update]
  before_filter :correct_project_user_destroy, only: [:destroy]

  # GET /projects
  # GET /projects.json

  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find_by_name(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find_by_name(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_path(@project.name), notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find_by_name(params[:project][:name])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to project_path(@project.name), notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to all_path }
      format.json { head :no_content }
    end
  end

  def vote_up
    begin
      current_user.vote_for(@project = Project.find(params[:id]))
      redirect_to :back, notice: 'Thanks for your vote.'
    rescue ActiveRecord::RecordInvalid
      redirect_to all_path, notice: 'VOTE ERROR: CANNOT COMPUTE'
    end
  end
end
