
  task fill_extras: :environment do


    @extras_name = %w(
      TV
      Wifi
      Washing\ Machine
      Furnished
      Balcony
      Elevator
      Pets\ allowed
      Smoking\ allowed
      Gay\ friendly
      Natural\ light
    )

    @extras_name.each do |extra|
      Extra.create!(:name => extra)
    end

  end
