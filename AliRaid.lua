local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer

local countedTools = {}
local webhookId = "https://discord.com/api/webhooks/1509487656172785815/y-W1lCQylgbvferK-QkNuhZgMsRPYmLJGRsKQsp7jzr7AXC4TYs7GzvZocRNeocYaxW6"
local isStarting = false
local Ended = false

local FruitData = {
	["Rocket Fruit"] = {Rarity = "Common", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341332172705982/Rocket.png?ex=69fbb893&is=69fa6713&hm=873159dda369034dd2027e36a74f24abba972bf47dd0249b5228c274bb701c22&=&format=webp&quality=lossless&width=440&height=440"},
	["Spin Fruit"] = {Rarity = "Common", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341331606208663/Spin.png?ex=69fbb893&is=69fa6713&hm=e4c2056334c6365bbfefb650dcc3bdb4fcc6530f64d6eb00e1377762bf7b65ac&=&format=webp&quality=lossless&width=440&height=440"},
	["Blade Fruit"] = {Rarity = "Common", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341331237240945/Blade.png?ex=69fbb892&is=69fa6712&hm=4b1371e51a2d2709d61c730a1fa8527bbb5353e505cb6ac3a7d83fce66507e04&=&format=webp&quality=lossless&width=440&height=440"},
	["Spring Fruit"] = {Rarity = "Common", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341330935386235/Spring.png?ex=69fbb892&is=69fa6712&hm=6de1c76257a6ed4191aed6c5f0b9318fcc267b1db2e8a5ed073ee0cdb7e21c31&=&format=webp&quality=lossless&width=440&height=440"},
	["Bomb Fruit"] = {Rarity = "Common", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341330591187116/Bomb.png?ex=69fbb892&is=69fa6712&hm=89abe64f836b51849f94142862a082fb1019681b52faa323e100fbe5016c2822&=&format=webp&quality=lossless&width=440&height=440"},
	["Smoke Fruit"] = {Rarity = "Common", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341330289459200/Smoke.png?ex=69fbb892&is=69fa6712&hm=9d581fbed9fcd0ae3534bbe199a3a515f40539eb3ca90479008705c7dd01271a&=&format=webp&quality=lossless&width=440&height=440"},
	["Spike Fruit"] = {Rarity = "Common", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341333410021396/Spike.png?ex=69fbb893&is=69fa6713&hm=b1cdbbf77f43d46ca4a760c291d5f697f1a0a1d7819ed0362c5c9257f8c34efd&=&format=webp&quality=lossless&width=440&height=440"},

	["Flame Fruit"] = {Rarity = "Rare", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341333103841430/Flame.png?ex=69fbb893&is=69fa6713&hm=ca31ee930d7480542a59f1ab4312bf5d084a96b51513fc82ec905afa0d97869c&=&format=webp&quality=lossless&width=1100&height=1100"},
	["Eagle Fruit"] = {Rarity = "Rare", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341316703977653/Eagle.png?ex=69fbb88f&is=69fa670f&hm=ceb9026296d521cb883c19612dac4a51d2a81a8c3ca51750c581e2bc011c9218&=&format=webp&quality=lossless&width=1100&height=1100"},
	["Ice Fruit"] = {Rarity = "Rare", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341332742864926/Ice.png?ex=69fbb893&is=69fa6713&hm=aef92de6ac87beadfdc6e6073e6261e574690dbdcb84900e32de07d45e7ea643&=&format=webp&quality=lossless&width=440&height=440"},
	["Sand Fruit"] = {Rarity = "Rare", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341317295247360/Sand.png?ex=69fbb88f&is=69fa670f&hm=0257766c94dc4ecf5b559909c393b47541d30099c376668a1f89d129bdf9355d&=&format=webp&quality=lossless&width=440&height=440"},
	["Dark Fruit"] = {Rarity = "Rare", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341317035196587/Dark.png?ex=69fbb88f&is=69fa670f&hm=1afcc3c6d23f36dab5c319a0e268fb75e9f8dc9546b05df9f861c3b841fe4487&=&format=webp&quality=lossless&width=440&height=440"},
	["Diamond Fruit"] = {Rarity = "Rare", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341316389273722/Diamond.png?ex=69fbb88f&is=69fa670f&hm=c1a8f2658fd9d9de02fc7ccc5914cf423ee98e053c673a05fc8e911f7026803a&=&format=webp&quality=lossless&width=440&height=440"},

	["Rubber Fruit"] = {Rarity = "Epic", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341318821974296/Rubber.png?ex=69fbb88f&is=69fa670f&hm=8d1a583f23d62e2d04cc716d3005b1d0f8e891d4061b8d16ff966bbe16129167&=&format=webp&quality=lossless&width=440&height=440"},
	["Magma Fruit"] = {Rarity = "Epic", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341318209732791/Magma.png?ex=69fbb88f&is=69fa670f&hm=39632e4709d576ad2b6ce8a8152f4cb79fe455161c653bb59be21214c6b43512&=&format=webp&quality=lossless&width=440&height=440"},
	["Light Fruit"] = {Rarity = "Epic", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341316037214308/Light.png?ex=69fbb88f&is=69fa670f&hm=8104a3c18925146fcaf80b25113fce91233a1b7a9093d5adc90e6f6163312f3e&=&format=webp&quality=lossless&width=440&height=440"},
	["Ghost Fruit"] = {Rarity = "Epic", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341318519980152/Ghost.png?ex=69fbb88f&is=69fa670f&hm=12ce4a4d494264d95c6b45893c9f2489a4d710afb910b6272e9dc37e2ba9b1c1&=&format=webp&quality=lossless&width=440&height=440"},

	["Quake Fruit"] = {Rarity = "Legendary", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341317916000266/Quake.png?ex=69fbb88f&is=69fa670f&hm=5e9a6261009f3562e4cee63e724682cdc2a515d576cbce936e8d1b13ac127f43&=&format=webp&quality=lossless&width=440&height=440"},
	["Buddha Fruit"] = {Rarity = "Legendary", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341317614272523/Buddha.png?ex=69fbb88f&is=69fa670f&hm=99326a743145a323bc921e5b33c3e9cbe4aca8e47577af4351a822c16da9581a&=&format=webp&quality=lossless&width=440&height=440"},
	["Love Fruit"] = {Rarity = "Legendary", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341270281289748/Love.png?ex=69fbb884&is=69fa6704&hm=21b32e00a714f350fecf976635a6791a913d40b13fd720d2f0fa1ed62acdae1b&=&format=webp&quality=lossless&width=440&height=440"},
	["Spider Fruit"] = {Rarity = "Legendary", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341269484372120/Spider.png?ex=69fbb884&is=69fa6704&hm=ed12e9ab9f8b389b5d898e231a0d9c8f516c5daaf7a4a072211655f6955eb6c2&=&format=webp&quality=lossless&width=440&height=440"},
	["Sound Fruit"] = {Rarity = "Legendary", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341268855488542/Sound.png?ex=69fbb884&is=69fa6704&hm=2079e9d96c7c27008ef75c4ea6efb4b8ed1f45ee77f75936d87d4933092ec8cc&=&format=webp&quality=lossless&width=440&height=440"},
	["Phoenix Fruit"] = {Rarity = "Legendary", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341268406439946/Phoenix.png?ex=69fbb883&is=69fa6703&hm=a1ba80c61d26a0aa485f35cc293c5db04126acd3dc49a57db73ba8a51bdd57c5&=&format=webp&quality=lossless&width=440&height=440"},
	["Portal Fruit"] = {Rarity = "Legendary", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341267924226209/Portal.png?ex=69fbb883&is=69fa6703&hm=3701f58dac015d4df7b82ef2d2da1dc873fbb4e4bd2e5f71029fc2be16c53bfa&=&format=webp&quality=lossless&width=440&height=440"},
	["Lightning Fruit"] = {Rarity = "Legendary", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341267567579206/Lighting.png?ex=69fbb883&is=69fa6703&hm=b35555bd2b9ec3feeba6c36ce51c16df1b18e650a4a9681f3ed5734749453e5a&=&format=webp&quality=lossless&width=440&height=440"},
	["Pain Fruit"] = {Rarity = "Legendary", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341271351099562/Pain.png?ex=69fbb884&is=69fa6704&hm=43a8d33120d8a6957d6e0922a4e1ed9c78494757fe89426d1c78663e3848eb7e&=&format=webp&quality=lossless&width=440&height=440"},
	["Blizzard Fruit"] = {Rarity = "Legendary", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341271023681706/Blizzard.png?ex=69fbb884&is=69fa6704&hm=7fb790b9adf4d05100f4f5b3221dc198b5f99a7b262e48803d2384fbe55260b9&=&format=webp&quality=lossless&width=440&height=440"},
	["Creation Fruit"] = {Rarity = "Legendary", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341269899743252/Creation.png?ex=69fbb884&is=69fa6704&hm=09be59c766c1821cfbd0346a816eb643e390febc7cfcb084923079d707f5b53e&=&format=webp&quality=lossless&width=462&height=462"},

	["Gravity Fruit"] = {Rarity = "Mythical", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341270633746482/Gravity.png?ex=69fbb884&is=69fa6704&hm=c468279a774c496ab322ffdc63d5411806fc6bc2c21e7c55a4a571c51439ba4a&=&format=webp&quality=lossless&width=1100&height=1100"},
	["Mammoth Fruit"] = {Rarity = "Mythical", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341249934983429/Mammoth.png?ex=69fbb87f&is=69fa66ff&hm=d8be8a554dd0f6b5c28b5ce52a796d8bd0b6294e98828eefa94f7b1e9cafead5&=&format=webp&quality=lossless&width=440&height=440"},
	["T-Rex Fruit"] = {Rarity = "Mythical", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341249431404762/Trex.png?ex=69fbb87f&is=69fa66ff&hm=5e25f60f6bff6721c60f81229270b877c76d72a6f3f3873bba68c88b83eac996&=&format=webp&quality=lossless&width=440&height=440"},
	["Dough Fruit"] = {Rarity = "Mythical", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341248978550915/Dough.png?ex=69fbb87f&is=69fa66ff&hm=0f12324c581f9b8b4d2f03c13558c2656470ae914dac375135b1802677256985&=&format=webp&quality=lossless&width=440&height=440"},
	["Shadow Fruit"] = {Rarity = "Mythical", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341248273776680/Shadow.png?ex=69fbb87f&is=69fa66ff&hm=50fd05e775b0e9263be84fabbfd1448b29a26c311d8b3960df2e7d90e93cbfbf&=&format=webp&quality=lossless&width=440&height=440"},
	["Venom Fruit"] = {Rarity = "Mythical", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501344834940571820/Venom.png?ex=69fbbbd6&is=69fa6a56&hm=3eee59e48b2c9ff529086a0af6b51f8bc8337fbae9a6218b0ea11f6fec6812c5&=&format=webp&quality=lossless&width=440&height=440"},
	["Control Fruit"] = {Rarity = "Mythical", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341250635305010/Control.png?ex=69fbb87f&is=69fa66ff&hm=b4ffb256e169edad67e6555414983e3590992e230cce70486802986d8f2df689&=&format=webp&quality=lossless&width=939&height=939"},
	["Spirit Fruit"] = {Rarity = "Mythical", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341252032139335/Spirit.png?ex=69fbb880&is=69fa6700&hm=d9bbd33f80b1ddd7d90da8e2e97305d977ed4305b10058be4b90dec609bc8158&=&format=webp&quality=lossless&width=440&height=440"},
	["Gas Fruit"] = {Rarity = "Mythical", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341252367552733/Gas.png?ex=69fbb880&is=69fa6700&hm=8e9b0512f6c251e042b75345575f9b96a7a56d61f98458e62973ecb4ad202c61&=&format=webp&quality=lossless&width=1100&height=1100"},
	["Tiger Fruit"] = {Rarity = "Mythical", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341251633549423/Tiger.png?ex=69fbb87f&is=69fa66ff&hm=f3d7e3551722cf903be4550e59dd8e223312199b0e294b85b7b54f3460c700f4&=&format=webp&quality=lossless&width=1100&height=1100"},
	["Yeti Fruit"] = {Rarity = "Mythical", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341251239415921/Yeti.png?ex=69fbb87f&is=69fa66ff&hm=e2cca24fccc83890784ef8f9588d12f1181f1c48b69ba9d4be03ed9ff15ffb11&=&format=webp&quality=lossless&width=166&height=166"},
	["Dragon Fruit"] = {Rarity = "Mythical", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341332453720125/Dragon.png?ex=69fbb893&is=69fa6713&hm=1001394dbdd24c24fd7b7cf206939a74ec03ecd63ca220b403534dc116b59365&=&format=webp&quality=lossless&width=165&height=165"},
	["Kitsune Fruit"] = {Rarity = "Mythical", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501341250991689979/Kitsune.png?ex=69fbb87f&is=69fa66ff&hm=39af55e5067fc975a4b62dd0fa7087c19de36b70d3aedc46c3af37c9b7bca2f0&=&format=webp&quality=lossless&width=1100&height=1100"},
	["Default"] = {Rarity = "Common", Icon = "https://media.discordapp.net/attachments/1122119351227662427/1501344834743701575/Default.png?ex=69fbbbd6&is=69fa6a56&hm=6fdc4707e9068fc4385f94e3165f8bd87abe510ecaa3596e55e1f0d0ffcc23cc&=&format=webp&quality=lossless&width=282&height=282"}
}

local rarityColors = {
	Common = 0x95A5A6,
	Rare = 0x3498DB,
	Epic = 0x9B59B6,
	Legendary = 0xF1C40F,
	Mythical = 0xE74C3C
}

local function getFruitColor(fruitName)
	local data = FruitData[fruitName]
	local rarity = (data and data.Rarity) or "Common"

	return rarityColors[rarity] or 0xFFFFFF
end

local function sendWebhook(fruitName)
	if not webhookId or webhookId == "" then 
		warn("Webhook URL is empty! Please enter it in the UI.")
		return 
	end

	local proxyUrl = webhookId:gsub("discord.com", "webhook.lewisakura.moe")
	local imageUrl = FruitData[fruitName] and FruitData[fruitName].Icon or FruitData["Default"].Icon

	local data = {
		["content"] = "@here, **".. player.DisplayName .. "** just found: **" .. fruitName .. "**",
		["embeds"] = {{
			["title"] = "Fruit Detected!",
			["description"] = "**" .. player.DisplayName .. "** just found: **" .. fruitName .. "**",
			["color"] = getFruitColor(fruitName),
			["thumbnail"] = {
				["url"] = imageUrl
			},
			["footer"] = {["text"] = "Mattcy Finder • " .. os.date("%X")}
		}}
	}

	local requestFunc = syn and syn.request or http_request or request or (http and http.request)

	if requestFunc then
		local success, result = pcall(function()
			return requestFunc({
				Url = proxyUrl,
				Method = "POST",
				Headers = {["Content-Type"] = "application/json"},
				Body = HttpService:JSONEncode(data)
			})
		end)

		if success then
			print("Successfully sent webhook for: " .. fruitName)
		else
			warn("Webhook Error: " .. tostring(result))
		end
	else
		warn("Executor error: Your executor does not support HTTP requests.")
	end
end

task.spawn(function()
	while task.wait(0.5) do 
		local backpack = player:FindFirstChild("Backpack")

		if backpack then
			for _, tool in ipairs(backpack:GetChildren()) do
				if string.find(tool.Name, "Fruit") then
					if not countedTools[tool] then
						countedTools[tool] = true 
						sendWebhook(tool.Name) 
					end
				end
			end
		end
	end
end)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")

local RE_RegisterAttack = Net:WaitForChild("RE/RegisterAttack")
local RE_RegisterHit = Net:WaitForChild("RE/RegisterHit")
local HIT_FUNCTION

local isMoving = false
	
local function moveTo(targetPos)
	if isMoving then return end
	isMoving = true

	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")

	if not hrp or not humanoid then return end

	humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding)

	local startPos = hrp.Position
	local distance = (targetPos - startPos).Magnitude

	if distance <= 100 then
		hrp.CFrame = CFrame.new(targetPos)
		hrp.AssemblyLinearVelocity = Vector3.zero
		hrp.AssemblyAngularVelocity = Vector3.zero
	elseif distance > 0.01 then
		local duration = distance / 275
		local startTime = tick()

		while true do
			local elapsed = tick() - startTime
			local alpha = math.clamp(elapsed / duration, 0, 1)

			local newPos = startPos:Lerp(targetPos, alpha)

			local currentRotation = hrp.CFrame - hrp.CFrame.Position
			hrp.CFrame = CFrame.new(newPos) * currentRotation

			hrp.AssemblyLinearVelocity = Vector3.zero
			hrp.AssemblyAngularVelocity = Vector3.zero

			if alpha >= 1 then 
				break 
			end

			game:GetService("RunService").RenderStepped:Wait()
		end
	end

	hrp.AssemblyLinearVelocity = Vector3.zero
	hrp.AssemblyAngularVelocity = Vector3.zero

	isMoving = false
	humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
end

local function equipWeapon(weaponType)
	local backpack = player:FindFirstChild("Backpack")
	local char = player.Character
	if not char then return end

	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if not backpack or not humanoid then return end

	for _, tool in ipairs(backpack:GetChildren()) do
		if tool:IsA("Tool") then
			local toolType = tool:GetAttribute("WeaponType")

			if toolType == weaponType then
				humanoid:EquipTool(tool)
				break
			end
		end
	end
end

local function getTarget(lastDist)
	local char = player.Character
	if not char or not char.PrimaryPart then return nil end

	local nearest = nil

	for _, enemy in pairs(workspace.Enemies:GetChildren()) do
		if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy.PrimaryPart then
			local dist = (char.PrimaryPart.Position - enemy.PrimaryPart.Position).Magnitude
			if dist < lastDist then
				nearest = enemy
				lastDist = dist
			end
		end
	end

	return nearest
end

game:GetService("RunService").Stepped:Connect(function()
	local char = player.Character

	if char then
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
			end
		end
	end
end)

pcall(function()
	HIT_FUNCTION = (getmenv or getsenv)(Net)._G.SendHitsToServer
end)

task.spawn(function()
	while task.wait(1) do
		equipWeapon("Melee")
	end
end)

task.spawn(function()
	while task.wait() do
		local char = player.Character
		local tool = char and char:FindFirstChildOfClass("Tool")

		if tool then
			local target = getTarget(150)
			if target and target.PrimaryPart then
				RE_RegisterAttack:FireServer(0)

				if HIT_FUNCTION then
					HIT_FUNCTION(target.PrimaryPart, {target.PrimaryPart})
				else
					RE_RegisterHit:FireServer(target.PrimaryPart, {target.PrimaryPart})
				end
			end
		end
	end
end)

task.spawn(function()
	while task.wait(0.5) do
		local char = player.Character
		if char and not char:FindFirstChild("HasBuso") then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
		end
	end
end)

task.spawn(function()
	if player:WaitForChild("PlayerGui"):WaitForChild("Main (minimal)", 10):FindFirstChild("ChooseTeam") then
		repeat task.wait(1)
			pcall(function()
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
			end)
		until player.Team ~= nil
	end
end)

task.spawn(function()
	while task.wait(1) do
		pcall(function()
			local Backpack = player:FindFirstChild("Backpack")
			local CommF = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_")
			if not Backpack then return end

			for _, fruit in Backpack:GetChildren() do
				if string.find(fruit.Name, "Fruit") then
					local args = {
						[1] = "StoreFruit",
						[2] = fruit:GetAttribute("OriginalName"),
						[3] = fruit
					}
					CommF:InvokeServer(unpack(args))
				end
			end
		end)
	end
end)

task.spawn(function()
	while true do 
		task.wait(0.5) 

		if setscriptable then
			setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
		end

		if sethiddenproperty then
			sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
		end
	end
end)

local function InMyNetWork(object, hrpPos)
	if isnetworkowner then
		return isnetworkowner(object)
	else
		return (object.Position - hrpPos).Magnitude <= 350
	end
end

task.spawn(function()
	while task.wait() do
		local char = player.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if not hrp then continue end

		local hrpPos = hrp.Position
		local hrpCFrame = hrp.CFrame
		local targetCFrame = hrpCFrame - Vector3.new(0, 20, 0)

		pcall(function()
			for _, v in ipairs(game.Workspace.Enemies:GetChildren()) do
				local enemyHrp = v:FindFirstChild("HumanoidRootPart")
				local enemyHumanoid = v:FindFirstChildOfClass("Humanoid")
				local enemyHead = v:FindFirstChild("Head")

				if enemyHrp and enemyHumanoid and enemyHumanoid.Health > 0 and not string.find(v.Name, "Boss") then
					if (enemyHrp.Position - hrpPos).Magnitude <= 350 then
						if InMyNetWork(enemyHrp, hrpPos) then
							enemyHrp.CFrame = targetCFrame
							enemyHrp.Size = Vector3.new(60, 60, 60)
							enemyHrp.Transparency = 1
							enemyHrp.CanCollide = false

							if enemyHead then 
								enemyHead.CanCollide = false 
							end

							enemyHumanoid.JumpPower = 0
							enemyHumanoid.WalkSpeed = 0

							local animator = enemyHumanoid:FindFirstChildOfClass("Animator")
							if animator then
								animator:Destroy()
							end

							enemyHumanoid:ChangeState(Enum.HumanoidStateType.Physics) 
							enemyHumanoid:ChangeState(Enum.HumanoidStateType.None)    
						end
					end
				end
			end
		end)
	end
end)

task.spawn(function()
	while task.wait() do
		local char = player.Character
		if not char then continue end

		local hrp = char:FindFirstChild("HumanoidRootPart")
		local humanoid = char:FindFirstChildOfClass("Humanoid")

		if hrp and hrp:IsDescendantOf(workspace) and humanoid and humanoid.Health > 0 then
			local fixedTargetPos = Vector3.new(-5498, 314, -2855)
			local distance = (hrp.Position - fixedTargetPos).Magnitude

			if distance > 1000 then
				moveTo(fixedTargetPos)
			else
				local target = getTarget(350)

				if target and target:FindFirstChild("HumanoidRootPart") and target:FindFirstChild("Humanoid") then
					if target.Humanoid.Health > 0 then
						local targetPos = target.HumanoidRootPart.Position + Vector3.new(0, 25, 0)
						hrp.CFrame = CFrame.new(targetPos, target.HumanoidRootPart.Position)
					end
				end
			end
		end
	end
end)

local TextChatService = game:GetService("TextChatService")
local LogService = game:GetService("LogService")

local function serverHop()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local BrowserRemote = ReplicatedStorage:WaitForChild("__ServerBrowser")

	if isStarting then return end
	
	local char = player.Character
	if not char then return end

	local hrp = char:FindFirstChild("HumanoidRootPart")
	local humanoid = char:FindFirstChildOfClass("Humanoid")

	if hrp and hrp:IsDescendantOf(workspace) and humanoid and humanoid.Health > 0 then
		local fixedTargetPos = Vector3.new(-5498, 314, -2855)
		local distance = (hrp.Position - fixedTargetPos).Magnitude

		if distance > 1000 then
			return
		end
	end

	for page = 1, 100 do 
		local success, serverList = pcall(function()
			return BrowserRemote:InvokeServer(page)
		end)

		if success and type(serverList) == "table" then
			for jobId, serverData in pairs(serverList) do
				if isStarting then return end
				
				if jobId ~= game.JobId and serverData["Count"] >= 2 and serverData["Count"] <= 10 then
					if not isStarting then
						print("[DEBUG] Teleporting to target server: " .. jobId)
						BrowserRemote:InvokeServer("teleport", jobId)
						task.wait(0.5)
					else
						return
					end
				end
			end
		end
		task.wait(0.1) 
	end
end

local function onRaidDetected()
	if isStarting then return end
	print("[DEBUG] Pirate Raid detected!.")
	isStarting = true
end

local function onRaidStart()
	print("[DEBUG] Raid started!.")
	
	local fixedTargetPos = Vector3.new(-5498, 314, -2855)
	moveTo(fixedTargetPos)
end

local function onRaidEnd()
	print("[DEBUG] Raid finished!.")
	Ended = true
	isStarting = false
	serverHop()
end

task.spawn(function()
	task.wait(15)

	while not isStarting do
		serverHop()
		task.wait(10)
	end
end)

TextChatService.MessageReceived:Connect(function(textChatMessage)
	local message = textChatMessage.Text

	if string.find(message, "Pirates have been spotted") then
		onRaidDetected()
	end
	
	if string.find(message, "Good job! Anybody who defeated") then
		onRaidEnd()
	end
	
	if string.find(message, "The pirates are raiding Castle on the Sea!") then
		onRaidStart()
	end
end)

LogService.MessageOut:Connect(function(message, messageType)
	if messageType == Enum.MessageType.MessageOutput or messageType == Enum.MessageType.MessageInfo then
		local lowerMessage = string.lower(message)

		if string.find(lowerMessage, "pirates have been spotted") then
			onRaidDetected()
		end
		
		if string.find(lowerMessage, "anybody who defeated at least") then
			onRaidEnd()
		end
		
		if string.find(lowerMessage, "the pirates are raiding") then
			onRaidStart()
		end
	end
end)
