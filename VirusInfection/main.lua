require "CiderDebugger";-------------------------------------------------------------------------------------------

local screen

local virusColony={}

local gameVars = {}

gameVars.totalVirusesOnScreen = 0
gameVars.maxVirusOnScreen = 20
gameVars.currentLevel = 1
gameVars.currentLevelBeat = false
gameVars.levels = {}

local bgMusic
local bgMusicChannel

local virusPopSound, virusPopSoundChannel

local drawLevel

local function restartGame(event)
    
    if "clicked" == event.action then
        local i = event.index
        if 1 == i then  --Retry Button    
            print("Restarting Level Now")
            
            for j = 1, #virusColony do
                
                if virusColony[j]~=nil then
                    
                    virusColony[j]:removeSelf()
                    virusColony[j]=nil
                    
                end
                
            end
            
            if gameVars.currentLevelBeat == false then
                drawLevel(gameVars.currentLevel)
            else
                gameVars.currentLevel = gameVars.currentLevel + 1
                if gameVars.currentLevel > #gameVars.levels then
                    --Show GAME END
                    print("Game Beat!")
                else
                    drawLevel(gameVars.currentLevel)
                end
                
            end
            
        end
    
    end
    gameVars.currentLevelBeat = false
    
end

local function endGame(endGameStatus)
    if endGameStatus=="Lost" then
        print("Game OVER, Too Many Viruses On The Screen")
        
        
        
        for i = 1, #virusColony do
            
--            for i,j in pairs(virusColony) do print(i,j) end

            local thisVirus = virusColony[i]
            
            if thisVirus~= nil then
                
                thisVirus:stopGrowing()
                thisVirus:stopMoving()
                thisVirus:stopRespondingToTouch()
            end 
        end
        gameVars.currentLevelBeat = false
        native.showAlert("Virus Infection", "The infection has spread beyond control", { "Retry" }, restartGame )
        
    elseif endGameStatus=="Won" then
        gameVars.currentLevelBeat = true
        native.showAlert("Virus Infection", "Congratulations! You cleared the infection.", { "Continue" }, restartGame )
    end
end

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
    
    virus.speed = params.speed or 100
    
    virus.children = params.children or 2
    virus.color = color
    
    
    function virus.move()
        
        local random = math.random
        local sqrt = math.sqrt
        
        local minX, maxX, minY, maxY = 10+virus.width/2, 310-virus.width/2, 60+virus.height/2, 470-virus.height/2
        
        local currentX, currentY = virus.x, virus.y
        
        local targetX= random(minX, maxX)
        
        local targetY= random(minY, maxY)
        
        local distance=sqrt((targetY-currentY)^2+(targetX-currentX)^2)
        
        local transitionTime = distance/virus.speed * 1000
 
        virus.transition = transition.to( virus, {time=transitionTime, alpha=1, x=targetX, y=targetY, onComplete=virus.move } )
        
        
    end
    
    virus.move()
    
    function virus.grow()
        
        if virus.age<2 then
            
            virus.width = virus.width +32
            virus.height = virus.height +32
            virus.age = virus.age + 1
            
        end
    end
    
    virus.growTimer = timer.performWithDelay(5000, virus.grow, 2)
    
    
    function virus:stopGrowing()
        timer.cancel(virus.growTimer)
    end
    
    function virus:stopMoving()
        transition.cancel(virus.transition)
    end
    
    function virus:stopRespondingToTouch()
        virus:removeEventListener("touch", virus)
    end
    
    function virus:touch(event)
        
        if event.phase=="ended" then
            
                virus:stopGrowing()
                virus:stopMoving()
                
                local event = {name="virusDied", target=virus}
                virus:dispatchEvent(event)
                
                audio.play(virusPopSound)
                
        end
        
        return true
    end
    
    
    virus:addEventListener("touch", virus)
    
    
    return virus
end

local function checkTotalVirus()
    
    if gameVars.totalVirusesOnScreen>gameVars.maxVirusOnScreen then
        local endGameStatus = "Lost"
        endGame(endGameStatus)
        return true
    elseif gameVars.totalVirusesOnScreen==0 then
        local endGameStatus = "Won"
        endGame(endGameStatus)
        return true
    end
end


function drawLevel(level)
    
    gameVars.totalVirusesOnScreen = 0
    
    local level = level or 1
    
    local virusType = {
        --Define the virus types
        {["color"]="Blue", ["speed"]=50, ["age"]=2, ["children"]=2},
        {["color"]="Green", ["speed"]=75, ["age"]=2, ["children"]=2},
        {["color"]="Red", ["speed"]=100, ["age"]=2, ["children"]=2}
        
    }
    
    gameVars.levels ={
        
        {0,0,1},  --Level1
        {0,1,0},  --Level2
        {1,0,0},  --Level3  
    }
    
    for virusTypes = 1, 3 do
        
--        print(levels[level][virusTypes])
        
        local virusToSpawn = gameVars.levels[level][virusTypes]
        
        for spawns = 1, virusToSpawn do
            
            local params = virusType[virusTypes]
            
            local thisVirus = createVirus(params)
            
            local function killOffVirus(event)
                
--                print("We just heard a virus died!")
--                print("Before:")
--                for i,j in pairs(virusColony) do print(i,j) end
                
                local copyOfVirus = event.target
                
                local thisVirusIndex = event.target.index
                event.target:removeSelf()
                event.target = nil
                
                virusColony[thisVirusIndex] = nil
                
                
--                print("After:")
--                for i,j in pairs(virusColony) do print(i,j) end
                
                gameVars.totalVirusesOnScreen = gameVars.totalVirusesOnScreen -1
                
                if copyOfVirus.age > 0 then
                    for children = 1, copyOfVirus.children do

                        local params = {color=copyOfVirus.color, speed=copyOfVirus.speed, age=copyOfVirus.age-1, children=copyOfVirus.children, x=copyOfVirus.x, y=copyOfVirus.y}

                        local thisVirus = createVirus(params)

                        thisVirus:addEventListener("virusDied", killOffVirus)

                        thisVirus.index = #virusColony + 1

                        gameVars.totalVirusesOnScreen = gameVars.totalVirusesOnScreen + 1

                        table.insert(virusColony, thisVirus )
                        
                        if checkTotalVirus()==true then
                            break
                        end


                    end
                else
                    checkTotalVirus()
                end
                copyOfVirus = nil
                
            end
            
            thisVirus:addEventListener("virusDied", killOffVirus)
            
            thisVirus.index = #virusColony + 1
            
            gameVars.totalVirusesOnScreen = gameVars.totalVirusesOnScreen + 1
            
            table.insert(virusColony, thisVirus )
            
            checkTotalVirus()
            
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
    
    
    --Load Music
    bgMusic = audio.loadStream("Sounds/music.wav")
    bgMusicChannel = audio.findFreeChannel()
    
    audio.play(bgMusic, {channel=bgMusicChannel, loops=-1, fadeIn=3000})
    
    
    --Load Virus Sound
    virusPopSound = audio.loadSound("Sounds/pop.wav")
    virusPopSoundChannel = audio.findFreeChannel()
    
    drawLevel()
    
end

initScreen()
