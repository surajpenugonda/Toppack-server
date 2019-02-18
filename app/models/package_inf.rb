require 'rest_client'
class PackageInf < ApplicationRecord
    def self.update_packages
        @users = UserInf.select(:user_name,:repo_name)
        @users_json =@users.as_json
        @users_json.each do |obj|
            @query_url = "https://api.github.com/repos/#{obj["user_name"]}/#{obj["repo_name"]}/contents/package.json"
            @response = RestClient.get(@query_url)
            @responseJSON = JSON.parse(@response)
            @content64 = @responseJSON["content"]
            @contentStr =Base64.decode64(@content64)
            @contentJSON =JSON.parse(@contentStr) 
            p @contentJSON
            packagesJSON =@contentJSON["devDependencies"].keys
            PackageInf.where(user_name: obj["user_name"]).destroy_all
            packagesJSON.each do|package_name|
                @tmp_pkg = PackageInf.new
                @tmp_pkg.user_name = obj["user_name"]
                @tmp_pkg.repo_name = obj["repo_name"]
                @tmp_pkg.package_name = package_name
                @tmp_pkg.save
            end
        end
    end
    
end
