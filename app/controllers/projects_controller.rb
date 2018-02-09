class ProjectsController < ApplicationController
  before_action :logged_in_user
  before_action :find_project, only: [:show, :edit, :update, :import_files, :destroy]
  
  def index
    if current_user.admin?
      @projects = Project.all.paginate(page: params[:page])
    else
      if Project.count > 0
        @projects = Project.find_by(company_id: current_user.company_id)
                           .paginate(page: params[:page])
      else
        @projects = Project.find_by(company_id: current_user.company_id)
      end
    end
  end
  
  def new
    @project = Project.new
  end
  
  def show
  end
  
  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:info] = "New project added."
      redirect_to projects_url
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @project.update_attributes(project_params)
      flash[:success] = "Project details updated"
      redirect_to projects_url
    else
      render 'edit'
    end
  end
  
  def destroy
    DestroyJob.perform_later(@project)
    redirect_to projects_url
  end
  
  def import_files
    puts "Processing files:"
    params[:project][:files].each do |file|
      puts file
      tempfile = Rails.root.join('app', 'assets', 'temp', file.original_filename)
      File.open(tempfile, 'wb') do |f|
        f.write(file.read)
      end
      ImportFileJob.perform_later(@project.code, tempfile.to_s)
      flash[:notice] = "Your file #{file.original_filename} has been uploaded and will be written to the database."   
    end
    # redirect_to data_table_path(code: @project.code, id: @data_table.id)
    redirect_to @project
  end
  
  private
  
    def project_params
      params.require(:project).permit(:code, :company_id, :files)
    end
    
    def find_project
      @project = Project.find_by(code: params[:code])
    end
end
