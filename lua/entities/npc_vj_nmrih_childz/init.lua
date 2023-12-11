AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/VJ_NMRIH/zombiekid_boy.mdl","models/VJ_NMRIH/zombiekid_girl.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_nmrih_childz_h")
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 30 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 70 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.4 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.6 -- How much time until it can use any attack again? | Counted in Seconds
ENT.MeleeAttackDamage = GetConVarNumber("vj_nmrih_childz_d")
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 5 -- How much time until player's Speed resets
ENT.MeleeAttackBleedEnemy = true -- Should the player bleed when attacked by melee
ENT.MeleeAttackBleedEnemyChance = 1 -- How chance there is that the play will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next rep?
ENT.MeleeAttackBleedEnemyReps = 4 -- How many reps?
ENT.FootStepTimeRun = 0.3 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.3 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.GibOnDeathDamagesTable = {"All"} -- Damages that it gibs from | "UseDefault" = Uses default damage types | "All" = Gib from any damage
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav"}
ENT.SoundTbl_Idle = {"nmr_zomb_kid/idle1.wav","nmr_zomb_kid/idle2.wav","nmr_zomb_kid/idle3.wav","nmr_zomb_kid/idle4.wav","nmr_zomb_kid/idle5.wav","nmr_zomb_kid/idle6.wav"}
ENT.SoundTbl_Alert = {"nmr_zomb_kid/alert1.wav","nmr_zomb_kid/alert2.wav","nmr_zomb_kid/alert3.wav","nmr_zomb_kid/alert4.wav","nmr_zomb_kid/alert5.wav","nmr_zomb_kid/alert6.wav"}
ENT.SoundTbl_MeleeAttack = {"nmr_zomb_kid/attack1.wav","nmr_zomb_kid/attack2.wav","nmr_zomb_kid/attack3.wav","nmr_zomb_kid/attack4.wav","nmr_zomb_kid/attack5.wav","nmr_zomb_kid/attack6.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav","npc/zombie/claw_miss2.wav"}
ENT.SoundTbl_Pain = {"nmr_zomb_kid/pain1.wav","nmr_zomb_kid/pain2.wav","nmr_zomb_kid/pain3.wav","nmr_zomb_kid/pain4.wav","nmr_zomb_kid/pain5.wav","nmr_zomb_kid/pain6.wav"}
ENT.SoundTbl_Death = {"nmr_zomb_kid/die1.wav","nmr_zomb_kid/die2.wav","nmr_zomb_kid/die3.wav","nmr_zomb_kid/die4.wav","nmr_zomb_kid/die5.wav","nmr_zomb_kid/die6.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(11, 11, 56), -Vector(11, 11, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	if hitgroup == HITGROUP_HEAD && dmginfo:GetDamageForce():Length() > 700 then
		self:SetBodygroup(0,1)
		if self.HasGibDeathParticles == true then
			for i=1,3 do
				ParticleEffect("blood_impact_red_01",self:GetAttachment(self:LookupAttachment("headshot_squirt")).Pos,self:GetAngles())
			end
		end
		
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("headshot_squirt")).Pos})
		return true,{AllowCorpse=true}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	if hitgroup == HITGROUP_HEAD && dmginfo:GetDamageForce():Length() > 700 && self.HasGibDeathParticles == true then
		local bloodeffect = ents.Create("info_particle_system")
		bloodeffect:SetKeyValue("effect_name","blood_advisor_puncture_withdraw")
		bloodeffect:SetPos(GetCorpse:GetAttachment(GetCorpse:LookupAttachment("headshot_squirt")).Pos)
		bloodeffect:SetAngles(GetCorpse:GetAttachment(GetCorpse:LookupAttachment("headshot_squirt")).Ang)
		bloodeffect:SetParent(GetCorpse)
		bloodeffect:Fire("SetParentAttachment","headshot_squirt")
		bloodeffect:Spawn()
		bloodeffect:Activate()
		bloodeffect:Fire("Start","",0)
		bloodeffect:Fire("Kill","",3.5)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_SlowPlayer(TheHitEntity)
	//PrintMessage( HUD_PRINTTALK, "You have been infected for "..self.SlowPlayerOnMeleeAttackTime.." Seconds!" )
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/