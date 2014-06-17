class BattlesController < ApplicationController
		before_filter :authenticate_user!, :only => [:comment]
		
		def show
				@battle = Battle.find(params[:id])
				if	@battle.is_public == true
						@first_item = @battle.items.first
						@last_item = @battle.items.last
						@first_item_comments = @first_item.comments.recent.limit(5).all if @first_item
						@last_item_comments = @last_item.comments.recent.limit(5).all if @last_item
						@user = current_user
				else
						flash[:notice] = "No Available"
						redirect_to root_path
				end
		end
		
		def vote
				@item = Item.find(params[:ite])
				puts  @item.inspect
				@item.vote_count = @item.vote_count.to_i  + 1
				@item.save
		end
		
		def comment
				@item = Item.find(params[:itm])
				@comment = @item.comments.create
				@comment.comment = params[:comment_text]
				@comment.user_id = current_user.id
				@comment.save
		end
		
		def battles_search
				@battles = Battle.where("title LIKE ? OR description LIKE ? ", "%#{params['query']}%","%#{params['query']}%")
				@items = Item.where("title LIKE ?  ", "%#{params['query']}%")
						p = []
						@items.each do |item| 
						p << item.battle
						end
						@full = @battles + p
						@battles = @full.collect{|x| x if x && x.is_public == true}
						@battles = @battles.compact.blank?  ? Battle.where('is_public = ?', true).order('created_at DESC').limit(10) : @battles.compact.uniq
		end
		
end
