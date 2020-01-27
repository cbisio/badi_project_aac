module Badi
  module V1
    class Rooms < Grape::API


      desc 'Returns a status ok'
      get '/rooms' do
        begin
          @rooms = Room.all
          present @rooms, with: Badi::V1::Entities::RoomSimple
        rescue => exception
          raise Badi::V1::ExceptionHandler::RoomNotFound, 'This room could not be found.'
        end
      end

      get '/room/:id' do
        begin
          @room = Room.find(@params[:id])
          present @room, with: Badi::V1::Entities::Room
        rescue => exception
          raise Badi::V1::ExceptionHandler::RoomNotFound, 'This room could not be found.'
        end
      end

      get '/roomsBounds' do
        begin
          @rooms = Room.joins(:city).where(cities: { name: @params[:city]}).
          where("latitude >="+@params[:y0]+" and latitude <="+@params[:y1]+" and longitude >="+@params[:x0]+" and longitude <="+@params[:x1])

          if @rooms.size >0
            present @rooms, with: Badi::V1::Entities::Room
          else
            raise Badi::V1::ExceptionHandler::RoomNotFound, 'Not rooms have been found in this bounds!'
          end
        rescue => exception
          raise Badi::V1::ExceptionHandler::RoomNotFound, 'Not rooms have been found in this bounds:'
        end
      end
    end
  end
end
