

namespace :retrieving_data_namespace do
  desc "TODO"
  task :retrieving_data, [:page] => :environment  do |t, args|
   
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
    
    body.length.times do |item|
      @name = body[item]["title"]
      @price = body[item]["prices_attributes"][0]["price"].to_i
      @description = body[item]["description"]
      @latitude = body[item]["latitude"].to_f
      @longitude = body[item]["longitude"].to_f
      @bills_included = (body[item]["prices_attributes"][0]["bills_included"] == "true")
      @deposit = body[item]["prices_attributes"][0]["deposit"].to_i
      @address = "Calle Piruleta 35"
      @room_size = 0
      @property_size = 0
      @owner_name = body[item]["tenants"][0]["first_name"] << " " << body[item]["tenants"][0]["last_name"]
      @owner_birth = body[item]["tenants"][0]["birth_date"] 
      if body[item]["tenants"][0]["biological_sex"] == 1
        @owner_gender = "Female"
      elsif body[item]["tenants"][0]["biological_sex"] == 2
        @owner_gender = "Male"
      else 
        @owner_gender = "Others"
      end
      @owner_about = body[item]["tenants"][0]["small_bio"]
      
      user_params = {
          :name => @owner_name, :birth_date => @owner_birth, :gender => @owner_gender, :about => @owner_about
      }

      @user = User.find_or_create_by!(user_params)

      room_params = {
        :name => @name, :price => @price, :description => @description,
         :latitude => @latitude, :longitude => @longitude, :num_visits => 0, 
         :bills_included => @bills_included, :deposit => @deposit, :user_id => @user.id, 
         :address => @address
      }

      @room = Room.create!(room_params)
      
      @num = 0
      body[item]["pictures"].each do |picture|
        @photo = Photo.create!(:order => @num, :room_id => @room.id)
        @photo.url.attach(:url => picture["url"])
        @num = @num + 1
      end
    end
    
  end
end
