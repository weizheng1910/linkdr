class JobsController < ApplicationController
  before_action :set_job, only: [:edit, :update, :destroy]
  before_action :authenticate_user_company!, :except => [:index, :show, :filter_job_company]

  # GET /jobs
  # GET /jobs.json
  def index
    sort_by = params["sort"]
    items_to_display = current_user_company ? 5 : 6
    if @candidate
      jobs_to_exclude = Job.joins(:matches).where("candidate_id = ? AND job_like = false", @candidate.id).pluck(:id)
      jobs_to_exclude << Job.joins(:matches).where("candidate_id= ? AND candidate_like = false", @candidate.id).pluck(:id)
      jobs_to_exclude.flatten!
    else
      jobs_to_exclude = nil
    end
    if sort_by == "salary asc"
      @pagy, @records = pagy(Job.order("offered_salary ASC").where.not(id: jobs_to_exclude), items: items_to_display)
    elsif sort_by == "salary desc"
      @pagy, @records = pagy(Job.order("offered_salary DESC").where.not(id: jobs_to_exclude), items: items_to_display)
    elsif sort_by == "best matches"
      @pagy, @records = pagy_array(Job.where.not(id: jobs_to_exclude).sort_by { |job| (job.skills & @candidate.skills).length - job.skills.length }.reverse, items: items_to_display)
    elsif sort_by == "newest jobs"
      @pagy, @records = pagy(Job.order("created_at DESC").where.not(id: jobs_to_exclude), items: items_to_display)
    else
      @pagy, @records = pagy(Job.where.not(id: jobs_to_exclude), items: items_to_display)
    end
  end

  def filter_job_company
    company_id = params[:id]
    @jobs = Job.where(company_id: company_id)
    render :index
  end

  # GET /jobs/1
  # GET /jobs/1.json
  # Anyone can see a job, hence it skips the validation in :set_job
  def show
    @job = Job.find(params[:id])
    if @candidate
      if @job.matches.any? { |m| m.candidate_id == @candidate.id && (m.candidate_like == false || m.job_like == false) }
        redirect_to '/dashboard/'
        return
      end
    end
    candidate_match_skills
    if @company == @job.company
      @matches = Match.where(job_id: @job.id, candidate_like: true)
    end

    @job.views += 1
    @job.save
  end

  # GET /jobs/new
  def new
    if current_user_candidate
      redirect_to root
    end
    @job = Job.new
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
    @job.country = @job.country_name
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
        @job.country = @job.country_name
        @job.save
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
    @job.matches.each {|m| m.room.destroy }
    @job.matches.destroy_all
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def candidate_match_skills
    match = true
    passing_percentage = 80

    if @candidate
      overlap_percentage = ((@candidate.skills & @job.skills).length.to_f / @job.skills.length.to_f) * 100
      if overlap_percentage >= passing_percentage
        match = true
      else
        match = false
      end

      if match == true
        Match.create(candidate: @candidate, job: @job)
        @match = Match.find_by(candidate: @candidate, job: @job)
      end
    end
  end

  # Set the job, also check that the user is allowed to see/edit the job.
  # Candidates should be able to see any job.
  def set_job
    company = current_user_company.company
    @job = Job.find(params[:id])
    if @job.company == company
      return
    else
      @job = nil
      redirect_to "/"
      return false
    end
  end

  # Only allow a list of trusted parameters through.
  def job_params
    params.require(:job).permit(:title, :description, :offered_salary, :country, :company_id, :skill_ids => [])
  end
end
