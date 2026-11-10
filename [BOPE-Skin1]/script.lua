txd = engineLoadTXD( '265.txd' ) 
engineImportTXD( txd, 59 ) 
dff = engineLoadDFF('265.dff', 59) 
engineReplaceModel( dff, 59 )