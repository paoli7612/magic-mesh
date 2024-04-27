local serverMode = false

-- Parsing degli argomenti della riga di comando
for i, arg in ipairs(arg) do
    if arg == "--server" then
        serverMode = true
    end
end

-- Inizializzazione del gioco
if serverMode then
    -- Carica i componenti del server
    require("server.server_main")
else
    -- Carica i componenti del client
    require("client.client_main")
end
