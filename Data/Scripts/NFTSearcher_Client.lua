local COMPONENT_ROOT = script:GetCustomProperty("ComponentRoot"):WaitForObject()
local SERVER_SCRIPT = script:GetCustomProperty("ServerScript"):WaitForObject()
local PICTURE = script:GetCustomProperty("Picture"):WaitForObject()
local INFO_BG = script:GetCustomProperty("InfoBG"):WaitForObject()
local INFO = script:GetCustomProperty("Info"):WaitForObject()
local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()
local SCREEN_UICONTAINER = script:GetCustomProperty("ScreenUIContainer"):WaitForObject()
local CONTRACT_ADDRESS_ENTRY = script:GetCustomProperty("ContractAddressEntry"):WaitForObject()
local TOKEN_ID_ENTRY = script:GetCustomProperty("TokenIdEntry"):WaitForObject()
local SEARCH_BUTTON = script:GetCustomProperty("SearchButton"):WaitForObject()
local CLOSE_BUTTON = script:GetCustomProperty("CloseButton"):WaitForObject()

local DEFAULT_CONTRACT_ADDRESS = COMPONENT_ROOT:GetCustomProperty("ContractAddress")
local DEFAULT_TOKEN_ID = COMPONENT_ROOT:GetCustomProperty("TokenId")
local DISPLAY_NAME = COMPONENT_ROOT:GetCustomProperty("DisplayName")

local contractAddress = ""
local tokenId = ""

local LOCAL_PLAYER = Game.GetLocalPlayer()

INFO_BG.visibility = DISPLAY_NAME and Visibility.FORCE_ON or Visibility.FORCE_OFF

local function UpdateNewToken(newContract, newId)
	Task.Spawn(function()
		local token, status, msg = Blockchain.GetToken(newContract, newId)
		if status == BlockchainTokenResultCode.SUCCESS then
			contractAddress = newContract
			tokenId = newId
			PICTURE:SetBlockchainToken(token)
			INFO.text = token.name
		else
			warn(msg)
		end
	end)
end

local function IsValidNewToken(newContract, newId)
	if newContract == nil or newId == nil then
		return false
	end
	return newContract ~= "" and newId ~= "" and (newContract ~= contractAddress or newId ~= tokenId)
end

local function CheckForTokenUpdate()
	local CURRENT_NFT = SERVER_SCRIPT:GetCustomProperty("CurrentNFT")
	local CONTRACT_ADDRESS, TOKEN_ID = CoreString.Split(CURRENT_NFT, {
        delimiters = {"/"}, 
        removeEmptyResults = true
    })
	if IsValidNewToken(CONTRACT_ADDRESS, TOKEN_ID) then
		UpdateNewToken(CONTRACT_ADDRESS, TOKEN_ID)
	elseif IsValidNewToken(DEFAULT_CONTRACT_ADDRESS, DEFAULT_TOKEN_ID) then
		UpdateNewToken(DEFAULT_CONTRACT_ADDRESS, DEFAULT_TOKEN_ID)
	end
end


local function OpenScreenUI()
	Events.BroadcastToServer(COMPONENT_ROOT.id .. ".LockCrouch")
	SCREEN_UICONTAINER.visibility = Visibility.FORCE_ON
	UI.SetCursorVisible(true)
	UI.SetCanCursorInteractWithUI(true)
	if contractAddress ~= "" then
		CONTRACT_ADDRESS_ENTRY.text = contractAddress
	end
	if tokenId ~= "" then
		TOKEN_ID_ENTRY.text = tokenId
	end
end

local function CloseScreenUI()
	Events.BroadcastToServer(COMPONENT_ROOT.id .. ".UnlockCrouch")
	SCREEN_UICONTAINER.visibility = Visibility.FORCE_OFF
	UI.SetCursorVisible(false)
	UI.SetCanCursorInteractWithUI(false)
	TRIGGER.isInteractable = TRIGGER:IsOverlapping(LOCAL_PLAYER)
end

local function OnBeginOverlap(trigger, other)
	if other == LOCAL_PLAYER then
		TRIGGER.isInteractable = true
	end
end

local function OnEndOverlap(trigger, other)
	if other == LOCAL_PLAYER then
		CloseScreenUI()
	end
end

local function OnInteracted(trigger, other)
	if other == LOCAL_PLAYER then
		OpenScreenUI()
		TRIGGER.isInteractable = false
	end
end

local function OnSearch()
	if IsValidNewToken(CONTRACT_ADDRESS_ENTRY.text, TOKEN_ID_ENTRY.text) then
		Events.BroadcastToServer(COMPONENT_ROOT.id .. ".NewToken", CONTRACT_ADDRESS_ENTRY.text, TOKEN_ID_ENTRY.text)
	end
	CloseScreenUI()
end

local function OnPropChange(owner, prop)
	if prop == "CurrentNFT" then
		CheckForTokenUpdate()
	end
end

TRIGGER.beginOverlapEvent:Connect(OnBeginOverlap)
TRIGGER.endOverlapEvent:Connect(OnEndOverlap)
TRIGGER.interactedEvent:Connect(OnInteracted)

SEARCH_BUTTON.clickedEvent:Connect(OnSearch)

CLOSE_BUTTON.clickedEvent:Connect(CloseScreenUI)

SERVER_SCRIPT.customPropertyChangedEvent:Connect(OnPropChange)

CloseScreenUI()
CheckForTokenUpdate()