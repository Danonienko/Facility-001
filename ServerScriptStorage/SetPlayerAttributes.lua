local DataStore = require(game.ServerScriptService.DataStoreModule)

function SetPlayerAttributes(player)
	local playerAttributes = DataStore.GetData(player)
	
	for key, value in pairs(playerAttributes) do
		player:SetAttribute(key, value)
	end
end

game.Players.PlayerAdded:Connect(SetPlayerAttributes)
