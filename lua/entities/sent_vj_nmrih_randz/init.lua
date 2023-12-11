AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.SingleSpawner = true -- If set to true, it will spawn the entities once then remove itself
ENT.Model = {"models/props_junk/popcan01a.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.EntitiesToSpawn = {
	{EntityName = "NPC1",SpawnPosition = {vForward=0,vRight=0,vUp=0},Entities = {"npc_vj_nmrih_walkmalez","npc_vj_nmrih_walkmalez","npc_vj_nmrih_walkmalez","npc_vj_nmrih_walkmalez","npc_vj_nmrih_walkmalez","npc_vj_nmrih_walkmalez","npc_vj_nmrih_walkfemalez","npc_vj_nmrih_walkfemalez","npc_vj_nmrih_walkfemalez","npc_vj_nmrih_walkfemalez","npc_vj_nmrih_walkfemalez","npc_vj_nmrih_runmalez","npc_vj_nmrih_runfemalez","npc_vj_nmrih_childz","npc_vj_nmrih_runsoldierz","npc_vj_nmrih_walksoldierz"}},
}
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/