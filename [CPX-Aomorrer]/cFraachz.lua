--[[

		:::::::::: :::::::::      :::         :::      ::::::::  :::    ::: :::::::::            
		:+:        :+:    :+:   :+: :+:     :+: :+:   :+:    :+: :+:    :+:      :+:             
		+:+        +:+    +:+  +:+   +:+   +:+   +:+  +:+        +:+    +:+     +:+              
		:#::+::#   +#++:++#:  +#++:++#++: +#++:++#++: +#+        +#++:++#++    +#+               
		+#+        +#+    +#+ +#+     +#+ +#+     +#+ +#+        +#+    +#+   +#+                
		#+#        #+#    #+# #+#     #+# #+#     #+# #+#    #+# #+#    #+#  #+#                 
		###        ###    ### ###     ### ###     ###  ########  ###    ### ######### ########## 

                                    » CopyRight © 2020
                            » Script feito por » Fraachz_#9999

]]--

local screenW, screenH = guiGetScreenSize()
local x, y = (screenW/1366), (screenH/768)

painel = false

function telaAoMorrer_dx()
    if painel == true then
        dxDrawImage(screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 1.0000, "files/IMGs/fundo.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawRectangle(screenW * 0.0176, screenH * 0.2604, screenW * 0.2684, screenH * 0.1628, tocolor(255, 255, 255, 0), true)
        dxDrawRectangle(screenW * 0.3676, screenH * 0.2604, screenW * 0.2684, screenH * 0.1628, tocolor(255, 255, 255, 0), true)
        dxDrawRectangle(screenW * 0.7147, screenH * 0.2604, screenW * 0.2684, screenH * 0.1628, tocolor(255, 255, 255, 0), true)

    end
end


function morrerTransfer()
    if painel == false then
        addEventHandler("onClientRender", root, telaAoMorrer_dx)
        playSoundFrontEnd(43)
        showCursor(true)
        painel = true
    else
        removeEventHandler("onClientRender", root, telaAoMorrer_dx) 
        playSoundFrontEnd(43)
        showCursor(false)
        painel = false
    end
end
addEvent("FR:TelaAoMorrer", true)
addEventHandler("onClientPlayerWasted", localPlayer, morrerTransfer)

function clientClick(_, state)
    if painel == true then
        if state == "down" then
            if isCursorOnElement(screenW * 0.3676, screenH * 0.2604, screenW * 0.2684, screenH * 0.1628) then -- Las Venturas
                
                triggerServerEvent("FR:MorrerTela", localPlayer, localPlayer, 1)
                removeEventHandler("onClientRender", root, telaAoMorrer_dx) 
                playSoundFrontEnd(43)
                showCursor(false)
                painel = false
                showChat(true)

            elseif isCursorOnElement(screenW * 0.0176, screenH * 0.2604, screenW * 0.2684, screenH * 0.1628) then -- Los Santos

                triggerServerEvent("FR:MorrerTela", localPlayer, localPlayer, 2)
                removeEventHandler("onClientRender", root, telaAoMorrer_dx) 
                playSoundFrontEnd(43)
                showCursor(false)
                painel = false
                showChat(true)

            elseif isCursorOnElement(screenW * 0.7147, screenH * 0.2604, screenW * 0.2684, screenH * 0.1628) then -- San Fierro

                triggerServerEvent("FR:MorrerTela", localPlayer, localPlayer, 3)
                removeEventHandler("onClientRender", root, telaAoMorrer_dx) 
                playSoundFrontEnd(43)
                showCursor(false)
                painel = false
                showChat(true)

            end
        end
    end
end
addEventHandler("onClientClick", root, clientClick)

function isCursorOnElement(posX, posY, width, height)
    if isCursorShowing() then
        local MouseX, MouseY = getCursorPosition()
        local clientW, clientH = guiGetScreenSize()
        local MouseX, MouseY = MouseX * clientW, MouseY * clientH
        if (MouseX > posX and MouseX < ( posX + width) and MouseY > posY and MouseY < (posY + height)) then
            return true
        end
    end
    return false
end