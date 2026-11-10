-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'ByKayke.txd' ) 
engineImportTXD( txd, 202 ) 
dff = engineLoadDFF('ByKayke.dff', 202 ) 
engineReplaceModel( dff, 202 )
end)
