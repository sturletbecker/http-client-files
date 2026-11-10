-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'desert_eagle.txd' ) 
engineImportTXD( txd, 352 ) 
dff = engineLoadDFF('desert_eagle.dff', 352) 
engineReplaceModel( dff, 352 )
end)
