-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'm4.txd' ) 
engineImportTXD( txd, 358 ) 
dff = engineLoadDFF('m4.dff', 358) 
engineReplaceModel( dff, 358 )
end)
