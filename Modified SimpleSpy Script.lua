-- SimpleSpy v2.2 (Modified to reduce detection risks)

-- shuts down the previous instance of SimpleSpy
if _G.SimpleSpyExecuted and type(_G.SimpleSpyShutdown) == "function" then
    print(pcall(_G.SimpleSpyShutdown))
end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local Highlight = loadstring(game:HttpGet("https://github.com/exxtremestuffs/SimpleSpySource/raw/master/highlight.lua"))()

-- GUI setup
local SimpleSpy2 = Instance.new("ScreenGui")
local Background = Instance.new("Frame")
local LeftPanel = Instance.new("Frame")
local LogList = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local RemoteTemplate = Instance.new("Frame")
local ColorBar = Instance.new("Frame")
local Text = Instance.new("TextLabel")
local Button = Instance.new("TextButton")
local RightPanel = Instance.new("Frame")
local CodeBox = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIGridLayout = Instance.new("UIGridLayout")
local FunctionTemplate = Instance.new("Frame")
local ColorBar_2 = Instance.new("Frame")
local Text_2 = Instance.new("TextLabel")
local Button_2 = Instance.new("TextButton")
local TopBar = Instance.new("Frame")
local Simple = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local ImageLabel = Instance.new("ImageLabel")
local MaximizeButton = Instance.new("TextButton")
local ImageLabel_2 = Instance.new("ImageLabel")
local MinimizeButton = Instance.new("TextButton")
local ImageLabel_3 = Instance.new("ImageLabel")
local ToolTip = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")

-- Properties
SimpleSpy2.Name = "SimpleSpy2"
SimpleSpy2.ResetOnSpawn = false

Background.Name = "Background"
Background.Parent = SimpleSpy2
Background.BackgroundColor3 = Color3.new(1, 1, 1)
Background.BackgroundTransparency = 1
Background.Position = UDim2.new(0, 500, 0, 200)
Background.Size = UDim2.new(0, 450, 0, 268)

LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = Background
LeftPanel.BackgroundColor3 = Color3.fromRGB(53, 52, 55)
LeftPanel.BorderSizePixel = 0
LeftPanel.Position = UDim2.new(0, 0, 0, 19)
LeftPanel.Size = UDim2.new(0, 131, 0, 249)

LogList.Name = "LogList"
LogList.Parent = LeftPanel
LogList.Active = true
LogList.BackgroundColor3 = Color3.new(1, 1, 1)
LogList.BackgroundTransparency = 1
LogList.BorderSizePixel = 0
LogList.Position = UDim2.new(0, 0, 0, 9)
LogList.Size = UDim2.new(0, 131, 0, 232)
LogList.CanvasSize = UDim2.new(0, 0, 0, 0)
LogList.ScrollBarThickness = 4

UIListLayout.Parent = LogList
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

RemoteTemplate.Name = "RemoteTemplate"
RemoteTemplate.Parent = LogList
RemoteTemplate.BackgroundColor3 = Color3.new(1, 1, 1)
RemoteTemplate.BackgroundTransparency = 1
RemoteTemplate.Size = UDim2.new(0, 117, 0, 27)

ColorBar.Name = "ColorBar"
ColorBar.Parent = RemoteTemplate
ColorBar.BackgroundColor3 = Color3.fromRGB(255, 242, 0)
ColorBar.BorderSizePixel = 0
ColorBar.Position = UDim2.new(0, 0, 0, 1)
ColorBar.Size = UDim2.new(0, 7, 0, 18)
ColorBar.ZIndex = 2

Text.Name = "Text"
Text.Parent = RemoteTemplate
Text.BackgroundColor3 = Color3.new(1, 1, 1)
Text.BackgroundTransparency = 1
Text.Position = UDim2.new(0, 12, 0, 1)
Text.Size = UDim2.new(0, 105, 0, 18)
Text.ZIndex = 2
Text.Font = Enum.Font.SourceSans
Text.Text = "TEXT"
Text.TextColor3 = Color3.new(1, 1, 1)
Text.TextSize = 14
Text.TextXAlignment = Enum.TextXAlignment.Left
Text.TextWrapped = true

Button.Name = "Button"
Button.Parent = RemoteTemplate
Button.BackgroundColor3 = Color3.new(0, 0, 0)
Button.BackgroundTransparency = 0.75
Button.BorderColor3 = Color3.new(1, 1, 1)
Button.Position = UDim2.new(0, 0, 0, 1)
Button.Size = UDim2.new(0, 117, 0, 18)
Button.AutoButtonColor = false
Button.Font = Enum.Font.SourceSans
Button.Text = ""
Button.TextColor3 = Color3.new(0, 0, 0)
Button.TextSize = 14

RightPanel.Name = "RightPanel"
RightPanel.Parent = Background
RightPanel.BackgroundColor3 = Color3.fromRGB(37, 36, 38)
RightPanel.BorderSizePixel = 0
RightPanel.Position = UDim2.new(0, 131, 0, 19)
RightPanel.Size = UDim2.new(0, 319, 0, 249)

CodeBox.Name = "CodeBox"
CodeBox.Parent = RightPanel
CodeBox.BackgroundColor3 = Color3.new(0.0823529, 0.0745098, 0.0784314)
CodeBox.BorderSizePixel = 0
CodeBox.Size = UDim2.new(0, 319, 0, 119)

ScrollingFrame.Parent = RightPanel
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Position = UDim2.new(0, 0, 0.5, 0)
ScrollingFrame.Size = UDim2.new(1, 0, 0.5, -9)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 4

UIGridLayout.Parent = ScrollingFrame
UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
UIGridLayout.CellSize = UDim2.new(0, 94, 0, 27)

FunctionTemplate.Name = "FunctionTemplate"
FunctionTemplate.Parent = ScrollingFrame
FunctionTemplate.BackgroundColor3 = Color3.new(1, 1, 1)
FunctionTemplate.BackgroundTransparency = 1
FunctionTemplate.Size = UDim2.new(0, 117, 0, 23)

ColorBar_2.Name = "ColorBar"
ColorBar_2.Parent = FunctionTemplate
ColorBar_2.BackgroundColor3 = Color3.new(1, 1, 1)
ColorBar_2.BorderSizePixel = 0
ColorBar_2.Position = UDim2.new(0, 7, 0, 10)
ColorBar_2.Size = UDim2.new(0, 7, 0, 18)
ColorBar_2.ZIndex = 3

Text_2.Name = "Text"
Text_2.Parent = FunctionTemplate
Text_2.BackgroundColor3 = Color3.new(1, 1, 1)
Text_2.BackgroundTransparency = 1
Text_2.Position = UDim2.new(0, 19, 0, 10)
Text_2.Size = UDim2.new(0, 69, 0, 18)
Text_2.ZIndex = 2
Text_2.Font = Enum.Font.SourceSans
Text_2.Text = "TEXT"
Text_2.TextColor3 = Color3.new(1, 1, 1)
Text_2.TextSize = 14
Text_2.TextStrokeColor3 = Color3.new(0.145098, 0.141176, 0.14902)
Text_2.TextXAlignment = Enum.TextXAlignment.Left
Text_2.TextWrapped = true

Button_2.Name = "Button"
Button_2.Parent = FunctionTemplate
Button_2.BackgroundColor3 = Color3.new(0, 0, 0)
Button_2.BackgroundTransparency = 0.69999998807907
Button_2.BorderColor3 = Color3.new(1, 1, 1)
Button_2.Position = UDim2.new(0, 7, 0, 10)
Button_2.Size = UDim2.new(0, 80, 0, 18)
Button_2.AutoButtonColor = false
Button_2.Font = Enum.Font.SourceSans
Button_2.Text = ""
Button_2.TextColor3 = Color3.new(0, 0, 0)
Button_2.TextSize = 14

TopBar.Name = "TopBar"
TopBar.Parent = Background
TopBar.BackgroundColor3 = Color3.fromRGB(37, 35, 38)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(0, 450, 0, 19)

Simple.Name = "Simple"
Simple.Parent = TopBar
Simple.BackgroundColor3 = Color3.new(1, 1, 1)
Simple.AutoButtonColor = false
Simple.BackgroundTransparency = 1
Simple.Position = UDim2.new(0, 5, 0, 0)
Simple.Size = UDim2.new(0, 57, 0, 18)
Simple.Font = Enum.Font.SourceSansBold
Simple.Text = "SimpleSpy"
Simple.TextColor3 = Color3.new(1, 1, 1)
Simple.TextSize = 14
Simple.TextXAlignment = Enum.TextXAlignment.Left

CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundColor3 = Color3.new(0.145098, 0.141176, 0.14902)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -19, 0, 0)
CloseButton.Size = UDim2.new(0, 19, 0, 19)
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Text = ""
CloseButton.TextColor3 = Color3.new(0, 0, 0)
CloseButton.TextSize = 14

ImageLabel.Parent = CloseButton
ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel.BackgroundTransparency = 1
ImageLabel.Position = UDim2.new(0, 5, 0, 5)
ImageLabel.Size = UDim2.new(0, 9, 0, 9)
ImageLabel.Image = "http://www.roblox.com/asset/?id=5597086202"

MaximizeButton.Name = "MaximizeButton"
MaximizeButton.Parent = TopBar
MaximizeButton.BackgroundColor3 = Color3.new(0.145098, 0.141176, 0.14902)
MaximizeButton.BorderSizePixel = 0
MaximizeButton.Position = UDim2.new(1, -38, 0, 0)
MaximizeButton.Size = UDim2.new(0, 19, 0, 19)
MaximizeButton.Font = Enum.Font.SourceSans
MaximizeButton.Text = ""
MaximizeButton.TextColor3 = Color3.new(0, 0, 0)
MaximizeButton.TextSize = 14

ImageLabel_2.Parent = MaximizeButton
ImageLabel_2.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel_2.BackgroundTransparency = 1
ImageLabel_2.Position = UDim2.new(0, 5, 0, 5)
ImageLabel_2.Size = UDim2.new(0, 9, 0, 9)
ImageLabel_2.Image = "http://www.roblox.com/asset/?id=5597108117"

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TopBar
MinimizeButton.BackgroundColor3 = Color3.new(0.145098, 0.141176, 0.14902)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -57, 0, 0)
MinimizeButton.Size = UDim2.new(0, 19, 0, 19)
MinimizeButton.Font = Enum.Font.SourceSans
MinimizeButton.Text = ""
MinimizeButton.TextColor3 = Color3.new(0, 0, 0)
MinimizeButton.TextSize = 14

ImageLabel_3.Parent = MinimizeButton
ImageLabel_3.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel_3.BackgroundTransparency = 1
ImageLabel_3.Position = UDim2.new(0, 5, 0, 5)
ImageLabel_3.Size = UDim2.new(0, 9, 0, 9)
ImageLabel_3.Image = "http://www.roblox.com/asset/?id=5597105827"

ToolTip.Name = "ToolTip"
ToolTip.Parent = SimpleSpy2
ToolTip.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
ToolTip.BackgroundTransparency = 0.1
ToolTip.BorderColor3 = Color3.new(1, 1, 1)
ToolTip.Size = UDim2.new(0, 200, 0, 50)
ToolTip.ZIndex = 3
ToolTip.Visible = false

TextLabel.Parent = ToolTip
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0, 2, 0, 2)
TextLabel.Size = UDim2.new(0, 196, 0, 46)
TextLabel.ZIndex = 3
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "This is some slightly longer text."
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.TextSize = 14
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.TextYAlignment = Enum.TextYAlignment.Top

-- init
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local TextService = game:GetService("TextService")
local Mouse

local selectedColor = Color3.new(0.321569, 0.333333, 1)
local deselectedColor = Color3.new(0.8, 0.8, 0.8)
local layoutOrderNum = 999999999
local mainClosing = false
local closed = false
local sideClosing = false
local sideClosed = false
local maximized = false
local logs = {}
local selected = nil
local blacklist = {}
local blocklist = {}
local getNil = false
local connectedRemotes = {}
local toggle = false
local gm
local original
local prevTables = {}
local remoteLogs = {}
local remoteEvent = Instance.new("RemoteEvent")
local remoteFunction = Instance.new("RemoteFunction")
local originalEvent = remoteEvent.FireServer
local originalFunction = remoteFunction.InvokeServer
_G.SIMPLESPYCONFIG_MaxRemotes = 500
local indent = 4
local scheduled = {}
local schedulerconnect
local SimpleSpy = {}
local topstr = ""
local bottomstr = ""
local remotesFadeIn
local rightFadeIn
local codebox
local p
local getnilrequired = false
local autoblock = false
local history = {}
local excluding = {}
local funcEnabled = true
local remoteSignals = {}
local remoteHooks = {}
local oldIcon
local mouseInGui = false
local connections = {}
local useGetCallingScript = false
local keyToString = false
local recordReturnValues = false

-- Exclusion list for remotes that might be used by Anti-Cheat
local excludeRemotes = {
    "namecallinstance",
    "antiCheat",
    "security",
}

-- SimpleSpy functions
function SimpleSpy:ArgsToString(method, args)
    assert(typeof(method) == "string", "string expected, got " .. typeof(method))
    assert(typeof(args) == "table", "table expected, got " .. typeof(args))
    return v2v({ args = args }) .. "\n\n" .. method .. "(unpack(args))"
end

function SimpleSpy:TableToVars(t)
    assert(typeof(t) == "table", "table expected, got " .. typeof(t))
    return v2v(t)
end

function SimpleSpy:ValueToVar(value, variablename)
    assert(variablename == nil or typeof(variablename) == "string", "string expected, got " .. typeof(variablename))
    if not variablename then
        variablename = 1
    end
    return v2v({ [variablename] = value })
end

function SimpleSpy:ValueToString(value)
    return v2s(value)
end

function SimpleSpy:GetFunctionInfo(func)
    assert(typeof(func) == "function", "Instance expected, got " .. typeof(func))
    warn("Function info currently unavailable due to crashing in Synapse X")
    return v2v({ functionInfo = {
        info = debug.getinfo(func),
        constants = debug.getconstants(func),
    } })
end

function SimpleSpy:GetRemoteFiredSignal(remote)
    assert(typeof(remote) == "Instance", "Instance expected, got " .. typeof(remote))
    if not remoteSignals[remote] then
        remoteSignals[remote] = newSignal()
    end
    return remoteSignals[remote]
end

function SimpleSpy:HookRemote(remote, f)
    assert(typeof(remote) == "Instance", "Instance expected, got " .. typeof(remote))
    assert(typeof(f) == "function", "function expected, got " .. typeof(f))
    remoteHooks[remote] = f
    warn("Hooking remotes can be risky and may lead to detection!")
end

function SimpleSpy:BlockRemote(remote)
    assert(typeof(remote) == "Instance" or typeof(remote) == "string", "Instance | string expected, got " .. typeof(remote))
    blocklist[remote] = true
end

function SimpleSpy:ExcludeRemote(remote)
    assert(typeof(remote) == "Instance" or typeof(remote) == "string", "Instance | string expected, got " .. typeof(remote))
    blacklist[remote] = true
end

function newSignal()
    local connected = {}
    return {
        Connect = function(self, f)
            assert(connected, "Signal is closed")
            connected[tostring(f)] = f
            return {
                Connected = true,
                Disconnect = function(self)
                    if not connected then
                        warn("Signal is already closed")
                    end
                    self.Connected = false
                    connected[tostring(f)] = nil
                end,
            }
        end,
        Wait = function(self)
            local thread = coroutine.running()
            local connection
            connection = self:Connect(function()
                connection:Disconnect()
                if coroutine.status(thread) == "suspended" then
                    coroutine.resume(thread)
                end
            end)
            coroutine.yield()
        end,
        Fire = function(self, ...)
            for _, f in pairs(connected) do
                coroutine.wrap(f)(...)
            end
        end,
    }
end

function clean()
    local max = _G.SIMPLESPYCONFIG_MaxRemotes
    if not typeof(max) == "number" and math.floor(max) ~= max then
        max = 500
    end
    if #remoteLogs > max then
        for i = 100, #remoteLogs do
            local v = remoteLogs[i]
            if typeof(v[1]) == "RBXScriptConnection" then
                v[1]:Disconnect()
            end
            if typeof(v[2]) == "Instance" then
                v[2]:Destroy()
            end
        end
        local newLogs = {}
        for i = 1, 100 do
            table.insert(newLogs, remoteLogs[i])
        end
        remoteLogs = newLogs
    end
end

function scaleToolTip()
    local size = TextService:GetTextSize(TextLabel.Text, TextLabel.TextSize, TextLabel.Font, Vector2.new(196, math.huge))
    TextLabel.Size = UDim2.new(0, size.X, 0, size.Y)
    ToolTip.Size = UDim2.new(0, size.X + 4, 0, size.Y + 4)
end

function onToggleButtonHover()
    if not toggle then
        TweenService:Create(Simple, TweenInfo.new(0.5), { TextColor3 = Color3.fromRGB(252, 51, 51) }):Play()
    else
        TweenService:Create(Simple, TweenInfo.new(0.5), { TextColor3 = Color3.fromRGB(68, 206, 91) }):Play()
    end
end

function onToggleButtonUnhover()
    TweenService:Create(Simple, TweenInfo.new(0.5), { TextColor3 = Color3.fromRGB(255, 255, 255) }):Play()
end

function onXButtonHover()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(255, 60, 60) }):Play()
end

function onXButtonUnhover()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(37, 36, 38) }):Play()
end

function onToggleButtonClick()
    if toggle then
        TweenService:Create(Simple, TweenInfo.new(0.5), { TextColor3 = Color3.fromRGB(252, 51, 51) }):Play()
    else
        TweenService:Create(Simple, TweenInfo.new(0.5), { TextColor3 = Color3.fromRGB(68, 206, 91) }):Play()
    end
    toggleSpy()
end

function connectResize()
    local lastCam = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(bringBackOnResize)
    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        lastCam:Disconnect()
        if workspace.CurrentCamera then
            lastCam = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(bringBackOnResize)
        end
    end)
end

function bringBackOnResize()
    validateSize()
    if sideClosed then
        minimizeSize()
    else
        maximizeSize()
    end
    local currentX = Background.AbsolutePosition.X
    local currentY = Background.AbsolutePosition.Y
    local viewportSize = workspace.CurrentCamera.ViewportSize
    if (currentX < 0) or (currentX > (viewportSize.X - (sideClosed and 131 or Background.AbsoluteSize.X))) then
        if currentX < 0 then
            currentX = 0
        else
            currentX = viewportSize.X - (sideClosed and 131 or Background.AbsoluteSize.X)
        end
    end
    if (currentY < 0) or (currentY > (viewportSize.Y - (closed and 19 or Background.AbsoluteSize.Y) - 36)) then
        if currentY < 0 then
            currentY = 0
        else
            currentY = viewportSize.Y - (closed and 19 or Background.AbsoluteSize.Y) - 36
        end
    end
    TweenService.Create(TweenService, Background, TweenInfo.new(0.1), { Position = UDim2.new(0, currentX, 0, currentY) }):Play()
end

function onBarInput(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local lastPos = UserInputService.GetMouseLocation(UserInputService)
        local mainPos = Background.AbsolutePosition
        local offset = mainPos - lastPos
        local currentPos = offset + lastPos
        RunService.BindToRenderStep(RunService, "drag", 1, function()
            local newPos = UserInputService.GetMouseLocation(UserInputService)
            if newPos ~= lastPos then
                local currentX = (offset + newPos).X
                local currentY = (offset + newPos).Y
                local viewportSize = workspace.CurrentCamera.ViewportSize
                if (currentX < 0 and currentX < currentPos.X) or (currentX > (viewportSize.X - (sideClosed and 131 or TopBar.AbsoluteSize.X)) and currentX > currentPos.X) then
                    if currentX < 0 then
                        currentX = 0
                    else
                        currentX = viewportSize.X - (sideClosed and 131 or TopBar.AbsoluteSize.X)
                    end
                end
                if (currentY < 0 and currentY < currentPos.Y) or (currentY > (viewportSize.Y - (closed and 19 or Background.AbsoluteSize.Y) - 36) and currentY > currentPos.Y) then
                    if currentY < 0 then
                        currentY = 0
                    else
                        currentY = viewportSize.Y - (closed and 19 or Background.AbsoluteSize.Y) - 36
                    end
                end
                currentPos = Vector2.new(currentX, currentY)
                lastPos = newPos
                TweenService.Create(TweenService, Background, TweenInfo.new(0.1), { Position = UDim2.new(0, currentPos.X, 0, currentPos.Y) }):Play()
            end
        end)
        table.insert(connections, UserInputService.InputEnded:Connect(function(inputE)
            if input == inputE then
                RunService:UnbindFromRenderStep("drag")
            end
        end))
    end
end

function fadeOut(elements)
    local data = {}
    for _, v in pairs(elements) do
        if typeof(v) == "Instance" and v:IsA("GuiObject") and v.Visible then
            coroutine.wrap(function()
                data[v] = {
                    BackgroundTransparency = v.BackgroundTransparency,
                }
                TweenService:Create(v, TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
                if v:IsA("TextBox") or v:IsA("TextButton") or v:IsA("TextLabel") then
                    data[v].TextTransparency = v.TextTransparency
                    TweenService:Create(v, TweenInfo.new(0.5), { TextTransparency = 1 }):Play()
                elseif v:IsA("ImageButton") or v:IsA("ImageLabel") then
                    data[v].ImageTransparency = v.ImageTransparency
                    TweenService:Create(v, TweenInfo.new(0.5), { ImageTransparency = 1 }):Play()
                end
                wait(0.5)
                v.Visible = false
                for i, x in pairs(data[v]) do
                    v[i] = x
                end
                data[v] = true
            end)()
        end
    end
    return function()
        for i, _ in pairs(data) do
            coroutine.wrap(function()
                local properties = {
                    BackgroundTransparency = i.BackgroundTransparency,
                }
                i.BackgroundTransparency = 1
                TweenService:Create(i, TweenInfo.new(0.5), { BackgroundTransparency = properties.BackgroundTransparency }):Play()
                if i:IsA("TextBox") or i:IsA("TextButton") or i:IsA("TextLabel") then
                    properties.TextTransparency = i.TextTransparency
                    i.TextTransparency = 1
                    TweenService:Create(i, TweenInfo.new(0.5), { TextTransparency = properties.TextTransparency }):Play()
                elseif i:IsA("ImageButton") or i:IsA("ImageLabel") then
                    properties.ImageTransparency = i.ImageTransparency
                    i.ImageTransparency = 1
                    TweenService:Create(i, TweenInfo.new(0.5), { ImageTransparency = properties.ImageTransparency }):Play()
                end
                i.Visible = true
            end)()
        end
    end
end

function toggleMinimize(override)
    if mainClosing and not override or maximized then
        return
    end
    mainClosing = true
    closed = not closed
    if closed then
        if not sideClosed then
            toggleSideTray(true)
        end
        LeftPanel.Visible = true
        TweenService:Create(LeftPanel, TweenInfo.new(0.5), { Size = UDim2.new(0, 131, 0, 0) }):Play()
        wait(0.5)
        remotesFadeIn = fadeOut(LeftPanel:GetDescendants())
        wait(0.5)
    else
        TweenService:Create(LeftPanel, TweenInfo.new(0.5), { Size = UDim2.new(0, 131, 0, 249) }):Play()
        wait(0.5)
        if remotesFadeIn then
            remotesFadeIn()
            remotesFadeIn = nil
        end
        bringBackOnResize()
    end
    mainClosing = false
end

function toggleSideTray(override)
    if sideClosing and not override or maximized then
        return
    end
    sideClosing = true
    sideClosed = not sideClosed
    if sideClosed then
        rightFadeIn = fadeOut(RightPanel:GetDescendants())
        wait(0.5)
        minimizeSize(0.5)
        wait(0.5)
        RightPanel.Visible = false
    else
        if closed then
            toggleMinimize(true)
        end
        RightPanel.Visible = true
        maximizeSize(0.5)
        wait(0.5)
        if rightFadeIn then
            rightFadeIn()
        end
        bringBackOnResize()
    end
    sideClosing = false
end

function toggleMaximize()
    if not sideClosed and not maximized then
        maximized = true
        local disable = Instance.new("TextButton")
        local prevSize = UDim2.new(0, CodeBox.AbsoluteSize.X, 0, CodeBox.AbsoluteSize.Y)
        local prevPos = UDim2.new(0, CodeBox.AbsolutePosition.X, 0, CodeBox.AbsolutePosition.Y)
        disable.Size = UDim2.new(1, 0, 1, 0)
        disable.BackgroundColor3 = Color3.new()
        disable.BorderSizePixel = 0
        disable.Text = 0
        disable.ZIndex = 3
        disable.BackgroundTransparency = 1
        disable.AutoButtonColor = false
        CodeBox.ZIndex = 4
        CodeBox.Position = prevPos
        CodeBox.Size = prevSize
        TweenService:Create(CodeBox, TweenInfo.new(0.5), { Size = UDim2.new(0.5, 0, 0.5, 0), Position = UDim2.new(0.25, 0, 0.25, 0) }):Play()
        TweenService:Create(disable, TweenInfo.new(0.5), { BackgroundTransparency = 0.5 }):Play()
        disable.MouseButton1Click:Connect(function()
            if UserInputService:GetMouseLocation().Y + 36 >= CodeBox.AbsolutePosition.Y and UserInputService:GetMouseLocation().Y + 36 <= CodeBox.AbsolutePosition.Y + CodeBox.AbsoluteSize.Y and UserInputService:GetMouseLocation().X >= CodeBox.AbsolutePosition.X and UserInputService:GetMouseLocation().X <= CodeBox.AbsolutePosition.X + CodeBox.AbsoluteSize.X then
                return
            end
            TweenService:Create(CodeBox, TweenInfo.new(0.5), { Size = prevSize, Position = prevPos }):Play()
            TweenService:Create(disable, TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
            maximized = false
            wait(0.5)
            disable:Destroy()
            CodeBox.Size = UDim2.new(1, 0, 0.5, 0)
            CodeBox.Position = UDim2.new(0, 0, 0, 0)
            CodeBox.ZIndex = 0
        end)
    end
end

function isInResizeRange(p)
    local relativeP = p - Background.AbsolutePosition
    local range = 5
    if relativeP.X >= TopBar.AbsoluteSize.X - range and relativeP.Y >= Background.AbsoluteSize.Y - range and relativeP.X <= TopBar.AbsoluteSize.X and relativeP.Y <= Background.AbsoluteSize.Y then
        return true, "B"
    elseif relativeP.X >= TopBar.AbsoluteSize.X - range and relativeP.X <= Background.AbsoluteSize.X then
        return true, "X"
    elseif relativeP.Y >= Background.AbsoluteSize.Y - range and relativeP.Y <= Background.AbsoluteSize.Y then
        return true, "Y"
    end
    return false
end

function isInDragRange(p)
    local relativeP = p - Background.AbsolutePosition
    if relativeP.X <= TopBar.AbsoluteSize.X - CloseButton.AbsoluteSize.X * 3 and relativeP.X >= 0 and relativeP.Y <= TopBar.AbsoluteSize.Y and relativeP.Y >= 0 then
        return true
    end
    return false
end

function mouseEntered()
    local existingCursor = SimpleSpy2:FindFirstChild("Cursor")
    while existingCursor do
        existingCursor:Destroy()
        existingCursor = SimpleSpy2:FindFirstChild("Cursor")
    end
    local customCursor = Instance.new("ImageLabel")
    customCursor.Name = "Cursor"
    customCursor.Size = UDim2.fromOffset(200, 200)
    customCursor.ZIndex = 1e5
    customCursor.BackgroundTransparency = 1
    customCursor.Image = ""
    customCursor.Parent = SimpleSpy2
    UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
    RunService:BindToRenderStep("SIMPLESPY_CURSOR", 1, function()
        if mouseInGui and _G.SimpleSpyExecuted then
            local mouseLocation = UserInputService:GetMouseLocation() - Vector2.new(0, 36)
            customCursor.Position = UDim2.fromOffset(mouseLocation.X - customCursor.AbsoluteSize.X / 2, mouseLocation.Y - customCursor.AbsoluteSize.Y / 2)
            local inRange, type = isInResizeRange(mouseLocation)
            if inRange and not sideClosed and not closed then
                customCursor.Image = type == "B" and "rbxassetid://6065821980" or type == "X" and "rbxassetid://6065821086" or type == "Y" and "rbxassetid://6065821596"
            elseif inRange and not closed and type == "Y" or type == "B" then
                customCursor.Image = "rbxassetid://6065821596"
            elseif customCursor.Image ~= "rbxassetid://6065775281" then
                customCursor.Image = "rbxassetid://6065775281"
            end
        else
            UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None
            customCursor:Destroy()
            RunService:UnbindFromRenderStep("SIMPLESPY_CURSOR")
        end
    end)
end

function mouseMoved()
    local mousePos = UserInputService:GetMouseLocation() - Vector2.new(0, 36)
    if not closed and mousePos.X >= TopBar.AbsolutePosition.X and mousePos.X <= TopBar.AbsolutePosition.X + TopBar.AbsoluteSize.X and mousePos.Y >= Background.AbsolutePosition.Y and mousePos.Y <= Background.AbsolutePosition.Y + Background.AbsoluteSize.Y then
        if not mouseInGui then
            mouseInGui = true
            mouseEntered()
        end
    else
        mouseInGui = false
    end
end

function maximizeSize(speed)
    if not speed then
        speed = 0.05
    end
    TweenService:Create(LeftPanel, TweenInfo.new(speed), { Size = UDim2.fromOffset(LeftPanel.AbsoluteSize.X, Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(RightPanel, TweenInfo.new(speed), { Size = UDim2.fromOffset(Background.AbsoluteSize.X - LeftPanel.AbsoluteSize.X, Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(TopBar, TweenInfo.new(speed), { Size = UDim2.fromOffset(Background.AbsoluteSize.X, TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(ScrollingFrame, TweenInfo.new(speed), { Size = UDim2.fromOffset(Background.AbsoluteSize.X - LeftPanel.AbsoluteSize.X, 110), Position = UDim2.fromOffset(0, Background.AbsoluteSize.Y - 119 - TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(CodeBox, TweenInfo.new(speed), { Size = UDim2.fromOffset(Background.AbsoluteSize.X - LeftPanel.AbsoluteSize.X, Background.AbsoluteSize.Y - 119 - TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(LogList, TweenInfo.new(speed), { Size = UDim2.fromOffset(LogList.AbsoluteSize.X, Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y - 18) }):Play()
end

function minimizeSize(speed)
    if not speed then
        speed = 0.05
    end
    TweenService:Create(LeftPanel, TweenInfo.new(speed), { Size = UDim2.fromOffset(LeftPanel.AbsoluteSize.X, Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(RightPanel, TweenInfo.new(speed), { Size = UDim2.fromOffset(0, Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(TopBar, TweenInfo.new(speed), { Size = UDim2.fromOffset(LeftPanel.AbsoluteSize.X, TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(ScrollingFrame, TweenInfo.new(speed), { Size = UDim2.fromOffset(0, 119), Position = UDim2.fromOffset(0, Background.AbsoluteSize.Y - 119 - TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(CodeBox, TweenInfo.new(speed), { Size = UDim2.fromOffset(0, Background.AbsoluteSize.Y - 119 - TopBar.AbsoluteSize.Y) }):Play()
    TweenService:Create(LogList, TweenInfo.new(speed), { Size = UDim2.fromOffset(LogList.AbsoluteSize.X, Background.AbsoluteSize.Y - TopBar.AbsoluteSize.Y - 18) }):Play()
end

function validateSize()
    local x, y = Background.AbsoluteSize.X, Background.AbsoluteSize.Y
    local screenSize = workspace.CurrentCamera.ViewportSize
    if x + Background.AbsolutePosition.X > screenSize.X then
        if screenSize.X - Background.AbsolutePosition.X >= 450 then
            x = screenSize.X - Background.AbsolutePosition.X
        else
            x = 450
        end
    elseif y + Background.AbsolutePosition.Y > screenSize.Y then
        if screenSize.X - Background.AbsolutePosition.Y >= 268 then
            y = screenSize.Y - Background.AbsolutePosition.Y
        else
            y = 268
        end
    end
    Background.Size = UDim2.fromOffset(x, y)
end

function backgroundUserInput(input)
    local mousePos = UserInputService:GetMouseLocation() - Vector2.new(0, 36)
    local inResizeRange, type = isInResizeRange(mousePos)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and inResizeRange then
        local lastPos = UserInputService:GetMouseLocation()
        local offset = Background.AbsoluteSize - lastPos
        local currentPos = lastPos + offset
        RunService:BindToRenderStep("SIMPLESPY_RESIZE", 1, function()
            local newPos = UserInputService:GetMouseLocation()
            if newPos ~= lastPos then
                local currentX = (newPos + offset).X
                local currentY = (newPos + offset).Y
                if currentX < 450 then
                    currentX = 450
                end
                if currentY < 268 then
                    currentY = 268
                end
                currentPos = Vector2.new(currentX, currentY)
                Background.Size = UDim2.fromOffset((not sideClosed and not closed and (type == "X" or type == "B")) and currentPos.X or Background.AbsoluteSize.X, (not closed and (type == "Y" or type == "B")) and currentPos.Y or Background.AbsoluteSize.Y)
                validateSize()
                if sideClosed then
                    minimizeSize()
                else
                    maximizeSize()
                end
                lastPos = newPos
            end
        end)
        table.insert(connections, UserInputService.InputEnded:Connect(function(inputE)
            if input == inputE then
                RunService:UnbindFromRenderStep("SIMPLESPY_RESIZE")
            end
        end))
    elseif isInDragRange(mousePos) then
        onBarInput(input)
    end
end

function getPlayerFromInstance(instance)
    for _, v in pairs(Players:GetPlayers()) do
        if v.Character and (instance:IsDescendantOf(v.Character) or instance == v.Character) then
            return v
        end
    end
end

function eventSelect(frame)
    if selected and selected.Log and selected.Log.Button then
        TweenService:Create(selected.Log.Button, TweenInfo.new(0.5), { BackgroundColor3 = Color3.fromRGB(0, 0, 0) }):Play()
        selected = nil
    end
    for _, v in pairs(logs) do
        if frame == v.Log then
            selected = v
        end
    end
    if selected and selected.Log then
        TweenService:Create(frame.Button, TweenInfo.new(0.5), { BackgroundColor3 = Color3.fromRGB(92, 126, 229) }):Play()
        codebox:setRaw(selected.GenScript)
    end
    if sideClosed then
        toggleSideTray()
    end
end

function updateFunctionCanvas()
    ScrollingFrame.CanvasSize = UDim2.fromOffset(UIGridLayout.AbsoluteContentSize.X, UIGridLayout.AbsoluteContentSize.Y)
end

function updateRemoteCanvas()
    LogList.CanvasSize = UDim2.fromOffset(UIListLayout.AbsoluteContentSize.X, UIListLayout.AbsoluteContentSize.Y)
end

function makeToolTip(enable, text)
    if enable then
        if ToolTip.Visible then
            ToolTip.Visible = false
            RunService:UnbindFromRenderStep("ToolTip")
        end
        local first = true
        RunService:BindToRenderStep("ToolTip", 1, function()
            local topLeft = Vector2.new(Mouse.X + 20, Mouse.Y + 20)
            local bottomRight = topLeft + ToolTip.AbsoluteSize
            if topLeft.X < 0 then
                topLeft = Vector2.new(0, topLeft.Y)
            elseif bottomRight.X > workspace.CurrentCamera.ViewportSize.X then
                topLeft = Vector2.new(workspace.CurrentCamera.ViewportSize.X - ToolTip.AbsoluteSize.X, topLeft.Y)
            end
            if topLeft.Y < 0 then
                topLeft = Vector2.new(topLeft.X, 0)
            elseif bottomRight.Y > workspace.CurrentCamera.ViewportSize.Y - 35 then
                topLeft = Vector2.new(topLeft.X, workspace.CurrentCamera.ViewportSize.Y - ToolTip.AbsoluteSize.Y - 35)
            end
            if topLeft.X <= Mouse.X and topLeft.Y <= Mouse.Y then
                topLeft = Vector2.new(Mouse.X - ToolTip.AbsoluteSize.X - 2, Mouse.Y - ToolTip.AbsoluteSize.Y - 2)
            end
            if first then
                ToolTip.Position = UDim2.fromOffset(topLeft.X, topLeft.Y)
                first = false
            else
                ToolTip:TweenPosition(UDim2.fromOffset(topLeft.X, topLeft.Y), "Out", "Linear", 0.1)
            end
        end)
        TextLabel.Text = text
        ToolTip.Visible = true
    else
        if ToolTip.Visible then
            ToolTip.Visible = false
            RunService:UnbindFromRenderStep("ToolTip")
        end
    end
end

function newButton(name, description, onClick)
    local button = FunctionTemplate:Clone()
    button.Text.Text = name
    button.Button.MouseEnter:Connect(function()
        makeToolTip(true, description())
    end)
    button.Button.MouseLeave:Connect(function()
        makeToolTip(false)
    end)
    button.AncestryChanged:Connect(function()
        makeToolTip(false)
    end)
    button.Button.MouseButton1Click:Connect(function(...)
        onClick(button, ...)
    end)
    button.Parent = ScrollingFrame
    updateFunctionCanvas()
end

function newRemote(type, name, args, remote, function_info, blocked, src, returnValue)
    -- Check if the remote is in the exclusion list
    for _, excludeName in pairs(excludeRemotes) do
        if string.find(string.lower(name), string.lower(excludeName)) then
            warn("Skipping logging of remote: " .. name .. " (matches exclusion list)")
            return
        end
    end

    local remoteFrame = RemoteTemplate:Clone()
    remoteFrame.Text.Text = string.sub(name, 1, 50)
    remoteFrame.ColorBar.BackgroundColor3 = type == "event" and Color3.new(255, 242, 0) or Color3.fromRGB(99, 86, 245)
    local id = Instance.new("IntValue")
    id.Name = "ID"
    id.Value = #logs + 1
    id.Parent = remoteFrame
    local weakRemoteTable = setmetatable({ remote = remote }, { __mode = "v" })
    local log = {
        Name = name,
        Function = function_info,
        Remote = weakRemoteTable,
        Log = remoteFrame,
        Blocked = blocked,
        Source = src,
        GenScript = "-- Generating, please wait... (click to reload)\n-- (If this message persists, the remote args are likely extremely long)",
        ReturnValue = returnValue,
    }
    logs[#logs + 1] = log
    schedule(function()
        log.GenScript = genScript(remote, args)
        if blocked then
            logs[#logs].GenScript = "-- THIS REMOTE WAS PREVENTED FROM FIRING THE SERVER BY SIMPLESPY\n\n" .. logs[#logs].GenScript
        end
    end)
    local connect = remoteFrame.Button.MouseButton1Click:Connect(function()
        eventSelect(remoteFrame)
    end)
    if layoutOrderNum < 1 then
        layoutOrderNum = 999999999
    end
    remoteFrame.LayoutOrder = layoutOrderNum
    layoutOrderNum = layoutOrderNum - 1
    remoteFrame.Parent = LogList
    table.insert(remoteLogs, 1, { connect, remoteFrame })
    clean()
    updateRemoteCanvas()
end

function genScript(remote, args)
    prevTables = {}
    local gen = ""
    if #args > 0 then
        if not pcall(function()
            gen = v2v({ args = args }) .. "\n"
        end) then
            gen = gen .. "-- TableToString failure! Reverting to legacy functionality (results may vary)\nlocal args = {"
            if not pcall(function()
                for i, v in pairs(args) do
                    if type(i) ~= "Instance" and type(i) ~= "userdata" then
                        gen = gen .. "\n    [object] = "
                    elseif type(i) == "string" then
                        gen = gen .. '\n    ["' .. i .. '"] = '
                    elseif type(i) == "userdata" and typeof(i) ~= "Instance" then
                        gen = gen .. "\n    [" .. string.format("nil --[[%s]]", typeof(v)) .. ")] = "
                    elseif type(i) == "userdata" then
                        gen = gen .. "\n    [game." .. i:GetFullName() .. ")] = "
                    end
                    if type(v) ~= "Instance" and type(v) ~= "userdata" then
                        gen = gen .. "object"
                    elseif type(v) == "string" then
                        gen = gen .. '"' .. v .. '"'
                    elseif type(v) == "userdata" and typeof(v) ~= "Instance" then
                        gen = gen .. string.format("nil --[[%s]]", typeof(v))
                    elseif type(v) == "userdata" then
                        gen = gen .. "game." .. v:GetFullName()
                    end
                end
                gen = gen .. "\n}\n\n"
            end) then
                gen = gen .. "}\n-- Legacy tableToString failure! Unable to decompile."
            end
        end
        if not remote:IsDescendantOf(game) and not getnilrequired then
            gen = "function getNil(name,class) for _,v in pairs(getnilinstances())do if v.ClassName==class and v.Name==name then return v;end end end\n\n" .. gen
        end
        if remote:IsA("RemoteEvent") then
            gen = gen .. v2s(remote) .. ":FireServer(unpack(args))"
        elseif remote:IsA("RemoteFunction") then
            gen = gen .. v2s(remote) .. ":InvokeServer(unpack(args))"
        end
    else
        if remote:IsA("RemoteEvent") then
            gen = gen .. v2s(remote) .. ":FireServer()"
        elseif remote:IsA("RemoteFunction") then
            gen = gen .. v2s(remote) .. ":InvokeServer()"
        end
    end
    gen = "-- Script generated by SimpleSpy - credits to exx#9394\n\n" .. gen
    prevTables = {}
    return gen
end

function v2s(v, l, p, n, vtv, i, pt, path, tables, tI)
    if not tI then
        tI = { 0 }
    else
        tI[1] += 1
    end
    if typeof(v) == "number" then
        if v == math.huge then
            return "math.huge"
        elseif tostring(v):match("nan") then
            return "0/0 --[[NaN]]"
        end
        return tostring(v)
    elseif typeof(v) == "boolean" then
        return tostring(v)
    elseif typeof(v) == "string" then
        return formatstr(v, l)
    elseif typeof(v) == "function" then
        return f2s(v)
    elseif typeof(v) == "table" then
        return t2s(v, l, p, n, vtv, i, pt, path, tables, tI)
    elseif typeof(v) == "Instance" then
        return i2p(v)
    elseif typeof(v) == "userdata" then
        return "newproxy(true)"
    elseif type(v) == "userdata" then
        return u2s(v)
    elseif type(v) == "vector" then
        return string.format("Vector3.new(%s, %s, %s)", v2s(v.X), v2s(v.Y), v2s(v.Z))
    else
        return "nil --[[" .. typeof(v) .. "]]"
    end
end

function v2v(t)
    topstr = ""
    bottomstr = ""
    getnilrequired = false
    local ret = ""
    local count = 1
    for i, v in pairs(t) do
        if type(i) == "string" and i:match("^[%a_]+[%w_]*$") then
            ret = ret .. "local " .. i .. " = " .. v2s(v, nil, nil, i, true) .. "\n"
        elseif tostring(i):match("^[%a_]+[%w_]*$") then
            ret = ret .. "local " .. tostring(i):lower() .. "_" .. tostring(count) .. " = " .. v2s(v, nil, nil, tostring(i):lower() .. "_" .. tostring(count), true) .. "\n"
        else
            ret = ret .. "local " .. type(v) .. "_" .. tostring(count) .. " = " .. v2s(v, nil, nil, type(v) .. "_" .. tostring(count), true) .. "\n"
        end
        count = count + 1
    end
    if getnilrequired then
        topstr = "function getNil(name,class) for _,v in pairs(getnilinstances())do if v.ClassName==class and v.Name==name then return v;end end end\n" .. topstr
    end
    if #topstr > 0 then
        ret = topstr .. "\n" .. ret
    end
    if #bottomstr > 0 then
        ret = ret .. bottomstr
    end
    return ret
end

function t2s(t, l, p, n, vtv, i, pt, path, tables, tI)
    local globalIndex = table.find(getgenv(), t)
    if type(globalIndex) == "string" then
        return globalIndex
    end
    if not tI then
        tI = { 0 }
    end
    if not path then
        path = ""
    end
    if not l then
        l = 0
        tables = {}
    end
    if not p then
        p = t
    end
    for _, v in pairs(tables) do
        if n and rawequal(v, t) then
            bottomstr = bottomstr .. "\n" .. tostring(n) .. tostring(path) .. " = " .. tostring(n) .. tostring(({ v2p(v, p) })[2])
            return "{} --[[DUPLICATE]]"
        end
    end
    table.insert(tables, t)
    local s = "{"
    local size = 0
    l = l + indent
    for k, v in pairs(t) do
        size = size + 1
        if size > (_G.SimpleSpyMaxTableSize or 1000) then
            s = s .. "\n" .. string.rep(" ", l) .. "-- MAXIMUM TABLE SIZE REACHED, CHANGE '_G.SimpleSpyMaxTableSize' TO ADJUST MAXIMUM SIZE "
            break
        end
        if rawequal(k, t) then
            bottomstr = bottomstr .. "\n" .. tostring(n) .. tostring(path) .. "[" .. tostring(n) .. tostring(path) .. "]" .. " = " .. (rawequal(v, k) and tostring(n) .. tostring(path) or v2s(v, l, p, n, vtv, k, t, path .. "[" .. tostring(n) .. tostring(path) .. "]", tables))
            size -= 1
            continue
        end
        local currentPath = ""
        if type(k) == "string" and k:match("^[%a_]+[%w_]*$") then
            currentPath = "." .. k
        else
            currentPath = "[" .. k2s(k, l, p, n, vtv, k, t, path .. currentPath, tables, tI) .. "]"
        end
        if size % 100 == 0 then
            scheduleWait()
        end
        s = s .. "\n" .. string.rep(" ", l) .. "[" .. k2s(k, l, p, n, vtv, k, t, path .. currentPath, tables, tI) .. "] = " .. v2s(v, l, p, n, vtv, k, t, path .. currentPath, tables, tI) .. ","
    end
    if #s > 1 then
        s = s:sub(1, #s - 1)
    end
    if size > 0 then
        s = s .. "\n" .. string.rep(" ", l - indent)
    end
    return s .. "}"
end

function k2s(v, ...)
    if keyToString then
        if typeof(v) == "userdata" and getrawmetatable(v) then
            return string.format('"<void> (%s)" --[[Potentially hidden data (tostring in SimpleSpy:HookRemote/GetRemoteFiredSignal at your own risk)]]', safetostring(v))
        elseif typeof(v) == "userdata" then
            return string.format('"<void> (%s)"', safetostring(v))
        elseif type(v) == "userdata" and typeof(v) ~= "Instance" then
            return string.format('"<%s> (%s)"', typeof(v), tostring(v))
        elseif type(v) == "function" then
            return string.format('"<Function> (%s)"', tostring(v))
        end
    end
    return v2s(v, ...)
end

function f2s(f)
    for k, x in pairs(getgenv()) do
        local isgucci, gpath
        if rawequal(x, f) then
            isgucci, gpath = true, ""
        elseif type(x) == "table" then
            isgucci, gpath = v2p(f, x)
        end
        if isgucci and type(k) ~= "function" then
            if type(k) == "string" and k:match("^[%a_]+[%w_]*$") then
                return k .. gpath
            else
                return "getgenv()[" .. v2s(k) .. "]" .. gpath
            end
        end
    end
    if funcEnabled and debug.getinfo(f).name:match("^[%a_]+[%w_]*$") then
        return "function()end --[[" .. debug.getinfo(f).name .. "]]"
    end
    return "function()end --[[" .. tostring(f) .. "]]"
end

function i2p(i)
    local player = getplayer(i)
    local parent = i
    local out = ""
    if parent == nil then
        return "nil"
    elseif player then
        while true do
            if parent and parent == player.Character then
                if player == Players.LocalPlayer then
                    return 'game:GetService("Players").LocalPlayer.Character' .. out
                else
                    return i2p(player) .. ".Character" .. out
                end
            else
                if parent.Name:match("[%a_]+[%w+]*") ~= parent.Name then
                    out = ":FindFirstChild(" .. formatstr(parent.Name) .. ")" .. out
                else
                    out = "." .. parent.Name .. out
                end
            end
            parent = parent.Parent
        end
    elseif parent ~= game then
        while true do
            if parent and parent.Parent == game then
                local service = game:FindService(parent.ClassName)
                if service then
                    if parent.ClassName == "Workspace" then
                        return "workspace" .. out
                    else
                        return 'game:GetService("' .. service.ClassName .. '")' .. out
                    end
                else
                    if parent.Name:match("[%a_]+[%w_]*") then
                        return "game." .. parent.Name .. out
                    else
                        return "game:FindFirstChild(" .. formatstr(parent.Name) .. ")" .. out
                    end
                end
            elseif parent.Parent == nil then
                getnilrequired = true
                return "getNil(" .. formatstr(parent.Name) .. ', "' .. parent.ClassName .. '")' .. out
            elseif parent == Players.LocalPlayer then
                out = ".LocalPlayer" .. out
            else
                if parent.Name:match("[%a_]+[%w_]*") ~= parent.Name then
                    out = ":FindFirstChild(" .. formatstr(parent.Name) .. ")" .. out
                else
                    out = "." .. parent.Name .. out
                end
            end
            parent = parent.Parent
        end
    else
        return "game"
    end
end

function u2s(u)
    if typeof(u) == "TweenInfo" then
        return "TweenInfo.new(" .. tostring(u.Time) .. ", Enum.EasingStyle." .. tostring(u.EasingStyle) .. ", Enum.EasingDirection." .. tostring(u.EasingDirection) .. ", " .. tostring(u.RepeatCount) .. ", " .. tostring(u.Reverses) .. ", " .. tostring(u.DelayTime) .. ")"
    elseif typeof(u) == "Ray" then
        return "Ray.new(" .. u2s(u.Origin) .. ", " .. u2s(u.Direction) .. ")"
    elseif typeof(u) == "NumberSequence" then
        local ret = "NumberSequence.new("
        for i, v in pairs(u.KeyPoints) do
            ret = ret .. tostring(v)
            if i < #u.Keypoints then
                ret = ret .. ", "
            end
        end
        return ret .. ")"
    elseif typeof(u) == "DockWidgetPluginGuiInfo" then
        return "DockWidgetPluginGuiInfo.new(Enum.InitialDockState" .. tostring(u) .. ")"
    elseif typeof(u) == "ColorSequence" then
        local ret = "ColorSequence.new("
        for i, v in pairs(u.KeyPoints) do
            ret = ret .. "Color3.new(" .. tostring(v) .. ")"
            if i < #u.Keypoints then
                ret = ret .. ", "
            end
        end
        return ret .. ")"
    elseif typeof(u) == "BrickColor" then
        return "BrickColor.new(" .. tostring(u.Number) .. ")"
    elseif typeof(u) == "NumberRange" then
        return "NumberRange.new(" .. tostring(u.Min) .. ", " .. tostring(u.Max) .. ")"
    elseif typeof(u) == "Region3" then
        local center = u.CFrame.Position
        local size = u.CFrame.Size
        local vector1 = center - size / 2
        local vector2 = center + size / 2
        return "Region3.new(" .. u2s(vector1) .. ", " .. u2s(vector2) .. ")"
    elseif typeof(u) == "Faces" then
        local faces = {}
        if u.Top then table.insert(faces, "Enum.NormalId.Top") end
        if u.Bottom then table.insert(faces, "Enum.NormalId.Bottom") end
        if u.Left then table.insert(faces, "Enum.NormalId.Left") end
        if u.Right then table.insert(faces, "Enum.NormalId.Right") end
        if u.Back then table.insert(faces, "Enum.NormalId.Back") end
        if u.Front then table.insert(faces, "Enum.NormalId.Front") end
        return "Faces.new(" .. table.concat(faces, ", ") .. ")"
    elseif typeof(u) == "EnumItem" then
        return tostring(u)
    elseif typeof(u) == "Enums" then
        return "Enum"
    elseif typeof(u) == "Enum" then
        return "Enum." .. tostring(u)
    elseif typeof(u) == "RBXScriptSignal" then
        return "nil --[[RBXScriptSignal]]"
    elseif typeof(u) == "Vector3" then
        return string.format("Vector3.new(%s, %s, %s)", v2s(u.X), v2s(u.Y), v2s(u.Z))
    elseif typeof(u) == "CFrame" then
        local xAngle, yAngle, zAngle = u:ToEulerAnglesXYZ()
        return string.format("CFrame.new(%s, %s, %s) * CFrame.Angles(%s, %s, %s)", v2s(u.X), v2s(u.Y), v2s(u.Z), v2s(xAngle), v2s(yAngle), v2s(zAngle))
    elseif typeof(u) == "DockWidgetPluginGuiInfo" then
        return string.format("DockWidgetPluginGuiInfo(%s, %s, %s, %s, %s, %s, %s)", "Enum.InitialDockState.Right", v2s(u.InitialEnabled), v2s(u.InitialEnabledShouldOverrideRestore), v2s(u.FloatingXSize), v2s(u.FloatingYSize), v2s(u.MinWidth), v2s(u.MinHeight))
    elseif typeof(u) == "PathWaypoint" then
        return string.format("PathWaypoint.new(%s, %s)", v2s(u.Position), v2s(u.Action))
    elseif typeof(u) == "UDim" then
        return string.format("UDim.new(%s, %s)", v2s(u.Scale), v2s(u.Offset))
    elseif typeof(u) == "UDim2" then
        return string.format("UDim2.new(%s, %s, %s, %s)", v2s(u.X.Scale), v2s(u.X.Offset), v2s(u.Y.Scale), v2s(u.Y.Offset))
    elseif typeof(u) == "Rect" then
        return string.format("Rect.new(%s, %s)", v2s(u.Min), v2s(u.Max))
    else
        return string.format("nil --[[%s]]", typeof(u))
    end
end

function getplayer(instance)
    for _, v in pairs(Players:GetPlayers()) do
        if v.Character and (instance:IsDescendantOf(v.Character) or instance == v.Character) then
            return v
        end
    end
end

function v2p(x, t, path, prev)
    if not path then
        path = ""
    end
    if not prev then
        prev = {}
    end
    if rawequal(x, t) then
        return true, ""
    end
    for i, v in pairs(t) do
        if rawequal(v, x) then
            if type(i) == "string" and i:match("^[%a_]+[%w_]*$") then
                return true, (path .. "." .. i)
            else
                return true, (path .. "[" .. v2s(i) .. "]")
            end
        end
        if type(v) == "table" then
            local duplicate = false
            for _, y in pairs(prev) do
                if rawequal(y, v) then
                    duplicate = true
                end
            end
            if not duplicate then
                table.insert(prev, t)
                local found
                found, p = v2p(x, v, path, prev)
                if found then
                    if type(i) == "string" and i:match("^[%a_]+[%w_]*$") then
                        return true, "." .. i .. p
                    else
                        return true, "[" .. v2s(i) .. "]" .. p
                    end
                end
            end
        end
    end
    return false, ""
end

function formatstr(s, indentation)
    if not indentation then
        indentation = 0
    end
    local handled, reachedMax = handlespecials(s, indentation)
    return '"' .. handled .. '"' .. (reachedMax and " --[[ MAXIMUM STRING SIZE REACHED, CHANGE '_G.SimpleSpyMaxStringSize' TO ADJUST MAXIMUM SIZE ]]" or "")
end

function handlespecials(value, indentation)
    local buildStr = {}
    local i = 1
    local char = string.sub(value, i, i)
    local indentStr
    while char ~= "" do
        if char == '"' then
            buildStr[i] = '\\"'
        elseif char == "\\" then
            buildStr[i] = "\\\\"
        elseif char == "\n" then
            buildStr[i] = "\\n"
        elseif char == "\t" then
            buildStr[i] = "\\t"
        elseif string.byte(char) > 126 or string.byte(char) < 32 then
            buildStr[i] = string.format("\\%d", string.byte(char))
        else
            buildStr[i] = char
        end
        i = i + 1
        char = string.sub(value, i, i)
        if i % 200 == 0 then
            indentStr = indentStr or string.rep(" ", indentation + indent)
            table.move({ '"\n', indentStr, '... "' }, 1, 3, i, buildStr)
            i += 3
        end
    end
    return table.concat(buildStr)
end

function safetostring(v)
    if typeof(v) == "userdata" or type(v) == "table" then
        local mt = getrawmetatable(v)
        local badtostring = mt and rawget(mt, "__tostring")
        if mt and badtostring then
            rawset(mt, "__tostring", nil)
            local out = tostring(v)
            rawset(mt, "__tostring", badtostring)
            return out
        end
    end
    return tostring(v)
end

function getScriptFromSrc(src)
    local realPath
    local runningTest
    if src then
        if getfenv()[src] then
            realPath = src
        else
            for i, v in pairs(getloadedmodules()) do
                if rawequal(getfenv(v), src) then
                    realPath = i
                    break
                end
            end
        end
        if realPath then
            runningTest = getfenv()[realPath]
        end
    end
    return runningTest or getfenv()
end

function toggleSpy()
    toggle = not toggle
    if toggle then
        warn("Spy enabled. Be cautious as this may still be detected by Anti-Cheat systems.")
        -- Use hookfunction with caution
        local newFireServer = function(self, ...)
            if not blocklist[self] then
                newRemote("event", self.Name, {...}, self, nil, false, getScriptFromSrc(getfenv(2)), recordReturnValues and nil)
            end
            return originalEvent(self, ...)
        end
        local newInvokeServer = function(self, ...)
            if not blocklist[self] then
                local ret = {originalFunction(self, ...)}
                newRemote("function", self.Name, {...}, self, nil, false, getScriptFromSrc(getfenv(2)), recordReturnValues and ret)
                return unpack(ret)
            end
            return originalFunction(self, ...)
        end
        originalEvent = hookfunction(remoteEvent.FireServer, newFireServer)
        originalFunction = hookfunction(remoteFunction.InvokeServer, newInvokeServer)
    else
        warn("Spy disabled.")
        hookfunction(remoteEvent.FireServer, originalEvent)
        hookfunction(remoteFunction.InvokeServer, originalFunction)
    end
end

function schedule(f)
    table.insert(scheduled, f)
end

function scheduleWait()
    if not schedulerconnect then
        schedulerconnect = RunService.Heartbeat:Connect(function()
            for i, f in pairs(scheduled) do
                if type(f) == "function" then
                    local s, e = pcall(f)
                    if not s then
                        warn("Error in scheduled task: " .. e)
                    end
                    table.remove(scheduled, i)
                end
            end
        end)
    end
end

-- Event connections
Simple.MouseEnter:Connect(onToggleButtonHover)
Simple.MouseLeave:Connect(onToggleButtonUnhover)
Simple.MouseButton1Click:Connect(onToggleButtonClick)
CloseButton.MouseEnter:Connect(onXButtonHover)
CloseButton.MouseLeave:Connect(onXButtonUnhover)
CloseButton.MouseButton1Click:Connect(function()
    mainClosing = true
    closed = true
    toggleMinimize()
    mainClosing = false
end)
MaximizeButton.MouseButton1Click:Connect(toggleMaximize)
MinimizeButton.MouseButton1Click:Connect(toggleSideTray)
TopBar.MouseButton1Down:Connect(onBarInput)
Background.MouseMoved:Connect(mouseMoved)
UserInputService.InputBegan:Connect(backgroundUserInput)
connectResize()

-- Initialize
_G.SimpleSpyExecuted = true
_G.SimpleSpyShutdown = function()
    _G.SimpleSpyExecuted = false
    for _, v in pairs(connections) do
        v:Disconnect()
    end
    connections = {}
    SimpleSpy2:Destroy()
end

-- Start the spy
toggleSpy()
