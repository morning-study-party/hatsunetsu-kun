Geocoder.configure(
  lookup: :google,
  api_key: Rails.application.credentials.dig(:google_map, :GOOGLE_MAP_API_KEY),
  units: :km
)
