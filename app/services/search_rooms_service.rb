class SearchRoomsService < ObjectService
  attr_reader :top_left_lat, :top_left_lon, :bottom_right_lat,:bottom_right_lon, :city, :page, :size

  def self.call(*args)
    new(*args).call
  end

  def initialize(top_left_point, bottom_right_point, opts = {})
    @top_left_lat = top_left_point[:top_left_lat]
    @top_left_lon = top_left_point[:top_left_lon]
    @bottom_right_lat = bottom_right_point[:bottom_right_lat]
    @bottom_right_lon = bottom_right_point[:bottom_right_lon]
    @city = opts[:city] || nil
    @page = opts[:page] || nil
    @size = opts[:size] || nil
    @sort_by = opts[:sort_by] || nil
  end

  def call
    @search_definitions = {
      query: {
        bool: {
          must: []
        }
      },
      sort: []
    }

    # Geo bounding box will always be a required search constrain
    add_geo_bounding_box

    # Add city match only if needed
    add_city_match if should_match_city?

    # Add pagination if needed
    add_pagination if use_pagination?

    # Add sort by specifications if needed
    add_sorting if use_sort_by?

    # Search using elastic search and the defined search
    response = Room.search(@search_definitions).results

    # Check if there were results and if so send them. Send an error otherwise.
    if response.size > 0
      Success.new(clean_rooms_response(response))
    else
      Error.new(I18n.t('search_rooms_service.errors.no_rooms_found'), 404)
    end
  end

  private
  def add_geo_bounding_box
    @search_definitions[:query][:bool][:must].push(
      geo_bounding_box: {
        location: {
          top_left: {
            lat: @top_left_lat.to_f,
            lon: @top_left_lon.to_f
          },
          bottom_right: {
            lat: @bottom_right_lat.to_f,
            lon: @bottom_right_lon.to_f
          }
        }
      }
    )
  end

  def should_match_city?
    if @city
      true
    else
      false
    end
  end

  def add_city_match
    @search_definitions[:query][:bool][:must].push(match: { 'city.name': @city })
  end

  def use_pagination?
    if @page && @size
      true
    else
      false
    end
  end

  def add_pagination
    @search_definitions[:from] = @page
    @search_definitions[:size] = @size
  end

  def use_sort_by?
    if @sort_by
      true
    else
      false
    end
  end

  def add_sorting
    @search_definitions[:sort].push(
      "room_location_service.#{@sort_by}": { 'order': 'desc' }
    )
  end

  def clean_rooms_response(dirty_response)
    rooms = []
    dirty_response.map { |room|
      rooms.push(room['_source'])
    }
    { rooms: rooms }
  end
end
