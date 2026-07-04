-- Laad de benodigde modules in
local Stack = require("stack")
local Hanoi = require("hanoi")

-- Een hulpfunctie om de pennen te resetten naar de beginstand
local function maak_beginstand(n)
    local A = Stack:new("A")
    local B = Stack:new("B")
    local C = Stack:new("C")

    -- Vul pen A in omgekeerde volgorde: van n naar 1 (stapgrootte -1)
    for i = n, 1, -1 do
        A:push(i)
    end
    return A, B, C
end

print("=== TEST 1: RECURSIEVE METHODE ===")
local A1, B1, C1 = maak_beginstand(3)
Hanoi.recursief(3, A1, C1, B1) -- Roept de recursieve versie aan
print("\nEindstand C:", C1)
print()

print("=== TEST 2: ITERATIEVE METHODE ===")
local A2, B2, C2 = maak_beginstand(3)
Hanoi.recursief(3, A2, C2, B2)    -- Roept de binaire versie aan
print("\nEindstand C:", C2)
