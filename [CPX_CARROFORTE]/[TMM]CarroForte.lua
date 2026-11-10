txd = engineLoadTXD("[TMM]CarroForte.txd")
engineImportTXD(txd, 428)
dff = engineLoadDFF("[TMM]CarroForte.dff", 428)
engineReplaceModel(dff, 428)
