﻿

if not ControlFreak then return end


----------------------
--      Locals      --
----------------------

local tekcheck = LibStub("tekKonfig-Checkbox")
local tekslider = LibStub("tekKonfig-Slider")
local GAP = 8


---------------------
--      Panel      --
---------------------

local frame = CreateFrame("Frame", nil, UIParent)
frame.name = "Control Freak"
frame:Hide()
frame:SetScript("OnShow", function(frame)
	local ControlFreak = ControlFreak
	local title, subtitle = LibStub("tekKonfig-Heading").new(frame, "Control Freak", "These settings change the 'always up' frame.  They are saved on a per-char basis.")


	local lockpos = tekcheck.new(frame, nil, "Lock frame", "TOPLEFT", subtitle, "BOTTOMLEFT", -2, -GAP)
	lockpos.tiptext = "Locks the frame to prevent accidental movement"
	local checksound = lockpos:GetScript("OnClick")
	lockpos:SetScript("OnClick", function(self) checksound(self); ControlFreak.db.char.frameopts.locked = not ControlFreak.db.char.frameopts.locked end)
	lockpos:SetChecked(ControlFreak.db.char.frameopts.locked)


	local showtip = tekcheck.new(frame, nil, "Show tooltip", "TOPLEFT", lockpos, "BOTTOMLEFT", 0, -GAP)
	showtip.tiptext = "Show help tooltip on hover"
	showtip:SetScript("OnClick", function(self) checksound(self); ControlFreak.db.char.showtooltip = not ControlFreak.db.char.showtooltip end)
	showtip:SetChecked(ControlFreak.db.char.showtooltip)


	local threshslider, threshslidertext, threshcontainer = tekslider.new(frame, "Break Threshold: "..ControlFreak.db.char.breakthreshold.." sec", 0, 10, "LEFT", frame, "TOP", GAP, 0)
	threshcontainer:SetPoint("TOP", lockpos, "TOP", 0, 0)
	threshslider.tiptext = "Time (in seconds) before spell breaks to unfade frame."
	threshslider:SetValue(ControlFreak.db.char.breakthreshold)
	threshslider:SetValueStep(1)
	threshslider:SetScript("OnValueChanged", function()
		ControlFreak.db.char.breakthreshold = threshslider:GetValue()
		threshslidertext:SetText("Break Threshold: "..ControlFreak.db.char.breakthreshold.." sec")
	end)


	local alpha = math.floor(ControlFreak.db.char.alpha*100 + .5)
	local alphaslider, alphaslidertext = tekslider.new(frame, "Alpha: "..alpha.."%", "0%", "100%", "TOP", threshcontainer, "BOTTOM", 0, -GAP)
--~ 	alphaslider:SetPoint("LEFT", threshslider, "LEFT")
	alphaslider.tiptext = "Alpha level to fade frame to when focus is controlled, dead, or not set."
	alphaslider:SetValue(ControlFreak.db.char.alpha)
	alphaslider:SetValueStep(0.05)
	alphaslider:SetScript("OnValueChanged", function()
		ControlFreak.db.char.alpha = alphaslider:GetValue()
		local alpha = math.floor(ControlFreak.db.char.alpha*100 + .5)
		alphaslidertext:SetText("Alpha: "..alpha.."%")
		ControlFreak:OnUpdate(true)
	end)


	frame:SetScript("OnShow", LibStub("tekKonfig-FadeIn").FadeIn)
	LibStub("tekKonfig-FadeIn").FadeIn(frame)
end)

InterfaceOptions_AddCategory(frame)
