require "CiderDebugger";-------------------------------------------------------------------------------------------
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
    
    local virusSize
    if params.age== 2 then
        virusSize = 96
    elseif params.age== 1 then
        virusSize = 64
    else
        virusSize = 32
    end
        
local virus = display.newImageRect( group, "/Images/"..color.."Virus@2x.png", virusSize, virusSize )
 
    virus.age = params.age or 0
    virus.x = params.x or display.contentWidth/2
    virus.y = params.y or display.contentHeight/2
    
    virus.speed = params.speed or 50
    
    
    
    function virus.move()
        
        local random = math.random
        local sqrt = math.sqrt
        
        local minX, maxX, minY, maxY = 10+virus.width/2, 310-virus.width/2, 60+virus.height/2, 470-virus.height/2
        
        local currentX, currentY = virus.x, virus.y
        
        local targetX= random(minX, maxX)
        
        local targetY= random(minY, maxY)
        
        local distance=sqrt((targetY-currentY)^2+(targetX-currentX)^2)
        
        local transitionTime = distance/virus.speed * 1000
 
        local virusTransition = transition.to( virus, {time=transitionTime, alpha=1, x=targetX, y=targetY, onComplete=virus.move } )
        
        return virusTransition
    end
    
    virus.transition = virus.move()
    
    function virus.grow()
        
        if virus.age<2 then
            
            virus.width = virus.width +32
            virus.height = virus.height +32
            virus.age = virus.age + 1
            
        end
    end
    
    timer.performWithDelay(5000, virus.grow, 2)
    
    
    function virus:touch(event)
        
        if event.phase=="ended" then
            
            print("Virus Touched!")
            print("Virus Speed: "..virus.speed)
            
        end
        
        return true
    end
    
    
    virus:addEventListener("touch", virus)
    
    
    return virus
end

local function drawLevel(level)
    
    local level = level or 1
    
    local virusType = {
        --Define the virus types
        {["color"]="Blue", ["speed"]=50, ["age"]=0},
        {["color"]="Green", ["speed"]=75, ["age"]=2},
        {["color"]="Red", ["speed"]=100, ["age"]=2}
        
    }
    
    local levels ={
        
        {3,1,2},  --Level1
        {1,1,0},  --Level2
        {1,1,1},  --Level3  
    }
    
    for virusTypes = 1, 3 do
        
        print(levels[level][virusTypes])
        
        local virusToSpawn = levels[level][virusTypes]
        
        for spawns = 1, virusToSpawn do
            
            local params = virusType[virusTypes]
            
            table.insert(virusColony, createVirus(params) )
        end
        
    end
    
end


local function initScreen()
    
    screen = display.newGroup()
    
    local contentWidth = display.contentWidth
    local contentHeight = display.contentHeight
    
    local background = display.newImageRect(screen, "/Images/background@2x.png", contentWidth, contentHeight )
    background.x = contentWidth/2
    background.y = contentHeight/2
    
    drawLevel()
    
end

initScreen()
