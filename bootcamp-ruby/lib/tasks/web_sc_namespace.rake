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
      habitaciones.push(body[item]["id"])
    end
    file.close


    habitaciones.each do |habitacion|

      # Fetch and parse HTML document
      doc = Nokogiri::HTML(open("https://badi.com/es/room/#{habitacion}")) 

      doc.css('h1.room__title').each do |link|
        @title = link.content
      end 

      doc.css('div.styled-components__FlexChild-jzrolq-0 h4').each do |link|
        @price = link.content.gsub ".", ""
      end

      doc.css('div.form__fieldset p').each do |link|
        @description = link.content
      end

      doc.css('h1.Heading__StyledHeading-cuu5h0-0').each do |link|
        @owner = link.content
      end

      req_payload = {
          :title => @title, :price => @price, :description => @description
      }

      puts req_payload
    end
  end
end
