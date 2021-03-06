class CompaniesController < ApplicationController
  before_action :authenticate_user_company!, :except => [:show, :index]

  def index
    redirect_to dashboard_path
  end

  def show
    @company = Company.find(params[:id])
    if current_user_company
      if current_user_company.company == @company
      else
        @company.views += 1
        @company.save
      end
    else
      @company.views += 1
      @company.save
    end
  end

  def new
    if current_user_company.company #company exists
      redirect_to "/"
    end
  end

  def edit
    cookies.signed[:email] = current_user_company.email
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
    @company = Company.find(params[:id])
    if params["company"]["avatar"] != nil
      result = Cloudinary::Uploader.upload(params["company"]["avatar"])
      @company.avatar_url = result["url"]
      @company.update(company_params)
    else
      @company.update(company_params)
    end
    redirect_to "/dashboard/"
    # redirect_to '/companies/' + params[:id]
  end

  def destroy
  end

  private

  def company_params
    params.require(:company).permit(:name, :industry, :size)
  end
end
