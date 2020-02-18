Rails.application.routes.draw do
  devise_for :user_candidates, path: 'user_candidates', controllers: { sessions: 'user_candidates/sessions', registrations: 'user_candidates/registrations' }
  devise_for :user_companies, path: 'user_companies', controllers: { sessions: 'user_companies/sessions', registrations: 'user_companies/registrations' }
  resources :jobs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
