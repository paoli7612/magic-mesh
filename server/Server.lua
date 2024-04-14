local enet = require 'enet'

function Server()
    local server = enet.host_create("127.0.0.1:7612")

    return server
end

return Server