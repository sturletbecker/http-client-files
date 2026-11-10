txd = engineLoadTXD( 'rancher.txd' ) 
engineImportTXD( txd, 597 ) 
dff = engineLoadDFF('rancher.dff', 597) 
engineReplaceModel( dff, 597 )