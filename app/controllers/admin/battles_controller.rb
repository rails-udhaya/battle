class Admin::BattlesController < ApplicationController
				layout 'admin_layout'
				require 'RMagick'
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
		
		
		def battle_is_public
				@battle = Battle.find params[:bat]
				@battle.is_public = params[:is_pub]
				@battle.save
		end
		
		def create_battle_main_asset
				@battle = Battle.find params[:bat]
				@items = @battle.items
				@first_item = @items.first
				@last_item = @items.last
				@first_item_asset = @first_item.asset.path(:medium)
				@last_item_asset = @last_item.asset.path(:medium)
				
				begin
				unmapped = Magick::ImageList.new(@first_item_asset,@last_item_asset)
				map = Magick::ImageList.new "netscape:"
				$stdout.sync = true
				mapped = unmapped.map map, false
				before = unmapped.append false
				path = Rails.root + "public/battle_combined/#{@first_item.id}_#{@last_item.id}/"
				FileUtils.mkdir_p path
				f_name = "combined_image.jpg"
				full_path = path + f_name
				before.write full_path
				f_l= File.open(full_path)
				@battle=@battle.update_attributes(:main_asset =>f_l)
    f_l.close
				rescue
				end
		end
		
		private		
		def valid_record
				return redirect_to admin_challenges_path if !Battle.exists?(params[:id])
				@battle = Battle.find(params[:id])
		end
end
