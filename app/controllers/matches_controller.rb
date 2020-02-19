class MatchesController < ApplicationController
  def companiesmatch
    render plain: "companies match here"
  end

  def candidatesmatch
    if current_user_candidate
      populate_matches_for_candidate ( current_user_candidate )
    end
    render plain: "candidates match here"
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
