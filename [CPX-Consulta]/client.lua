

local screenW, screenH = guiGetScreenSize()

local ExibindoPainel = false
    function Painel ()
        dxDrawImage(315, 240, 0, 0, ":Consulta/files/Consulta.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.3174, screenH * 0.1849, screenW * 0.3721, screenH * 0.5964, ":Consulta/files/Consulta.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
end

addEvent("HitarMarker", true)
addEventHandler("HitarMarker", root, function()
	if ExibindoPainel == false then
		addEventHandler("onClientRender", getRootElement(), Painel)
		showCursor(true)
		ExibindoPainel = true
	end
end)

bindKey("backspace", "down", function()
	if ExibindoPainel == true then
		removeEventHandler("onClientRender", getRootElement(), Painel)
		ExibindoPainel = false
		showCursor(false)
	end
end)

addEventHandler("onClientClick", root, function(button, state)
	if button=="left" and state=="down" then
	    if ExibindoPainel == true then
			if isMouseInPosition(screenW * 0.3379, screenH * 0.4831, screenW * 0.3457, screenH * 0.0729) then
				triggerServerEvent ("Consultar", localPlayer, localPlayer, 1)
			end
		end
	end
end)

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

-- Modified version for DX Text
function isCursorOverText(posX, posY, sizeX, sizeY)
	if ( not isCursorShowing( ) ) then
		return false
	end
	local cX, cY = getCursorPosition()
	local screenWidth, screenHeight = guiGetScreenSize()
	local cX, cY = (cX*screenWidth), (cY*screenHeight)

	return ( (cX >= posX and cX <= posX+(sizeX - posX)) and (cY >= posY and cY <= posY+(sizeY - posY)) )
end