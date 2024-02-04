-- Written by @Danonienko

local module = {}

local crud = require(script.CrudModule)

local dataStoreService = game:GetService("DataStoreService")
local playerAttributes = dataStoreService:GetDataStore("PlayerAttributes")	

function SetDefaultData(player)
	local key = "PlayerData_"..player.UserId
	local data = {
		Clearance = 0,
		HasO5 = false,
		CD_Rank = 1,
		ScD_Rank = 1,
		MD_Rank = 1,
		SD_Rank = 1,
		MTF_E11_Rank = 0,
		MTF_Nu7_Rank = 0,
		MTF_A1_Rank = 0,
		IA_Rank = 0,
		ISD_Rank = 0,
		SiD_Rank = 0
	}
	
	crud.ProtectedSetAsync(playerAttributes, key, data)
	print("Default data set")
end

function module.GetData(player)
	local key = "PlayerData_"..player.UserId
	local data = crud.ProtectedGetAsync(playerAttributes, key)
	
	if data == nil then
		print("Setting to default data")
		SetDefaultData(player)
		return crud.ProtectedGetAsync(playerAttributes, key)
	else
		return data
	end
end

function module.UpdateData(player)
	local key = "PlayerData_"..player.UserId
	local newPlayerAttributes = player:GetAttributes()
	local data = {}
	
	for key, value in pairs(newPlayerAttributes) do
		data[key] = value
	end	
	
	crud.ProtectedSetAsync(playerAttributes, key, data)
end

function module.DeleteData(player)
	local key = "PlayerData_"..player.UserId
	
	crud.ProtectedRemoveAsync(playerAttributes, key)
end

return module
