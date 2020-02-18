Rails.application.routes.draw do
  devise_for :user_candidates
  devise_for :user_companies
  resources :jobs
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/companies/new" => "companies#new"
  post "/companies/new" => "companies#create", as:"new_company"
  get "/companies/:id" => "companies#show", as: "company"
  get "/companies/:id/edit" => "companies#edit"
  patch "/companies/:id" => "companies#update"
end
