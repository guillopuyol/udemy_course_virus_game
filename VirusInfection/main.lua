-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here





virusColony = {}



virus1 = {["Life"]=1, ["Speed"]=30, ["Color"]="Blue", ["InfectFactor"]=3}

virus2 = {["Life"]=23, ["Speed"]=20, ["Color"]="Yellow", ["InfectFactor"]=1}

virus3 = {["Life"]=13, ["Speed"]=25, ["Color"]="Red", ["InfectFactor"]=4}

virus4 = {["Life"]=15, ["Speed"]=32, ["Color"]="Black", ["InfectFactor"]=5}


virusColony[1]=virus1
virusColony[2]=virus3
virusColony[3]=virus2
virusColony[4]=virus4



while virusColony[1].Life<=31 do

    if virusColony[1].Life > 30 then
        print("Virus Died!")
    elseif virusColony[1].Life == 30 then
        print("Virus is about to die!")
    elseif virusColony[1].Life >= 25 and virusColony[1].Life <= 30 then
        print("Virus is getting old!")
    else
        print("Virus is in good health.")
    end
    
    virusColony[1].Life = virusColony[1].Life + 1
    print("Virus Age: "..virusColony[1].Life)
end