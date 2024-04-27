local enet = require 'enet'

function Server()
    local server = {
        connection = enet.host_create("127.0.0.1:7612")
    }

    function server.load()
        print('Start server: localhost:7612')
    end
    
    function server.update(dt)
    end

    function server.draw()
    end

    function server.quit()
    end


    server.load()
    return server
end

return Server