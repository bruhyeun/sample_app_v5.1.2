class DataTablesController < ApplicationController
  before_action :logged_in_user

  def show
    @data_table = DataTable.find(params[:id])
    @project = @data_table.project
    @data_records = @data_table.data_records.paginate(page: params[:page]).per_page(@data_table.records_per_page.blank? ? 30 : @data_table.records_per_page)
  end
  
  def update
    # @data_table = DataTable.find(params[:id])
    # @data_table.records_per_page = params[:data_table][:records_per_page]
    # @project = @data_table.project
    # redirect_to @data_table
  end
  
  def destroy
    @data_table = DataTable.find(params[:id])
    @project = @data_table.project
    @data_table.destroy
    flash[:success] = "Data Table deleted"
    redirect_to project_url(@project)
  end
end
