desc 'Update room location services'
task update_rls: :environment do
  RoomLocationService.where('updated_at < ?',Date.today - 30).each{ |x| GeoServicesNearRoom.call(x.id) }
end
