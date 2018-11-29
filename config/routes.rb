Rails.application.routes.draw do
  get '/set_turkish', to: 'set_language#turkish', as: :set_turkish
  get '/set_english', to: 'set_language#english', as: :set_english

  available_locales = I18n.available_locales.join('|')
  scope ':locale', locale: /#{available_locales}/ do
    resources :timers, only: %i[index create update destroy]
    get "/insight", to: "timers#insight", as: :insight_timer
    get "/reports", to: "timers#reports", as: :reports_timer
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
  get '/' => redirect("/#{I18n.locale}")
end
