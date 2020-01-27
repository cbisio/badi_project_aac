namespace :fill_extras_namespace do
  desc "TODO"
  task fill_extras: :environment do


    @extras_name = ["TV","Wifi", "Washing Machine", "Furnished","Balcony", "Elevator", "Pets allowed", "Smoking allowed", "Gay friendly", "Natural light"]

    @extras_name.each do |extra|
      Extra.create!(:name => extra)
    end
  end

end