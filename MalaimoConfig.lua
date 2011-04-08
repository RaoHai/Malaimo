local addon, ns = ...
MalaimoSpells={
["DRUID"]={
	["buff"]={
		filter ="buff",size=32,buffunit="player",caster="player",Direction = "RIGHT",
		list={48438,33763,"回春術",},
		Pointlist={
			{"CENTER",nil,"CENTER", -250, 100,},
			{0},
			{0},
			},
	},	
	["debuff"]={
		filter ="debuff",size=47,buffunit="target",caster="player",Direction = "RIGHT",
		list={8921,589,2944,},
		Pointlist={
			{ "CENTER",nil,"CENTER",250, 100,},
			{0},
			{0},
		},
	},
	["cd"]={
		filter="cooldown",size=40,buffunit="player",caster="player",Direction="RIGHT",
		list={22812,5215,"slot13",},
		Pointlist={
			{"CENTER",nil,"CENTER",250,150},
			{0},
			{0},
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