/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "No More Room In Hell SNPCs"
local AddonName = "No More Room In Hell"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_nmrih_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	local vCat = "No More Room In Hell"

	-- Running
	VJ.AddNPC("Running Male Zombie","npc_vj_nmrih_runmalez",vCat)
	VJ.AddNPC("Running Female Zombie","npc_vj_nmrih_runfemalez",vCat)
	VJ.AddNPC("Running National Guard","npc_vj_nmrih_runsoldierz",vCat)
	VJ.AddNPC("Random Running Zombie","sent_vj_nmrih_runrandz",vCat)
	VJ.AddNPC("Random Running Zombie Spawner","sent_vj_nmrih_runrandzspawner",vCat)

	-- Walking
	VJ.AddNPC("Walking Male Zombie","npc_vj_nmrih_walkmalez",vCat)
	VJ.AddNPC("Walking Female Zombie","npc_vj_nmrih_walkfemalez",vCat)
	VJ.AddNPC("Walking National Guard","npc_vj_nmrih_walksoldierz",vCat)
	VJ.AddNPC("Random Walking Zombie","sent_vj_nmrih_walkrandz",vCat)
	VJ.AddNPC("Random Walking Zombie Spawner","sent_vj_nmrih_walkrandzspawner",vCat)

	-- Misc
	VJ.AddNPC("Child Zombie","npc_vj_nmrih_childz",vCat)
	VJ.AddNPC("Random Zombie","sent_vj_nmrih_randz",vCat)
	VJ.AddNPC("Random Zombie Spawner","sent_vj_nmrih_randzspawner",vCat)

	-- Precache Models --
	util.PrecacheModel("models/nmr_zombie/berny.mdl")
	util.PrecacheModel("models/nmr_zombie/casual_02.mdl")
	util.PrecacheModel("models/nmr_zombie/herby.mdl")
	util.PrecacheModel("models/nmr_zombie/jessica.mdl")
	util.PrecacheModel("models/nmr_zombie/jogger.mdl")
	util.PrecacheModel("models/nmr_zombie/julie.mdl")
	util.PrecacheModel("models/nmr_zombie/lisa.mdl")
	util.PrecacheModel("models/nmr_zombie/maxx.mdl")
	util.PrecacheModel("models/nmr_zombie/nmr_shared.mdl")
	util.PrecacheModel("models/nmr_zombie/nmr_shared_female.mdl")
	util.PrecacheModel("models/nmr_zombie/officezom.mdl")
	util.PrecacheModel("models/nmr_zombie/runner.mdl")
	util.PrecacheModel("models/nmr_zombie/tammy.mdl")
	util.PrecacheModel("models/nmr_zombie/toby.mdl")
	util.PrecacheModel("models/nmr_zombie/zombiekid_boy.mdl")
	util.PrecacheModel("models/nmr_zombie/zombiekid_girl.mdl")

	-- ConVars --
	
	-- Running
	VJ.AddConVar("vj_nmrih_runmalez_h",150)
	VJ.AddConVar("vj_nmrih_runmalez_d_single",20)
	VJ.AddConVar("vj_nmrih_runmalez_d_dualfast",14)
	VJ.AddConVar("vj_nmrih_runmalez_d_dualslow",18)

	VJ.AddConVar("vj_nmrih_runfemalez_h",150)
	VJ.AddConVar("vj_nmrih_runfemalez_d_single",20)
	VJ.AddConVar("vj_nmrih_runfemalez_d_dualfast",14)
	VJ.AddConVar("vj_nmrih_runfemalez_d_dualslow",18)

	VJ.AddConVar("vj_nmrih_runsoldierz_h",300)
	VJ.AddConVar("vj_nmrih_runsoldierz_d_single",35)
	VJ.AddConVar("vj_nmrih_runsoldierz_d_dualfast",20)
	VJ.AddConVar("vj_nmrih_runsoldierz_d_dualslow",24)

	-- Walking
	VJ.AddConVar("vj_nmrih_walkmalez_h",150)
	VJ.AddConVar("vj_nmrih_walkmalez_d_single",20)
	VJ.AddConVar("vj_nmrih_walkmalez_d_dualfast",14)
	VJ.AddConVar("vj_nmrih_walkmalez_d_dualslow",18)

	VJ.AddConVar("vj_nmrih_walkfemalez_h",150)
	VJ.AddConVar("vj_nmrih_walkfemalez_d_single",20)
	VJ.AddConVar("vj_nmrih_walkfemalez_d_dualfast",14)
	VJ.AddConVar("vj_nmrih_walkfemalez_d_dualslow",18)

	VJ.AddConVar("vj_nmrih_walksoldierz_h",300)
	VJ.AddConVar("vj_nmrih_walksoldierz_d_single",35)
	VJ.AddConVar("vj_nmrih_walksoldierz_d_dualfast",20)
	VJ.AddConVar("vj_nmrih_walksoldierz_d_dualslow",24)

	-- Child
	VJ.AddConVar("vj_nmrih_childz_h",100)
	VJ.AddConVar("vj_nmrih_childz_d",20)

-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end