Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/packages' => 'package#index'
  post '/packages' => 'package#create'
  get  '/top_packages' => 'package#top_packages'
  get '/top_packages/:package_name' => 'package#get_repos'
  get '/top_repos' => 'package#get_top_repos'
  get '/search/:repo_name' => 'package#search'
  get '/update_packages' => 'package#update_package'
end
