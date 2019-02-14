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

    def get_repos
        @name = params[:package_name]
        @string_qu = "INNER JOIN 'user_infs' ON user_infs.user_name = package_infs.user_name WHERE package_infs.package_name ='"+@name+"'"
        @query = PackageInf.joins(@string_qu).select('package_infs.user_name,user_infs.stars').order('user_infs.stars DESC').limit(3)
        @temp = @query.map do |tmp|
            tmp.attributes
        end
        render json:@temp
    end
    def get_top_repos
        @top_repos = UserInf.all.order(stars: :desc).limit(10)
        render json:@top_repos
    end
    def search
        @key_word = params[:repo_name]
        @reg = "%"+@key_word+"%"
        @suggest_repos =PackageInf.select(:package_name).where("package_infs.package_name LIKE ?",@reg).limit(3).distinct
        render json:@suggest_repos
    end 
    def update_package
        @all_users = UserInf.select(:user_name,:repo_name,:updated_at)
        render json:@all_users
    end
end
