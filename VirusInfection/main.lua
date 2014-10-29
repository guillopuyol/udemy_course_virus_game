-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here





virusColony = {}



virus1 = {["Life"]=10, ["Speed"]=30, ["Color"]="Blue", ["InfectFactor"]=3}

virus2 = {["Life"]=23, ["Speed"]=20, ["Color"]="Yellow", ["InfectFactor"]=1}

virus3 = {["Life"]=13, ["Speed"]=25, ["Color"]="Red", ["InfectFactor"]=4}

virus4 = {["Life"]=15, ["Speed"]=32, ["Color"]="Black", ["InfectFactor"]=5}


virusColony[1]=virus1
virusColony[2]=virus3
virusColony[3]=virus2
virusColony[4]=virus4


print(virusColony[3].Color)