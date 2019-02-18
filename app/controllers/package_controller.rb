require 'rest_client'
class PackageController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        @all_packages = PackageInf.all
        render json:@all_packages
    end

    def create
        @user_name = params[:user_name]
        @repo_name = params[:repo_name]
        @stars = params[:stars]
        @forks = params[:forks]
        @user = UserInf.new
        @user.user_name = @user_name
        @user.repo_name = @repo_name
        @user.stars = @stars 
        @user.forks = @forks
        @user.save
        @packages =params[:packages]
        @packages.each do |package_name,package_version|
            @package = PackageInf.new
            @package.user_name = @user_name
            @package.repo_name = @repo_name
            @package.package_name = package_name
            @package.save
        end
        render json:@package,status: :created
    end

    def top_packages
        @top_packs = PackageInf.group(:package_name).order('1 DESC').limit(10).count
        render json:@top_packs
    end

    def get_package_repos
        @name = params[:package_name]
        @string_qu = "INNER JOIN 'user_infs' ON user_infs.user_name = package_infs.user_name WHERE package_infs.package_name ='"+@name+"'"
        @query = PackageInf.joins(@string_qu).select('package_infs.user_name,user_infs.stars').order('user_infs.stars DESC').limit(3)
        @temp = @query.map do |tmp|
            tmp.attributes
        end
        render json:@temp
    end

    def show
        @key_word = params[:id]
        @reg = "%"+@key_word+"%"
        @suggest_repos =PackageInf.select(:package_name).where("package_infs.package_name LIKE ?",@reg).limit(3).distinct
        render json:@suggest_repos
    end 


    def information
        @response = $redis.get(params[:repo_name])
        if @response.nil?
            @response = RestClient.get 'https://api.github.com/search/repositories', {:params => {:q => params[:repo_name], 'sort' => 'stars','order'=>'desc'}}
            $redis.set(params[:repo_name],@response)
            $redis.expire(params[:repo_name],1.minute.to_i)
        end
        render json:@response
    end
end
