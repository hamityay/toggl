Rails.application.routes.draw do
  devise_path_names = {
      sign_in: 'login',
      sign_out: 'logout',
      password: 'secret',
      confirmation: 'verification'
  }
  # Users
  devise_for :users,
             path_names: devise_path_names

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
end
