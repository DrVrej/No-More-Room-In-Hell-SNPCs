include("vj_base/extension/nmrih_zombie.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.StartHealth = 60

ENT.MeleeAttackDistance = 25 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 60 -- How far does the damage go?

ENT.Zombie_Type = 2
ENT.Zombie_Gender = 2
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize()
	if math.random(1, 2) == 1 then
		self.Model = "models/VJ_NMRIH/zombiekid_boy.mdl"
		self.Zombie_GibNumber = VJ.SET(0, math.random(1, 2))
	else
		self.Model = "models/VJ_NMRIH/zombiekid_girl.mdl"
		self.Zombie_GibNumber = VJ.SET(0, math.random(1, 4))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:NMRIH_Init()
	self:SetCollisionBounds(Vector(11, 11, 56), -Vector(11, 11, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if act == ACT_WALK or act == ACT_RUN then
		return ACT_WALK -- Child zombies only have ACT_WALK
	end
	return self.BaseClass.TranslateActivity(self, act)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
	return -- Child zombies can NOT crawl
end