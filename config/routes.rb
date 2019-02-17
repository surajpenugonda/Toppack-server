Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :package
  post 'information' => 'package#information'
  get  'top_packages' => 'package#top_packages'
  get 'top_packages/:package_name' => 'package#get_package_repos'
  get 'top_repos' => 'user#get_top_repos'
end
