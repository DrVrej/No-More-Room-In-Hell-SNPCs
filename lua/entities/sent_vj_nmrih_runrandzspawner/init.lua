AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/props_junk/popcan01a.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.EntitiesToSpawn = {
	{EntityName = "NPC1",SpawnPosition = {vForward=50,vRight=0,vUp=0},Entities = {"npc_vj_nmrih_runmalez","npc_vj_nmrih_runmalez","npc_vj_nmrih_runmalez","npc_vj_nmrih_runfemalez","npc_vj_nmrih_runfemalez","npc_vj_nmrih_runsoldierz","npc_vj_nmrih_childz"}},
	{EntityName = "NPC2",SpawnPosition = {vForward=0,vRight=50,vUp=0},Entities = {"npc_vj_nmrih_runmalez","npc_vj_nmrih_runmalez","npc_vj_nmrih_runmalez","npc_vj_nmrih_runfemalez","npc_vj_nmrih_runfemalez","npc_vj_nmrih_runsoldierz","npc_vj_nmrih_childz"}},
	{EntityName = "NPC3",SpawnPosition = {vForward=100,vRight=50,vUp=0},Entities = {"npc_vj_nmrih_runmalez","npc_vj_nmrih_runmalez","npc_vj_nmrih_runmalez","npc_vj_nmrih_runfemalez","npc_vj_nmrih_runfemalez","npc_vj_nmrih_runsoldierz","npc_vj_nmrih_childz"}},
	{EntityName = "NPC4",SpawnPosition = {vForward=100,vRight=-50,vUp=0},Entities = {"npc_vj_nmrih_runmalez","npc_vj_nmrih_runmalez","npc_vj_nmrih_runmalez","npc_vj_nmrih_runfemalez","npc_vj_nmrih_runfemalez","npc_vj_nmrih_runsoldierz","npc_vj_nmrih_childz"}},
	{EntityName = "NPC5",SpawnPosition = {vForward=0,vRight=-50,vUp=0},Entities = {"npc_vj_nmrih_runmalez","npc_vj_nmrih_runmalez","npc_vj_nmrih_runmalez","npc_vj_nmrih_runfemalez","npc_vj_nmrih_runfemalez","npc_vj_nmrih_runsoldierz","npc_vj_nmrih_childz"}},
}
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/