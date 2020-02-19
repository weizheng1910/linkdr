class MatchesController < ApplicationController
  def companiesmatch
    render plain: "companies match here"
  end

  def candidatesmatch
    render plain: "candidates match here"
  end
end
