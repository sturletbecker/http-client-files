buttons = {}
activeButton = false

local screenX, screenY = guiGetScreenSize()

local activeDirectX = false
local lastActiveDirectX = false

local buttonIsProcessing = false

function cursorInBox(x, y, w, h)
	if x and y and w and h then
		if isCursorShowing() then
			if not isMTAWindowActive() then
				local cursorX, cursorY = getCursorPosition()
				
				cursorX, cursorY = cursorX * screenX, cursorY * screenY
				
				if cursorX >= x and cursorX <= x + w and cursorY >= y and cursorY <= y + h then
					return true
				end
			end
		end
	end
	
	return false
end

function dxDrawMetroButtonWithBorder(key, label, x, y, w, h, buttonColor, activeColor, textColor, font, textAlign1, textAlign2, imagePath, imageW, imageH, imageColor)
	lastActiveDirectX = activeDirectX
    activeDirectX = activeButton

    --local buttonColor
    local imageColorEx = imageColor

	if activeButton == key then -- !!!
        buttonColor = {processColorSwitchEffect(key, {activeColor[1], activeColor[2], activeColor[3], activeColor[4]})}
        if imagePath then
            imageColorEx = {processColorSwitchEffect(key .. "_img", {255, 255, 255, 255})}
        end
	else
        buttonColor = {processColorSwitchEffect(key, {buttonColor[1], buttonColor[2], buttonColor[3], buttonColor[4]})}
        if imagePath then
            imageColorEx = {processColorSwitchEffect(key .. "_img", {imageColor[1], imageColor[2], imageColor[3], 255})}
        end
	end

	local alphaDifference = 175 - buttonColor[4]
	local fadeAmount = 1

	roundedRectangle(x, y, w, h, tocolor(60, 60, 60, buttonColor[4] * fadeAmount))

    textAlign1 = textAlign1 or "left"
    textAlign2 = textAlign2 or "center"

    if imagePath then

        if not imageColor then
            imageColor = {255, 255, 255}
        end

        dxDrawImage(x + respc(5), y + respc(5), imageW - respc(10), imageH - respc(10), imagePath, 0, 0, 0, tocolor(imageColorEx[1], imageColorEx[2], imageColorEx[3], 255 * fadeAmount))
        dxDrawText(label, x + imageW + respc(5), y, x + w, y + h, tocolor(textColor[1], textColor[2], textColor[3], 255 * fadeAmount), 1, font, textAlign1, textAlign2)
    else
        dxDrawText(label, x + respc(5), y, x + w, y + h, tocolor(textColor[1], textColor[2], textColor[3], 255 * fadeAmount), 1, font, textAlign1, textAlign2)
    end

	buttons[key] = {x, y, w, h} -- !!!

    if activeDirectX ~= lastActiveDirectX and activeDirectX then
    end
end

function dxDrawMetroTilePanel(key, label, x, y, w, h, activeColor, imagePath, imageW, imageH, imageColor, imageAlign, titleText, titleTextColor, titleTextFont, titleTextAlign, downText, downTextColor, downTextFont, downTextAlign, centerText, centerTextColor, centerTextFont, centerTextAlign)
	local buttonColor

		buttonColor = {processColorSwitchEffect(key, {activeColor[1], activeColor[2], activeColor[3], activeColor[4]})}

	local alphaDifference = 175 - buttonColor[4]
	local fadeAmount = 1

	roundedRectangle(x, y, w, h, tocolor(buttonColor[1], buttonColor[2], buttonColor[3], (175 - alphaDifference) * fadeAmount))

	if imagePath then
        imageW = imageW or respc(100)
        imageH = imageH or respc(100)
        if imageColor then
            imageColor = tocolor(imageColor[1], imageColor[2], imageColor[3], imageColor[4] * fadeAmount) or tocolor(255, 255, 255, 255 * fadeAmount)
        else
            imageColor = tocolor(255, 255, 255, 255 * fadeAmount)
        end
        imageAlign = imageAlign or "center"

        if imageAlign == "center" then
            local imgX, imgY = x + (w - imageW) * 0.5, y + (h - imageH) * 0.5
            dxDrawImage(imgX, imgY, imageW, imageH, imagePath, 0, 0, 0, imageColor)
        elseif imageAlign == "left" then
            local imgX, imgY = x + respc(10), y + (h - imageH) * 0.5
            dxDrawImage(imgX, imgY, imageW, imageH, imagePath, 0, 0, 0, imageColor)
        elseif imageAlign == "right" then
            local imgX, imgY = x + w - imageW - respc(10), y + (h - imageH) * 0.5
            dxDrawImage(imgX, imgY, imageW, imageH, imagePath, 0, 0, 0, imageColor)
        end
    end

    
	
	--buttons[key] = {x, y, w, h} -- !!!
end

function dxDrawInnerBorder(thickness, x, y, w, h, color)
	thickness = thickness or 2

	dxDrawLine(x, y, x + w, y, color, thickness)
	dxDrawLine(x, y + h, x + w, y + h, color, thickness)
	dxDrawLine(x, y, x, y + h, color, thickness)
	dxDrawLine(x + w, y, x + w, y + h, color, thickness)
end

local colorSwitch = {}

colorSwitch.storedColors = {}
colorSwitch.lastColors = {}
colorSwitch.startInterpolation = {}
colorSwitch.lastColorConcat = {}

function processColorSwitchEffect(key, color, duration, type)
	if not colorSwitch.storedColors[key] then
		if not color[4] then
			color[4] = 255
		end

		colorSwitch.storedColors[key] = color
		colorSwitch.lastColors[key] = color

		colorSwitch.lastColorConcat[key] = table.concat(color)
	end

	duration = duration or 500
	type = type or "Linear"

	if colorSwitch.lastColorConcat[key] ~= table.concat(color) then
		colorSwitch.lastColorConcat[key] = table.concat(color)
		colorSwitch.lastColors[key] = color
		colorSwitch.startInterpolation[key] = getTickCount()
	end

	if colorSwitch.startInterpolation[key] then
		local progress = (getTickCount() - colorSwitch.startInterpolation[key]) / duration

		local r, g, b = interpolateBetween(
			colorSwitch.storedColors[key][1], colorSwitch.storedColors[key][2], colorSwitch.storedColors[key][3],
			color[1], color[2], color[3],
			progress, type
		)

		local a = interpolateBetween(colorSwitch.storedColors[key][4], 0, 0, color[4], 0, 0, progress, type)

		colorSwitch.storedColors[key][1] = r
		colorSwitch.storedColors[key][2] = g
		colorSwitch.storedColors[key][3] = b
		colorSwitch.storedColors[key][4] = a

		if progress >= 1 then
			colorSwitch.startInterpolation[key] = false
		end
	end

	return colorSwitch.storedColors[key][1], colorSwitch.storedColors[key][2], colorSwitch.storedColors[key][3], colorSwitch.storedColors[key][4]
end

function activeButtonChecker()
    local cx, cy = getCursorPosition() -- получить относительное положение курсора

    if tonumber(cx) and tonumber(cy) then -- если задано число, то отображается курсор
        cx, cy = cx * screenX, cy * screenY -- преобразование в абсолютные значения
        cursorX, cursorY = cx, cy -- абсолютные положения курсора сохраняются в переменной

        activeButton = false -- если вы не можете найти дерьмо, нет ничего назначенного, так что ложь

        for k, v in pairs(buttons) do -- пройдите через созданные кнопки
            if cx >= v[1] and cy >= v[2] and cx <= v[1] + v[3] and cy <= v[2] + v[4] then -- он в кабинке?
                activeButton = k -- сохраните активную выбранную кнопку
                break -- остановите цикл
            end
        end
    else -- если курсор не отображается
        activeButton = false -- Не выбрано
        cursorX, cursorY = -10, -10 -- курсор вне экрана, так что рендеринг не обнаруживает
    end
end

function table.empty (self)
    for _, _ in pairs(self) do
        return false
    end
    return true
end

function reMap(value, low1, high1, low2, high2)
    return (value - low1) * (high2 - low2) / (high1 - low1) + low2
end

scrollData = {}
scrollData.draggingGrips = {}
scrollData.gripPoses = {}
local lastScrollByArrowBtn = 0

function drawScrollbar(key, x, y, w, h, visibleItems, currentItems)
    local fadeAmount = 1

    local trackY = y + w
    local trackHeight = h - (w * 2)
    
    local gripHeight = (trackHeight / currentItems) * visibleItems
    local gripColor

    if not scrollData[key .. "Offset"] then
        scrollData[key .. "Offset"] = 0
    end

    if scrollData.draggingGrips[key] then
        gripColor = {174, 174, 174, 255}

        scrollData.gripPoses[key] = cursorY - scrollData.draggingGrips[key]

        if scrollData.gripPoses[key] < trackY then
            scrollData.gripPoses[key] = trackY
        elseif scrollData.gripPoses[key] > trackY + trackHeight - gripHeight then
            scrollData.gripPoses[key] = trackY + trackHeight - gripHeight
        end

        scrollData[key .. "Offset"] = math.floor(reMap(scrollData.gripPoses[key], trackY, trackY + trackHeight - gripHeight, 0, 1) * (currentItems - visibleItems))
    elseif activeButton == "scrollbarGrip:" .. key then
        if getKeyState("mouse1") then
            gripColor = {174, 174, 174, 255}
        else
            gripColor = {174, 174, 174, 255}
        end
    else
        gripColor = {93, 93, 93, 255}
    end

    local gripY = trackY + (trackHeight / currentItems) * math.min(scrollData[key .. "Offset"], currentItems - visibleItems)

    if gripY < trackY then
        gripY = trackY
    elseif gripY > trackY + trackHeight - gripHeight then
        gripY = trackY + trackHeight - gripHeight
    end

    scrollData.gripPoses[key] = gripY

    roundedRectangle(x+7, trackY-10, w, trackHeight+21, tocolor(53, 53, 53, 255 * fadeAmount))
    roundedRectangle(x+7, gripY-10, w, gripHeight+21, tocolor(gripColor[1], gripColor[2], gripColor[3], gripColor[4] * fadeAmount))
    buttons["scrollbarGrip:" .. key] = {x, gripY, w, gripHeight}

    -- ** Kis gomb (fel)
    local colorOfUp = tocolor(50, 50, 48, 255 * fadeAmount)
    local colorOfArrow = tocolor(210, 210, 210, 255 * fadeAmount)

    if activeButton == "scrollUp:" .. key then
        if getKeyState("mouse1") then
            colorOfUp = tocolor(173, 173, 173, 255 * fadeAmount)
            colorOfArrow = tocolor(83, 83, 83, 255 * fadeAmount)

            if lastScrollByArrowBtn == 0 then
                scrollData[key .. "Offset"] = scrollData[key .. "Offset"] - 1
                lastScrollByArrowBtn = getTickCount()
            end

            if getTickCount() - lastScrollByArrowBtn >= 125 then
                scrollData[key .. "Offset"] = scrollData[key .. "Offset"] - 1
                lastScrollByArrowBtn = getTickCount()
            end

            if scrollData[key .. "Offset"] < 0 then
                scrollData[key .. "Offset"] = 0
            end
        else
            lastScrollByArrowBtn = 0
            colorOfUp = tocolor(73, 73, 72)
        end
    end

    buttons["scrollUp:" .. key] = {x, trackY - w, w, w}

    local colorOfDown = tocolor(50, 50, 48, 255 * fadeAmount)
    local colorOfArrow = tocolor(210, 210, 210, 255 * fadeAmount)

    if activeButton == "scrollDown:" .. key then
        if getKeyState("mouse1") then
            colorOfDown = tocolor(173, 173, 173, 255 * fadeAmount)
            colorOfArrow = tocolor(83, 83, 83, 255 * fadeAmount)

            if lastScrollByArrowBtn == 0 then
                scrollData[key .. "Offset"] = scrollData[key .. "Offset"] + 1
                lastScrollByArrowBtn = getTickCount()
            end

            if getTickCount() - lastScrollByArrowBtn >= 125 then
                scrollData[key .. "Offset"] = scrollData[key .. "Offset"] + 1
                lastScrollByArrowBtn = getTickCount()
            end

            if scrollData[key .. "Offset"] > currentItems - visibleItems then
                scrollData[key .. "Offset"] = currentItems - visibleItems
            end
        else
            lastScrollByArrowBtn = 0
            colorOfDown = tocolor(73, 73, 72)
        end
    end

    buttons["scrollDown:" .. key] = {x, trackY + trackHeight, w, w}
end

local buttonSlider = {}
buttonSlider.offsets = {}
buttonSlider.interpolationStart = {}
buttonSlider.states = {}

function drawButtonSlider(key, state, x, y, h, offColor, onColor)
    local fadeAmount = 1

    if not buttonSlider.offsets[key] then
        buttonSlider.offsets[key] = 0
        buttonSlider.states[key] = state
    end

    local buttonColor
    if state then
        buttonColor = {processColorSwitchEffect(key, {onColor[1], onColor[2], onColor[3], 0})}
    else
        buttonColor = {processColorSwitchEffect(key, {offColor[1], offColor[2], offColor[3], 255})}
    end

    if buttonSlider.states[key] ~= state then
        buttonSlider.states[key] = state
        buttonSlider.interpolationStart[key] = {getTickCount(), state}
    end

    if buttonSlider.interpolationStart[key] then
        local progress = (getTickCount() - buttonSlider.interpolationStart[key][1]) / 500

        if  buttonSlider.interpolationStart[key][2] then
            buttonSlider.offsets[key] = interpolateBetween(buttonSlider.offsets[key], 0, 0, 32, 0, 0, progress, "Linear")
        else
            buttonSlider.offsets[key] = interpolateBetween(buttonSlider.offsets[key], 0, 0, 0, 0, 0, progress, "Linear")
        end

        if progress >= 1 then
            buttonSlider.interpolationStart[key] = false
        end
    end

    local alphaDifference = 255 - buttonColor[4]

    buttons[key] = {x, y, 64, 32}

    y = y + (h - 32) / 2

    dxDrawImage(x, y, 64, 32, ":sarp_groups/files/toggleSwitch/off.png", 0, 0, 0, tocolor(255, 255, 255, (255 - alphaDifference) * fadeAmount))
    dxDrawImage(x, y, 64, 32, ":sarp_groups/files/toggleSwitch/on.png", 0, 0, 0, tocolor(buttonColor[1], buttonColor[2], buttonColor[3], alphaDifference * fadeAmount))
    dxDrawImage(x + buttonSlider.offsets[key], y, 64, 32, ":sarp_groups/files/toggleSwitch/circle.png", 0, 0, 0, tocolor(255, 255, 255, 255 * fadeAmount))
end

addEventHandler("onClientClick", getRootElement(),
    function (button, state)
        if button == "left" and state == "down" then
            if activeButton then
                local selected = split(activeButton, ":")

                if selected[1] == "scrollbarGrip" then
                    local key = selected[2]

                    scrollData.draggingGrips[key] = cursorY - scrollData.gripPoses[key]
                end
            end
        elseif button == "left" and state == "up" then
            scrollData.draggingGrips = {}
        end
    end
)

function roundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
    if (x and y and w and h) then
        if (not borderColor) then
            borderColor = tocolor(0, 0, 0, 200);
        end
        if (not bgColor) then
            bgColor = borderColor;
        end
        dxDrawRectangle(x, y, w, h, bgColor, postGUI);
        dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI);
        dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI);
        dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI);
        dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI);
    end
end