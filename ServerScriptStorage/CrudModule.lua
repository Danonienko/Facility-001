local module = {}

function module.ProtectedGetAsync(variable, key)
	local data

	local success, result = pcall(function() data = variable:GetAsync(key) end)
	if success then
		if data then
			print("Data Loaded")
			return data
		else
			print("No data found")
			return nil
		end
	else
		print("Error occured. Data could not be loaded")
		for count = 0, 4, 1 do
			local success, result = pcall(function() data = variable:GetAsync(key) end)
			if success then
				return data
			else
				print("Retrying...")
				continue
			end
		end
		print("Failed to load data. Function has exceeded the amount of retries")
		warn(result)
	end
end

function module.ProtectedSetAsync(variable, key, data)
	local success, result = pcall(function() variable:SetAsync(key, data) end)
	if success then
		print("Data Saved")
	else
		for count = 0, 4, 1 do
			print("Error occured. Could not set the data")
			local success, result = pcall(function() variable:SetAsync(key, data) end)
			if success then 
				print("Data Saved")
			else 
				print("Retrying...") 
				continue 
			end
		end
		print("Failed to set data. Function has exceeded the amount of retries")
		warn(result)
	end
end

function module.ProtectedRemoveAsync(variable, key)
	local success, result = pcall(function() variable:RemoveAsync(key) end)
	if success then
		print("Data Deleted")
	else
		print("Error occured. Data could not be deleted")
		for count = 0, 4, 1 do
			local success, result = pcall(function() variable:RemoveAsync(key) end)
			if success then
				print("Data Deleted")
			else
				print("Retrying...")
				continue
			end
		end
		print("Failed to delete data. Function has exceeded the amount of retries")
	end

end

return module
