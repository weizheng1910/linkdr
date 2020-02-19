class CandidatesController < ApplicationController
  def index
  end

  def new
  end

  def show
    @candidate = Candidate.find(params[:id])   
  end

  def edit
    @candidate = Candidate.find(params[:id])
  end

  def create
  end

  def destroy
  end

  def update
    @candidate = Candidate.find(params[:id])
    @candidate.update(candidate_params)
    redirect_to @candidate
  end

private
  def candidate_params
    params.require(:candidate).permit(:given_name, :family_name, :years_of_experience, :expected_salary, :user_candidate_id)
  end
end
