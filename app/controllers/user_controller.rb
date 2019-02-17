class UserController < ApplicationController

    def get_top_repos
        @top_repos = UserInf.all.order(stars: :desc).limit(10)
        render json:@top_repos
    end

    

end
