-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'ByKayke.txd' ) 
engineImportTXD( txd, 201 ) 
dff = engineLoadDFF('ByKayke.dff', 201) 
engineReplaceModel( dff, 201 )
end)
