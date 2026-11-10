-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'silenced.txd' ) 
engineImportTXD( txd, 347 ) 
dff = engineLoadDFF('silenced.dff', 347) 
engineReplaceModel( dff, 347 )
end)
