require 'csv'

class ProjectsController < ApplicationController
  before_action :logged_in_user
  before_action :find_project, only: [:show, :edit, :update, :import_files]
  
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
    Project.find_by(code: params[:code]).destroy
    flash[:success] = "Project deleted"
    redirect_to projects_url
  end
  
  def import_files
    puts "Processing files:"
    params[:project][:files].each do |file|
      
      puts file.original_filename
      
      # header = CSV.parse(file.tempfile, {headers: true, converters: :all})
      # json = file.tempfile.size > 2.megabytes ? "" : csv.map(&:to_h).to_json
      
      CSV.foreach(file.tempfile, headers: true) do |row|
        if @data_table.nil?
          @data_table = @project.data_tables.build(source_filename: file.original_filename,
                                   source_folder: "source_folder",
                                   header: row.headers.to_s.gsub("\"", ""),
                                   data: "")
          @data_table.save!
        else
          @data_record = @data_table.data_records.build(row: row)
          @data_record.save!
        end
      end
      
    end
    redirect_to project_url
  end
  
  private
  
    def project_params
      params.require(:project).permit(:code, :company_id, :files)
    end
    
    def find_project
      @project = Project.find_by(code: params[:code])
    end
end
