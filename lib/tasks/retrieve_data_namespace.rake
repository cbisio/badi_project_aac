
  task :retrieve_data, [:page, :city_letter] => :environment  do |t, args|


    if Extra.any? == false
      Rake::Task["fill_extras"].invoke
    end

    Geocoder.configure(ip_lookup: :ipinfo_io)

    if args.city_letter == 'M' 
    query = { 
      "page"     => args.page,
      "bounds"     => {"ne":{"lat":40.64352,"lng":-3.51801},"sw":{"lat":40.31207,"lng":-3.889}}
    }
    elsif args.city_letter == 'V' 
      query = { 
        "page"     => args.page,
        "bounds"     => {"ne":{"lat":39.5073225,"lng":-0.2914778},"sw":{"lat":39.308248,"lng":-0.4315448}}
      }
    else
      query = { 
        "page"     => args.page,
        "bounds"     => {"ne":{"lat":41.4695761,"lng":2.2280099},"sw":{"lat":41.320004,"lng":2.0695258}}
      }
    end
    headers = { 
      "authorization"  => ENV["BADI_API_KEY"]
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
      @results = Geocoder.search([@latitude, @longitude])
      @address = @results.first.address
      @room_size = rand(5..15)
      @property_size = rand(50..120)
      if body[item]["prices_attributes"][0]["currency"] == "EUR"
        @currency = "€"
      elsif body[item]["prices_attributes"][0]["currency"] == "USD"
        @currency = "$"
      else 
        @currency = "€"
      end
      @city_name = body[item]["city"]
      @owner_name = body[item]["tenants"][0]["first_name"] << " " << body[item]["tenants"][0]["last_name"]
      @owner_birth = body[item]["tenants"][0]["birth_date"] 
      if body[item]["tenants"][0]["biological_sex"] == 1
        @owner_gender = "Female"
      elsif body[item]["tenants"][0]["biological_sex"] == 2
        @owner_gender = "Male"
      else
        @owner_gender = "Other"
      end
      @owner_about = body[item]["tenants"][0]["small_bio"]
      
      user_params = {
          :name => @owner_name, :birth_date => @owner_birth, :gender => @owner_gender, :about => @owner_about
      }

      @user = User.find_or_create_by!(user_params)

      @city = City.find_or_create_by!(:name => @city_name)

      room_params = {
        :name => @name, :price => @price, :description => @description,
         :latitude => @latitude, :longitude => @longitude, :num_visits => 0, 
         :bills_included => @bills_included, :deposit => @deposit, :user_id => @user.id, 
         :address => @address, :currency => @currency, :city_id => @city.id, 
         :room_size => @room_size, :property_size => @property_size
      }

      @room = Room.create!(room_params)
      GeoServicesNearRoom.call(@room.id)
      
      @num = 1
      body[item]["pictures"].each do |picture|
        Photo.create!(:url => picture["url"], :order => @num, :room_id => @room.id)
        @num = @num + 1
      end

        @extra = Extra.all.sample(2)
        @room.extras << @extra[0]
        @room.extras << @extra[1]
     
    end
  end

