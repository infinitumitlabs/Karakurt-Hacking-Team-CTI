class Rack::Attack
  throttle('req/ip', limit: 300, period: 2.minutes) do |req|
    req.ip
  end
end