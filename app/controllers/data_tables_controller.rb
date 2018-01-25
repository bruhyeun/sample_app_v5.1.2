class DataTablesController < ApplicationController
  before_action :logged_in_user

  def show
    @data_table = DataTable.find(params[:id])
    @data_records = @data_table.data_records.paginate(page: params[:page])
  end
end
