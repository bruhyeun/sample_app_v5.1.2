if ENV["REDISTOGO_URL"].present?
  uri = URI.parse(ENV["REDISTOGO_URL"])
  REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)
else
  REDIS = Redis.new(host: "localhost", port: 6379)
end

Resque.redis = REDIS