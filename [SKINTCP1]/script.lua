-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( '8.txd' ) 
engineImportTXD( txd, 156 ) 
dff = engineLoadDFF('8.dff', 156) 
engineReplaceModel( dff, 156 )
end)
