require "./spec_helper"
require "spec"
require "../src/get_kvps"
require "nuummite"

describe "get kvps" do
  # TODO: Write tests
  it "gets a list of key, value pairs" do
    hash = {
      "one" => "un",
      "two" => "deux",
      "three" => "trois",
      "four" => "quatre"
    }
    expected_list = [] of {String, String}

    db = Nuummite.new(".", "crystal-proxy-test.db")

    hash.each do |english, french|
      db[english] = french
      expected_list << {english, french}
    end
    get_kvps(db).should eq expected_list
  end

end
