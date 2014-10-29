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


for i=1,#virusColony do
    
    print("We're now checking the "..virusColony[i].Color.." virus")
    
    repeat
         if virusColony[i].Life > 30 then
             print("Virus Died!")
         elseif virusColony[i].Life == 30 then
             print("Virus is about to die!")
         elseif virusColony[i].Life >= 25 and virusColony[i].Life <= 30 then
             print("Virus is getting old!")
         else
             print("Virus is in good health.")
         end

         virusColony[i].Life = virusColony[i].Life + 1
         print("Virus Age: "..virusColony[i].Life)

     until virusColony[i].Life>=32 
end




--Printing Virus Colony
print(virusColony)

for key,value in pairs(virusColony) do
    print(key,value)
    
    for insideKey,insideValue in pairs(value) do
        print(insideKey, insideValue)
    end
end
