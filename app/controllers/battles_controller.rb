class BattlesController < ApplicationController
		before_filter :authenticate_user!, :only => [:comment]
		
		def show
				@battle = Battle.find(params[:id])
				@first_item = @battle.items.first
				@last_item = @battle.items.last
				@first_item_comments = @first_item.comments.recent.limit(5).all if @first_item
				@last_item_comments = @last_item.comments.recent.limit(5).all if @last_item
				@user = current_user
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
		
end
