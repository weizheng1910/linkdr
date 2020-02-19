class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_company!, :except => [ :show ]

  # GET /jobs
  # GET /jobs.json
  def index
    company_id = current_user_company.id
    @jobs = Job.where(company_id: company_id)
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    if current_user_candidate
      redirect_to "/"
    end
    @job = Job.new
    @company = current_user_company.company
    @skills = Skill.all
  end

  # GET /jobs/1/edit
  def edit
    @skills = Skill.all
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)
    @job.company = current_user_company.company

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: "Job was successfully created." }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: "Job was successfully updated." }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_job
      @job = Job.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:title, :description, :company_id, :skill_ids => [])
    end
end
