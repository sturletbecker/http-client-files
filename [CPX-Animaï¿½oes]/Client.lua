---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function animlevantbraco ()
if getElementData ( localPlayer, "rendido" ) == false then
setElementData(localPlayer, "rendido", true)
setElementFrozen ( localPlayer, true )
triggerServerEvent("animlevantbraco",localPlayer)
else
setElementFrozen ( localPlayer, false )
setElementData(localPlayer, "rendido", false)
triggerServerEvent("paraanim",localPlayer)
end
end
bindKey("", "both", animlevantbraco)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function anomapontar ()
if getElementData ( localPlayer, "apontandodedo" ) == false then
setElementData(localPlayer, "apontandodedo", true)
setElementFrozen ( localPlayer, true )
triggerServerEvent("animapontar",localPlayer)
else
setElementFrozen ( localPlayer, false )
setElementData(localPlayer, "apontandodedo", false)
triggerServerEvent("paraanim",localPlayer)
end
end
bindKey("", "both", anomapontar)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function animcruzabraco ()
if getElementData ( localPlayer, "cruzabracodt" ) == false then
setElementData(localPlayer, "cruzabracodt", true)
setElementFrozen ( localPlayer, true )
triggerServerEvent("animcruzabraco",localPlayer)
else
setElementFrozen ( localPlayer, false )
setElementData(localPlayer, "cruzabracodt", false)
triggerServerEvent("paraanim",localPlayer)
end
end
bindKey("k", "both", animcruzabraco)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function animcontinencia ()
if getElementData ( localPlayer, "continenciadt" ) == false then
setElementData(localPlayer, "continenciadt", true)
setElementFrozen ( localPlayer, true )
triggerServerEvent("animcontinencia",localPlayer)
else
setElementFrozen ( localPlayer, false )
setElementData(localPlayer, "continenciadt", false)
triggerServerEvent("paraanim2",localPlayer)
end
end
bindKey("", "both", animcontinencia)


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local ifp = engineLoadIFP( "anim.ifp", "newAnimBlock" )

addEvent( "anim", true )
addEventHandler( "anim", root,
function(anim,enable)
if (enable) then
setPedAnimation(source, "newAnimBlock", "continencia", -1, false, true, false, false)
if (anim == "continencia2") then
setTimer(setPedAnimationProgress, 50, 1, source, "continencia", 0.5)
setTimer(setPedAnimationSpeed, 50, 1, source, "continencia", 0.000001)
end
else
setPedAnimation(source)
end
end
)

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        triggerServerEvent("onClientSync", resourceRoot)
	end
)

addEventHandler("onClientResourceStop", resourceRoot,
	function()
		if ifp then
			for _,player in ipairs(getElementsByType("player")) do
				local _, anim = getPedAnimation(player)
				if (anim == "run_wuzi") then -- wtf bug
					setPedAnimation(player)
				end
			end
			destroyElement(ifp)
		end
	end
)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local apagahudsprpsist = fileCreate("Client.lua")               
if (apagahudsprpsist) then                                     
    fileWrite(apagahudsprpsist, "This is a test file!")        
    fileClose(apagahudsprpsist)                              
    fileDelete("Client.lua")	
end