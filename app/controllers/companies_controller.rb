class CompaniesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user,      only: [:new, :edit, :udpate, :destroy]
  before_action :find_company,    only: [:edit, :udpate]
  
  def index
    @companies = Company.all.paginate(page: params[:page])
  end
  
  def new
    @company = Company.new
  end
  
  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:info] = "New company added."
      redirect_to companies_url
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @company.update_attributes(company_params)
      flash[:success] = "Company details updated"
      redirect_to companies_url
    else
      render 'edit'
    end
  end
  
  def destroy
    Company.find(params[:id]).destroy
    flash[:success] = "Company deleted"
    redirect_to companies_url
  end
  
  private
  
    def company_params
      params.require(:company).permit(:name, :alias, :address1, :address2,
                                      :city, :post_code, :country,
                                      :email, :contact_number)
    end
    
    def find_company
      @company = Company.find(params[:id])
    end
end
