require "kemal"
require "nuummite"
# TODO: Write documentation for `Crystal::Proxy`
# def get_code(env)
#   env.params.url["code"]
# end

module Crystal::Proxy
  VERSION = "0.1.0"
  db = Nuummite.new(".", "crystal-proxy.db")

get "/" do
  db.each do |key, value|
    "#{key} ==> #{value}"
  end
end

get "/forward/:code" do |env|
  url_code = env.params.url["code"]?
  if !url_code.nil?
    url = db[url_code]?
    if !url.nil?
      env.redirect url
    else
      "Code #{url_code} is not registered"
    end
  else
    "Url code not found"
  end
  # begin
  # url = db[url_code]
  # env.redirect url
  # rescue
  #   "Code #{url_code} not found"
  # end
end

post "/code/:code" do |env|
  code = env.params.url["code"]?
  post_body = env.request.body
  if post_body.nil?
    halt env, status_code: 400, response: "No Post body"
  elsif code.nil?
    halt env, status_code: 400, response: "No Url in path"
  else
    parser = JSON::Parser.new(post_body)
    json_any = parser.parse()
    url = json_any["url"]?
    if url.nil?
      halt env, status_code: 400, response: "No Url in JSON body"
    else
      begin
        url = url.as_s
        db[code] = url
      rescue exception
        halt env, status_code: 400, response: "Url was not a string"
      end
    end
  end
  # begin
  # url = env.params.json["url"].as(String)
  # db[url_code] = url
  # "registered code #{url_code} for #{url}"
  # rescue
  #   "Code #{url_code} not found"
  # end
end

delete "/code/:code" do |env|
  url_code = env.params.url["code"]?
  if !url_code.nil?
    db.delete(url_code)
    "deleted code #{url_code}"
  else
    "Code #{url_code} not found"
  end
  # begin
  # db.delete(url_code)
  # "deleted code #{url_code}"
  # rescue
  #   "Code #{url_code} not found"
  # end
end



Kemal.run
end
