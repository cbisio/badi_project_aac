require 'nokogiri'
require 'open-uri'



namespace :web_sc_namespace do
  desc "TODO"
  task :web_scrapping, [:page] do |t, args|

    habitaciones = []
   
    query = { 
      "page"     => args.page,
      "bounds"     => {"ne":{"lat":41.4695761,"lng":2.2280099},"sw":{"lat":41.320004,"lng":2.0695258}}
    }
    headers = { 
      "authorization"  => " Bearer cb01be126a7034f1921f07f8747252cf5c124148dd2dd0b8837378249c43c955"
    }
    
    response = HTTParty.post(
      "https://api.badiapp.com/v1/search/rooms", 
      :query => query,
      :headers => headers
    )
    
    body = JSON.parse(response.body)
    
    file = File.open("roomsIds.txt", "w")
    
    body.length.times do |item|
      @title = body[item]["title"]
      @price = body[item]["prices_attributes"]["price"].gsub ".", "" 
      @description = body[item]["description"]
      @latitude = body[item]["latitude"]
      @longitude = body[item]["longitude"]
      @bills_included = body[item]["prices_attributes"]["bills_included"]
      @deposit = body[item]["prices_attributes"]["deposit"]
      #@room_size
      #@property_size
      @owner_name = body[item]["tenants"]["first_name"]+" "+["tenants"]["last_name"]
      @owner_birth = body[item]["tenants"]["birth_date"]
      @owner_gender = body[item]["tenants"]["biological_sex"]
      @owner_about = body[item]["tenants"]["small_bio"]

      room_params = {
          :title => @title, :price => @price, :description => @description,
           :latitude => @latitude, :longitude => @longitude, :num_visits => 0, 
           :bills_included => @bills_included, :deposit => @deposit
      }

      user_params = {
          :name => @owner_name, :birth_date => @owner_birth, :gender => @owner_gender, :about => @owner_about
      }

      @room = Room.create!(room_params)
      User.create!(user_params)
      @num = 0
      body[item]["pictures"].each do |picture|
        Photos.create!(:url => picture[url], :order => @num, :room_id => @room.id)
        @num = @num + 1
      end
    end
    file.close
    
  end
end
