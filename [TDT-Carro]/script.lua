-- GMMods agradece a preferencia, para entrar no discord da GM basta entrar no link https://discord.gg/aqV87V4 <3

local id = 550


addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'TeslabyGuilhermeModder-GMMODS.txd' ) 
engineImportTXD( txd, id ) 
dff = engineLoadDFF('TeslabyGuilhermeModder-GMMODS.dff', id) 
engineReplaceModel( dff, id )
end)
