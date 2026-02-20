local YUUGTRL = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled

local function showNotify()
    local notifyGui = Instance.new("ScreenGui")
    notifyGui.Name = "YUUGTRL_Notify"
    notifyGui.ResetOnSpawn = false
    notifyGui.Parent = player:WaitForChild("PlayerGui")
    notifyGui.IgnoreGuiInset = true
    notifyGui.DisplayOrder = 9999
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 160, 0, 36)
    frame.Position = UDim2.new(0.5, -80, 0, -40)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BorderSizePixel = 0
    frame.Parent = notifyGui
    frame.Draggable = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, -10, 1, 0)
    text.Position = UDim2.new(0, 5, 0, 0)
    text.BackgroundTransparency = 1
    text.Text = "YUUGTRL"
    text.TextColor3 = Color3.fromRGB(170, 85, 255)
    text.Font = Enum.Font.GothamBold
    text.TextSize = 16
    text.Parent = frame
    
    local tweenIn = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5, -80, 0, 20)
    })
    tweenIn:Play()
    
    task.wait(1.2)
    
    local tweenOut = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5, -80, 0, -40)
    })
    tweenOut:Play()
    tweenOut.Completed:Connect(function()
        notifyGui:Destroy()
    end)
end

spawn(showNotify)

local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
end

local function createGradient(button, color)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(math.min(color.R*1.3,1), math.min(color.G*1.3,1), math.min(color.B*1.3,1))),
        ColorSequenceKeypoint.new(1, Color3.new(color.R*0.7, color.G*0.7, color.B*0.7))
    })
    gradient.Rotation = 90
    gradient.Parent = button
end

function YUUGTRL:CreateWindow(title, size, options)
    options = options or {}
    size = size or (isMobile and UDim2.new(0, 260, 0, 300) or UDim2.new(0, 320, 0, 360))
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "YUUGTRL_" .. title
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = size
    mainFrame.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    createCorner(mainFrame, 8)
    
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, isMobile and 30 or 35)
    header.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    header.Parent = mainFrame
    createCorner(header, 8)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 1, 0)
    titleLabel.Position = UDim2.new(0, 8, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = isMobile and 13 or 15
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = header
    
    local windowObj = {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        Header = header,
        Container = nil,
        Elements = {},
        CloseButton = nil,
        SettingsButton = nil
    }
    
    if options.ShowClose ~= false then
        local closeButton = Instance.new("TextButton")
        closeButton.Size = UDim2.new(0, isMobile and 24 or 28, 0, isMobile and 24 or 28)
        closeButton.Position = UDim2.new(1, -(isMobile and 28 or 32), 0, isMobile and 3 or 4)
        closeButton.BackgroundColor3 = options.CloseColor or Color3.fromRGB(200, 70, 70)
        closeButton.Text = ""
        closeButton.Parent = header
        createCorner(closeButton, 6)
        createGradient(closeButton, closeButton.BackgroundColor3)
        
        local closeText = Instance.new("TextLabel")
        closeText.Size = UDim2.new(1, 0, 1, 0)
        closeText.BackgroundTransparency = 1
        closeText.Text = "×"
        closeText.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeText.Font = Enum.Font.GothamBold
        closeText.TextSize = isMobile and 16 or 18
        closeText.Parent = closeButton
        
        windowObj.CloseButton = closeButton
    end
    
    if options.ShowSettings then
        local settingsButton = Instance.new("TextButton")
        settingsButton.Size = UDim2.new(0, isMobile and 24 or 28, 0, isMobile and 24 or 28)
        settingsButton.Position = UDim2.new(1, -(isMobile and 56 or 64), 0, isMobile and 3 or 4)
        settingsButton.BackgroundColor3 = options.SettingsColor or Color3.fromRGB(80, 100, 220)
        settingsButton.Text = ""
        settingsButton.Parent = header
        createCorner(settingsButton, 6)
        createGradient(settingsButton, settingsButton.BackgroundColor3)
        
        local settingsText = Instance.new("TextLabel")
        settingsText.Size = UDim2.new(1, 0, 1, 0)
        settingsText.BackgroundTransparency = 1
        settingsText.Text = "⚙"
        settingsText.TextColor3 = Color3.fromRGB(255, 255, 255)
        settingsText.Font = Enum.Font.GothamBold
        settingsText.TextSize = isMobile and 16 or 18
        settingsText.Parent = settingsButton
        
        windowObj.SettingsButton = settingsButton
    end
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -12, 1, -(header.Size.Y.Offset + 12))
    container.Position = UDim2.new(0, 6, 0, header.Size.Y.Offset + 6)
    container.BackgroundTransparency = 1
    container.Parent = mainFrame
    
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollingFrame.BackgroundTransparency = 1
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.ScrollBarThickness = 3
    scrollingFrame.Parent = container
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, isMobile and 3 or 4)
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.Parent = scrollingFrame
    
    windowObj.Container = scrollingFrame
    windowObj.Layout = listLayout
    
    function windowObj:AddButton(text, color, callback)
        color = color or Color3.fromRGB(80, 100, 220)
        
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -6, 0, isMobile and 30 or 32)
        button.BackgroundColor3 = color
        button.Text = ""
        button.Parent = self.Container
        createCorner(button, 6)
        createGradient(button, color)
        
        local buttonText = Instance.new("TextLabel")
        buttonText.Size = UDim2.new(1, 0, 1, 0)
        buttonText.BackgroundTransparency = 1
        buttonText.Text = text
        buttonText.TextColor3 = Color3.fromRGB(255, 255, 255)
        buttonText.Font = Enum.Font.GothamBold
        buttonText.TextSize = isMobile and 11 or 12
        buttonText.Parent = button
        
        button.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
        
        table.insert(self.Elements, button)
        self.Container.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 6)
        
        return button
    end
    
    function windowObj:AddLabel(text)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -6, 0, isMobile and 16 or 18)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(200, 200, 255)
        label.Font = Enum.Font.GothamBold
        label.TextSize = isMobile and 10 or 11
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = self.Container
        
        table.insert(self.Elements, label)
        self.Container.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 6)
        
        return label
    end
    
    function windowObj:AddCredit(text, color)
        local credit = Instance.new("TextLabel")
        credit.Size = UDim2.new(1, -12, 0, 12)
        credit.Position = UDim2.new(0, 6, 1, -14)
        credit.BackgroundTransparency = 1
        credit.Text = text
        credit.TextColor3 = color or Color3.fromRGB(170, 85, 255)
        credit.Font = Enum.Font.GothamBold
        credit.TextSize = 9
        credit.TextXAlignment = Enum.TextXAlignment.Right
        credit.Parent = self.MainFrame
        return credit
    end
    
    function windowObj:Destroy()
        screenGui:Destroy()
    end
    
    return windowObj
end

function YUUGTRL:CreateNotification(title, message, duration)
    duration = duration or 3
    
    local notifGui = Instance.new("ScreenGui")
    notifGui.Name = "YUUGTRL_Notification"
    notifGui.ResetOnSpawn = false
    notifGui.Parent = player:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = isMobile and UDim2.new(0, 220, 0, 60) or UDim2.new(0, 260, 0, 70)
    frame.Position = UDim2.new(0.5, -130, 0, -90)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.Parent = notifGui
    createCorner(frame, 8)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -16, 0, isMobile and 20 or 22)
    titleLabel.Position = UDim2.new(0, 8, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = isMobile and 12 or 13
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = frame
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -16, 0, isMobile and 20 or 22)
    messageLabel.Position = UDim2.new(0, 8, 0, isMobile and 25 or 28)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    messageLabel.Font = Enum.Font.GothamBold
    messageLabel.TextSize = isMobile and 10 or 11
    messageLabel.Parent = frame
    
    local tweenIn = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5, -130, 0, 20)
    })
    tweenIn:Play()
    
    task.wait(duration)
    
    local tweenOut = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5, -130, 0, -90)
    })
    tweenOut:Play()
    tweenOut.Completed:Connect(function()
        notifGui:Destroy()
    end)
end

function YUUGTRL:IsMobile()
    return isMobile
end

return YUUGTRL
