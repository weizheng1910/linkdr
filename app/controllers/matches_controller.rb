class MatchesController < ApplicationController
  def companiesmatch
    if current_user_company
      job_id = params[:jobs_id]
      if job_id
        @job = Job.find_by( id: job_id )
        populate_matches_for_company ( @job )
        @matches = Match.find_by(
          job: @job,
          job_like: nil
        )
      end
    end
  end

  def candidatesmatch
    if current_user_candidate
      populate_matches_for_candidate ( current_user_candidate )
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
    redirect_to '/candidates/' + id.to_s + '/matches'


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

  def populate_matches_for_company ( job )
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

end
