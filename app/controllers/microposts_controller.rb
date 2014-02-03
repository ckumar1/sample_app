class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
	usernames = extract_mentioned_screen_names(@micropost.content)
	@mention_id = @micropost.id
	unless usernames.empty?
		usernames.each do |i|
			@mention_user= User.find_by_name(i).id
			@final = Mention.new(user_id: @mention_user, micropost_id: @mention_id)
			@final.save
			
		end
	end
       flash[:success] = "Micropost created!"
       redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end


  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
