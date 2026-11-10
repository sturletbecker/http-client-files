-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'ByStalin.txd' ) 
engineImportTXD( txd, 203 ) 
dff = engineLoadDFF('ByStalin.dff', 203) 
engineReplaceModel( dff, 203 )
end)
