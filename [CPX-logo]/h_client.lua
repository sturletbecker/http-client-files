local screenW, screenH = guiGetScreenSize()
local x, y  =  (screenW/1366), (screenH/768)

local tableHud = {
}

local iconesHUD = {
}

local logo = {
	{image = "files/logo.png", x1 = 630, y1 = -8, x2 = 106, y2 = 88} -- 630, -8, 106, 88
}

local velocimetro = {
}

local iconVelo = {
}

randX = 0
randY = 0
randW = 0
randH = 0
alpha = 0

addEventHandler("onClientRender", root, function()
	
	for i,v in pairs(tableHud) do
		dxDrawImage( x*tableHud[i]['x1'], y*tableHud[i]['y1'], x*tableHud[i]['x2'], y*tableHud[i]['y2'], tableHud[i]['image'], 0, 0, 0, tocolor(255,255,255,255), false )
		if voice then
			randX = math.random(1, 2)
			randY = math.random(1, 2)
			randW = math.random(2, 3)
			randH = math.random(2, 3)
			dxDrawImage( x*tableHud[2]['x1']-randX, y*tableHud[2]['y1']-randY, x*tableHud[2]['x2']+randW, y*tableHud[2]['y2']+randH, tableHud[2]['image'], 0, 0, 0, tocolor(90,90,255,255), false )
		end
	end
	
	
	for i,v in pairs(iconesHUD) do
		dxDrawImage( x*iconesHUD[i]['x1'], y*iconesHUD[i]['y1'], x*iconesHUD[i]['x2'], y*iconesHUD[i]['y2'], iconesHUD[i]['image'], 0, 0, 0, tocolor(255,255,255,255), false )
	end
	if alpha < 190 then
		alpha = alpha + 1
	else
		alpha = 0
	end
	for i,v in pairs(logo) do
		dxDrawImage( x*logo[i]['x1'], y*logo[i]['y1'], x*logo[i]['x2'], y*logo[i]['y2'], logo[i]['image'], 0, 0, 0, tocolor(alpha,alpha,alpha,255), false )
	end
end)

AnimY = 1000
addEventHandler("onClientRender", root, function()
	in_vehicle = getPedOccupiedVehicle(localPlayer)
	if in_vehicle then
		if getVehicleEngineState ( in_vehicle, true ) then
			AnimY = 1000
			local gasolina = getElementData(in_vehicle, "MD:Gasolina") or 0
			for i,v in pairs(velocimetro) do
                
				dxDrawImage( x*velocimetro[i]['x1'], y*velocimetro[i]['y1'], x*velocimetro[i]['x2'], y*velocimetro[i]['y2'], velocimetro[i]['image'], 0, 0, 0, tocolor(200,200,200,200), false )
				dxDrawImageSection(x*1222, y*729, x*105*gasolina/100, y*13, 0, 0, x*65, y*65*gasolina/100, "files/gasolina.png")
			end
			for i,v in pairs(iconVelo) do
				dxDrawImage( x*iconVelo[i]['x1'], y*iconVelo[i]['y1'], x*iconVelo[i]['x2'], y*iconVelo[i]['y2'], iconVelo[i]['image'], 0, 0, 0, tocolor(255,255,255,255), false )
			end
			dxDrawImage( x*velocimetro[2]['x1'], y*velocimetro[2]['y1'], x*velocimetro[2]['x2'], y*velocimetro[2]['y2'], velocimetro[2]['image'], 0, 0, 0, tocolor(90,90,255,255), false )
			vehicleSpeed = getElementSpeed(in_vehicle,1)
			local getSpeed = string.format("%03d",vehicleSpeed)
	        dxDrawText("KM/h", 1256, y*717, 1293, y*729, tocolor(0, 0, 0, 230), 0.82, "sans", "center", "top", false, false, false, false, false)
			dxDrawText("KM/h", 1256, y*717, 1293, y*729, tocolor(188, 188, 188, 230), 0.82, "sans", "center", "top", false, false, false, false, false)
	        dxDrawText(getSpeed.."\nKM/h", x*1256, y*705, x*1293, y*717, tocolor(0, 0, 0, 230), 0.82, "sans", "center", "top", false, false, false, false, false)
	        dxDrawText(getSpeed.."\nKM/h", x*1256, y*705, x*1293, y*717, tocolor(188, 188, 188, 230), 0.82, "sans", "center", "top", false, false, false, false, false)
		else
			if AnimY > 674 then
				AnimY = AnimY - 10
			else
				AnimY = 674
			end
			dxDrawText("VEICULO DESLIGADO \n'J' PARA LIGAR", x*651-1,  y*AnimY-1, x*711+2, y*734+2, tocolor(0, 0, 0, 255), 2, "default", "center", "top", false, false, true)
			dxDrawText("VEICULO DESLIGADO \n'J' PARA LIGAR", x*651,  y*AnimY, x*711, y*734, tocolor(255, 255, 255, 255), 2, "default", "center", "top", false, false, true)
		end
		if isVehicleLocked( in_vehicle ) or ( getElementData( in_vehicle, "cl_vehiclelocked" ) ) then 
			dxDrawImage( x*velocimetro[4]['x1'], y*velocimetro[4]['y1'], x*velocimetro[4]['x2'], y*velocimetro[4]['y2'], velocimetro[4]['image'], 0, 0, 0, tocolor(90,90,255,255), false )
		end
		if getVehicleOverrideLights ( in_vehicle ) == 2 then
			dxDrawImage( x*velocimetro[3]['x1'], y*velocimetro[3]['y1'], x*velocimetro[3]['x2'], y*velocimetro[3]['y2'], velocimetro[3]['image'], 0, 0, 0, tocolor(90,90,255,255), false )
		end
		if getElementData(localPlayer, "ov") then
			dxDrawImage( x*velocimetro[5]['x1'], y*velocimetro[5]['y1'], x*velocimetro[5]['x2'], y*velocimetro[5]['y2'], velocimetro[5]['image'], 0, 0, 0, tocolor(90,90,255,255), false )
		end
	end
end)



--//complementos
g_Player = getLocalPlayer()
function getVehicleSpeed()
    if isPedInVehicle(g_Player) then
        local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(g_Player))
        return math.sqrt(vx^2 + vy^2 + vz^2) * 187.5
    end
    return 0
end
function getElementSpeed(element,unit)
    assert(isElement(element), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(element) .. ")")
    assert(getElementType(element) == "player" or getElementType(element) == "ped" or getElementType(element) == "object" or getElementType(element) == "vehicle", "Invalid element type @ getElementSpeed (player/ped/object/vehicle expected, got " .. getElementType(element) .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(element)) * mult).length
end

function toggleRadar()
	if isVisible then
		addEventHandler("onClientRender", root, hud )
	else
		removeEventHandler("onClientRender", root, hud )
	end
	isVisible = not isVisible
end
bindKey ("F11", "down", toggleRadar)

local components = {"weapon", "ammo", "health", "clock", "money", "breath", "armour", "wanted", "vehicle_name", "area_name", "radio"}
function onClientResourceStart()
	sAlpha = 200
	for _, component in ipairs(components) do
		setPlayerHudComponentVisible(component, false)
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart)

function onClientResourceStop()
	for _, component in ipairs(components) do
		setPlayerHudComponentVisible(component, true)
	end
end
addEventHandler("onClientResourceStop", resourceRoot, onClientResourceStop)

function getPedMaxHealth(ped)
	assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ 'getPedMaxHealth' [Expected ped/player at argument 1, got " .. tostring(ped) .. "]")
	local stat = getPedStat(ped, 24)
	local maxhealth = 100 + (stat - 569) / 4.31
	return math.max(1, maxhealth)
end

addEventHandler("onClientPlayerVoiceStart", localPlayer,
	function()
		voice= true
	end
)

addEventHandler("onClientPlayerVoiceStop", localPlayer,
	function()
		voice= false
	end
)

local veh = false
local nosOn = false
bindKey("vehicle_fire", "both",
function(_,state)
        veh = getPedOccupiedVehicle(localPlayer)
        if veh and state == "up" and isVehicleNitroActivated(veh) and getVehicleController(veh) == localPlayer then
                setVehicleNitroActivated(veh, false)
                nosOn = false
        elseif veh and state == "down" and getVehicleController(veh) == localPlayer then
                setVehicleNitroActivated(veh, true)
                nosOn = true
        end
end)
