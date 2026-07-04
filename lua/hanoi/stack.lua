local Stack = {}
Stack.__index = Stack

function Stack:new(naam)
    local instance = {
        name = naam or "Onbekende Stack" -- Sla de naam op
    }
    setmetatable(instance, Stack)
    return instance
end

-- voeg een waarde aan de top toe
function Stack:push(waarde)
    table.insert(self, waarde)
end

-- geef top element en verwijder, nil voor een lege stack
function Stack:pop()
    return table.remove(self)
end

-- geef top element maar verwijder niet
function Stack:peek()
    return self[#self] --#self aantal elementen van de stack
end

function Stack:is_empty()
    return #self == 0
end

function Stack:__tostring()
    local elementen = {}

    -- Loop door alle genummerde indexen (de inhoud van de stack)
    for i = 1, #self do
        -- we zetten tostring() eromheen voor het geval er getallen/booleans in zitten
        table.insert(elementen, tostring(self[i]))
    end

    -- Plak alle elementen aan elkaar met een komma en spatie
    local inhoud_tekst = table.concat(elementen, ", ")

    -- Geef de geformatteerde string terug
    return "Stack: " .. self.name .. " [" .. inhoud_tekst .. "]"
end

return Stack
