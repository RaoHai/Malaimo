local addon, ns = ...
local class = select(2, UnitClass("player"));
local MalaimoConfig=ns.MalaimoSpells[class]
local Equal = ns.Equal
AuraHooked=0
CDHooked=0
local optionframe


local items = {
 
}


local function OnClick(self)
   UIDropDownMenu_SetSelectedID(DropDownMenuADD, self:GetID())
    optionsframe.des4:SetText("")
   StartHook()
   
end

local function initialize(self, level)
   local info = UIDropDownMenu_CreateInfo()
   for k,v in pairs(items) do
      info = UIDropDownMenu_CreateInfo()
      info.text = v
      info.value = v
      info.func = OnClick
      UIDropDownMenu_AddButton(info, level)
   end
end


SLASH_MALAMOGUI1="/mlm"
SlashCmdList["MALAMOGUI"]=function(msg)
if(msg=="add") then
	if not DropDownMenuADD then
		optionsframe = CreateFrame("frame","DCP_OptionsFrame",UIParent)
		optionsframe:SetBackdrop({
		  bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", 
		  edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", 
		  tile=1, tileSize=32, edgeSize=32, 
		  insets={left=11, right=12, top=12, bottom=11}
		})
		optionsframe:SetWidth(400)
		optionsframe:SetHeight(300)
		optionsframe:SetPoint("CENTER",UIParent)
		optionsframe:Show()
		 local header = optionsframe:CreateTexture(nil,"ARTWORK")
		header:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header.blp")
		header:SetWidth(350)
		header:SetHeight(68)
		header:SetPoint("TOP",optionsframe,"TOP",0,12)
		local buttonOK = CreateFrame("Button", "optionsframeButton", optionsframe, "UIPanelButtonTemplate")
			buttonOK:SetWidth(75)
			buttonOK:SetHeight(30)
			buttonOK:SetPoint("BOTTOM",0,15)
			buttonOK:SetText("OK")
			buttonOK:SetScript("OnClick", function(self)
				optionsframe:Hide();
				EndHook();
			end)
				
		local buttonADD = CreateFrame("Button", "optionsframeButton", optionsframe, "UIPanelButtonTemplate")
			buttonADD:SetWidth(150)
			buttonADD:SetHeight(30)
			buttonADD:SetPoint("BOTTOM",-105,55)
			buttonADD:SetText("Add To Default Point")
			buttonADD:SetScript("OnClick", function(self)
			if(optionsframe.name~="") then
				local c=UIDropDownMenu_GetText(DropDownMenuADD)
				local found=false
				for i ,j in ipairs(Malaimo_Opt[class][c].list) do
					if(j==optionsframe.name) then
						found=true
					end
				end
				if(found==true ) then
				optionsframe.des4:SetText("Cannot Add This Aura:|cffff0000Already Have This Aura:")
				else
				
				table.insert(Malaimo_Opt[class][c].list,optionsframe.name)
				table.insert(Malaimo_Opt[class][c].Pointlist,{0})
				optionsframe.des4:SetText("Successed!:")
				end
				end
		end)
		
		local buttonATA = CreateFrame("Button", "optionsframeButton", optionsframe, "UIPanelButtonTemplate")
			buttonATA:SetWidth(180)
			buttonATA:SetHeight(30)
			buttonATA:SetPoint("BOTTOM",85,55)
			buttonATA:SetText("Add To Customize Point...")
			buttonATA:SetScript("OnClick", function(self)
			if(optionsframe.name~="") then
				local c=UIDropDownMenu_GetText(DropDownMenuADD)
				local found=false
				for i ,j in ipairs(Malaimo_Opt[class][c].list) do
					if(j==optionsframe.name) then
						found=true
					end
				end
				if(found==true ) then
				optionsframe.des4:SetText("Cannot Add This Aura:|cffff0000Already Have This Aura:")
				else
				if(buttonATA:GetText()=="HERE!") then
					buttonATA:SetText("Add To Customize Point...")
					local point, relativeTo, relativePoint, xOfs, yOfs =optionsframe.iconframe:GetPoint()
					local pt={point, relativeTo, relativePoint, xOfs, yOfs}
					print(pt)
					table.insert(Malaimo_Opt[class][c].list,optionsframe.name)
					table.insert(Malaimo_Opt[class][c].Pointlist,pt)
				else
					optionsframe.des4:SetText("Drag This Icon To Customize Point Then Press [HERE!]button:")
					buttonATA:SetText("HERE!")
					optionsframe.iconframe:RegisterForDrag("LeftButton")
					optionsframe.iconframe:SetScript("OnDragStart", function(self) self:StartMoving() end)
					optionsframe.iconframe:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
				end
				end
				end
			end)
		local buttonDel = CreateFrame("Button", "optionsframeButton", optionsframe, "UIPanelButtonTemplate")
			buttonDel:SetWidth(75)
			buttonDel:SetHeight(30)
			buttonDel:SetPoint("BOTTOM",0,85)
			buttonDel:SetText("Remove")
			buttonDel:SetScript("OnClick", function(self)
			local c=UIDropDownMenu_GetText(DropDownMenuADD)
			local found=0
				for i ,j in ipairs(Malaimo_Opt[class][c].list) do
					if(j==optionsframe.name) then
						found=i
					end
					if(found>0) then
						table.remove(Malaimo_Opt[class][c].list,i)
						table.remove(Malaimo_Opt[class][c].Pointlist,i)
						optionsframe.des4:SetText("Remove Successed!:"..optionsframe.name)
						else
					
						optionsframe.des4:SetText("Cannot Remove This Aura:|cffff0000Not Found:")
					end
				end
			end)
		local headertext = optionsframe:CreateFontString(nil,"ARTWORK","GameFontNormal")
		headertext:SetPoint("TOP",header,"TOP",0,-14)
		headertext:SetText("Malaimo~~ADD")
		for i in pairs(MalaimoConfig)do
			table.insert(items,i)
		end
	
	   CreateFrame("Button", "DropDownMenuADD", optionsframe, "UIDropDownMenuTemplate")
	   DropDownMenuADD:ClearAllPoints()
		DropDownMenuADD:SetPoint("TOP",optionsframe,"TOP", 0, -40)
		DropDownMenuADD:Show()
			local des1 = optionsframe:CreateFontString(nil,"ARTWORK","GameFontNormal")
		 des1:SetPoint("BOTTOM",DropDownMenuADD,"TOP",0,0)
		 des1:SetText("Add A New Aura Into Group:")
		
		local des2= optionsframe:CreateFontString(nil,"ARTWORK","GameFontNormal")
		 des2:SetPoint("TOP",DropDownMenuADD,"BOTTOM",0,0)
		
		local des3= optionsframe:CreateFontString(nil,"ARTWORK","GameFontNormal")
		 des3:SetPoint("TOP",des2,"BOTTOM",0,0)
		 des3:SetText("Move Your Cursor To\n An Aura Icon On Your Screen")
		local iconframe=CreateFrame("frame")
		iconframe:SetSize(40,40)
		iconframe:SetPoint("TOP",des3,"BOTTOM",0,0)
		iconframe:EnableMouse(true)
		iconframe:SetMovable(true)
		 local icon =optionsframe:CreateTexture(nil, "ARTWORK");
		 icon:SetTexCoord(0.08, 0.92, 0.08, 0.92);
		 icon:SetSize(40,40)
		  icon:SetAllPoints(iconframe)
	
		   local des4= optionsframe:CreateFontString(nil,"ARTWORK","GameFontNormal")
		 des4:SetPoint("TOP",icon,"BOTTOM",0,0)
		   optionsframe.icon =icon
		   optionsframe.iconframe =iconframe
		   optionsframe.des1=des1;
		  optionsframe.des2=des2
		 optionsframe.des3= des3
		 optionsframe.des4=des4
		 optionsframe.name=""
		UIDropDownMenu_Initialize(DropDownMenuADD, initialize)
		UIDropDownMenu_SetWidth(DropDownMenuADD, 100);
		UIDropDownMenu_SetButtonWidth(DropDownMenuADD, 124)
		UIDropDownMenu_SetSelectedID(DropDownMenuADD, 1)
		UIDropDownMenu_JustifyText(DropDownMenuADD, "LEFT")
		 StartHook();
	else
		if(optionsframe:IsShown()) then optionsframe:Hide(); EndHook();else optionsframe:Show(); StartHook(); end
	end
	else
	ns.test=not ns.test
end
end
function Buff_handler(self, unitId, auraIndex, filter)
	if AuraHooked==1 then 
	 local c=UIDropDownMenu_GetText(DropDownMenuADD)
	 local tfilter;
	 if(filter=="HELPFUL") then tfilter="buff" else tfilter="debuff" end
	 if(MalaimoConfig[c].filter==tfilter) then
	   local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitAura(unitId, auraIndex, filter)
		  optionsframe.icon:SetTexture(icon)
		  if(caster~=MalaimoConfig[c].caster and MalaimoConfig[c].caster~="anyone") then
				optionsframe.des4:SetText("Cannot Add This Aura:|cffff0000Incorrect Caster")
				optionsframe.name=""
			  elseif (unitId~=MalaimoConfig[c].buffunit) then
				optionsframe.des4:SetText("Cannot Add This Aura:|cffff0000Incorrect Unit")
				optionsframe.name=""
			   else
			   optionsframe.name=name
			   optionsframe.des4:SetText("")
		  end
		  else
			optionsframe.des4:SetText("Cannot Add This Aura:|cffff0000Incorrect Type")
	end
	end
end
function CD_handler(table,index,spelltype)
	if CDHooked==1 then
		link, tradeLink = GetSpellLink(index,spelltype)
		Name, Subtext = GetSpellBookItemName(index,spelltype)
		if link then
		local spellID = string.match(link,"spell:(%d+)")
			local spn,_,icon = GetSpellInfo(spellID)
			optionsframe.name=spn
			 optionsframe.icon:SetTexture(icon)
		end
	end
end
function StartHook()
	
	local c=UIDropDownMenu_GetText(DropDownMenuADD)
	if(MalaimoConfig[c].filter=="buff" or MalaimoConfig[c].filter=="debuff") then
		AuraHooked=1
		optionsframe.des2:SetText("Filter:"..MalaimoConfig[c].filter..",Caster:"..MalaimoConfig[c].caster..",Unit:"..MalaimoConfig[c].buffunit)
		hooksecurefunc(GameTooltip, "SetUnitAura", Buff_handler)
	elseif (MalaimoConfig[c].filter=="cooldown") then
		CDHooked=1
		optionsframe.des2:SetText("Filter:"..MalaimoConfig[c].filter..",Caster:"..MalaimoConfig[c].caster..",Unit:"..MalaimoConfig[c].buffunit)
		hooksecurefunc(GameTooltip, "SetSpellBookItem", CD_handler)
	end
end
function EndHook()
	AuraHooked=0
	CDHooked=0
end



