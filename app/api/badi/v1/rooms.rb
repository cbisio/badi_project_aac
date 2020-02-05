# frozen_string_literal: true

module Badi
  module V1
    # Rooms Grape API Class
    class Rooms < Grape::API
      # GET /room/{id}
      params do
        requires :id, type: Integer, message: I18n.t('api.rooms.errors.id_param_required')
      end
      get '/room/:id' do
        @room = Room.find(@params[:id])
        @ip = env['REMOTE_ADDR']
        @room.update_attribute(:num_visits, @room.num_visits + 1) if @room.room_views.where(ip: @ip, created_at: (Time.now - 1.day)..Time.now).exists? == false
        @room_view = @room.room_views.create!(ip: @ip)
        present @room, with: Badi::V1::Entities::Room
      rescue ActiveRecord::RecordNotFound => e
        raise Badi::V1::ExceptionHandler::RoomNotFound, e.message
      end

      # GET /rooms
      params do
        requires :topleft_lat, type: String, message: I18n.t('api.rooms.errors.lat_lon_required')
        requires :topleft_lon, type: String, message: I18n.t('api.rooms.errors.lat_lon_required')
        requires :btmright_lat, type: String, message: I18n.t('api.rooms.errors.lat_lon_required')
        requires :btmright_lon, type: String, message: I18n.t('api.rooms.errors.lat_lon_required')
        optional :city, type: String
        optional :page, type: String
        optional :size, type: String
        optional :sort_by, type: String, values: %w[health leisure transport food tourism]
      end
      get '/rooms' do
        # Optional query params
        opts = {}
        opts[:city] = params[:city] if params[:city]
        opts[:page] = params[:page] if params[:page]
        opts[:size] = params[:size] if params[:size]
        opts[:sort_by] = params[:sort_by] if params[:sort_by]

        # Wrapping mandatory query params
        top_left_point = { top_left_lat: params[:topleft_lat], top_left_lon: params[:topleft_lon] }
        bottom_right_point = { bottom_right_lat: params[:btmright_lat], bottom_right_lon: params[:btmright_lon] }

        # Call the SearchRoomsService and send response
        result = SearchRoomsService.call(top_left_point, bottom_right_point, opts)

        raise Badi::V1::ExceptionHandler::SearchRoomsServiceError.new(result.error_code), result.error_message unless result.success?

        status :ok
        present result.data, with: Badi::V1::Entities::Rooms
      end
    end
  end
end
