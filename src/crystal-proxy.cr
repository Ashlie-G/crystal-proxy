require "kemal"
# TODO: Write documentation for `Crystal::Proxy`
module Crystal::Proxy
  VERSION = "0.1.0"


get "/" do
  "Hello World!"
end

Kemal.run
end
