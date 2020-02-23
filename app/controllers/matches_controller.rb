class MatchesController < ApplicationController
  before_action :set_match, only: [:edit, :update, :destroy]

  def index
    # Route / job if they are a company
    # Need to refactor this to have pagination and reordering
    # (most recent candidates, mark them as being reached out to?)
    if current_user_company
      @company = current_user_company.company
      jobs = current_user_company.company.job
      array = []
      jobs.each do |job|
        array << Match.where(job_id: job.id)
      end
      @array = array

      # Route / job is they are a candidate
      # Require pagination and ordering on this matches list.
    elsif current_user_candidate
      @candidate = current_user_candidate.candidate
      @matches = Match.where(candidate_id: current_user_candidate.candidate.id)

      # If they are not logged in then redirect them to the index
    else
      redirect_to "/"
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
    respond_to do |format|
      if @match.update(match_params)
        if current_user_company
          if @match.job_like && @match.candidate_like
            UserMailer.with(candidate: @match.candidate.user_candidate).technical_test.deliver_now
            redirect_to @match.candidate
            return
          end
          format.html { redirect_to "/jobs/" + @match.job.id.to_s + "/matches/", notice: "Feedback accepted" }
        else
          format.html { redirect_to @match.job, notice: "Feedback accepted" }
          format.json { render :show, status: :ok, location: @match.job }
        end
      else
        format.html { render @match.job }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  # Match game for companies
  def companiesmatch
    if current_user_company
      job_id = params[:id]
      if job_id
        @job = Job.find_by(id: job_id)
        populate_matches_for_company (@job)
        @match = Match.order("candidate_like").find_by(
          job: @job,
          job_like: nil,
        )
        if @match
          @match.candidate.views += 1
          @match.candidate.save
        else
          redirect_to @job, notice: "No more candidates, womp womp"
          return
        end
      end
    end
  end

  # Match game for candidates
  def candidatesmatch
    if current_user_candidate
      populate_matches_for_candidate (current_user_candidate)
      @candidate = current_user_candidate.candidate
      @match = Match.where(
        candidate: @candidate,
        job_like: nil,
      )
    end
  end

  def likejob
    this_match = Match.find(params[:candidate_like][:match_id])

    if this_match.candidate_like == false || this_match.candidate_like == nil
      this_match.update_attributes(:candidate_like => true)
    else
      this_match.update_attributes(:candidate_like => false)
    end

    id = this_match.candidate_id
    redirect_to "/candidates/" + id.to_s + "/matches"
  end

  private

  def set_match
    @match = Match.find(params[:id])
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

  def populate_matches_for_company(job)
    @candidates = Candidate.all
    @candidates.each_with_index do |candidate, index|
      match = true
      job.skills.each do |skill|
        if candidate.skills.include? skill
          next
        else
          match = false
        end
      end
      if match == true
        Match.create(candidate: candidate, job: job)
      end
    end
  end

  def match_params
    params.require(:match).permit(:candidate, :job, :candidate_like, :job_like)
  end
end
