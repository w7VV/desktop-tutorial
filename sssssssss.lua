local Players = game:GetService("Players")
local player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TextChatService = game:GetService("TextChatService")
local RunService = game:GetService("RunService")

local selectedCommands = {}
local favoriteCommands = {}
local targetedPlayer = nil
local espEnabled = false
local espHighlight = nil
local spamEnabled = false
local spamThread = nil
local protectionEnabled = false
local protectionConnections = {}
local screenGui = nil

-- Clean player name
local function cleanPlayerName(name)
    name = string.gsub(name, "^%s*(.-)%s*$", "%1")
    name = string.gsub(name, "[^%w_]", "")
    return name
end

-- Find player by partial name
local function findPlayer(partialName)
    if partialName == "" then
        return { player.Name }
    end
    local playerNames = {}
    for name in string.gmatch(partialName, "[^,]+") do
        name = cleanPlayerName(name)
        if name == "" then
            continue
        end
        local found = false
        for _, p in pairs(Players:GetPlayers()) do
            local cleanedPlayerName = cleanPlayerName(p.Name)
            local cleanedDisplayName = p.DisplayName and cleanPlayerName(p.DisplayName) or ""
            local lowerSearchName = string.lower(name)
            if string.lower(cleanedPlayerName):find(lowerSearchName) or
               (p.DisplayName and string.lower(cleanedDisplayName):find(lowerSearchName)) then
                table.insert(playerNames, p.Name)
                found = true
                break
            end
        end
        if not found then
            print("⚠️ لم يتم العثور على لاعب باسم: " .. name)
            table.insert(playerNames, name)
        end
    end
    return playerNames
end

-- Get all players
local function getAllPlayers()
    local playerNames = {}
    for _, p in pairs(Players:GetPlayers()) do
        table.insert(playerNames, p.Name)
    end
    return table.concat(playerNames, ",")
end

-- Copy text to clipboard
local function copyToClipboard(text)
    local success, err = pcall(function()
        setclipboard(text)
    end)
    if success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "تم النسخ!",
            Text = text,
            Duration = 3
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "فشل النسخ",
            Text = "تعذر النسخ، تحقق من وحدة التحكم (F9)",
            Duration = 3
        })
    end
end

-- Send message to chat
local function sendMessageToChat(message)
    if message == "" then
        return false
    end
    local chatService = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    if chatService then
        local sayMessageRequest = chatService:FindFirstChild("SayMessageRequest")
        if sayMessageRequest then
            sayMessageRequest:FireServer(message, "All")
            wait(0.1)
            return true
        end
    end
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local textChannels = TextChatService:FindFirstChild("TextChannels")
        if textChannels then
            local channel = textChannels:FindFirstChild("RBXGeneral") or
                           textChannels:FindFirstChildWhichIsA("TextChatChannel")
            if channel then
                channel:SendAsync(message)
                wait(0.1)
                return true
            end
        end
    end
    return false
end

-- Get player info
local function getPlayerInfo(playerObj)
    local userId = playerObj.UserId
    local info = {
        userId = userId,
        displayName = playerObj.DisplayName,
        username = playerObj.Name
    }
    local success, result = pcall(function()
        return game:GetService("Players"):GetHumanoidDescriptionFromUserId(userId)
    end)
    info.creationDate = success and os.date("%Y-%m-%d", playerObj.AccountAge * 86400 + os.time()) or "غير متوفر"
    info.location = "غير متوفر (يمكن تخصيصه)"
    info.thumbnailUrl = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png", userId)
    return info
end

-- Toggle ESP
local function toggleESP(playerObj, enable)
    if not playerObj.Character then
        return
    end
    if enable then
        if espHighlight then
            espHighlight:Destroy()
        end
        espHighlight = Instance.new("Highlight")
        espHighlight.FillColor = Color3.fromRGB(255, 0, 0)
        espHighlight.OutlineColor = Color3.fromRGB(255, 255, 0)
        espHighlight.Adornee = playerObj.Character
        espHighlight.Parent = playerObj.Character
    else
        if espHighlight then
            espHighlight:Destroy()
            espHighlight = nil
        end
    end
end

-- Toggle protection
local function toggleProtection(enable)
    if enable then
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
            table.insert(protectionConnections, humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                if protectionEnabled then
                    humanoid.Health = math.huge
                end
            end))
            table.insert(protectionConnections, humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                if protectionEnabled then
                    humanoid.WalkSpeed = 16
                end
            end))
            table.insert(protectionConnections, humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
                if protectionEnabled then
                    humanoid.JumpPower = 50
                end
            end))
            table.insert(protectionConnections, humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(function()
                if protectionEnabled then
                    humanoid.MaxHealth = math.huge
                    humanoid.Health = math.huge
                end
            end))
        end
        if player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    local originalSize = part.Size
                    local originalTransparency = part.Transparency
                    table.insert(protectionConnections, part:GetPropertyChangedSignal("Size"):Connect(function()
                        if protectionEnabled then
                            part.Size = originalSize
                        end
                    end))
                    table.insert(protectionConnections, part:GetPropertyChangedSignal("Transparency"):Connect(function()
                        if protectionEnabled then
                            part.Transparency = originalTransparency
                        end
                    end))
                    table.insert(protectionConnections, part:GetPropertyChangedSignal("CanCollide"):Connect(function()
                        if protectionEnabled then
                            part.CanCollide = true
                        end
                    end))
                end
            end
        end
        if player.Character then
            table.insert(protectionConnections, player.Character.ChildRemoved:Connect(function(child)
                if protectionEnabled and child:IsA("BasePart") then
                    player:LoadCharacter()
                end
            end))
        end
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local lastPosition = hrp.Position
            table.insert(protectionConnections, RunService.Heartbeat:Connect(function()
                if protectionEnabled then
                    local currentPosition = hrp.Position
                    local distance = (currentPosition - lastPosition).Magnitude
                    if distance > 50 then
                        hrp.Position = lastPosition
                    else
                        lastPosition = currentPosition
                    end
                end
            end))
        end
        table.insert(protectionConnections, player.CharacterAdded:Connect(function(character)
            if protectionEnabled then
                wait(0.1)
                toggleProtection(true)
            end
        end))
    else
        for _, connection in pairs(protectionConnections) do
            connection:Disconnect()
        end
        protectionConnections = {}
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            humanoid.MaxHealth = 100
            humanoid.Health = 100
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
    end
end

-- Create GUI
local function createGUI()
    screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    screenGui.Name = "AdvancedCommandGUI"
    screenGui.ResetOnSpawn = false

    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Size = UDim2.new(0, 700, 0, 500)
    mainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.Active = true
    mainFrame.Draggable = true

    local title = Instance.new("TextLabel", mainFrame)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = "gg v3 beta"
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 20
    title.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
    title.TextColor3 = Color3.new(1, 1, 1)

    local hideBtn = Instance.new("TextButton", mainFrame)
    hideBtn.Size = UDim2.new(0, 30, 0, 30)
    hideBtn.Position = UDim2.new(1, -35, 0, 0)
    hideBtn.Text = "X"
    hideBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    hideBtn.TextColor3 = Color3.new(1, 1, 1)

    local tabsFrame = Instance.new("Frame", mainFrame)
    tabsFrame.Size = UDim2.new(1, 0, 0, 30)
    tabsFrame.Position = UDim2.new(0, 0, 0, 30)
    tabsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    local targetPageBtn = Instance.new("TextButton", tabsFrame)
    targetPageBtn.Size = UDim2.new(0.2, 0, 1, 0)
    targetPageBtn.Position = UDim2.new(0, 0, 0, 0)
    targetPageBtn.Text = "الاستهداف (الاعب الي كتبت اسمه)"
    targetPageBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    targetPageBtn.TextColor3 = Color3.new(1, 1, 1)
    targetPageBtn.Font = Enum.Font.SourceSansBold
    targetPageBtn.TextSize = 16

    local protectionPageBtn = Instance.new("TextButton", tabsFrame)
    protectionPageBtn.Size = UDim2.new(0.2, 0, 1, 0)
    protectionPageBtn.Position = UDim2.new(0.2, 0, 0, 0)
    protectionPageBtn.Text = "الحماية"
    protectionPageBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    protectionPageBtn.TextColor3 = Color3.new(1, 1, 1)
    protectionPageBtn.Font = Enum.Font.SourceSansBold
    protectionPageBtn.TextSize = 16

    local spamPageBtn = Instance.new("TextButton", tabsFrame)
    spamPageBtn.Size = UDim2.new(0.2, 0, 1, 0)
    spamPageBtn.Position = UDim2.new(0.4, 0, 0, 0)
    spamPageBtn.Text = "الارسال"
    spamPageBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    spamPageBtn.TextColor3 = Color3.new(1, 1, 1)
    spamPageBtn.Font = Enum.Font.SourceSansBold
    spamPageBtn.TextSize = 16

    local commandsPageBtn = Instance.new("TextButton", tabsFrame)
    commandsPageBtn.Size = UDim2.new(0.2, 0, 1, 0)
    commandsPageBtn.Position = UDim2.new(0.6, 0, 0, 0)
    commandsPageBtn.Text = "الأوامر"
    commandsPageBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    commandsPageBtn.TextColor3 = Color3.new(1, 1, 1)
    commandsPageBtn.Font = Enum.Font.SourceSansBold
    commandsPageBtn.TextSize = 16

    local infoPageBtn = Instance.new("TextButton", tabsFrame)
    infoPageBtn.Size = UDim2.new(0.2, 0, 1, 0)
    infoPageBtn.Position = UDim2.new(0.8, 0, 0, 0)
    infoPageBtn.Text = "الصفحة الرئيسية"
    infoPageBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    infoPageBtn.TextColor3 = Color3.new(1, 1, 1)
    infoPageBtn.Font = Enum.Font.SourceSansBold
    infoPageBtn.TextSize = 16

    local commandsPage = Instance.new("Frame", mainFrame)
    commandsPage.Size = UDim2.new(1, 0, 1, -60)
    commandsPage.Position = UDim2.new(0, 0, 0, 60)
    commandsPage.BackgroundTransparency = 1
    commandsPage.Visible = false

    local targetPage = Instance.new("Frame", mainFrame)
    targetPage.Size = UDim2.new(1, 0, 1, -60)
    targetPage.Position = UDim2.new(0, 0, 0, 60)
    targetPage.BackgroundTransparency = 1
    targetPage.Visible = false

    local protectionPage = Instance.new("Frame", mainFrame)
    protectionPage.Size = UDim2.new(1, 0, 1, -60)
    protectionPage.Position = UDim2.new(0, 0, 0, 60)
    protectionPage.BackgroundTransparency = 1
    protectionPage.Visible = false

    local spamPage = Instance.new("Frame", mainFrame)
    spamPage.Size = UDim2.new(1, 0, 1, -60)
    spamPage.Position = UDim2.new(0, 0, 0, 60)
    spamPage.BackgroundTransparency = 1
    spamPage.Visible = false

    local infoPage = Instance.new("Frame", mainFrame)
    infoPage.Size = UDim2.new(1, 0, 1, -60)
    infoPage.Position = UDim2.new(0, 0, 0, 60)
    infoPage.BackgroundTransparency = 1
    infoPage.Visible = true

    local searchBox = Instance.new("TextBox", commandsPage)
    searchBox.Size = UDim2.new(1, -20, 0, 30)
    searchBox.Position = UDim2.new(0, 10, 0, 10)
    searchBox.PlaceholderText = "ابحث عن أمر..."
    searchBox.Text = ""
    searchBox.TextSize = 16
    searchBox.TextColor3 = Color3.new(1, 1, 1)
    searchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    searchBox.TextScaled = true
    searchBox.TextWrapped = true

    local selectBtn = Instance.new("TextButton", commandsPage)
    selectBtn.Size = UDim2.new(0.12, -5, 0, 25)
    selectBtn.Position = UDim2.new(0, 10, 0, 50)
    selectBtn.Text = "تحديد الأوامر"
    selectBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    selectBtn.TextColor3 = Color3.new(1, 1, 1)
    selectBtn.Font = Enum.Font.SourceSansBold
    selectBtn.TextSize = 14
    selectBtn.TextScaled = true
    selectBtn.TextWrapped = true

    local playerOnlyBtn = Instance.new("TextButton", commandsPage)
    playerOnlyBtn.Size = UDim2.new(0.12, -5, 0, 25)
    playerOnlyBtn.Position = UDim2.new(0.12, 5, 0, 50)
    playerOnlyBtn.Text = "أوامر <player>"
    playerOnlyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
    playerOnlyBtn.TextColor3 = Color3.new(1, 1, 1)
    playerOnlyBtn.Font = Enum.Font.SourceSansBold
    playerOnlyBtn.TextSize = 14
    selectBtn.TextScaled = true
    selectBtn.TextWrapped = true

    local withArgsBtn = Instance.new("TextButton", commandsPage)
    withArgsBtn.Size = UDim2.new(0.12, -5, 0, 25)
    withArgsBtn.Position = UDim2.new(0.24, 0, 0, 50)
    withArgsBtn.Text = "أوامر مع ارقام الى اخره"
    withArgsBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
    withArgsBtn.TextColor3 = Color3.new(1, 1, 1)
    withArgsBtn.Font = Enum.Font.SourceSansBold
    withArgsBtn.TextSize = 14
    withArgsBtn.TextScaled = true
    withArgsBtn.TextWrapped = true

    local favoritesBtn = Instance.new("TextButton", commandsPage)
    favoritesBtn.Size = UDim2.new(0.12, -5, 0, 25)
    favoritesBtn.Position = UDim2.new(0.36, -5, 0, 50)
    favoritesBtn.Text = "⭐ المفضلة"
    favoritesBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
    favoritesBtn.TextColor3 = Color3.new(1, 1, 1)
    favoritesBtn.Font = Enum.Font.SourceSansBold
    favoritesBtn.TextSize = 14
    favoritesBtn.TextScaled = true
    favoritesBtn.TextWrapped = true

    local selectAllBtn = Instance.new("TextButton", commandsPage)
    selectAllBtn.Size = UDim2.new(0.12, -5, 0, 25)
    selectAllBtn.Position = UDim2.new(0.48, -10, 0, 50)
    selectAllBtn.Text = "تحديد كل اللاعبين"
    selectAllBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    selectAllBtn.TextColor3 = Color3.new(1, 1, 1)
    selectAllBtn.Font = Enum.Font.SourceSansBold
    selectAllBtn.TextSize = 14
    selectAllBtn.TextScaled = true
    selectAllBtn.TextWrapped = true

    local clearAllPlayersBtn = Instance.new("TextButton", commandsPage)
    clearAllPlayersBtn.Size = UDim2.new(0.12, -5, 0, 25)
    clearAllPlayersBtn.Position = UDim2.new(0.60, -15, 0, 50)
    clearAllPlayersBtn.Text = "إلغاء تحديد اللاعبين"
    clearAllPlayersBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    clearAllPlayersBtn.TextColor3 = Color3.new(1, 1, 1)
    clearAllPlayersBtn.Font = Enum.Font.SourceSansBold
    clearAllPlayersBtn.TextSize = 14
    clearAllPlayersBtn.TextScaled = true
    clearAllPlayersBtn.TextWrapped = true

    local copySelectedBtn = Instance.new("TextButton", commandsPage)
    copySelectedBtn.Size = UDim2.new(0.12, -5, 0, 25)
    copySelectedBtn.Position = UDim2.new(0.72, -20, 0, 50)
    copySelectedBtn.Text = "نسخ المحدد"
    copySelectedBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    copySelectedBtn.TextColor3 = Color3.new(1, 1, 1)
    copySelectedBtn.Font = Enum.Font.SourceSansBold
    copySelectedBtn.TextSize = 14
    copySelectedBtn.TextScaled = true
    copySelectedBtn.TextWrapped = true

    local clearSelectionBtn = Instance.new("TextButton", commandsPage)
    clearSelectionBtn.Size = UDim2.new(0.12, -5, 0, 25)
    clearSelectionBtn.Position = UDim2.new(0.84, -25, 0, 50)
    clearSelectionBtn.Text = "إلغاء التحديد"
    clearSelectionBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    clearSelectionBtn.TextColor3 = Color3.new(1, 1, 1)
    clearSelectionBtn.Font = Enum.Font.SourceSansBold
    clearSelectionBtn.TextSize = 14
    clearSelectionBtn.TextScaled = true
    clearSelectionBtn.TextWrapped = true

    local nameBox = Instance.new("TextBox", commandsPage)
    nameBox.Size = UDim2.new(1, -20, 0, 30)
    nameBox.Position = UDim2.new(0, 10, 0, 85)
    nameBox.PlaceholderText = "اسم اللاعب"
    nameBox.Text = player.Name
    nameBox.TextSize = 16
    nameBox.TextColor3 = Color3.new(1, 1, 1)
    nameBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    nameBox.TextScaled = true
    nameBox.TextWrapped = true

    local dividerLine = Instance.new("Frame", commandsPage)
    dividerLine.Size = UDim2.new(1, -20, 0, 2)
    dividerLine.Position = UDim2.new(0, 10, 0, 120)
    dividerLine.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
    dividerLine.BorderSizePixel = 0

    local numberBox = Instance.new("TextBox", commandsPage)
    numberBox.Size = UDim2.new(1, -20, 0, 30)
    numberBox.Position = UDim2.new(0, 10, 0, 130)
    numberBox.PlaceholderText = "الأرقام (مثل 10، 0.5...)"
    numberBox.Text = ""
    numberBox.TextSize = 16
    numberBox.TextColor3 = Color3.new(1, 1, 1)
    numberBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    numberBox.Visible = false
    numberBox.TextScaled = true
    numberBox.TextWrapped = true

    local colorBox = Instance.new("TextBox", commandsPage)
    colorBox.Size = UDim2.new(1, -20, 0, 30)
    colorBox.Position = UDim2.new(0, 10, 0, 165)
    colorBox.PlaceholderText = "اللون (مثل red، blue...)"
    colorBox.Text = ""
    colorBox.TextSize = 16
    colorBox.TextColor3 = Color3.new(1, 1, 1)
    colorBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    colorBox.Visible = false
    colorBox.TextScaled = true
    colorBox.TextWrapped = true

    local textBox = Instance.new("TextBox", commandsPage)
    textBox.Size = UDim2.new(1, -20, 0, 30)
    textBox.Position = UDim2.new(0, 10, 0, 200)
    textBox.PlaceholderText = "النص (مثل hello، test...)"
    textBox.Text = ""
    textBox.TextSize = 16
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    textBox.Visible = false
    textBox.TextScaled = true
    textBox.TextWrapped = true

    local cmdFrame = Instance.new("ScrollingFrame", commandsPage)
    cmdFrame.Size = UDim2.new(1, -20, 1, -260)
    cmdFrame.Position = UDim2.new(0, 10, 0, 260)
    cmdFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    cmdFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    cmdFrame.ScrollBarThickness = 6

    local spamContainer = Instance.new("Frame", spamPage)
    spamContainer.Size = UDim2.new(1, -20, 1, -20)
    spamContainer.Position = UDim2.new(0, 10, 0, 10)
    spamContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    spamContainer.BorderSizePixel = 0

    local spamTextBox = Instance.new("TextBox", spamContainer)
    spamTextBox.Size = UDim2.new(0.8, 0, 0, 50)
    spamTextBox.Position = UDim2.new(0.1, 0, 0.3, 0)
    spamTextBox.PlaceholderText = "الصق الامر الي نسخته   ..."
    spamTextBox.Text = ""
    spamTextBox.TextSize = 16
    spamTextBox.TextColor3 = Color3.new(1, 1, 1)
    spamTextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    spamTextBox.TextWrapped = true
    spamTextBox.TextScaled = true

    local spamBtn = Instance.new("TextButton", spamContainer)
    spamBtn.Size = UDim2.new(0.3, 0, 0, 30)
    spamBtn.Position = UDim2.new(0.35, 0, 0.5, 0)
    spamBtn.Text = "تفعيل الارسال"
    spamBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    spamBtn.TextColor3 = Color3.new(1, 1, 1)
    spamBtn.Font = Enum.Font.SourceSansBold
    spamBtn.TextSize = 16
    spamBtn.TextScaled = true
    spamBtn.TextWrapped = true

    local infoContainer = Instance.new("Frame", infoPage)
    infoContainer.Size = UDim2.new(1, -20, 1, -20)
    infoContainer.Position = UDim2.new(0, 10, 0, 10)
    infoContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    infoContainer.BorderSizePixel = 0

    local profileImage = Instance.new("ImageLabel", infoContainer)
    profileImage.Size = UDim2.new(0, 150, 0, 150)
    profileImage.Position = UDim2.new(0, 10, 0, 10)
    profileImage.BackgroundTransparency = 1
    profileImage.Image = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png", player.UserId)

    local infoLabel = Instance.new("TextLabel", infoContainer)
    infoLabel.Size = UDim2.new(1, -180, 0, 100)
    infoLabel.Position = UDim2.new(0, 170, 0, 10)
    infoLabel.Text = "نسخة بيتا مو كاملة (فيها مشاكل)\nحقوق 6rb."
    infoLabel.TextColor3 = Color3.new(1, 1, 1)
    infoLabel.TextSize = 16
    infoLabel.BackgroundTransparency = 1
    infoLabel.TextWrapped = true
    infoLabel.TextYAlignment = Enum.TextYAlignment.Top
    infoLabel.TextScaled = true

    local profileImage2 = Instance.new("ImageLabel", infoContainer)
    profileImage2.Size = UDim2.new(0, 150, 0, 150)
    profileImage2.Position = UDim2.new(0, 10, 0, 170)
    profileImage2.BackgroundTransparency = 1
    profileImage2.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=49917433&width=420&height=420&format=png"

    local targetContainer = Instance.new("Frame", targetPage)
    targetContainer.Size = UDim2.new(1, -20, 1, -60)
    targetContainer.Position = UDim2.new(0, 10, 0, 10)
    targetContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    targetContainer.BorderSizePixel = 0

    local targetProfileImage = Instance.new("ImageLabel", targetContainer)
    targetProfileImage.Size = UDim2.new(0, 150, 0, 150)
    targetProfileImage.Position = UDim2.new(0, 10, 0, 10)
    targetProfileImage.BackgroundTransparency = 1

    local targetInfoLabel = Instance.new("TextLabel", targetContainer)
    targetInfoLabel.Size = UDim2.new(1, -180, 1, -20)
    targetInfoLabel.Position = UDim2.new(0, 170, 0, 10)
    targetInfoLabel.Text = "لم يتم تحديد لاعب مستهدف بعد..."
    targetInfoLabel.TextColor3 = Color3.new(1, 1, 1)
    targetInfoLabel.TextSize = 16
    targetInfoLabel.BackgroundTransparency = 1
    targetInfoLabel.TextWrapped = true
    targetInfoLabel.TextYAlignment = Enum.TextYAlignment.Top
    targetInfoLabel.TextScaled = true

    local espBtn = Instance.new("TextButton", targetPage)
    espBtn.Size = UDim2.new(0.3, 0, 0, 30)
    espBtn.Position = UDim2.new(0.35, 0, 0.85, 0)
    espBtn.Text = "تفعيل ESP"
    espBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    espBtn.TextColor3 = Color3.new(1, 1, 1)
    espBtn.Font = Enum.Font.SourceSansBold
    espBtn.TextSize = 16
    espBtn.TextScaled = true
    espBtn.TextWrapped = true

    local protectionContainer = Instance.new("Frame", protectionPage)
    protectionContainer.Size = UDim2.new(1, -20, 1, -20)
    protectionContainer.Position = UDim2.new(0, 10, 0, 10)
    protectionContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    protectionContainer.BorderSizePixel = 0

    local protectionLabel = Instance.new("TextLabel", protectionContainer)
    protectionLabel.Size = UDim2.new(1, 0, 0, 50)
    protectionLabel.Position = UDim2.new(0, 0, 0, 10)
    protectionLabel.Text = "الحماية: تمنع الأوامر من التأثير عليك (احتمال ماتشتغل)"
    protectionLabel.TextColor3 = Color3.new(1, 1, 1)
    protectionLabel.TextSize = 18
    protectionLabel.BackgroundTransparency = 1
    protectionLabel.TextWrapped = true
    protectionLabel.TextYAlignment = Enum.TextYAlignment.Center
    protectionLabel.TextScaled = true

    local protectionBtn = Instance.new("TextButton", protectionContainer)
    protectionBtn.Size = UDim2.new(0.3, 0, 0, 30)
    protectionBtn.Position = UDim2.new(0.35, 0, 0.5, 0)
    protectionBtn.Text = "تفعيل الحماية"
    protectionBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    protectionBtn.TextColor3 = Color3.new(1, 1, 1)
    protectionBtn.Font = Enum.Font.SourceSansBold
    protectionBtn.TextSize = 16
    protectionBtn.TextScaled = true
    protectionBtn.TextWrapped = true

    local function updateTargetPage()
        if targetedPlayer then
            local info = getPlayerInfo(targetedPlayer)
            targetProfileImage.Image = info.thumbnailUrl
            targetInfoLabel.Text = string.format(
                "معلومات اللاعب المستهدف:\n\nالاسم: %s\nاسم العرض: %s\nالمعرف: %d\nتاريخ الإنشاء: %s\nالموقع: %s",
                info.username, info.displayName, info.userId, info.creationDate, info.location
            )
        else
            targetProfileImage.Image = ""
            targetInfoLabel.Text = "لم يتم تحديد لاعب مستهدف بعد..."
        end
    end

    nameBox:GetPropertyChangedSignal("Text"):Connect(function()
        local playerNames = findPlayer(nameBox.Text)
        if #playerNames == 1 then
            targetedPlayer = Players:FindFirstChild(playerNames[1])
        else
            targetedPlayer = nil
        end
        updateTargetPage()
    end)

    local allCommands = {
        { cmd = "ice", args = "<player>", category = "playerOnly" },
        { cmd = "jice", args = "<player>", category = "playerOnly" },
        { cmd = "jail", args = "<player>", category = "playerOnly" },
        { cmd = "unjail", args = "<player>", category = "playerOnly" },
        { cmd = "buffify", args = "<player>", category = "playerOnly" },
        { cmd = "wormify", args = "<player>", category = "playerOnly" },
        { cmd = "chibify", args = "<player>", category = "playerOnly" },
        { cmd = "plushify", args = "<player>", category = "playerOnly" },
        { cmd = "freakify", args = "<player>", category = "playerOnly" },
        { cmd = "frogify", args = "<player>", category = "playerOnly" },
        { cmd = "spongify", args = "<player>", category = "playerOnly" },
        { cmd = "bigify", args = "<player>", category = "playerOnly" },
        { cmd = "creepify", args = "<player>", category = "playerOnly" },
        { cmd = "dinofy", args = "<player>", category = "playerOnly" },
        { cmd = "fatify", args = "<player>", category = "playerOnly" },
        { cmd = "glass", args = "<player>", category = "playerOnly" },
        { cmd = "neon", args = "<player>", category = "playerOnly" },
        { cmd = "shine", args = "<player>", category = "playerOnly" },
        { cmd = "ghost", args = "<player>", category = "playerOnly" },
        { cmd = "gold", args = "<player>", category = "playerOnly" },
        { cmd = "bigHead", args = "<player>", category = "playerOnly" },
        { cmd = "smallHead", args = "<player>", category = "playerOnly" },
        { cmd = "dwarf", args = "<player>", category = "playerOnly" },
        { cmd = "giantDwarf", args = "<player>", category = "playerOnly" },
        { cmd = "squash", args = "<player>", category = "playerOnly" },
        { cmd = "fat", args = "<player>", category = "playerOnly" },
        { cmd = "thin", args = "<player>", category = "playerOnly" },
        { cmd = "fire", args = "<player>", category = "playerOnly" },
        { cmd = "smoke", args = "<player>", category = "playerOnly" },
        { cmd = "sparkles", args = "<player>", category = "playerOnly" },
        { cmd = "jump", args = "<player>", category = "playerOnly" },
        { cmd = "sit", args = "<player>", category = "playerOnly" },
        { cmd = "invisible", args = "<player>", category = "playerOnly" },
        { cmd = "nightVision", args = "<player>", category = "playerOnly" },
        { cmd = "ping", args = "<player>", category = "playerOnly" },
        { cmd = "refresh", args = "<player>", category = "playerOnly" },
        { cmd = "jrespawn", args = "<player>", category = "playerOnly" },
        { cmd = "res", args = "<player>", category = "playerOnly" },
        { cmd = "clearHats", args = "<player>", category = "playerOnly" },
        { cmd = "warp", args = "<player>", category = "playerOnly" },
        { cmd = "hideGuis", args = "<player>", category = "playerOnly" },
        { cmd = "showGuis", args = "<player>", category = "playerOnly" },
        { cmd = "freeze", args = "<player>", category = "playerOnly" },
        { cmd = "hideName", args = "<player>", category = "playerOnly" },
        { cmd = "potatoHead", args = "<player>", category = "playerOnly" },
        { cmd = "forceField", args = "<player>", category = "playerOnly" },
        { cmd = "cmds", args = "<player>", category = "playerOnly" },
        { cmd = "view", args = "<player>", category = "playerOnly" },
        { cmd = "god", args = "<player>", category = "playerOnly" },
        { cmd = "kill", args = "<player>", category = "playerOnly" },
        { cmd = "handTo", args = "<player>", category = "playerOnly" },
        { cmd = "sword", args = "<player>", category = "playerOnly" },
        { cmd = "explode", args = "<player>", category = "playerOnly" },
        { cmd = "size", args = "<player> <scale3>", category = "withArgs" },
        { cmd = "hotDance", args = "<player> <speed>", category = "withArgs" },
        { cmd = "touchDance", args = "<player> <speed>", category = "withArgs" },
        { cmd = "feetDance", args = "<player> <speed>", category = "withArgs" },
        { cmd = "spin", args = "<player> <number>", category = "withArgs" },
        { cmd = "width", args = "<player> <scale2>", category = "withArgs" },
        { cmd = "paint", args = "<player> <color>", category = "withArgs" },
        { cmd = "material", args = "<player> <material>", category = "withArgs" },
        { cmd = "reflectance", args = "<player> <number>", category = "withArgs" },
        { cmd = "transparency", args = "<player> <number2>", category = "withArgs" },
        { cmd = "laserEyes", args = "<player> <color>", category = "withArgs" },
        { cmd = "shirt", args = "<player> <number>", category = "withArgs" },
        { cmd = "pants", args = "<player> <number>", category = "withArgs" },
        { cmd = "hat", args = "<player> <number>", category = "withArgs" },
        { cmd = "face", args = "<player> <number>", category = "withArgs" },
        { cmd = "head", args = "<player> <number>", category = "withArgs" },
        { cmd = "name", args = "<player> <text>", category = "withArgs" },
        { cmd = "bodyTypeScale", args = "<player> <scale>", category = "withArgs" },
        { cmd = "depth", args = "<player> <scale2>", category = "withArgs" },
        { cmd = "headSize", args = "<player> <scale2>", category = "withArgs" },
        { cmd = "height", args = "<player> <scale>", category = "withArgs" },
        { cmd = "hipHeight", args = "<player> <scale>", category = "withArgs" },
        { cmd = "char", args = "<player> <userId/username>", category = "withArgs" },
        { cmd = "morph", args = "<player> <morph>", category = "withArgs" },
        { cmd = "bundle", args = "<player> <number>", category = "withArgs" },
        { cmd = "damage", args = "<player> <number3>", category = "withArgs" },
        { cmd = "teleport", args = "<player> <individual>", category = "withArgs" },
        { cmd = "bring", args = "<player> <individual>", category = "withArgs" },
        { cmd = "to", args = "<player> <individual>", category = "withArgs" },
        { cmd = "apparate", args = "<player> <studs>", category = "withArgs" },
        { cmd = "title", args = "<player> <text>", category = "withArgs" },
        { cmd = "titleb", args = "<player> <text>", category = "withArgs" }
    }

    local function createCommandButton(cmdData, yOffset)
        local btnFrame = Instance.new("Frame", cmdFrame)
        btnFrame.Size = UDim2.new(1, 0, 0, 60)
        btnFrame.Position = UDim2.new(0, 0, 0, yOffset)
        btnFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        btnFrame.Name = cmdData.cmd

        local cmdText = Instance.new("TextLabel", btnFrame)
        cmdText.Size = UDim2.new(1, -10, 0, 30)
        cmdText.Position = UDim2.new(0, 5, 0, 0)
        cmdText.Text = ";" .. cmdData.cmd .. " " .. cmdData.args
        cmdText.TextColor3 = Color3.new(1, 1, 1)
        cmdText.TextSize = 14
        cmdText.TextXAlignment = Enum.TextXAlignment.Left
        cmdText.BackgroundTransparency = 1
        cmdText.TextScaled = true
        cmdText.TextWrapped = true

        local copyBtn = Instance.new("TextButton", btnFrame)
        copyBtn.Size = UDim2.new(0.2, 0, 0, 20)
        copyBtn.Position = UDim2.new(0, 5, 0, 35)
        copyBtn.Text = "نسخ"
        copyBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        copyBtn.TextColor3 = Color3.new(1, 1, 1)
        copyBtn.TextSize = 12
        copyBtn.TextScaled = true
        copyBtn.TextWrapped = true

        local favoriteBtn = Instance.new("TextButton", btnFrame)
        favoriteBtn.Size = UDim2.new(0.2, 0, 0, 20)
        favoriteBtn.Position = UDim2.new(0.25, 0, 0, 35)
        favoriteBtn.Text = "⭐"
        favoriteBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
        favoriteBtn.TextColor3 = Color3.new(1, 1, 1)
        favoriteBtn.TextSize = 12
        favoriteBtn.TextScaled = true
        favoriteBtn.TextWrapped = true

        local selectCmdBtn = Instance.new("TextButton", btnFrame)
        selectCmdBtn.Size = UDim2.new(0.2, 0, 0, 20)
        selectCmdBtn.Position = UDim2.new(0.5, 0, 0, 35)
        selectCmdBtn.Text = "+"
        selectCmdBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        selectCmdBtn.TextColor3 = Color3.new(1, 1, 1)
        selectCmdBtn.TextSize = 12
        selectCmdBtn.TextScaled = true
        selectCmdBtn.TextWrapped = true

        local isSelected = false
        local isFavorite = false

        for _, cmd in ipairs(selectedCommands) do
            if cmd.cmd == cmdData.cmd then
                isSelected = true
                selectCmdBtn.Text = "✔"
                selectCmdBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                break
            end
        end

        for _, cmd in ipairs(favoriteCommands) do
            if cmd.cmd == cmdData.cmd then
                isFavorite = true
                favoriteBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
                btnFrame.BackgroundColor3 = Color3.fromRGB(100, 75, 0)
                break
            end
        end

        selectCmdBtn.MouseButton1Click:Connect(function()
            isSelected = not isSelected
            if isSelected then
                selectCmdBtn.Text = "✔"
                selectCmdBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                table.insert(selectedCommands, cmdData)
            else
                selectCmdBtn.Text = "+"
                selectCmdBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                for i, cmd in ipairs(selectedCommands) do
                    if cmd.cmd == cmdData.cmd then
                        table.remove(selectedCommands, i)
                        break
                    end
                end
            end
        end)

        favoriteBtn.MouseButton1Click:Connect(function()
            isFavorite = not isFavorite
            if isFavorite then
                favoriteBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
                btnFrame.BackgroundColor3 = Color3.fromRGB(100, 75, 0)
                table.insert(favoriteCommands, cmdData)
            else
                favoriteBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
                btnFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                for i, cmd in ipairs(favoriteCommands) do
                    if cmd.cmd == cmdData.cmd then
                        table.remove(favoriteCommands, i)
                        break
                    end
                end
            end
        end)

        copyBtn.MouseButton1Click:Connect(function()
            local playerNames = findPlayer(nameBox.Text)
            local commandsToCopy = {}
            for _, playerName in ipairs(playerNames) do
                local cleanedPlayerName = cleanPlayerName(playerName)
                if cleanedPlayerName == "" then
                    continue
                end
                local commandText = ";" .. cmdData.cmd .. " " .. cleanedPlayerName
                if cmdData.category == "withArgs" then
                    local replacementText = ""
                    if string.find(cmdData.args, "<number") or string.find(cmdData.args, "<scale") then
                        replacementText = numberBox.Text
                    elseif string.find(cmdData.args, "<color") then
                        replacementText = colorBox.Text
                    elseif string.find(cmdData.args, "<text") or string.find(cmdData.args, "<material") then
                        replacementText = textBox.Text
                    end
                    if replacementText ~= "" then
                        commandText = string.gsub(commandText, "<[^>]+>", replacementText, 1)
                    end
                    if cmdData.cmd == "titleb" then
                        commandText = commandText .. string.rep(" ", 100) .. "ّ"
                    end
                end
                table.insert(commandsToCopy, commandText)
                wait(0.1)
            end
            local finalText = table.concat(commandsToCopy, "\n\n") .. "\n\n" .. string.rep(".", 500)
            copyToClipboard(finalText)
        end)

        return 70
    end

    local function displayCommands(commands)
        cmdFrame:ClearAllChildren()
        local yOffset = 0
        local playerOnlyCommands = {}
        local withArgsCommands = {}

        for _, cmd in ipairs(commands) do
            if cmd.category == "playerOnly" then
                table.insert(playerOnlyCommands, cmd)
            else
                table.insert(withArgsCommands, cmd)
            end
        end

        numberBox.Visible = #withArgsCommands > 0
        colorBox.Visible = #withArgsCommands > 0
        textBox.Visible = #withArgsCommands > 0

        if #playerOnlyCommands > 0 then
            local sectionLabel = Instance.new("TextLabel", cmdFrame)
            sectionLabel.Size = UDim2.new(1, 0, 0, 20)
            sectionLabel.Position = UDim2.new(0, 0, 0, yOffset)
            sectionLabel.Text = "الأوامر الي فيها اسم الاعب "
            sectionLabel.TextColor3 = Color3.new(1, 1, 1)
            sectionLabel.TextSize = 16
            sectionLabel.BackgroundTransparency = 1
            sectionLabel.TextScaled = true
            sectionLabel.TextWrapped = true
            yOffset = yOffset + 20

            for _, cmd in ipairs(playerOnlyCommands) do
                yOffset = yOffset + createCommandButton(cmd, yOffset)
                local divider = Instance.new("Frame", cmdFrame)
                divider.Size = UDim2.new(1, 0, 0, 1)
                divider.Position = UDim2.new(0, 0, 0, yOffset - 10)
                divider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                divider.BorderSizePixel = 0
            end
        end

        if #playerOnlyCommands > 0 and #withArgsCommands > 0 then
            local divider = Instance.new("Frame", cmdFrame)
            divider.Size = UDim2.new(1, 0, 0, 2)
            divider.Position = UDim2.new(0, 0, 0, yOffset)
            divider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            divider.BorderSizePixel = 0
            yOffset = yOffset + 10
        end

        if #withArgsCommands > 0 then
            local sectionLabel = Instance.new("TextLabel", cmdFrame)
            sectionLabel.Size = UDim2.new(1, 0, 0, 20)
            sectionLabel.Position = UDim2.new(0, 0, 0, yOffset)
            sectionLabel.Text = "الأوامر الي فيها ارقام الى اخره    "
            sectionLabel.TextColor3 = Color3.new(1, 1, 1)
            sectionLabel.TextSize = 16
            sectionLabel.BackgroundTransparency = 1
            sectionLabel.TextScaled = true
            sectionLabel.TextWrapped = true
            yOffset = yOffset + 20

            for _, cmd in ipairs(withArgsCommands) do
                yOffset = yOffset + createCommandButton(cmd, yOffset)
                local divider = Instance.new("Frame", cmdFrame)
                divider.Size = UDim2.new(1, 0, 0, 1)
                divider.Position = UDim2.new(0, 0, 0, yOffset - 10)
                divider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                divider.BorderSizePixel = 0
            end
        end

        cmdFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
    end

    displayCommands(allCommands)

    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local searchText = string.lower(searchBox.Text)
        if searchText == "" then
            displayCommands(allCommands)
            return
        end
        local filteredCommands = {}
        for _, cmd in ipairs(allCommands) do
            if string.lower(cmd.cmd):find(searchText) then
                table.insert(filteredCommands, cmd)
            end
        end
        displayCommands(filteredCommands)
    end)

    playerOnlyBtn.MouseButton1Click:Connect(function()
        local filteredCommands = {}
        for _, cmd in ipairs(allCommands) do
            if cmd.category == "playerOnly" then
                table.insert(filteredCommands, cmd)
            end
        end
        displayCommands(filteredCommands)
    end)

    withArgsBtn.MouseButton1Click:Connect(function()
        local filteredCommands = {}
        for _, cmd in ipairs(allCommands) do
            if cmd.category == "withArgs" then
                table.insert(filteredCommands, cmd)
            end
        end
        displayCommands(filteredCommands)
    end)

    favoritesBtn.MouseButton1Click:Connect(function()
        if #favoriteCommands == 0 then
            copyToClipboard("لا توجد أوامر مفضلة!")
            return
        end
        displayCommands(favoriteCommands)
    end)

    selectBtn.MouseButton1Click:Connect(function()
        displayCommands(allCommands)
    end)

    selectAllBtn.MouseButton1Click:Connect(function()
        local allPlayers = getAllPlayers()
        if allPlayers == "" then
            copyToClipboard("لا يوجد لاعبون في السيرفر!")
            return
        end
        nameBox.Text = allPlayers
        copyToClipboard("تم تحديد جميع اللاعبين: " .. allPlayers)
    end)

    clearAllPlayersBtn.MouseButton1Click:Connect(function()
        nameBox.Text = player.Name
        copyToClipboard("تم إلغاء تحديد جميع اللاعبين")
    end)

    copySelectedBtn.MouseButton1Click:Connect(function()
        if #selectedCommands == 0 then
            copyToClipboard("لم يتم تحديد أي أوامر!")
            return
        end
        local playerNames = findPlayer(nameBox.Text)
        local combinedCommands = {}
        for _, cmdData in ipairs(selectedCommands) do
            for _, playerName in ipairs(playerNames) do
                local cleanedPlayerName = cleanPlayerName(playerName)
                if cleanedPlayerName == "" then
                    continue
                end
                local commandText = ";" .. cmdData.cmd .. " " .. cleanedPlayerName
                if cmdData.category == "withArgs" then
                    local replacementText = ""
                    if string.find(cmdData.args, "<number") or string.find(cmdData.args, "<scale") then
                        replacementText = numberBox.Text
                    elseif string.find(cmdData.args, "<color") then
                        replacementText = colorBox.Text
                    elseif string.find(cmdData.args, "<text") or string.find(cmdData.args, "<material") then
                        replacementText = textBox.Text
                    end
                    if replacementText ~= "" then
                        commandText = string.gsub(commandText, "<[^>]+>", replacementText, 1)
                    end
                    if cmdData.cmd == "titleb" then
                        commandText = commandText .. string.rep(" ", 100) .. "ّ"
                    end
                end
                table.insert(combinedCommands, commandText)
                wait(0.1)
            end
        end
        local finalText = table.concat(combinedCommands, "\n\n") .. "\n\n" .. string.rep(".", 500)
        copyToClipboard(finalText)
    end)

    clearSelectionBtn.MouseButton1Click:Connect(function()
        for _, child in ipairs(cmdFrame:GetChildren()) do
            if child:IsA("Frame") then
                local isFavorite = false
                for _, favCmd in ipairs(favoriteCommands) do
                    if favCmd.cmd == child.Name then
                        isFavorite = true
                        break
                    end
                end
                child.BackgroundColor3 = isFavorite and Color3.fromRGB(100, 75, 0) or Color3.fromRGB(45, 45, 45)
                local selectBtn = child:FindFirstChildWhichIsA("TextButton")
                if selectBtn and (selectBtn.Text == "+" or selectBtn.Text == "✔") then
                    selectBtn.Text = "+"
                    selectBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                end
            end
        end
        selectedCommands = {}
    end)

    local function showPage(page)
        commandsPage.Visible = (page == commandsPage)
        targetPage.Visible = (page == targetPage)
        protectionPage.Visible = (page == protectionPage)
        spamPage.Visible = (page == spamPage)
        infoPage.Visible = (page == infoPage)
        targetPageBtn.BackgroundColor3 = (page == targetPage) and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(60, 60, 60)
        protectionPageBtn.BackgroundColor3 = (page == protectionPage) and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(60, 60, 60)
        spamPageBtn.BackgroundColor3 = (page == spamPage) and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(60, 60, 60)
        commandsPageBtn.BackgroundColor3 = (page == commandsPage) and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(60, 60, 60)
        infoPageBtn.BackgroundColor3 = (page == infoPage) and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(60, 60, 60)
    end

    targetPageBtn.MouseButton1Click:Connect(function()
        showPage(targetPage)
    end)

    protectionPageBtn.MouseButton1Click:Connect(function()
        showPage(protectionPage)
    end)

    spamPageBtn.MouseButton1Click:Connect(function()
        showPage(spamPage)
    end)

    commandsPageBtn.MouseButton1Click:Connect(function()
        showPage(commandsPage)
    end)

    infoPageBtn.MouseButton1Click:Connect(function()
        showPage(infoPage)
    end)

    espBtn.MouseButton1Click:Connect(function()
        if not targetedPlayer then
            copyToClipboard("لم يتم تحديد لاعب مستهدف!")
            return
        end
        espEnabled = not espEnabled
        espBtn.Text = espEnabled and "إيقاف ESP" or "تفعيل ESP"
        espBtn.BackgroundColor3 = espEnabled and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(0, 150, 0)
        toggleESP(targetedPlayer, espEnabled)
    end)

    spamBtn.MouseButton1Click:Connect(function()
        spamEnabled = not spamEnabled
        spamBtn.Text = spamEnabled and "إيقاف الارسال" or "تفعيل الارسال"
        spamBtn.BackgroundColor3 = spamEnabled and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(0, 150, 0)
        if spamEnabled then
            local message = spamTextBox.Text
            if message == "" then
                copyToClipboard("يرجى إدخال النص (الصق الامر الي نسخته هنا) !")
                spamEnabled = false
                spamBtn.Text = "تفعيل الارسال"
                spamBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                return
            end
            spamThread = coroutine.create(function()
                while spamEnabled do
                    sendMessageToChat(message)
                    wait(0.5)
                end
            end)
            coroutine.resume(spamThread)
        else
            spamThread = nil
        end
    end)

    protectionBtn.MouseButton1Click:Connect(function()
        protectionEnabled = not protectionEnabled
        protectionBtn.Text = protectionEnabled and "إيقاف الحماية" or "تفعيل الحماية"
        protectionBtn.BackgroundColor3 = protectionEnabled and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(0, 150, 0)
        toggleProtection(protectionEnabled)
    end)

    hideBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        local reopenBtn = Instance.new("TextButton", screenGui)
        reopenBtn.Size = UDim2.new(0, 50, 0, 50)
        reopenBtn.Position = UDim2.new(0, 10, 0, 10)
        reopenBtn.Text = "↖"
        reopenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        reopenBtn.TextColor3 = Color3.new(1, 1, 1)
        reopenBtn.Font = Enum.Font.SourceSansBold
        reopenBtn.TextSize = 20
        reopenBtn.MouseButton1Click:Connect(function()
            mainFrame.Visible = true
            reopenBtn:Destroy()
        end)
    end)
end

createGUI()
