function IconDressUp(button)
	if (button) then
				button.icon:SetPoint("TOPLEFT", 2, -2)
				button.icon:SetPoint("BOTTOMRIGHT", -2, 2)
				button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92);
				button.count = button:CreateFontString(nil, "OVERLAY");
				button.count:SetFont(GameTooltipTextLeft1:GetFont(), 12, "OUTLINE");
				button.count:SetPoint("BOTTOMRIGHT", 1, -1);
				button.count:SetJustifyH("RIGHT");
				button.cooldown = CreateFrame("Cooldown", nil, button, "CooldownFrameTemplate");
				button.cooldown:SetAllPoints(button.icon);
				button.cooldown:SetReverse();
				button.cooldown.noCooldownCount = true	
				button.time = button:CreateFontString(nil, "ARTWORK");
				button.time:SetFont(GameTooltipTextLeft1:GetFont(), 12, "OUTLINE");
				button.time:SetPoint("CENTER", button.icon, 0, 0);
			if (not button.texture) then
				button.texture = button:CreateTexture('$parentOverlay', 'ARTWORK')
				button.texture:SetParent(button)
				button.texture:SetTexture("Interface\\Addons\\Malaimo\\media\\iconborder")
				button.texture:SetPoint('TOPRIGHT', button, 1, 1)
				button.texture:SetPoint('BOTTOMLEFT', button, -1, -1)
				button.texture:SetVertexColor(0,0,0,1)
				button.texture:Hide()
			end
			if (not button.Shadow) then
				button.Shadow = button:CreateTexture('$parentShadow', 'BACKGROUND')
				button.Shadow:SetTexture('Interface\\AddOns\\Malaimo\\media\\textureShadow')
				button.Shadow:SetPoint('TOPRIGHT', button.texture or border, 3.35, 3.35)
				button.Shadow:SetPoint('BOTTOMLEFT', button.texture or border, -3.35, -3.35)
				button.Shadow:SetVertexColor(0, 0, 0, 1)
				button.Shadow:Hide()
		end
	end
end