-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'desert_eagle.txd' ) 
engineImportTXD( txd, 348 ) 
dff = engineLoadDFF('desert_eagle.dff', 348) 
engineReplaceModel( dff, 348 )
end)
