Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'static_pages#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'callback' => 'line_bot#callback'
  get 'login' => 'user_sessions#new'
  post 'login' => 'user_sessions#create'
  #logoutのHTTPメソッドをGETにしているのは、rails_adminで作成した管理画面のビューファイルがgemの内部にあるため、ログアウトボタンを配置するのが困難なため。
  #これによって、/logoutにGETでアクセスすることでログアウトが可能になる。
  get 'logout' => 'user_sessions#destroy'
end
