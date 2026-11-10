local shader = dxCreateShader("shader.fx")
local texture = dxCreateTexture("alpha.png")
dxSetShaderValue(shader, "gTexture", texture)

local leavesTextureNames = {
	"newtreed256", "newtreeleaves128", "kb_ivy2_256", "tree19mi", "ashbrnch",
	"pinebrnch1", "cedarwee", "elmdead", "pinelo128", "elmtreered", "elm_treegrn",
	"elm_treegrn4", "elm_treegrn2", "oakleaf1", "oakleaf2", "cypress1", "cypress2",
	"trunk3", "sm_josh_leaf", "locustbra", "planta256", "kbtree4_test", "newtreeleavesb128",
	"veg_largefurs05", "veg_largefurs06", "lod_largefurs07", "spruce1", "cedar2",
	"pinebranch2", "cedar1", "lod_largefurs07", "sm_redwood_branch", "veg_largefurs05",
	"veg_largefurs06", "lod_redwoodgrp",
	-- add texture name to the table what you want to make invisible
}

for _, name in ipairs(leavesTextureNames) do -- loader
	engineApplyShaderToWorldTexture(shader, name)
end