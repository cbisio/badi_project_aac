module Badi
  module V1
    class Rooms < Grape::API

      get '/room/:id' do
        begin
          @room = Room.find(@params[:id])
          present @room, with: Badi::V1::Entities::Room
          @room.update_attribute(:num_visits, @room.num_visits + 1) #+1 visit at this room
        rescue
          raise Badi::V1::ExceptionHandler::RoomNotFound, 'This room could not be found.'
        end
      end

      get '/rooms' do
        begin
          @rooms = Room.joins(:city).where(cities: { name: @params[:city]}).
          where("latitude >=? and latitude <= ? and longitude >= ? and longitude <= ?",@params[:topleft_lat],@params[:btmright_lat],@params[:topleft_long],@params[:btmright_long])

          if @rooms.size >0
            present @rooms, with: Badi::V1::Entities::Room
          else
            raise Badi::V1::ExceptionHandler::RoomNotFound, 'Not rooms have been found in this bounds'
          end
        rescue
          raise Badi::V1::ExceptionHandler::RoomNotFound, 'Not rooms have been found in this bounds'
        end
      end
    end
  end
end
