TechReviewSite::Application.routes.draw do
  devise_for :users
  root  'top#index'
  get 'product/:id'  =>  'products#show'
  get 'search'   =>  'top#search'
  get 'entry/:id' =>  'top#entry'
  post  'entry/:id' =>  'top#post'
  get 'users/:id'  =>   'users#show'
end
