class CandidatesController < ApplicationController
  before_action :authenticate_user_candidate!, :except => [:show, :index]
  before_action :set_candidate, only: [:edit, :show, :update, :destroy]

  def index
  end

  def new
    @skills = Skill.all
  end

  def show
    if user_candidate_signed_in?
      redirect_to root_path
      # @matches = Match.where(candidate: @candidate, candidate_like: true)
      # populate_matches_for_candidate (current_user_candidate)
      # @candidate = current_user_candidate.candidate
      # @matches = Match.where(
      #   candidate: @candidate,
      #   job_like: nil,
      # )
    elsif user_company_signed_in?
      @company = current_user_company.company
      @matches = Match.where(candidate: @candidate)
      @matches.each do |match|
        if match.job_like and match.candidate_like and match.job.company == current_user_company.company
          @candidate = Candidate.find(params[:id])
          return
        end
      end
      redirect_to root_path and return
    end
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
      begin
      result = Cloudinary::Uploader.upload(params["candidate"]["resume"], :allowed_formats => ["pdf"])
      rescue => e
        if e
          redirect_to edit_candidate_path, flash: { error: "Please upload a PDF file!" }
          return
        end
      end
      @candidate.resume_url = result["url"]
      @candidate.update(candidate_params)
    else
      @candidate.update(candidate_params)
    end
    redirect_to dashboard_path
  end

  private

  def candidate_params
    params.require(:candidate).permit(:given_name, :family_name, :years_of_experience, :expected_salary, :user_candidate_id, :bio, :skill_ids => [])
  end

  def set_candidate
    @candidate = Candidate.find(params[:id])
  end

  def populate_matches_for_candidate(candidate)
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
