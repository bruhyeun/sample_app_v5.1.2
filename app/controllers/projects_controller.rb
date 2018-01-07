class ProjectsController < ApplicationController
  before_action :logged_in_user
  
  def index
    if current_user.admin?
      @projects = Project.all.paginate(page: params[:page])
    else
      if Project.count > 0
        @projects = Project.find_by(company_id: current_user.company_id).paginate(page: params[:page])
      else
        @projects = Project.find_by(company_id: current_user.company_id)
      end
    end
  end
  
  def new
    @project = Project.new
  end
  
  def show
    @project = Project.find_by(code: params[:code])
    @db = connect_db @project.code
  end
  
  def create
    @project = Project.new(project_params)
    if create_db(@project.code).nil?
      if @project.save
        flash[:info] = "New project added."
        redirect_to projects_url
      else
        delete_db(@project.code)
        render 'new'
      end
    else
      flash[:error] = "Unable to create database. Project not created."
    end
  end
  
  def edit
    @project = Project.find_by(code: params[:code])
  end
  
  def update
    @project = Project.find_by(code: params[:code])
    if @project.update_attributes(project_params)
      flash[:success] = "Project details updated"
      redirect_to projects_url
    else
      render 'edit'
    end
  end
  
  def destroy
    if archive_db(params[:code]).nil?
      flash[:error] = "Unable to archive database. Project not deleted."
    else
      Project.find_by(code: params[:code]).destroy
      flash[:success] = "Project deleted"
      redirect_to projects_url
    end
  end
  
  def upload
    @project = Project.find_by(code: params[:code])
    @files = params[:project][:files]
    puts "Processing files"
    puts @files.original_filename
    redirect_to project_url
  end
  
  private
  
    def project_params
      params.require(:project).permit(:code, :company_id, :files)
    end
    
    def create_db(code)
      puts "Creating SQLite database for #{code}"
      begin
        SQLite3::Database.new("db/#{code}.sqlite3")
      rescue => e
        puts e
        return nil
      end
      puts "SQLite database created for #{code}"
    end
    
    def connect_db(code)
      puts "Connecting to SQLite database for #{code}"
      begin
        return SQLite3::Database.new("db/#{code}.sqlite3")
      rescue => e
        puts e
        return nil
      end
    end
    
    def archive_db(code)
      puts "Archiving SQLite database for #{code}"
      begin
        File.rename "db/#{code}.sqlite3", "db/archive/#{Time.now.strftime("%Y%m%d%H%M%S")}_#{code}.sqlite3"
        puts "SQLite database for #{code} has been archived"
        return 0
      rescue => e
        puts e
        return nil
      end
    end
    
    def delete_db(code)
      puts "Archiving SQLite database for #{code}"
      begin
        File.delete "db/#{code}.sqlite3"
        puts "SQLite database for #{code} has been archived"
        return 0
      rescue => e
        puts e
        return nil
      end
    end
end