desc 'Update room location services'
task update_rls: :environment do
  #RLS notupdated in last 30 days
  RoomLocationService.where('updated_at < ?',Date.today - 30).each{ |x| GeoServicesNearRoom.call(x.id) }
  #rooms that don't have RLS
  Room.where(' 0 = (select count(1) as total from room_location_services where room_id = rooms.id)',Date.today - 30).each{ |x| GeoServicesNearRoom.call(x.id) }
end
