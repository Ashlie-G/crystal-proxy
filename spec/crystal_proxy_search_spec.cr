require "nuummite"
require "../src/crystal-proxy"
    

describe "search" do
    # it "returns the right url" do
    #     code = "mytestcode"
    #     url = "https://twitch.com"
    #     db = Nuummite.new(".", "crystal-proxy-search-test.db" )
    #     db[code] = url

    #     get "/search/#{code}"
    #     response.body.should eq url
    # end

    it "returns 404 when code doesn't exist" do
        get "/search/nocode"
        response.status_code.should eq 404
    end
end