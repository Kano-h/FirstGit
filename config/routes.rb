Rails.application.routes.draw do
  #お気に入り機能
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/delete" => "likes#delete"
  #ユーザー画面でのお気に入りリスト
  get "users/:id/likes" => "users#likes"
  #新規投稿
  get "posts/newpost" => "posts#newpost_form"
  post "posts/newpost" => "posts#newpost"
  #投稿一覧
  get "posts/index" => "posts#index"
  get "posts/:id/show" => "posts#show"
  #投稿の編集、削除
  post "posts/:id/update" => "posts#update"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/delete" => "posts#delete"
  #ログイン
  get "login" => "users#login_form"
  post "login" => "users#login"
  #ログアウト
  post "logout" => "users#logout"
  #新規登録
  get "users/signup" => "users#signup_form"
  post "users/signup" => "users#signup"
  #ユーザー情報
  get "users/:id/show" => "users#show"
  post "users/:id/update" => "users#update"
  get "users/:id/edit" => "users#edit"
  #ユーザー一覧
  get "users/index" => "users#index"

  #トップ
  get "/" => "home#top"
  
end
