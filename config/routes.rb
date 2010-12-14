MongoOnRailsBlog::Application.routes.draw do
  devise_for :users
  resources :authors
  resources :articles do
    resources :comments
  end
  match "/articles/tag/:tag" => "articles#tag", :as => "articles_by_tag"
  match "/articles/author/:author" => "articles#author", :as => "articles_by_author"

  root :to => "articles#index"
end
