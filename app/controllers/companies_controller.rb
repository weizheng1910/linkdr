class CompaniesController < ApplicationController
  before_action :authenticate_user_company!, :except => [:show, :index]

  def index
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    if current_user_company.company #company exists
      redirect_to "/"
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(company_params)
    if current_user_company.company
      redirect_to "/" # company exists. disallow creation
    else
      @company.user_company = current_user_company
      @company.save
      redirect_to @company # redirect to root path for now, may want to redirect to jobs
    end
  end

  def update
    @company = Company.update(company_params)
    redirect_to @company
  end

  def destroy
  end

  private

  def company_params
    params.require(:company).permit(:name, :industry, :size)
  end
end
