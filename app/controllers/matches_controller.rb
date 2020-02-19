class MatchesController < ApplicationController
  def companiesmatch
    if current_user_company
      job_id = params[:jobs_id]
      if job_id
        @job = Job.find_by( job_id: job_id )
        populate_matches_for_company ( @job )
        @match = Match.find_by(
          job: @job,
          job_like: nil
        )
        render plain: "companies match here"
      end
    end
  end

  def candidatesmatch
    if current_user_candidate
      populate_matches_for_candidate ( current_user_candidate )
      @match = Match.find_by(
        candidate: current_user_candidate.candidate,
        candidate_like: nil
      )
    end
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
