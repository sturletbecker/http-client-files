-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'mp5lng.txd' ) 
engineImportTXD( txd, 353 ) 
dff = engineLoadDFF('mp5lng.dff', 353) 
engineReplaceModel( dff, 353 )
end)
