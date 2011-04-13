local addon, ns = ...
MalaimoSpells={
["DRUID"]={
	["buff"]={
		filter ="buff",size=32,buffunit="player",caster="player",Direction = "RIGHT",
		list={
		{id=48438,setpoint={"CENTER",nil,"CENTER", -250, 100,},},
		{id=33763,setpoint={0},},
		{id="回春術",setpoint={0},tex="Interface\\Addons\\Malaimo\\media\\lock",sound1="igMiniMapOpen",sound2="igMiniMapOpen"},
		},
	},	
	["debuff"]={
		filter ="debuff",size=47,buffunit="target",caster="player",Direction = "RIGHT",
		list={
		{id=8921,setpoint={ "CENTER",nil,"CENTER",250, 100,},},
		{id="蟲群",setpoint={0},},
		},
	},
	["cd"]={
		filter="cooldown",size=40,buffunit="player",caster="player",Direction="RIGHT",
		list={
		{id=22812,setpoint={"CENTER",nil,"CENTER",250,150},},
		{id=5215,setpoint={0},},
		{id="slot13",setpoint={0},},
		{id="寧靜",setpoint={0},},
		},
		},
	},
	["HUNTER"] ={
	},
	["MAGE"] ={
	},
	["WARRIOR"] ={
	},
	["SHAMAN"] ={
	},
	["PALADIN"] ={
	},
	["PRIEST"] ={
	},
	["WARLOCK"] ={
	},
	["ROGUE"] ={
	},
	["DEATHKNIGHT"] ={
	},
	
}

Equal={
	[8921]=93401,
}
ns.MalaimoSpells=MalaimoSpells
ns.Equal=Equal
function MalaimoGetTable()
	return ns.MalaimoSpells
end