class BattlesController < ApplicationController
		
		
		def show
				@battle = Battle.find(params[:id])
		end
		
		def vote
				@item = Item.find(params[:ite])
				puts  @item.inspect
				@item.vote_count = @item.vote_count.to_i  + 1
				@item.save
		end
		
end
