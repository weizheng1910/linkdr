class CandidatesController < ApplicationController
  before_action :authenticate_user_candidate!, :except => [:show, :index]

  def index
  end

  def new
    @skills = Skill.all
  end

  def show
    # @candidate = Candidate.find(params[:id])
    populate_matches_for_candidate ( current_user_candidate )
      @candidate = current_user_candidate.candidate
      @matches = Match.where(
        candidate: @candidate,
        job_like: nil,
      )
  end

  def edit
    @candidate = Candidate.find(params[:id])
    @skills = Skill.all
  end

  def create
  end

  def destroy
  end

  def update
    @candidate = Candidate.find(params[:id])
    if params["candidate"]["resume"] != nil
      result = Cloudinary::Uploader.upload(params["candidate"]["resume"], :allowed_formats => ["pdf"])
      @candidate.resume_url = result["url"]
      @candidate.update(candidate_params)
    else
      @candidate.update(candidate_params)
    end
    redirect_to @candidate
  end

  private

  def candidate_params
    params.require(:candidate).permit(:given_name, :family_name, :years_of_experience, :expected_salary, :user_candidate_id)
  end

  private

  def populate_matches_for_candidate ( candidate )
    @jobs = Job.all
    @jobs.each_with_index do |job, index|
      match = true
      job.skills.each do |skill|
        if candidate.candidate.skills.include? skill
          next
        else
          match = false
        end
      end
      if match == true
        Match.create(candidate: candidate.candidate, job: job)
      end
    end
  end


end
