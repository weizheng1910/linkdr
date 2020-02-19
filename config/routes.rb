Rails.application.routes.draw do
  get 'matches/matches'
  resources :candidates
  resources :companies
  devise_for :user_candidates, path: 'candidate', controllers: { sessions: 'user_candidates/sessions', registrations: 'user_candidates/registrations' }
  devise_for :user_companies, path: 'company', controllers: { sessions: 'user_companies/sessions', registrations: 'user_companies/registrations' }
  resources :jobs

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "dashboard#index"
  

  get "/companies/:id/dashboard" => "dashboard#show"
  get "/candidates/:id/dashboard" => "dashboard#show"


  get "/candidate/createprofile" => "candidates#edit"
  get "/candidate/:id/edit" => "candidates#edit"

  get "/companies/:id/matches" => "matches#companiesmatch"
  get "/candidates/:id/matches" => "matches#candidatesmatch"

  post "/candidates/:id/matches" => "matches#likejob"

end
