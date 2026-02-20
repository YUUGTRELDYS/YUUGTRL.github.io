local YUUGTRL = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled

local function showLoadMessage()
    local msgGui = Instance.new("ScreenGui")
    msgGui.Name = "YUUGTRL_LoadMessage"
    msgGui.ResetOnSpawn = false
    msgGui.Parent = player:WaitForChild("PlayerGui")
    msgGui.IgnoreGuiInset = true
    msgGui.DisplayOrder = 9999
    
    local msgFrame = Instance.new("Frame")
    msgFrame.Name = "MessageFrame"
    msgFrame.Size = UDim2.new(0, 280, 0, 50)
    msgFrame.Position = UDim2.new(0.5, -140, 0, -70)
    msgFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    msgFrame.BorderSizePixel = 0
    msgFrame.ClipsDescendants = true
    msgFrame.Parent = msgGui
    
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 15, 1, 15)
    shadow.Position = UDim2.new(0, -7, 0, -7)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.9
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = msgFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = msgFrame
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
    })
    gradient.Rotation = 45
    gradient.Parent = msgFrame
    
    local msgText = Instance.new("TextLabel")
    msgText.Name = "MessageText"
    msgText.Size = UDim2.new(1, -20, 1, 0)
    msgText.Position = UDim2.new(0, 10, 0, 0)
    msgText.BackgroundTransparency = 1
    msgText.Text = "📚 YUUGTRL LIBRARY LOADED"
    msgText.TextColor3 = Color3.fromRGB(170, 85, 255)
    msgText.Font = Enum.Font.GothamBold
    msgText.TextSize = isMobile and 12 or 14
    msgText.TextXAlignment = Enum.TextXAlignment.Left
    msgText.Parent = msgFrame
    
    local versionText = Instance.new("TextLabel")
    versionText.Name = "VersionText"
    versionText.Size = UDim2.new(0, 50, 1, 0)
    versionText.Position = UDim2.new(1, -60, 0, 0)
    versionText.BackgroundTransparency = 1
    versionText.Text = "v2.0"
    versionText.TextColor3 = Color3.fromRGB(80, 100, 220)
    versionText.Font = Enum.Font.GothamBold
    versionText.TextSize = isMobile and 10 or 12
    versionText.TextXAlignment = Enum.TextXAlignment.Right
    versionText.Parent = msgFrame
    
    local tweenIn = TweenService:Create(msgFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -140, 0, 20)
    })
    tweenIn:Play()
    
    task.wait(2)
    
    local tweenOut = TweenService:Create(msgFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -140, 0, -70)
    })
    tweenOut:Play()
    tweenOut.Completed:Connect(function()
        msgGui:Destroy()
    end)
end

spawn(showLoadMessage)

local function createShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 15, 1, 15)
    shadow.Position = UDim2.new(0, -7, 0, -7)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.9
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = parent
    return shadow
end

local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 16)
    corner.Parent = parent
    return corner
end

local function createGradient(parent, from, to, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, from), ColorSequenceKeypoint.new(1, to)})
    gradient.Rotation = rotation or 90
    gradient.Parent = parent
    return gradient
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
    
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = textColor
    label.Font = Enum.Font.GothamBold
    label.TextSize = size or (isMobile and 12 or 14)
    label.TextStrokeTransparency = 1
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

function YUUGTRL:CreateWindow(title, size)
    size = size or (isMobile and UDim2.new(0, 280, 0, 320) or UDim2.new(0, 350, 0, 400))
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "YUUGTRL_" .. title
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 999
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.IgnoreGuiInset = true
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = size
    mainFrame.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    createShadow(mainFrame)
    createCorner(mainFrame, 16)
    createGradient(mainFrame, Color3.fromRGB(40, 40, 50), Color3.fromRGB(25, 25, 35), 45)
    
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, isMobile and 35 or 45)
    header.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    header.BorderSizePixel = 0
    header.Parent = mainFrame
    
    createGradient(header, Color3.fromRGB(60, 60, 80), Color3.fromRGB(40, 40, 55))
    createCorner(header, 16)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -90, 1, 0)
    titleLabel.Position = UDim2.new(0, 12, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = isMobile and 14 or 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = header
    
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, isMobile and 26 or 32, 0, isMobile and 26 or 32)
    closeButton.Position = UDim2.new(1, isMobile and -30 or -37, 0, isMobile and 4 or 6)
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 70, 70)
    closeButton.Text = ""
    closeButton.Parent = header
    
    createCorner(closeButton, 8)
    createButtonGradient(closeButton, Color3.fromRGB(200, 70, 70))
    createButtonText(closeButton, "×", Color3.fromRGB(200, 70, 70), isMobile and 16 or 20)
    
    local settingsButton = Instance.new("TextButton")
    settingsButton.Name = "SettingsButton"
    settingsButton.Size = UDim2.new(0, isMobile and 26 or 32, 0, isMobile and 26 or 32)
    settingsButton.Position = UDim2.new(1, isMobile and -60 or -75, 0, isMobile and 4 or 6)
    settingsButton.BackgroundColor3 = Color3.fromRGB(80, 100, 220)
    settingsButton.Text = ""
    settingsButton.Parent = header
    
    createCorner(settingsButton, 8)
    createButtonGradient(settingsButton, Color3.fromRGB(80, 100, 220))
    createButtonText(settingsButton, "⚙", Color3.fromRGB(80, 100, 220), isMobile and 16 or 20)
    
    makeDraggable(mainFrame, header)
    
    local container = Instance.new("Frame")
    container.Name = "Container"
    container.Size = UDim2.new(1, -20, 1, -(header.Size.Y.Offset + 20))
    container.Position = UDim2.new(0, 10, 0, header.Size.Y.Offset + 10)
    container.BackgroundTransparency = 1
    container.Parent = mainFrame
    
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Name = "ScrollingFrame"
    scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollingFrame.BackgroundTransparency = 1
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.ScrollBarThickness = 4
    scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 130)
    scrollingFrame.Parent = container
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollingFrame.ScrollingEnabled = true
    scrollingFrame.ScrollBarImageTransparency = 0.5
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, isMobile and 4 or 6)
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.Parent = scrollingFrame
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 5)
    padding.PaddingBottom = UDim.new(0, 5)
    padding.Parent = scrollingFrame
    
    local windowObj = {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        Header = header,
        CloseButton = closeButton,
        SettingsButton = settingsButton,
        Container = scrollingFrame,
        Layout = listLayout,
        Elements = {}
    }
    
    function windowObj:AddButton(text, color, callback)
        if not callback and type(color) == "function" then
            callback = color
            color = Color3.fromRGB(80, 100, 220)
        end
        
        color = color or Color3.fromRGB(80, 100, 220)
        
        local button = Instance.new("TextButton")
        button.Name = text .. "Button"
        button.Size = UDim2.new(1, -10, 0, isMobile and 35 or 40)
        button.BackgroundColor3 = color
        button.Text = ""
        button.Parent = self.Container
        button.AutoButtonColor = false
        
        createCorner(button, 10)
        createButtonGradient(button, color)
        createButtonText(button, text, color, isMobile and 12 or 14)
        
        button.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
        
        table.insert(self.Elements, button)
        
        self.Container.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
        listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            self.Container.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
        end)
        
        return button
    end
    
    function windowObj:AddToggle(text, default, callback)
        local frame = Instance.new("Frame")
        frame.Name = text .. "Toggle"
        frame.Size = UDim2.new(1, -10, 0, isMobile and 35 or 40)
        frame.BackgroundTransparency = 1
        frame.Parent = self.Container
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(220, 220, 255)
        label.Font = Enum.Font.GothamBold
        label.TextSize = isMobile and 12 or 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local toggleButton = Instance.new("TextButton")
        toggleButton.Name = "ToggleButton"
        toggleButton.Size = UDim2.new(0, isMobile and 50 or 60, 0, isMobile and 25 or 30)
        toggleButton.Position = UDim2.new(1, -(isMobile and 55 or 65), 0.5, -(isMobile and 12.5 or 15))
        toggleButton.BackgroundColor3 = default and Color3.fromRGB(80, 180, 120) or Color3.fromRGB(200, 70, 70)
        toggleButton.Text = ""
        toggleButton.Parent = frame
        toggleButton.AutoButtonColor = false
        
        createCorner(toggleButton, 15)
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
        
        table.insert(self.Elements, {frame, toggleButton})
        
        self.Container.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
        
        return toggleButton
    end
    
    function windowObj:AddSlider(text, min, max, default, callback)
        local frame = Instance.new("Frame")
        frame.Name = text .. "Slider"
        frame.Size = UDim2.new(1, -10, 0, isMobile and 45 or 55)
        frame.BackgroundTransparency = 1
        frame.Parent = self.Container
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0, isMobile and 20 or 25)
        label.BackgroundTransparency = 1
        label.Text = text .. ": " .. tostring(default or min)
        label.TextColor3 = Color3.fromRGB(220, 220, 255)
        label.Font = Enum.Font.GothamBold
        label.TextSize = isMobile and 11 or 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local sliderBg = Instance.new("Frame")
        sliderBg.Name = "SliderBg"
        sliderBg.Size = UDim2.new(1, 0, 0, isMobile and 16 or 20)
        sliderBg.Position = UDim2.new(0, 0, 1, -(isMobile and 20 or 25))
        sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        sliderBg.BorderSizePixel = 0
        sliderBg.Parent = frame
        
        createCorner(sliderBg, 10)
        
        local fill = Instance.new("Frame")
        fill.Name = "Fill"
        fill.Size = UDim2.new((default or min) / max, 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(80, 100, 220)
        fill.BorderSizePixel = 0
        fill.Parent = sliderBg
        
        createCorner(fill, 10)
        createButtonGradient(fill, Color3.fromRGB(80, 100, 220))
        
        local button = Instance.new("TextButton")
        button.Name = "DragButton"
        button.Size = UDim2.new(0, isMobile and 16 or 20, 0, isMobile and 16 or 20)
        button.Position = UDim2.new((default or min) / max, -(isMobile and 8 or 10), 0.5, -(isMobile and 8 or 10))
        button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        button.Text = ""
        button.BorderSizePixel = 0
        button.Parent = sliderBg
        button.AutoButtonColor = false
        
        createCorner(button, 10)
        createButtonGradient(button, Color3.fromRGB(255, 255, 255))
        
        local value = default or min
        local dragging = false
        
        button.MouseButton1Down:Connect(function()
            dragging = true
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local mousePos = input.Position.X
                local sliderPos = sliderBg.AbsolutePosition.X
                local sliderSize = sliderBg.AbsoluteSize.X
                local relativePos = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
                local newValue = min + (max - min) * relativePos
                newValue = math.floor(newValue * 100) / 100
                
                fill.Size = UDim2.new(relativePos, 0, 1, 0)
                button.Position = UDim2.new(relativePos, -(isMobile and 8 or 10), 0.5, -(isMobile and 8 or 10))
                label.Text = text .. ": " .. tostring(newValue)
                
                if callback then callback(newValue) end
            end
        end)
        
        table.insert(self.Elements, {frame, sliderBg})
        
        self.Container.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
        
        return sliderBg
    end
    
    function windowObj:AddLabel(text)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -10, 0, isMobile and 20 or 25)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(200, 200, 255)
        label.Font = Enum.Font.GothamBold
        label.TextSize = isMobile and 11 or 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = self.Container
        
        table.insert(self.Elements, label)
        
        self.Container.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
        
        return label
    end
    
    function windowObj:AddCredit(text, color)
        local credit = Instance.new("TextLabel")
        credit.Size = UDim2.new(1, -20, 0, 15)
        credit.Position = UDim2.new(0, 10, 1, -20)
        credit.BackgroundTransparency = 1
        credit.Text = text
        credit.TextColor3 = color or Color3.fromRGB(170, 85, 255)
        credit.Font = Enum.Font.GothamBold
        credit.TextSize = 11
        credit.TextXAlignment = Enum.TextXAlignment.Right
        credit.Parent = self.MainFrame
        return credit
    end
    
    function windowObj:CreateSettingsFrame()
        local settingsFrame = Instance.new("Frame")
        settingsFrame.Name = "SettingsFrame"
        settingsFrame.Size = isMobile and UDim2.new(0, 250, 0, 180) or UDim2.new(0, 280, 0, 200)
        settingsFrame.Position = UDim2.new(0.5, isMobile and -125 or -140, 0.5, isMobile and -90 or -100)
        settingsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        settingsFrame.BorderSizePixel = 0
        settingsFrame.Visible = false
        settingsFrame.Parent = self.ScreenGui
        
        createShadow(settingsFrame)
        createCorner(settingsFrame, 16)
        createGradient(settingsFrame, Color3.fromRGB(40, 40, 50), Color3.fromRGB(25, 25, 35), 45)
        
        local settingsHeader = Instance.new("Frame")
        settingsHeader.Name = "SettingsHeader"
        settingsHeader.Size = UDim2.new(1, 0, 0, isMobile and 35 or 40)
        settingsHeader.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        settingsHeader.BorderSizePixel = 0
        settingsHeader.Parent = settingsFrame
        
        createGradient(settingsHeader, Color3.fromRGB(60, 60, 80), Color3.fromRGB(40, 40, 55))
        createCorner(settingsHeader, 16)
        
        local settingsTitle = Instance.new("TextLabel")
        settingsTitle.Name = "SettingsTitle"
        settingsTitle.Size = UDim2.new(1, -50, 1, 0)
        settingsTitle.Position = UDim2.new(0, 15, 0, 0)
        settingsTitle.BackgroundTransparency = 1
        settingsTitle.Text = "Settings"
        settingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        settingsTitle.Font = Enum.Font.GothamBold
        settingsTitle.TextSize = isMobile and 14 or 16
        settingsTitle.TextXAlignment = Enum.TextXAlignment.Left
        settingsTitle.Parent = settingsHeader
        
        local settingsClose = Instance.new("TextButton")
        settingsClose.Name = "SettingsClose"
        settingsClose.Size = UDim2.new(0, isMobile and 25 or 30, 0, isMobile and 25 or 30)
        settingsClose.Position = UDim2.new(1, isMobile and -30 or -35, 0, isMobile and 5 or 5)
        settingsClose.BackgroundColor3 = Color3.fromRGB(200, 70, 70)
        settingsClose.Text = ""
        settingsClose.Parent = settingsHeader
        
        createCorner(settingsClose, 8)
        createButtonGradient(settingsClose, Color3.fromRGB(200, 70, 70))
        createButtonText(settingsClose, "×", Color3.fromRGB(200, 70, 70), isMobile and 16 or 18)
        
        local settingsContainer = Instance.new("Frame")
        settingsContainer.Name = "SettingsContainer"
        settingsContainer.Size = UDim2.new(1, -20, 1, -(settingsHeader.Size.Y.Offset + 20))
        settingsContainer.Position = UDim2.new(0, 10, 0, settingsHeader.Size.Y.Offset + 10)
        settingsContainer.BackgroundTransparency = 1
        settingsContainer.Parent = settingsFrame
        
        local settingsScrolling = Instance.new("ScrollingFrame")
        settingsScrolling.Size = UDim2.new(1, 0, 1, 0)
        settingsScrolling.BackgroundTransparency = 1
        settingsScrolling.BorderSizePixel = 0
        settingsScrolling.ScrollBarThickness = 4
        settingsScrolling.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 130)
        settingsScrolling.Parent = settingsContainer
        settingsScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
        
        local settingsLayout = Instance.new("UIListLayout")
        settingsLayout.Padding = UDim.new(0, isMobile and 4 or 6)
        settingsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        settingsLayout.Parent = settingsScrolling
        
        local settingsPadding = Instance.new("UIPadding")
        settingsPadding.PaddingTop = UDim.new(0, 5)
        settingsPadding.PaddingBottom = UDim.new(0, 5)
        settingsPadding.Parent = settingsScrolling
        
        makeDraggable(settingsFrame, settingsHeader)
        
        local settingsObj = {
            Frame = settingsFrame,
            Header = settingsHeader,
            CloseButton = settingsClose,
            Container = settingsScrolling,
            Layout = settingsLayout
        }
        
        function settingsObj:AddLabel(text)
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -10, 0, isMobile and 20 or 25)
            label.BackgroundTransparency = 1
            label.Text = text
            label.TextColor3 = Color3.fromRGB(200, 200, 255)
            label.Font = Enum.Font.GothamBold
            label.TextSize = isMobile and 11 or 13
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = self.Container
            
            self.Container.CanvasSize = UDim2.new(0, 0, 0, self.Layout.AbsoluteContentSize.Y + 10)
            self.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                self.Container.CanvasSize = UDim2.new(0, 0, 0, self.Layout.AbsoluteContentSize.Y + 10)
            end)
            
            return label
        end
        
        function settingsObj:AddButton(text, color, callback)
            if not callback and type(color) == "function" then
                callback = color
                color = Color3.fromRGB(80, 100, 220)
            end
            
            color = color or Color3.fromRGB(80, 100, 220)
            
            local button = Instance.new("TextButton")
            button.Name = text .. "Button"
            button.Size = UDim2.new(1, -10, 0, isMobile and 30 or 35)
            button.BackgroundColor3 = color
            button.Text = ""
            button.Parent = self.Container
            button.AutoButtonColor = false
            
            createCorner(button, 10)
            createButtonGradient(button, color)
            createButtonText(button, text, color, isMobile and 11 or 13)
            
            button.MouseButton1Click:Connect(function()
                if callback then callback() end
            end)
            
            self.Container.CanvasSize = UDim2.new(0, 0, 0, self.Layout.AbsoluteContentSize.Y + 10)
            
            return button
        end
        
        function settingsObj:AddSlider(text, min, max, default, callback)
            local frame = Instance.new("Frame")
            frame.Name = text .. "Slider"
            frame.Size = UDim2.new(1, -10, 0, isMobile and 45 or 55)
            frame.BackgroundTransparency = 1
            frame.Parent = self.Container
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, isMobile and 20 or 25)
            label.BackgroundTransparency = 1
            label.Text = text .. ": " .. tostring(default or min)
            label.TextColor3 = Color3.fromRGB(220, 220, 255)
            label.Font = Enum.Font.GothamBold
            label.TextSize = isMobile and 11 or 13
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame
            
            local sliderBg = Instance.new("Frame")
            sliderBg.Name = "SliderBg"
            sliderBg.Size = UDim2.new(1, 0, 0, isMobile and 16 or 20)
            sliderBg.Position = UDim2.new(0, 0, 1, -(isMobile and 20 or 25))
            sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            sliderBg.BorderSizePixel = 0
            sliderBg.Parent = frame
            
            createCorner(sliderBg, 10)
            
            local fill = Instance.new("Frame")
            fill.Name = "Fill"
            fill.Size = UDim2.new((default or min) / max, 0, 1, 0)
            fill.BackgroundColor3 = Color3.fromRGB(80, 100, 220)
            fill.BorderSizePixel = 0
            fill.Parent = sliderBg
            
            createCorner(fill, 10)
            createButtonGradient(fill, Color3.fromRGB(80, 100, 220))
            
            local button = Instance.new("TextButton")
            button.Name = "DragButton"
            button.Size = UDim2.new(0, isMobile and 16 or 20, 0, isMobile and 16 or 20)
            button.Position = UDim2.new((default or min) / max, -(isMobile and 8 or 10), 0.5, -(isMobile and 8 or 10))
            button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            button.Text = ""
            button.BorderSizePixel = 0
            button.Parent = sliderBg
            button.AutoButtonColor = false
            
            createCorner(button, 10)
            createButtonGradient(button, Color3.fromRGB(255, 255, 255))
            
            local value = default or min
            local dragging = false
            
            button.MouseButton1Down:Connect(function()
                dragging = true
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local mousePos = input.Position.X
                    local sliderPos = sliderBg.AbsolutePosition.X
                    local sliderSize = sliderBg.AbsoluteSize.X
                    local relativePos = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
                    local newValue = min + (max - min) * relativePos
                    newValue = math.floor(newValue * 100) / 100
                    
                    fill.Size = UDim2.new(relativePos, 0, 1, 0)
                    button.Position = UDim2.new(relativePos, -(isMobile and 8 or 10), 0.5, -(isMobile and 8 or 10))
                    label.Text = text .. ": " .. tostring(newValue)
                    
                    if callback then callback(newValue) end
                end
            end)
            
            self.Container.CanvasSize = UDim2.new(0, 0, 0, self.Layout.AbsoluteContentSize.Y + 10)
            
            return sliderBg
        end
        
        return settingsObj
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
    notifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    notifGui.DisplayOrder = 9998
    notifGui.ResetOnSpawn = false
    notifGui.Parent = player:WaitForChild("PlayerGui")
    notifGui.IgnoreGuiInset = true
    
    local frame = Instance.new("Frame")
    frame.Name = "Notification"
    frame.Size = isMobile and UDim2.new(0, 250, 0, 70) or UDim2.new(0, 300, 0, 80)
    frame.Position = UDim2.new(0.5, -150, 0, -100)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BorderSizePixel = 0
    frame.Parent = notifGui
    frame.ClipsDescendants = true
    
    createShadow(frame)
    createCorner(frame, 16)
    createGradient(frame, Color3.fromRGB(40, 40, 50), Color3.fromRGB(25, 25, 35), 45)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, isMobile and 25 or 30)
    titleLabel.Position = UDim2.new(0, 10, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = isMobile and 13 or 15
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = frame
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -20, 0, isMobile and 25 or 30)
    messageLabel.Position = UDim2.new(0, 10, 0, isMobile and 30 or 35)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    messageLabel.Font = Enum.Font.GothamBold
    messageLabel.TextSize = isMobile and 11 or 13
    messageLabel.TextWrapped = true
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.Parent = frame
    
    local tweenIn = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -150, 0, 20)
    })
    tweenIn:Play()
    
    task.wait(duration)
    
    local tweenOut = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -150, 0, -100)
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
