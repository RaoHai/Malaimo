--[[

	Malaimo
	=.=surgesoft


--]]

local addon, ns = ...
local test=false;
ns.test=test;
local class = select(2, UnitClass("player"));

local MalaimoConfig={}--=ns.MalaimoSpells[class]
local Equal = ns.Equal

local function OnUpdate(self, elapsed)
		if ( self.duration and self.duration > 0 ) then
			if(self.cd) then
			local t=self.expirationTime+self.duration-GetTime()
			if t<= 60 then
				self.time:SetFormattedText("%.1f",(t));
			else
				self.time:SetFormattedText("%d:%.1d",(t/60),(t/2));
			end
			if(t>2) then
			CooldownFrame_SetTimer(self.cooldown, self.expirationTime, self.duration, 1);
			self.icon:Show()
			self.texture:Show()
			self.Shadow:Show() 
			end
			if t<0 then self.cooldown:Hide(); 
				self.icon:Hide()
				self.time:SetText("")
				self.texture:Hide()
				self.Shadow:Hide() 
			end
			else
			t=self.expirationTime-GetTime()
			if t<= 60 then
				self.time:SetFormattedText("%.1f",(t));
			else
				self.time:SetFormattedText("%d:%.1d",(t/60),(t/2));
			end
			CooldownFrame_SetTimer(self.cooldown, self.expirationTime-self.duration, self.duration, 1);
			end
		else
		self.time:SetText("");
		self.cooldown:Hide();	
		end
		
end
function CreateButton(frame)
				local button=CreateFrame("Button",nil,frame,"SecureActionButtonTemplate")
				button:SetWidth(40)
				button:SetHeight(40)
				button:SetAllPoints(frame)
				--button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
				button:SetAttribute("type1","macro")
				--[[button.overlay = ActionButton_GetOverlayGlow();
				button.overlay:SetParent(button);
				button.overlay:ClearAllPoints();
				button.overlay:SetSize(56,56);
				button.overlay:SetPoint("TOPLEFT", button, "TOPLEFT", -40 * 0.2, 40 * 0.2);
				button.overlay:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT",40 * 0.2, -40 * 0.2);
				button.overlay.animIn:Play();--]]
				frame.button=button
end
function Update(frame)
		if(not frame.icon) then
		for i=1,#frame.list do
				local n=frame.list[i];
				local m;
				local ptAt;
				tempframe = CreateFrame("Frame",nil,UIParent)
				if(not(frame.Pointlist[i]) or unpack(frame.Pointlist[i])==0) then
					if (i>=1) then m=frame.list[i-1]; end
					if(frame.Direction=="LEFT") then ptAt="RIGHT" else ptAt="LEFT" end
					tempframe:SetPoint(frame.Direction,frame.bufflist[m],ptAt,0,0)
				else
					tempframe:SetPoint(unpack(frame.Pointlist[i]))
				end
				tempframe:SetSize(frame:GetWidth(),frame:GetWidth())
				tempframe.icon = tempframe:CreateTexture(nil, "ARTWORK");
				tempframe.name=frame.list[i]
				tempframe.seted=false
				

				
				IconDressUp(tempframe)
				if frame.filter=="cooldown" then tempframe.cd=true tempframe.icon:Hide() end
				frame.bufflist[n]=tempframe;
				tempframe:SetScript("OnUpdate", OnUpdate);
		end	
		end
	
end
local function OnEvent(self, event, ...)
local unit = ...;
if ( ( unit == "target" or unit == "player" ) or event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_ENTERING_WORLD" or event == "SPELL_UPDATE_COOLDOWN" ) then
	local data, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable, start, enabled, slotLink, slotID,spn,e;
	for i=1,#self.list do
			local id = self.list[i]
				if self.filter=="buff" then
				spn,_,ticon = GetSpellInfo(id)
				
				name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff(self.buffunit or "Player", spn or "33763");
			
			elseif self.filter=="debuff" then
				spn = GetSpellInfo(id)
				spn,_,ticon = GetSpellInfo(id)				
				name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff(self.buffunit or "target", spn or "33763");
				if (Equal[id] and not name )then
				tspn = GetSpellInfo(Equal[id])
				--tspn,_,ticon = GetSpellInfo(Equal[id])				
				name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff(self.buffunit or "target", tspn or "33763");
				if(name) then spn=tspn end;
				end
			else
				isSlot,e=string.find(id,"slot")
				isItem,f=string.find(id,"item")
				if(isSlot) then
					slotID=string.sub(id,e+1);
					slotLink = GetInventoryItemLink("player",slotID);
					if ( slotLink ) then
						name, _, _, _, _, _, _, _, _, icon = GetItemInfo(slotLink);
						ticon=icon
						spn=name
						start, duration, enabled = GetInventoryItemCooldown("player", slotID);
					end
				elseif(isItem) then
					slotID=string.sub(id,f+1);
					name, _, _, _, _, _, _, _, _, icon = GetItemInfo(slotID);
					ticon=icon
					spn=name
					start, duration, enabled =GetItemCooldown(slotID)
				else
					spn = GetSpellInfo(id)
					start, duration, enabled = GetSpellCooldown( spn );
					_,_,icon = GetSpellInfo(spn);
					ticon=icon
				end
					self.bufflist[id].icon:SetTexture(icon)
					self.bufflist[id].expirationTime = expirationTime or start ;
					self.bufflist[id].duration= duration;
					self.bufflist[id].count:SetText(count and (count > 1 and count or ""));
			end
			if(self.caster=="player") then
				if(not InCombatLockdown() ) then
				if(self.bufflist[id].seted==false and spn) then
					CreateButton(self.bufflist[id])
					
					local text="/cast [target="..self.buffunit.."] "..spn;
					
					if id==8921 then 
					self.bufflist[id].button:SetAttribute("type1","spell")
					self.bufflist[id].button:SetAttribute("spell",id)
					else
					self.bufflist[id].button:SetAttribute("macrotext",text)
					end
					self.bufflist[id].seted=true
				 end
			end
			end
			if(self.caster==caster or self.caster=="anyone" or self.filter=="cooldown") then
			self.bufflist[id].icon:SetTexture(icon)
			if( self.filter~="cooldown") then
				if(icon) then self.bufflist[id].texture:Show() self.bufflist[id].Shadow:Show() else self.bufflist[id].texture:Hide() self.bufflist[id].Shadow:Hide() end
			end
			self.bufflist[id].expirationTime = expirationTime or start ;
			self.bufflist[id].duration= duration;
			self.bufflist[id].count:SetText(count and (count > 1 and count or ""));
			--if icon then self.bufflist[id].button:Show() else self.bufflist[id].button:Hide() end
			elseif (caster==nil) then
			self.bufflist[id].icon:SetTexture()
				if(icon) then self.bufflist[id].texture:Show() self.bufflist[id].Shadow:Show() else self.bufflist[id].texture:Hide() self.bufflist[id].Shadow:Hide() end
			self.bufflist[id].expirationTime = 0 ;
			self.bufflist[id].duration= 0;
			self.bufflist[id].count:SetText();
			else
			self.bufflist[id].icon:SetTexture()
			end
			if(ns.test) then
		
			self.bufflist[id].icon:SetTexture(ticon)
			self.bufflist[id].icon:Show()
			end
			end
		
			
	end
end
--end
local f=CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED");
f:SetScript("OnEvent", function(self,event,...)
	if(event=="ADDON_LOADED" and ...=="Malaimo") then
		MalaimoConfig=th_table_dup(Malaimo_Opt[class])--=ns.MalaimoSpells[class]
		CreateMalaimo()
	end
end);
function th_table_dup(ori_tab)
    if (type(ori_tab) ~= "table") then
        return nil;
    end
    local new_tab = {};
    for i,v in pairs(ori_tab) do
        local vtyp = type(v);
        if (vtyp == "table") then
            new_tab[i] = th_table_dup(v);
        elseif (vtyp == "thread") then
            -- TODO: dup or just point to?
            new_tab[i] = v;
        elseif (vtyp == "userdata") then
            -- TODO: dup or just point to?
            new_tab[i] = v;
        else
            new_tab[i] = v;
        end
    end
    return new_tab;
end

function CreateMalaimo()
	for i in pairs(MalaimoConfig)do
		local frame = CreateFrame("Frame","MalaimoBaseFrame",UIParent)
		frame:SetSize(MalaimoConfig[i].size,MalaimoConfig[i].size)
		frame.list=MalaimoConfig[i].list
		frame.Pointlist = MalaimoConfig[i].Pointlist
		frame.caster = MalaimoConfig[i].caster
		frame.buffunit = MalaimoConfig[i].buffunit
		frame.bufflist={};
		frame.filter=MalaimoConfig[i].filter
		frame.Direction=MalaimoConfig[i].Direction
		frame:RegisterEvent("UNIT_AURA");
		frame:RegisterEvent("PLAYER_TARGET_CHANGED");
		frame:RegisterEvent("PLAYER_ENTERING_WORLD");
			Update(frame)

		frame:SetScript("OnEvent", OnEvent);
	end
end


SLASH_MALAMOSAVE1="/save"
SlashCmdList["MALAMOSAVE"]=function(msg)
if(not Malaimo_Opt) then Malaimo_Opt={} end;
Malaimo_Opt[class]=MalaimoConfig
end



