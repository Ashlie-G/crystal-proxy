require "kemal"
# TODO: Write documentation for `Crystal::Proxy`
def get_code(env)
  env.params.url["code"]
end

module Crystal::Proxy
  VERSION = "0.1.0"

get "/" do
  "Please refer to documentation for REST api specs"
end

get "/forward/:code" do |env|
  url_code = get_code(env)
  env.redirect "https://github.com"
end
post "/code/:code" do |env|
  url_code = get_code(env)
  "registering code #{url_code}"
end

delete "/code/:code" do |env|
  url_code = get_code(env)
  "deleting code #{url_code}"
end



Kemal.run
end
