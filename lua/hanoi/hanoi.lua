local Stack = require("stack")

local Hanoi = {}

-- debug mode
Hanoi.DEBUG = true
-- De invariant-check functie
local function check_invariant(bron, doel)
    if Hanoi.DEBUG then
        -- We checken alleen als de doelstack NIET leeg is
        if not doel:is_empty() then
            local schijf_te_verplaatsen = bron:peek()
            local bovenste_schijf_doel = doel:peek()

            -- Invariant: de schijf die we pakken MOET kleiner zijn dan de top van de doelstack
            assert(schijf_te_verplaatsen < bovenste_schijf_doel,
                string.format("[DEBUG ERROR] Invariant geschonden! Schijf %d mag niet op Schijf %d van Stack %s",
                schijf_te_verplaatsen, bovenste_schijf_doel, doel.name))
        end
    end
end

local function move(x,y)
       -- debug check
       check_invariant(x, y)
       
       y:push(x:pop())
       io.write(x.name)
       io.write(y.name)
       io.write(" ")
end

function Hanoi.recursief(n,from,to,spare)
    if n==1 then  -- stop conditie
        move(from,to)
    else
        Hanoi.recursief(n-1,from,spare,to)
        move(from,to)
        Hanoi.recursief(n-1,spare,to,from)
    end
end

local function ctz(t)
    if t == 0 then return 32 end
    local count = 0
    -- Zolang het meest rechtse bitje 0 is, schuiven we op
    while (t & 1) == 0 do
        count = count + 1
        t = t >> 1
    end
    return count
end

-- iteratieve versie
function Hanoi.iteratief(n, from, to, spare)

local totaal_zetten = 2^n -1

local stacks
    if n % 2 == 1 then
        stacks = {from, to, spare}
    else
        stacks = {from, spare, to}
    end

local schijf_posities = {}
    for d = 1, n do
        schijf_posities[d] = 1
    end

for t = 1, totaal_zetten do
        -- Bepaal welke schijf moet bewegen via de trailing zeros
        local d = ctz(t) + 1

        local huidige_stack_idx = schijf_posities[d]
        local volgende_stack_idx

        -- De oneven schijven draaien met klok mee, de even schijven tegen de klok in
        if d % 2 == 1 then
            -- Met de klok mee 
            volgende_stack_idx = (huidige_stack_idx % 3) + 1
        else
            -- Tegen de klok in 
            volgende_stack_idx = huidige_stack_idx - 1
            if volgende_stack_idx == 0 then volgende_stack_idx = 3 end
        end

        -- Pak de daadwerkelijke Stack-objecten erbij
        local bron = stacks[huidige_stack_idx]
        local doel = stacks[volgende_stack_idx]

        -- Voer de fysieke move uit op de stacks
        move(bron, doel)

        -- Update de positie van deze schijf voor de volgende rondes
        schijf_posities[d] = volgende_stack_idx
    end
end

-- return module
return Hanoi
