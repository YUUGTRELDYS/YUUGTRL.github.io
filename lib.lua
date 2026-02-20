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
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
    })
    gradient.Rotation = 45
    gradient.Parent = frame
    
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
    return corner
end

local function createButtonGradient(button, baseColor)
    local r, g, b = baseColor.R, baseColor.G, baseColor.B
    local lighter = Color3.new(math.min(r * 1.3, 1), math.min(g * 1.3, 1), math.min(b * 1.3, 1))
    local darker = Color3.new(r * 0.7, g * 0.7, b * 0.7)
    
    for _, child in pairs(button:GetChildren()) do
        if child:IsA("UIGradient") then
            child:Destroy()
        end
    end
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, lighter),
        ColorSequenceKeypoint.new(1, darker)
    })
    gradient.Rotation = 90
    gradient.Parent = button
end

local function createButtonText(button, text, baseColor, size)
    local r, g, b = baseColor.R, baseColor.G, baseColor.B
    local textColor = Color3.new(math.min(r * 1.4, 1), math.min(g * 1.4, 1), math.min(b * 1.4, 1))
    
    for _, child in pairs(button:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = textColor
    label.Font = Enum.Font.GothamBold
    label.TextSize = size or (isMobile and 12 or 14)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Parent = button
    return label
end

local function makeDraggable(frame, handle)
    local dragging = false
    local dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    connection:Disconnect()
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

function YUUGTRL:CreateWindow(title, size, options)
    options = options or {}
    size = size or (isMobile and UDim2.new(0, 260, 0, 300) or UDim2.new(0, 320, 0, 360))
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "YUUGTRL_" .. title
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 999
    
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
    header.BorderSizePixel = 0
    header.Parent = mainFrame
    createCorner(header, 8)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -70, 1, 0)
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
    
    local buttonX = isMobile and -28 or -32
    if options.ShowSettings then
        local settingsButton = Instance.new("TextButton")
        settingsButton.Size = UDim2.new(0, isMobile and 24 or 28, 0, isMobile and 24 or 28)
        settingsButton.Position = UDim2.new(1, buttonX, 0, isMobile and 3 or 4)
        settingsButton.BackgroundColor3 = options.SettingsColor or Color3.fromRGB(80, 100, 220)
        settingsButton.Text = ""
        settingsButton.Parent = header
        settingsButton.AutoButtonColor = false
        createCorner(settingsButton, 6)
        createButtonGradient(settingsButton, settingsButton.BackgroundColor3)
        createButtonText(settingsButton, "⚙", settingsButton.BackgroundColor3, isMobile and 16 or 18)
        
        windowObj.SettingsButton = settingsButton
        buttonX = buttonX - (isMobile and 28 or 32)
    end
    
    if options.ShowClose ~= false then
        local closeButton = Instance.new("TextButton")
        closeButton.Size = UDim2.new(0, isMobile and 24 or 28, 0, isMobile and 24 or 28)
        closeButton.Position = UDim2.new(1, buttonX, 0, isMobile and 3 or 4)
        closeButton.BackgroundColor3 = options.CloseColor or Color3.fromRGB(200, 70, 70)
        closeButton.Text = ""
        closeButton.Parent = header
        closeButton.AutoButtonColor = false
        createCorner(closeButton, 6)
        createButtonGradient(closeButton, closeButton.BackgroundColor3)
        createButtonText(closeButton, "×", closeButton.BackgroundColor3, isMobile and 16 or 18)
        
        windowObj.CloseButton = closeButton
    end
    
    makeDraggable(mainFrame, header)
    
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
        button.Size = UDim2.new(1, -6, 0, isMobile and 32 or 36)
        button.BackgroundColor3 = color
        button.Text = ""
        button.Parent = self.Container
        button.AutoButtonColor = false
        
        createCorner(button, 6)
        createButtonGradient(button, color)
        createButtonText(button, text, color, isMobile and 12 or 14)
        
        button.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
        
        table.insert(self.Elements, button)
        self.Container.CanvasSize = UDim2.new(0, 0, 0, self.Layout.AbsoluteContentSize.Y + 6)
        
        return button
    end
    
    function windowObj:AddToggle(text, default, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -6, 0, isMobile and 32 or 36)
        frame.BackgroundTransparency = 1
        frame.Parent = self.Container
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.6, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(220, 220, 255)
        label.Font = Enum.Font.GothamBold
        label.TextSize = isMobile and 12 or 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local toggleButton = Instance.new("TextButton")
        toggleButton.Size = UDim2.new(0, isMobile and 50 or 55, 0, isMobile and 24 or 28)
        toggleButton.Position = UDim2.new(1, -(isMobile and 55 or 60), 0.5, -(isMobile and 12 or 14))
        toggleButton.BackgroundColor3 = default and Color3.fromRGB(80, 180, 120) or Color3.fromRGB(200, 70, 70)
        toggleButton.Text = ""
        toggleButton.Parent = frame
        toggleButton.AutoButtonColor = false
        
        createCorner(toggleButton, 12)
        createButtonGradient(toggleButton, toggleButton.BackgroundColor3)
        local toggleText = createButtonText(toggleButton, default and "ON" or "OFF", toggleButton.BackgroundColor3, isMobile and 10 or 12)
        
        local toggled = default or false
        
        toggleButton.MouseButton1Click:Connect(function()
            toggled = not toggled
            local newColor = toggled and Color3.fromRGB(80, 180, 120) or Color3.fromRGB(200, 70, 70)
            toggleButton.BackgroundColor3 = newColor
            createButtonGradient(toggleButton, newColor)
            toggleText:Destroy()
            toggleText = createButtonText(toggleButton, toggled and "ON" or "OFF", newColor, isMobile and 10 or 12)
            if callback then callback(toggled) end
        end)
        
        table.insert(self.Elements, frame)
        self.Container.CanvasSize = UDim2.new(0, 0, 0, self.Layout.AbsoluteContentSize.Y + 6)
        
        return toggleButton
    end
    
    function windowObj:AddSlider(text, min, max, default, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -6, 0, isMobile and 45 or 50)
        frame.BackgroundTransparency = 1
        frame.Parent = self.Container
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0, isMobile and 18 or 20)
        label.BackgroundTransparency = 1
        label.Text = text .. ": " .. tostring(default or min)
        label.TextColor3 = Color3.fromRGB(220, 220, 255)
        label.Font = Enum.Font.GothamBold
        label.TextSize = isMobile and 11 or 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(1, 0, 0, isMobile and 12 or 14)
        sliderBg.Position = UDim2.new(0, 0, 1, -(isMobile and 18 or 20))
        sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        sliderBg.BorderSizePixel = 0
        sliderBg.Parent = frame
        
        createCorner(sliderBg, 6)
        
        local fill = Instance.new("Frame")
        fill.Size = UDim2.new((default or min) / max, 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(80, 100, 220)
        fill.BorderSizePixel = 0
        fill.Parent = sliderBg
        
        createCorner(fill, 6)
        createButtonGradient(fill, Color3.fromRGB(80, 100, 220))
        
        local dragButton = Instance.new("TextButton")
        dragButton.Size = UDim2.new(0, isMobile and 14 or 16, 0, isMobile and 14 or 16)
        dragButton.Position = UDim2.new((default or min) / max, -(isMobile and 7 or 8), 0.5, -(isMobile and 7 or 8))
        dragButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        dragButton.Text = ""
        dragButton.BorderSizePixel = 0
        dragButton.Parent = sliderBg
        dragButton.AutoButtonColor = false
        
        createCorner(dragButton, 7)
        createButtonGradient(dragButton, Color3.fromRGB(255, 255, 255))
        
        local value = default or min
        local dragging = false
        
        local function updateFromMouse(input)
            local mousePos = input.Position.X
            local sliderPos = sliderBg.AbsolutePosition.X
            local sliderSize = sliderBg.AbsoluteSize.X
            local rel = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
            local newValue = min + (max - min) * rel
            newValue = math.floor(newValue * 100) / 100
            
            fill.Size = UDim2.new(rel, 0, 1, 0)
            dragButton.Position = UDim2.new(rel, -(isMobile and 7 or 8), 0.5, -(isMobile and 7 or 8))
            label.Text = text .. ": " .. tostring(newValue)
            if callback then callback(newValue) end
        end
        
        dragButton.MouseButton1Down:Connect(function()
            dragging = true
        end)
        
        UserInputService.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        UserInputService.InputChanged:Connect(function(i)
            if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                updateFromMouse(i)
            end
        end)
        
        sliderBg.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                updateFromMouse(i)
            end
        end)
        
        table.insert(self.Elements, frame)
        self.Container.CanvasSize = UDim2.new(0, 0, 0, self.Layout.AbsoluteContentSize.Y + 6)
        
        return sliderBg
    end
    
    function windowObj:AddLabel(text)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -6, 0, isMobile and 18 or 20)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(200, 200, 255)
        label.Font = Enum.Font.GothamBold
        label.TextSize = isMobile and 11 or 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = self.Container
        
        table.insert(self.Elements, label)
        self.Container.CanvasSize = UDim2.new(0, 0, 0, self.Layout.AbsoluteContentSize.Y + 6)
        
        return label
    end
    
    function windowObj:AddCredit(text, color)
        local credit = Instance.new("TextLabel")
        credit.Size = UDim2.new(1, -12, 0, 14)
        credit.Position = UDim2.new(0, 6, 1, -16)
        credit.BackgroundTransparency = 1
        credit.Text = text
        credit.TextColor3 = color or Color3.fromRGB(170, 85, 255)
        credit.Font = Enum.Font.GothamBold
        credit.TextSize = 10
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
    notifGui.IgnoreGuiInset = true
    notifGui.DisplayOrder = 9998
    
    local frame = Instance.new("Frame")
    frame.Size = isMobile and UDim2.new(0, 220, 0, 60) or UDim2.new(0, 260, 0, 70)
    frame.Position = UDim2.new(0.5, -130, 0, -90)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.Parent = notifGui
    frame.Draggable = true
    createCorner(frame, 8)
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
    })
    gradient.Rotation = 45
    gradient.Parent = frame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -16, 0, isMobile and 20 or 22)
    titleLabel.Position = UDim2.new(0, 8, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = isMobile and 12 or 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = frame
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -16, 0, isMobile and 20 or 22)
    messageLabel.Position = UDim2.new(0, 8, 0, isMobile and 25 or 28)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    messageLabel.Font = Enum.Font.GothamBold
    messageLabel.TextSize = isMobile and 11 or 13
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
