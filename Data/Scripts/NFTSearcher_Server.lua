local COMPONENT_ROOT = script:GetCustomProperty("ComponentRoot"):WaitForObject()

Events.Connect(COMPONENT_ROOT.id .. ".NewToken", function(contractAddress, tokenId)
	script:SetCustomProperty("CurrentNFT", contractAddress .. "/" .. tokenId)
end)

Events.ConnectForPlayer(COMPONENT_ROOT.id .. ".LockCrouch", function(player)
	player.isCrouchEnabled = false
end)

Events.ConnectForPlayer(COMPONENT_ROOT.id .. ".UnlockCrouch", function(player)
	player.isCrouchEnabled = true
end)