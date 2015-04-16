Rails.application.routes.draw do
  devise_for :users
  mount RootV1 => '/'
end
