class Yelp::Business < Yelp
  API_PATH = '/v2/business'

  ACCEPTED_PARAMS = %w(
    id
    cc
    lang
    lang_filter
  )

  def find(params)
    if !params.is_a?(Hash)
      raise "You must provide a hash to perform a search."
    end

    invalid_param = params.keys.select { |k| !ACCEPTED_PARAMS.member?(k.to_s) }.first
    raise ApiError, "Invalid parameter: #{invalid_param}" if invalid_param

    Rails.logger.debug("id #{params[:id]}")
    path = Yelp.append_to_path(API_PATH,params[:id])

    response_body = @connection.get(Yelp.build_query(path, params)).body
    return JSON.parse(response_body)
  end
end
