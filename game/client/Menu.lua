local menu = {}

function menu.show()
    local items = {"Nuova Partita", "Opzioni", "Esci"}
    local selectedItem = 1
    
    while true do
        love.graphics.clear(0.2, 0.2, 0.2)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("Menu Principale", 0, 50, love.graphics.getWidth(), "center")
        
        for i, item in ipairs(items) do
            if i == selectedItem then
                love.graphics.setColor(1, 0, 0)
            else
                love.graphics.setColor(1, 1, 1)
            end
            love.graphics.printf(item, 0, 100 + i * 30, love.graphics.getWidth(), "center")
        end
        
        love.graphics.present()
        
        local key = love.event.waitForKey()
        
        if key == "up" then
            selectedItem = selectedItem - 1
            if selectedItem < 1 then
                selectedItem = #items
            end
        elseif key == "down" then
            selectedItem = selectedItem + 1
            if selectedItem > #items then
                selectedItem = 1
            end
        elseif key == "return" then
            return items[selectedItem] -- Restituisce l'opzione selezionata
        end
    end
end

return menu