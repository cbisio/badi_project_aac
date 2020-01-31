module Badi
  module V1
    class Rooms < Grape::API
      # GET /room/{id}
      params do
        requires :id, type: Integer, message: I18n.t('api.rooms.errors.id_param_required')
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

      # GET /rooms
      params do
        requires :topleft_lat, type: String, message: I18n.t('api.rooms.errors.lat_lon_required')
        requires :topleft_lon, type: String, message: I18n.t('api.rooms.errors.lat_lon_required')
        requires :btmright_lat, type: String, message: I18n.t('api.rooms.errors.lat_lon_required')
        requires :btmright_lon, type: String, message: I18n.t('api.rooms.errors.lat_lon_required')
      end
      get '/rooms' do
        # Optional query params
        params[:city] ? city = params[:city] : city = nil
        params[:page] ? page = params[:page] : page = nil
        params[:size] ? size = params[:size] : size = nil

        opts = {
          city: city,
          page: page,
          size: size
        }

        # Wrapping mandatory query params
        top_left_point = { top_left_lat: params[:topleft_lat], top_left_lon: params[:topleft_lon] }
        bottom_right_point = { bottom_right_lat: params[:btmright_lat], bottom_right_lon: params[:btmright_lon] }

        result = SearchRoomsService.call(top_left_point, bottom_right_point, opts)

        if result.success?
          status :ok
          present result.data, with: Badi::V1::Entities::Rooms
        else
          raise Badi::V1::ExceptionHandler::SearchRoomsServiceError.new(result.error_code), result.error_message
        end
      end
    end
  end
end
