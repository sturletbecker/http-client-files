-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'Bradock.txd' ) 
engineImportTXD( txd, 157 ) 
dff = engineLoadDFF('Bradock.dff', 157) 
engineReplaceModel( dff, 157 )
end)
