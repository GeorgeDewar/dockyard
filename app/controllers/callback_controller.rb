class CallbackController < ApplicationController

  def github
    session[:github_token] = Github.new.get_token(params[:code]).token
    redirect_to new_repository_path
  end

end