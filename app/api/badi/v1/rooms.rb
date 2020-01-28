module Badi
  module V1
    class Rooms < Grape::API


      desc 'Returns a status ok'
      get '/rooms' do
        begin
          @rooms = Room.all
          present @rooms, with: Badi::V1::Entities::Room
        rescue
          raise Badi::V1::ExceptionHandler::RoomNotFound, 'This room could not be found.'
        end
      end

      get '/room/:id' do
        begin
          @room = Room.find(@params[:id])
          present @room, with: Badi::V1::Entities::Room
          @room.update_attribute(:num_visits, @room.num_visits + 1) #+1 visit at this room
        rescue
          raise Badi::V1::ExceptionHandler::RoomNotFound, 'This room could not be found.'
        end
      end

      get '/roomsBounds' do
        begin
          # @rooms = Room.joins(:city).where(cities: { name: @params[:city]}).
          # where("latitude >="+@params[:y0]+" and latitude <="+@params[:y1]+" and longitude >="+@params[:x0]+" and longitude <="+@params[:x1])

          @rooms = Room.joins(:city).where(cities: { name: @params[:city]}).
          where("latitude >=? and latitude <= ? and longitude >= ? and longitude <= ?",@params[:y0],@params[:y1],@params[:x0],@params[:x1])

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
