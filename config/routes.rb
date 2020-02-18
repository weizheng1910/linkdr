Rails.application.routes.draw do
  resources :candidates
  devise_for :user_candidates, path: 'candidate', controllers: { sessions: 'user_candidates/sessions', registrations: 'user_candidates/registrations' }
  devise_for :user_companies, path: 'companies', controllers: { sessions: 'user_companies/sessions', registrations: 'user_companies/registrations' }
  resources :jobs

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/companies/new" => "companies#new"
  post "/companies/new" => "companies#create", as:"new_company"
  get "/companies/:id" => "companies#show", as: "company"
  get "/companies/:id/edit" => "companies#edit"
  patch "/companies/:id" => "companies#update"

  get "/candidate/createprofile" => "candidates#edit"
end
