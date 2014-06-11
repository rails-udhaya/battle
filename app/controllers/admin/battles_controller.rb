class Admin::BattlesController < ApplicationController
				layout 'admin_layout'
  before_filter :admin_only!		
		before_filter :valid_record, :only => [:show, :edit, :update, :destroy]
		
		
		def show
		end
		
		def index
				@battles = Battle.order("created_at DESC").all
		end
		
		def new
		end
		
		
		def create
				@battle = Battle.create(params[:battle])
				@items = params[:item]
				@items.each do |item| 
						@item = @battle.items.create(item)
				end
		if @item.save
						flash[:success] = "Battle created successfully."
						redirect_to admin_battles_path
				else
						render 'new'
				end
		end
		
		private		
		def valid_record
				return redirect_to admin_challenges_path if !Battle.exists?(params[:id])
				@battle = Battle.find(params[:id])
		end
end
