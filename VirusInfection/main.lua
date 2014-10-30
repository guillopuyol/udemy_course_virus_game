-------------------------------------------------------------------------------------------
----
---- main.lua
----
-------------------------------------------------------------------------------------------
--
---- Your code here
--
--
--
--
--virusColony = {}
--
--local maxSpeed = 40
--
--virus1 = {["Life"]=1, ["Speed"]=maxSpeed, ["Color"]="Blue", ["InfectFactor"]=3}
--
--virus2 = {["Life"]=23, ["Speed"]=maxSpeed, ["Color"]="Yellow", ["InfectFactor"]=1}
--
--virus3 = {["Life"]=13, ["Speed"]=maxSpeed, ["Color"]="Red", ["InfectFactor"]=4}
--
--virus4 = {["Life"]=15, ["Speed"]=maxSpeed, ["Color"]="Black", ["InfectFactor"]=5}
--
--
--virusColony[1]=virus1
--virusColony[2]=virus3
--virusColony[3]=virus2
--virusColony[4]=virus4
--
--
--for i=1,#virusColony do
--    
--    if type(virusColony[i])=="table" then
--    
--        print("We're now checking the "..virusColony[i].Color.." virus")
--
--        repeat
--             if virusColony[i].Life > 30 then
--                 print("Virus Died!")
--             elseif virusColony[i].Life == 30 then
--                 print("Virus is about to die!")
--             elseif virusColony[i].Life >= 25 and virusColony[i].Life <= 30 then
--                 print("Virus is getting old!")
--             else
--                 print("Virus is in good health.")
--             end
--
--             virusColony[i].Life = virusColony[i].Life + 1
----             print("Virus Age: "..virusColony[i].Life)
--
--         until virusColony[i].Life>=32 
--         
--    end
--end
--
--
--function changeVirusSpeed(virus, deltaSpeed)
--    
--    local maxSpeed = 70
--    
--    virus.Speed = virus.Speed + deltaSpeed
--    
--    print("MaxSpeed inside the function: "..maxSpeed)
--
--end
--
--
--function getVirusSpeed(virus)
--    return virus.Speed
--end
--
--
--print("Original MaxSpeed: "..maxSpeed)
--
--print("Original Speed: "..virusColony[2].Speed)
--
--changeVirusSpeed(virusColony[2], 40)
--
--print("MaxSpeed after the function: "..maxSpeed)
--
--print("Original Speed: "..virusColony[2].Speed)
--
--
--print("Virus 3 has a speed of: "..getVirusSpeed(virusColony[3]))









local screen

local virusColony={}


local function createVirus(params)
    
    local params = params
    

    
    local group = params.group or screen
    local color = params.color or "Red"
    
    local virus = display.newImageRect( group, "/Images/"..color.."Virus@2x.png", 64, 64 )
 

    virus.x = params.x or display.contentWidth/2
    virus.y = params.y or display.contentHeight/2
    
    return virus
end


local function initScreen()
    
    screen = display.newGroup()
    
    local contentWidth = display.contentWidth
    local contentHeight = display.contentHeight
    
    local background = display.newImageRect(screen, "/Images/background@2x.png", contentWidth, contentHeight )
    background.x = contentWidth/2
    background.y = contentHeight/2
    
    local params = {["group"]=screen, ["color"]="Blue", ["x"]=200, ["y"]=70}
    
    table.insert(virusColony, createVirus(params) )
    
    
    
end

initScreen()
