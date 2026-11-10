function playerPressedKey(button, press)
    if (press) then
        if getElementData(getLocalPlayer(), "emEvento") == true then
            if (button == getElementData(getLocalPlayer(), "heditBindKey")) then
                if(not ENABLE_HEDIT)then
                    cancelEvent()
                end
                return
            end
            for _,v in pairs(_KEYs) do
                if (button == v) then
                    cancelEvent()
                    return
                end
            end
        end
    end
end
addEventHandler("onClientKey", root, playerPressedKey)

------------------------------------------------
fileDelete("evento_C.lua")