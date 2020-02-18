Rails.application.routes.draw do
  devise_for :user_candidates, path: 'user_candidates'
  devise_for :user_companies, path: 'user_companies'
  resources :jobs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
