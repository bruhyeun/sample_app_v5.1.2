class DataTablesController < ApplicationController
  before_action :logged_in_user
  
  def show
    @data_table = DataTable.find(params[:id])
    @data = JSON.parse(@data_table.data)
  end
end
