local screenX, screenY = guiGetScreenSize()

function reMap(value, low1, high1, low2, high2)
	return low2 + (value - low1) * (high2 - low2) / (high1 - low1)
end

local responsiveMultiplier = reMap(screenX, 1024, 1920, 0.75, 1)

function getResponsiveMultiplier()
	return responsiveMultiplier
end

local responsiveMultipler = getResponsiveMultiplier()

function resp(value)
    return value * responsiveMultipler
end

function respc(value)
    return math.ceil(value * responsiveMultipler)
end

fonts = {
	Roboto11 = dxCreateFont("assets/fonts/Roboto-Regular.ttf", respc(11), false, "antialiased"),
	Roboto13 = dxCreateFont("assets/fonts/Roboto-Regular.ttf", respc(13), false, "antialiased"),
	Roboto14 = dxCreateFont("assets/fonts/Roboto-Regular.ttf", respc(14), false, "antialiased"),
	Roboto16 = dxCreateFont("assets/fonts/Roboto-Regular.ttf", respc(16), false, "cleartype"),
	Roboto18 = dxCreateFont("assets/fonts/Roboto-Regular.ttf", respc(18), false, "cleartype"),
	RobotoL = dxCreateFont("assets/fonts/Roboto-Light.ttf", respc(18), false, "cleartype"),
	RobotoL14 = dxCreateFont("assets/fonts/Roboto-Light.ttf", respc(14), false, "cleartype"),
	RobotoL16 = dxCreateFont("assets/fonts/Roboto-Light.ttf", respc(16), false, "cleartype"),
	RobotoL18 = dxCreateFont("assets/fonts/Roboto-Light.ttf", respc(18), false, "cleartype"),
	RobotoL24 = dxCreateFont("assets/fonts/Roboto-Light.ttf", respc(24), false, "cleartype"),
	RobotoLI16 = dxCreateFont("assets/fonts/Roboto-Light-Italic.ttf", respc(16), false, "cleartype"),
	RobotoLI24 = dxCreateFont("assets/fonts/Roboto-Light-Italic.ttf", respc(24), false, "cleartype"),
	RobotoB18 = dxCreateFont("assets/fonts/Roboto-Bold.ttf", respc(18), false, "antialiased"),
}

local panelState = false
local selectedAnim = false

local panelAnimsW, panelAnimsH = respc(350), respc(450)
local panelAnimsX, panelAnimsY = (screenX - panelAnimsW) * 0.5, (screenY - panelAnimsH) * 0.5

local rowW, rowH = panelAnimsW - respc(20), respc(40)
local rowX, rowStartY = panelAnimsX + respc(10), panelAnimsY + 20

local seged = {}

bindKey("f2", "down", function()
	panelState = not panelState
	showCursor(not isCursorShowing()) 
end)

addCommandHandler("animlist", function(cmd)
	panelState = not panelState
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
	for k, v in pairs(animations) do
		table.insert(seged, k)
	end
end)

addEventHandler("onClientKey", getRootElement(),
    function (key, press)
        if press then
            if panelState then
				local offset = scrollData["animsOffset"] or 0

				if key == "mouse_wheel_down" and offset < #seged - maxVisibleRow then
					offset = offset + 1
				elseif key == "mouse_wheel_up" and offset > 0 then
					offset = offset - 1
				end

				scrollData["animsOffset"] = offset
            end
        end
    end
)

addEventHandler("onClientRender", root, function()

	if not panelState then
		return
	end

	absX, absY = 0, 0

    if isCursorShowing() then
        local relX, relY = getCursorPosition()

        absX = screenX * relX
        absY = screenY * relY
    end

	roundedRectangle(panelAnimsX, panelAnimsY, panelAnimsW, panelAnimsH, tocolor( 0, 0, 0, 80))

	roundedRectangle(panelAnimsX, panelAnimsY, panelAnimsW, 30, tocolor(0,255,0))
	dxDrawText("Painel Animações", panelAnimsX + 1 * 55, panelAnimsY, 0, panelAnimsY + 30, tocolor(255, 255, 255), 1, fonts.RobotoL, "left", "center")

	local closeTextWidth = dxGetTextWidth("X", 1, fonts.RobotoL)
	local closeTextPosX = panelAnimsX + panelAnimsW - closeTextWidth - 5
	local closeColor = tocolor(255, 255, 255)

	if absX >= closeTextPosX and absY >= panelAnimsY and absX <= closeTextPosX + closeTextWidth and absY <= panelAnimsY + 30 then
		closeColor = tocolor(215, 89, 89)

		if getKeyState("mouse1") then
			panelState = false
			showCursor(false)
			selectedAnim = false
			return
		end
	end
	
	dxDrawText("X", closeTextPosX, panelAnimsY, 0, panelAnimsY + 30, closeColor, 1, fonts.RobotoL, "left", "center")


	maxVisibleRow = 8
	local animsOffset = scrollData["animsOffset"] or 0
	for i = 1, maxVisibleRow do
		local anim = seged[i + animsOffset]

		if anim then
			local rowY = rowStartY + (rowH * i)
			
			local colorOfRow = tocolor(10, 10, 10, 125)

			if i % 2 == 0 then
				colorOfRow = tocolor(10, 10, 10, 125)
			end
			
			if selectedAnim == anim then
				colorOfRow = tocolor(0, 255, 0)
			end
			

			roundedRectangle(rowX, rowY, rowW, rowH, colorOfRow)
			dxDrawText(anim, rowX + respc(10), rowY, rowX + rowW, rowY + rowH, tocolor(255, 255, 255, 255), 1, fonts.Roboto11, "left", "center")
		end
	end

	if #seged > maxVisibleRow then
		drawScrollbar("anims", rowX + rowW - respc(12), rowStartY + rowH, respc(12), rowH * maxVisibleRow, maxVisibleRow, #seged)
	end

	if selectedAnim then
		dxDrawMetroButtonWithBorder("anim:play", "Habilitar", panelAnimsX + respc(10), panelAnimsY + panelAnimsH - respc(50), panelAnimsW - respc(20), respc(40), {43, 87, 151, 125}, {43, 87, 151, 175}, {255, 255, 255}, fonts.Roboto14, "center", "center", nil, nil, nil, nil)
	end

	activeButtonChecker()
end)

addEventHandler("onClientClick", root, function(button, state)
	if not panelState then
		return
	end

	if button == "left" and state == "down" then
		if activeButton == "anim:play" then
			local animsOffset = scrollData["animsOffset"] or 0
			triggerServerEvent("sarp_animationS:playAnimation", root, localPlayer, selectedAnim)
		end

		for i = 1, maxVisibleRow do
			local animsOffset = scrollData["animsOffset"] or 0
			local anim = seged[i + animsOffset]
	
			if anim then
				local rowY = rowStartY + (rowH * i)
				if cursorInBox(rowX, rowY, rowW, rowH) then
					selectedAnim = anim
					break
				end
			end
		end
		
	end
end)