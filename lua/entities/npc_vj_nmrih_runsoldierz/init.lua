 AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/VJ_NMRIH/national_guard.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_nmrih_runsoldierz_h")
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 30 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 90 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 1 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.5 -- How much time until it can use any attack again? | Counted in Seconds
ENT.MeleeAttackDamage = GetConVarNumber("vj_nmrih_runsoldierz_d_single")
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 5 -- How much time until player's Speed resets
ENT.MeleeAttackBleedEnemy = true -- Should the enemy bleed when attacked by melee?
ENT.MeleeAttackBleedEnemyChance = 1 -- How chance there is that the play will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next rep?
ENT.MeleeAttackBleedEnemyReps = 4 -- How many reps?
ENT.FootStepTimeRun = 0.3 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.GibOnDeathDamagesTable = {"All"} -- Damages that it gibs from | "UseDefault" = Uses default damage types | "All" = Gib from any damage
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_BIG_FLINCH} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav"}
ENT.SoundTbl_Idle = {"nmr_zomb_male/idle1.wav","nmr_zomb_male/idle2.wav","nmr_zomb_male/idle3.wav","nmr_zomb_male/idle4.wav","nmr_zomb_male/idle5.wav","nmr_zomb_male/idle6.wav"}
ENT.SoundTbl_Alert = {"nmr_zomb_male/alert1.wav","nmr_zomb_male/alert2.wav","nmr_zomb_male/alert3.wav","nmr_zomb_male/alert4.wav","nmr_zomb_male/alert5.wav","nmr_zomb_male/alert6.wav"}
ENT.SoundTbl_MeleeAttack = {"nmr_zomb_male/attack1.wav","nmr_zomb_male/attack2.wav","nmr_zomb_male/attack3.wav","nmr_zomb_male/attack4.wav","nmr_zomb_male/attack5.wav","nmr_zomb_male/attack6.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav","npc/zombie/claw_miss2.wav"}
ENT.SoundTbl_Pain = {"nmr_zomb_male/pain1.wav","nmr_zomb_male/pain2.wav","nmr_zomb_male/pain3.wav","nmr_zomb_male/pain4.wav","nmr_zomb_male/pain5.wav","nmr_zomb_male/pain6.wav"}
ENT.SoundTbl_Death = {"nmr_zomb_male/die1.wav","nmr_zomb_male/die2.wav","nmr_zomb_male/die3.wav","nmr_zomb_male/die4.wav","nmr_zomb_male/die5.wav","nmr_zomb_male/die6.wav"}

-- Custom
ENT.Zombie_IsCrawling = false
ENT.Zombie_DmgToCrawl = 0
ENT.WhiteSkin = false
ENT.BlackSkin = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	if math.random(1,3) == 1 then self:SetBodygroup(1,1) end

	self:SetBodygroup(4,math.random(0,2))

	local randomstart_race = math.random(1,2)
	if randomstart_race == 1 then self.WhiteSkin = true self:SetBodygroup(3,0)
	elseif randomstart_race == 2 then self.BlackSkin = true self:SetBodygroup(3,1) end

	if self.WhiteSkin == true then
		if math.random(1,2) == 1 then self:SetSkin(0) else self:SetSkin(2) end
	end

	if self.BlackSkin == true then
		if math.random(1,2) == 1 then self:SetSkin(1) else self:SetSkin(3) end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self.Zombie_IsCrawling == true then
		self.AnimTbl_Walk = {self:GetSequenceActivity(self:LookupSequence("Crawl"))}
		self.AnimTbl_Run = {self:GetSequenceActivity(self:LookupSequence("Crawl"))}
		self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("Crawlidle"))}
	else
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}
		self.AnimTbl_IdleStand = {ACT_IDLE}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo,hitgroup)
	if hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG or dmginfo:GetDamageType() == DMG_BLAST then
		self.Zombie_DmgToCrawl = self.Zombie_DmgToCrawl + dmginfo:GetDamage()
		if self.Zombie_DmgToCrawl >= 30 then
			self.Zombie_IsCrawling = true
			self.CanFlinch = 0
			self:SetCollisionBounds(Vector(25, 25, 20), -Vector(25, 25, 0))
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	if self.Zombie_IsCrawling == true then
		self.AnimTbl_MeleeAttack = {"vjseq_crawlgrabshove"}
		self.TimeUntilMeleeAttackDamage = 0.5
		self.NextAnyAttackTime_Melee = 0.166666666667
		self.MeleeAttackExtraTimers = {}
		self.MeleeAttackDamage = GetConVarNumber("vj_nmrih_runsoldierz_d_single")
	else
		local randattack = math.random(1,3)
		if randattack == 1 then
			self.AnimTbl_MeleeAttack = {"vjseq_attacka"}
			self.TimeUntilMeleeAttackDamage = 1.05
			self.NextAnyAttackTime_Melee = 0.53
			self.MeleeAttackExtraTimers = {}
			self.MeleeAttackDamage = GetConVarNumber("vj_nmrih_runsoldierz_d_single")
		elseif randattack == 2 then
			self.AnimTbl_MeleeAttack = {"vjseq_attackb"}
			self.TimeUntilMeleeAttackDamage = 0.8
			self.NextAnyAttackTime_Melee = 0.69
			self.MeleeAttackExtraTimers = {1.2}
			self.MeleeAttackDamage = GetConVarNumber("vj_nmrih_runsoldierz_d_dualfast")
		elseif randattack == 3 then
			self.AnimTbl_MeleeAttack = {"vjseq_attackc"}
			self.TimeUntilMeleeAttackDamage = 1
			self.NextAnyAttackTime_Melee = 1.16
			self.MeleeAttackExtraTimers = {1.85}
			self.MeleeAttackDamage = GetConVarNumber("vj_nmrih_runsoldierz_d_dualslow")
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	if hitgroup == HITGROUP_HEAD && dmginfo:GetDamageForce():Length() > 700 then
		self:SetBodygroup(1,1)
		if math.random(1,2) == 1 then self:SetBodygroup(3,2) else self:SetBodygroup(3,3) end
		
		if self.HasGibDeathParticles == true then
			for i=1,3 do
				ParticleEffect("blood_impact_red_01",self:GetAttachment(self:LookupAttachment("headshot_squirt")).Pos,self:GetAngles())
			end
		end
		
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("headshot_squirt")).Pos+self:GetUp()*5})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:GetAttachment(self:LookupAttachment("headshot_squirt")).Pos+self:GetUp()*5+self:GetRight()*5})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_03.mdl",{Pos=self:GetAttachment(self:LookupAttachment("headshot_squirt")).Pos+self:GetUp()*5+self:GetRight()*-5})
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