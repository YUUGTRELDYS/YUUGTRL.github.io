local YUUGTRL = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled

local windows = {}

local function showNotify()
    local notifyGui = Instance.new("ScreenGui")
    notifyGui.Name = "YUUGTRL_Notify"
    notifyGui.ResetOnSpawn = false
    notifyGui.Parent = player:WaitForChild("PlayerGui")
    notifyGui.IgnoreGuiInset = true
    notifyGui.DisplayOrder = 9999
    
    local frame = Instance.new("Frame")
    frame.Name = "NotifyFrame"
    frame.Size = UDim2.new(0, 160, 0, 36)
    frame.Position = UDim2.new(0.5, -80, 0, -40)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BorderSizePixel = 0
    frame.Parent = notifyGui
    frame.Draggable = true
    frame.Active = true
    
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.9
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = frame
    
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
    text.Name = "Text"
    text.Size = UDim2.new(1, -10, 1, 0)
    text.Position = UDim2.new(0, 5, 0, 0)
    text.BackgroundTransparency = 1
    text.Text = "YUUGTRL"
    text.TextColor3 = Color3.fromRGB(170, 85, 255)
    text.Font = Enum.Font.GothamBold
    text.TextSize = 16
    text.TextXAlignment = Enum.TextXAlignment.Center
    text.Parent = frame
    
    local tweenIn = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -80, 0, 20)
    })
    tweenIn:Play()
    
    task.wait(1.2)
    
    local tweenOut = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -80, 0, -40)
    })
    tweenOut:Play()
    tweenOut.Completed:Connect(function()
        notifyGui:Destroy()
    end)
end

spawn(showNotify)

local function createShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
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
    corner.CornerRadius = UDim.new(0, radius or 8)
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

local function createButtonGradient(button, baseColor, isPressed)
    local r, g, b = baseColor.R, baseColor.G, baseColor.B
    
    local top, bottom
    if isPressed then
        top = Color3.new(r * 0.6, g * 0.6, b * 0.6)
        bottom = Color3.new(r * 0.4, g * 0.4, b * 0.4)
    else
        top = Color3.new(math.min(r * 1.3, 1), math.min(g * 1.3, 1), math.min(b * 1.3, 1))
        bottom = Color3.new(r * 0.7, g * 0.7, b * 0.7)
    end
    
    for _, child in pairs(button:GetChildren()) do
        if child:IsA("UIGradient") then
            child:Destroy()
        end
    end
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, top),
        ColorSequenceKeypoint.new(1, bottom)
    })
    gradient.Rotation = 90
    gradient.Parent = button
end

local function createButtonText(button, text, baseColor, size, isPressed)
    local r, g, b = baseColor.R, baseColor.G, baseColor.B
    local textColor
    
    if isPressed then
        textColor = Color3.new(r * 0.8, g * 0.8, b * 0.8)
    else
        textColor = Color3.new(math.min(r * 1.4, 1), math.min(g * 1.4, 1), math.min(b * 1.4, 1))
    end
    
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

function YUUGTRL:CreateWindow(title, size, options)
    options = options or {}
    size = size or (isMobile and UDim2.new(0, 260, 0, 300) or UDim2.new(0, 320, 0, 360))
    
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
    
    table.insert(windows, mainFrame)
    
    createShadow(mainFrame)
    createCorner(mainFrame, 8)
    createGradient(mainFrame, Color3.fromRGB(40, 40, 50), Color3.fromRGB(25, 25, 35), 45)
    
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, isMobile and 30 or 35)
    header.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    header.BorderSizePixel = 0
    header.Parent = mainFrame
    
    createGradient(header, Color3.fromRGB(60, 60, 80), Color3.fromRGB(40, 40, 55))
    createCorner(header, 8)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -20, 1, 0)
    titleLabel.Position = UDim2.new(0, 8, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = isMobile and 13 or 15
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = header
    
    if options.ShowClose ~= false then
        local closeButton = Instance.new("TextButton")
        closeButton.Name = "CloseButton"
        closeButton.Size = UDim2.new(0, isMobile and 22 or 24, 0, isMobile and 22 or 24)
        closeButton.Position = UDim2.new(1, -(isMobile and 26 or 28), 0, isMobile and 4 or 5)
        closeButton.BackgroundColor3 = options.CloseColor or Color3.fromRGB(200, 70, 70)
        closeButton.Text = ""
        closeButton.Parent = header
        
        createCorner(closeButton, 6)
        createButtonGradient(closeButton, closeButton.BackgroundColor3, false)
        createButtonText(closeButton, "×", closeButton.BackgroundColor3, isMobile and 14 or 15, false)
        
        closeButton.MouseButton1Down:Connect(function()
            createButtonGradient(closeButton, closeButton.BackgroundColor3, true)
            createButtonText(closeButton, "×", closeButton.BackgroundColor3, isMobile and 14 or 15, true)
        end)
        
        closeButton.MouseButton1Up:Connect(function()
            createButtonGradient(closeButton, closeButton.BackgroundColor3, false)
            createButtonText(closeButton, "×", closeButton.BackgroundColor3, isMobile and 14 or 15, false)
        end)
        
        closeButton.MouseLeave:Connect(function()
            createButtonGradient(closeButton, closeButton.BackgroundColor3, false)
            createButtonText(closeButton, "×", closeButton.BackgroundColor3, isMobile and 14 or 15, false)
        end)
        
        windowObj.CloseButton = closeButton
    end
    
    if options.ShowSettings then
        local settingsButton = Instance.new("TextButton")
        settingsButton.Name = "SettingsButton"
        settingsButton.Size = UDim2.new(0, isMobile and 22 or 24, 0, isMobile and 22 or 24)
        settingsButton.Position = options.SettingsPosition or UDim2.new(1, -(isMobile and 52 or 56), 0, isMobile and 4 or 5)
        settingsButton.BackgroundColor3 = options.SettingsColor or Color3.fromRGB(80, 100, 220)
        settingsButton.Text = ""
        settingsButton.Parent = header
        
        createCorner(settingsButton, 6)
        createButtonGradient(settingsButton, settingsButton.BackgroundColor3, false)
        createButtonText(settingsButton, "⚙", settingsButton.BackgroundColor3, isMobile and 14 or 15, false)
        
        settingsButton.MouseButton1Down:Connect(function()
            createButtonGradient(settingsButton, settingsButton.BackgroundColor3, true)
            createButtonText(settingsButton, "⚙", settingsButton.BackgroundColor3, isMobile and 14 or 15, true)
        end)
        
        settingsButton.MouseButton1Up:Connect(function()
            createButtonGradient(settingsButton, settingsButton.BackgroundColor3, false)
            createButtonText(settingsButton, "⚙", settingsButton.BackgroundColor3, isMobile and 14 or 15, false)
        end)
        
        settingsButton.MouseLeave:Connect(function()
            createButtonGradient(settingsButton, settingsButton.BackgroundColor3, false)
            createButtonText(settingsButton, "⚙", settingsButton.BackgroundColor3, isMobile and 14 or 15, false)
        end)
        
        windowObj.SettingsButton = settingsButton
    end
    
    makeDraggable(mainFrame, header)
    
    local container = Instance.new("Frame")
    container.Name = "Container"
    container.Size = UDim2.new(1, -12, 1, -(header.Size.Y.Offset + 12))
    container.Position = UDim2.new(0, 6, 0, header.Size.Y.Offset + 6)
    container.BackgroundTransparency = 1
    container.Parent = mainFrame
    
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Name = "ScrollingFrame"
    scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollingFrame.BackgroundTransparency = 1
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.ScrollBarThickness = 3
    scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 130)
    scrollingFrame.Parent = container
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollingFrame.ScrollingEnabled = true
    scrollingFrame.ScrollBarImageTransparency = 0.5
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, isMobile and 3 or 4)
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.Parent = scrollingFrame
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 3)
    padding.PaddingBottom = UDim.new(0, 3)
    padding.Parent = scrollingFrame
    
    local windowObj = {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        Header = header,
        Container = scrollingFrame,
        Layout = listLayout,
        Elements = {}
    }
    
    function windowObj:AddButton(text, color, callback, toggleMode)
        if not callback and type(color) == "function" then
            callback = color
            color = Color3.fromRGB(80, 100, 220)
            toggleMode = false
        elseif type(toggleMode) == "function" then
            callback = toggleMode
            toggleMode = false
        end
        
        color = color or Color3.fromRGB(80, 100, 220)
        
        local button = Instance.new("TextButton")
        button.Name = text .. "Button"
        button.Size = UDim2.new(1, -6, 0, isMobile and 30 or 32)
        button.BackgroundColor3 = color
        button.Text = ""
        button.Parent = self.Container
        button.AutoButtonColor = false
        
        local isPressed = false
        local isToggled = false
        
        createCorner(button, 6)
        createButtonGradient(button, color, false)
        local buttonText = createButtonText(button, text, color, isMobile and 11 or 12, false)
        
        if toggleMode then
            button.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                if isToggled then
                    createButtonGradient(button, color, true)
                    createButtonText(button, "✓ " .. text, color, isMobile and 11 or 12, true)
                else
                    createButtonGradient(button, color, false)
                    createButtonText(button, text, color, isMobile and 11 or 12, false)
                end
                if callback then callback(isToggled) end
            end)
        else
            button.MouseButton1Down:Connect(function()
                isPressed = true
                createButtonGradient(button, color, true)
                createButtonText(button, text, color, isMobile and 11 or 12, true)
            end)
            
            button.MouseButton1Up:Connect(function()
                if isPressed then
                    isPressed = false
                    createButtonGradient(button, color, false)
                    createButtonText(button, text, color, isMobile and 11 or 12, false)
                    if callback then callback() end
                end
            end)
            
            button.MouseLeave:Connect(function()
                if isPressed then
                    isPressed = false
                    createButtonGradient(button, color, false)
                    createButtonText(button, text, color, isMobile and 11 or 12, false)
                end
            end)
        end
        
        table.insert(self.Elements, button)
        
        self.Container.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 6)
        listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            self.Container.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 6)
        end)
        
        return button
    end
    
    function windowObj:AddToggle(text, default, callback)
        local frame = Instance.new("Frame")
        frame.Name = text .. "Toggle"
        frame.Size = UDim2.new(1, -6, 0, isMobile and 30 or 32)
        frame.BackgroundTransparency = 1
        frame.Parent = self.Container
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(220, 220, 255)
        label.Font = Enum.Font.GothamBold
        label.TextSize = isMobile and 11 or 12
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local toggleButton = Instance.new("TextButton")
        toggleButton.Name = "ToggleButton"
        toggleButton.Size = UDim2.new(0, isMobile and 45 or 50, 0, isMobile and 22 or 24)
        toggleButton.Position = UDim2.new(1, -(isMobile and 50 or 55), 0.5, -(isMobile and 11 or 12))
        toggleButton.BackgroundColor3 = default and Color3.fromRGB(80, 180, 120) or Color3.fromRGB(200, 70, 70)
        toggleButton.Text = ""
        toggleButton.Parent = frame
        toggleButton.AutoButtonColor = false
        
        createCorner(toggleButton, 12)
        createButtonGradient(toggleButton, toggleButton.BackgroundColor3, false)
        local toggleText = createButtonText(toggleButton, default and "ON" or "OFF", toggleButton.BackgroundColor3, isMobile and 9 or 10, false)
        
        local toggled = default or false
        
        toggleButton.MouseButton1Down:Connect(function()
            createButtonGradient(toggleButton, toggleButton.BackgroundColor3, true)
            createButtonText(toggleButton, toggleText.Text, toggleButton.BackgroundColor3, isMobile and 9 or 10, true)
        end)
        
        toggleButton.MouseButton1Up:Connect(function()
            toggled = not toggled
            local newColor = toggled and Color3.fromRGB(80, 180, 120) or Color3.fromRGB(200, 70, 70)
            toggleButton.BackgroundColor3 = newColor
            createButtonGradient(toggleButton, newColor, false)
            toggleText:Destroy()
            toggleText = createButtonText(toggleButton, toggled and "ON" or "OFF", newColor, isMobile and 9 or 10, false)
            if callback then callback(toggled) end
        end)
        
        toggleButton.MouseLeave:Connect(function()
            createButtonGradient(toggleButton, toggleButton.BackgroundColor3, false)
            createButtonText(toggleButton, toggleText.Text, toggleButton.BackgroundColor3, isMobile and 9 or 10, false)
        end)
        
        table.insert(self.Elements, {frame, toggleButton})
        
        self.Container.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 6)
        
        return toggleButton
    end
    
    function windowObj:AddSlider(text, min, max, default, callback)
        local frame = Instance.new("Frame")
        frame.Name = text .. "Slider"
        frame.Size = UDim2.new(1, -6, 0, isMobile and 40 or 45)
        frame.BackgroundTransparency = 1
        frame.Parent = self.Container
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0, isMobile and 16 or 18)
        label.BackgroundTransparency = 1
        label.Text = text .. ": " .. tostring(default or min)
        label.TextColor3 = Color3.fromRGB(220, 220, 255)
        label.Font = Enum.Font.GothamBold
        label.TextSize = isMobile and 10 or 11
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local sliderBg = Instance.new("Frame")
        sliderBg.Name = "SliderBg"
        sliderBg.Size = UDim2.new(1, 0, 0, isMobile and 12 or 14)
        sliderBg.Position = UDim2.new(0, 0, 1, -(isMobile and 16 or 18))
        sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        sliderBg.BorderSizePixel = 0
        sliderBg.Parent = frame
        
        createCorner(sliderBg, 6)
        
        local fill = Instance.new("Frame")
        fill.Name = "Fill"
        fill.Size = UDim2.new((default or min) / max, 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(80, 100, 220)
        fill.BorderSizePixel = 0
        fill.Parent = sliderBg
        
        createCorner(fill, 6)
        createButtonGradient(fill, Color3.fromRGB(80, 100, 220), false)
        
        local button = Instance.new("TextButton")
        button.Name = "DragButton"
        button.Size = UDim2.new(0, isMobile and 14 or 16, 0, isMobile and 14 or 16)
        button.Position = UDim2.new((default or min) / max, - (isMobile and 7 or 8), 0.5, - (isMobile and 7 or 8))
        button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        button.Text = ""
        button.BorderSizePixel = 0
        button.Parent = sliderBg
        button.AutoButtonColor = false
        
        createCorner(button, 7)
        createButtonGradient(button, Color3.fromRGB(255, 255, 255), false)
        
        local value = default or min
        local dragging = false
        
        local function updateFromMouse(input)
            local mousePos = input.Position.X
            local sliderPos = sliderBg.AbsolutePosition.X
            local sliderSize = sliderBg.AbsoluteSize.X
            local relativePos = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
            local newValue = min + (max - min) * relativePos
            newValue = math.floor(newValue * 100) / 100
            
            fill.Size = UDim2.new(relativePos, 0, 1, 0)
            button.Position = UDim2.new(relativePos, - (isMobile and 7 or 8), 0.5, - (isMobile and 7 or 8))
            label.Text = text .. ": " .. tostring(newValue)
            
            if callback then callback(newValue) end
        end
        
        button.MouseButton1Down:Connect(function()
            dragging = true
            createButtonGradient(button, Color3.fromRGB(255, 255, 255), true)
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
                createButtonGradient(button, Color3.fromRGB(255, 255, 255), false)
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                updateFromMouse(input)
            end
        end)
        
        sliderBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                updateFromMouse(input)
            end
        end)
        
        table.insert(self.Elements, {frame, sliderBg})
        
        self.Container.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 6)
        
        return sliderBg
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
    
    function windowObj:CreateDropdown(text, options, callback)
        local frame = Instance.new("Frame")
        frame.Name = text .. "Dropdown"
        frame.Size = UDim2.new(1, -6, 0, isMobile and 30 or 32)
        frame.BackgroundTransparency = 1
        frame.Parent = self.Container
        
        local button = Instance.new("TextButton")
        button.Name = "DropdownButton"
        button.Size = UDim2.new(1, 0, 1, 0)
        button.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        button.Text = text .. " ▼"
        button.TextColor3 = Color3.fromRGB(200, 200, 255)
        button.Font = Enum.Font.GothamBold
        button.TextSize = isMobile and 10 or 11
        button.Parent = frame
        
        createCorner(button, 6)
        createButtonGradient(button, Color3.fromRGB(45, 45, 55), false)
        local buttonText = createButtonText(button, text .. " ▼", Color3.fromRGB(45, 45, 55), isMobile and 10 or 11, false)
        
        button.MouseButton1Down:Connect(function()
            createButtonGradient(button, Color3.fromRGB(45, 45, 55), true)
            createButtonText(button, text .. " ▼", Color3.fromRGB(45, 45, 55), isMobile and 10 or 11, true)
        end)
        
        button.MouseButton1Up:Connect(function()
            createButtonGradient(button, Color3.fromRGB(45, 45, 55), false)
            createButtonText(button, text .. " ▼", Color3.fromRGB(45, 45, 55), isMobile and 10 or 11, false)
        end)
        
        button.MouseLeave:Connect(function()
            createButtonGradient(button, Color3.fromRGB(45, 45, 55), false)
            createButtonText(button, text .. " ▼", Color3.fromRGB(45, 45, 55), isMobile and 10 or 11, false)
        end)
        
        local dropdownFrame = Instance.new("Frame")
        dropdownFrame.Name = "DropdownFrame"
        dropdownFrame.Size = UDim2.new(1, 0, 0, #options * (isMobile and 24 or 26))
        dropdownFrame.Position = UDim2.new(0, 0, 1, 4)
        dropdownFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        dropdownFrame.BorderSizePixel = 0
        dropdownFrame.Visible = false
        dropdownFrame.Parent = frame
        
        createShadow(dropdownFrame)
        createCorner(dropdownFrame, 6)
        
        local dropdownList = Instance.new("ScrollingFrame")
        dropdownList.Size = UDim2.new(1, -8, 1, -8)
        dropdownList.Position = UDim2.new(0, 4, 0, 4)
        dropdownList.BackgroundTransparency = 1
        dropdownList.ScrollBarThickness = 2
        dropdownList.Parent = dropdownFrame
        
        local dropdownLayout = Instance.new("UIListLayout")
        dropdownLayout.Padding = UDim.new(0, 1)
        dropdownLayout.Parent = dropdownList
        
        for _, option in ipairs(options) do
            local optionButton = Instance.new("TextButton")
            optionButton.Name = option .. "Option"
            optionButton.Size = UDim2.new(1, 0, 0, isMobile and 22 or 24)
            optionButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            optionButton.Text = option
            optionButton.TextColor3 = Color3.fromRGB(200, 200, 255)
            optionButton.Font = Enum.Font.GothamBold
            optionButton.TextSize = isMobile and 9 or 10
            optionButton.Parent = dropdownList
            
            createCorner(optionButton, 4)
            createButtonGradient(optionButton, Color3.fromRGB(45, 45, 55), false)
            local optionText = createButtonText(optionButton, option, Color3.fromRGB(45, 45, 55), isMobile and 9 or 10, false)
            
            optionButton.MouseButton1Down:Connect(function()
                createButtonGradient(optionButton, Color3.fromRGB(45, 45, 55), true)
                createButtonText(optionButton, option, Color3.fromRGB(45, 45, 55), isMobile and 9 or 10, true)
            end)
            
            optionButton.MouseButton1Up:Connect(function()
                createButtonGradient(optionButton, Color3.fromRGB(45, 45, 55), false)
                createButtonText(optionButton, option, Color3.fromRGB(45, 45, 55), isMobile and 9 or 10, false)
                button.Text = option .. " ▼"
                buttonText:Destroy()
                buttonText = createButtonText(button, option .. " ▼", Color3.fromRGB(45, 45, 55), isMobile and 10 or 11, false)
                dropdownFrame.Visible = false
                if callback then callback(option) end
            end)
            
            optionButton.MouseLeave:Connect(function()
                createButtonGradient(optionButton, Color3.fromRGB(45, 45, 55), false)
                createButtonText(optionButton, option, Color3.fromRGB(45, 45, 55), isMobile and 9 or 10, false)
            end)
        end
        
        button.MouseButton1Click:Connect(function()
            dropdownFrame.Visible = not dropdownFrame.Visible
        end)
        
        table.insert(self.Elements, {frame, dropdownFrame})
        
        self.Container.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 6)
        
        return dropdownFrame
    end
    
    function windowObj:CreateTextBox(text, placeholder, callback)
        local frame = Instance.new("Frame")
        frame.Name = text .. "TextBox"
        frame.Size = UDim2.new(1, -6, 0, isMobile and 30 or 32)
        frame.BackgroundTransparency = 1
        frame.Parent = self.Container
        
        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Size = UDim2.new(0.3, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(200, 200, 255)
        label.Font = Enum.Font.GothamBold
        label.TextSize = isMobile and 10 or 11
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local box = Instance.new("TextBox")
        box.Name = "TextBox"
        box.Size = UDim2.new(0.65, 0, 0, isMobile and 22 or 24)
        box.Position = UDim2.new(0.35, 0, 0.5, -(isMobile and 11 or 12))
        box.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        box.PlaceholderText = placeholder or ""
        box.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
        box.Text = ""
        box.TextColor3 = Color3.fromRGB(255, 255, 255)
        box.Font = Enum.Font.Gotham
        box.TextSize = isMobile and 9 or 10
        box.ClearTextOnFocus = false
        box.Parent = frame
        
        createCorner(box, 5)
        createButtonGradient(box, Color3.fromRGB(45, 45, 55), false)
        
        box.Focused:Connect(function()
            createButtonGradient(box, Color3.fromRGB(45, 45, 55), true)
        end)
        
        box.FocusLost:Connect(function(enterPressed)
            createButtonGradient(box, Color3.fromRGB(45, 45, 55), false)
            if enterPressed and callback then
                callback(box.Text)
            end
        end)
        
        table.insert(self.Elements, {frame, box})
        
        self.Container.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 6)
        
        return box
    end
    
    function windowObj:CreateTab(tabName)
        local tabFrame = Instance.new("Frame")
        tabFrame.Name = tabName .. "Tab"
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false
        tabFrame.Parent = self.Container
        
        local tabLayout = Instance.new("UIListLayout")
        tabLayout.Padding = UDim.new(0, isMobile and 3 or 4)
        tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        tabLayout.Parent = tabFrame
        
        local tabPadding = Instance.new("UIPadding")
        tabPadding.PaddingTop = UDim.new(0, 3)
        tabPadding.PaddingBottom = UDim.new(0, 3)
        tabPadding.Parent = tabFrame
        
        local tabObj = {
            Frame = tabFrame,
            Layout = tabLayout,
            Elements = {}
        }
        
        function tabObj:AddButton(text, color, callback, toggleMode)
            local btn = windowObj:AddButton(text, color, callback, toggleMode)
            btn.Parent = tabFrame
            table.insert(self.Elements, btn)
            return btn
        end
        
        function tabObj:AddToggle(text, default, callback)
            local tog = windowObj:AddToggle(text, default, callback)
            tog.Parent = tabFrame
            table.insert(self.Elements, tog)
            return tog
        end
        
        function tabObj:AddSlider(text, min, max, default, callback)
            local slid = windowObj:AddSlider(text, min, max, default, callback)
            slid.Parent = tabFrame
            table.insert(self.Elements, slid)
            return slid
        end
        
        function tabObj:AddLabel(text)
            local lbl = windowObj:AddLabel(text)
            lbl.Parent = tabFrame
            table.insert(self.Elements, lbl)
            return lbl
        end
        
        table.insert(self.Elements, tabFrame)
        return tabObj
    end
    
    function windowObj:CreateTabBar(tabs)
        local barFrame = Instance.new("Frame")
        barFrame.Name = "TabBar"
        barFrame.Size = UDim2.new(1, -6, 0, isMobile and 30 or 32)
        barFrame.BackgroundTransparency = 1
        barFrame.Parent = self.Container
        
        local barLayout = Instance.new("UIListLayout")
        barLayout.FillDirection = Enum.FillDirection.Horizontal
        barLayout.Padding = UDim.new(0, 3)
        barLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        barLayout.Parent = barFrame
        
        local tabObjects = {}
        local currentTab = nil
        
        for i, tabName in ipairs(tabs) do
            local tabButton = Instance.new("TextButton")
            tabButton.Name = tabName .. "TabButton"
            tabButton.Size = UDim2.new(0, (self.Container.AbsoluteSize.X - 30) / #tabs, 0, isMobile and 26 or 28)
            tabButton.BackgroundColor3 = Color3.fromRGB(80, 100, 220)
            tabButton.Text = tabName
            tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            tabButton.Font = Enum.Font.GothamBold
            tabButton.TextSize = isMobile and 9 or 10
            tabButton.Parent = barFrame
            
            createCorner(tabButton, 6)
            createButtonGradient(tabButton, Color3.fromRGB(80, 100, 220), false)
            local tabText = createButtonText(tabButton, tabName, Color3.fromRGB(80, 100, 220), isMobile and 9 or 10, false)
            
            tabButton.MouseButton1Down:Connect(function()
                createButtonGradient(tabButton, Color3.fromRGB(80, 100, 220), true)
                createButtonText(tabButton, tabName, Color3.fromRGB(80, 100, 220), isMobile and 9 or 10, true)
            end)
            
            tabButton.MouseButton1Up:Connect(function()
                createButtonGradient(tabButton, Color3.fromRGB(80, 100, 220), false)
                createButtonText(tabButton, tabName, Color3.fromRGB(80, 100, 220), isMobile and 9 or 10, false)
            end)
            
            tabButton.MouseLeave:Connect(function()
                createButtonGradient(tabButton, Color3.fromRGB(80, 100, 220), false)
                createButtonText(tabButton, tabName, Color3.fromRGB(80, 100, 220), isMobile and 9 or 10, false)
            end)
            
            local tabContent = self:CreateTab(tabName)
            tabContent.Frame.Position = UDim2.new(0, 0, 0, barFrame.Size.Y.Offset + 6)
            
            if i == 1 then
                tabContent.Frame.Visible = true
                tabButton.BackgroundColor3 = Color3.fromRGB(140, 80, 220)
                currentTab = tabContent
            end
            
            tabButton.MouseButton1Click:Connect(function()
                if currentTab then
                    currentTab.Frame.Visible = false
                end
                for _, btn in ipairs(barFrame:GetChildren()) do
                    if btn:IsA("TextButton") then
                        btn.BackgroundColor3 = Color3.fromRGB(80, 100, 220)
                    end
                end
                tabButton.BackgroundColor3 = Color3.fromRGB(140, 80, 220)
                tabContent.Frame.Visible = true
                currentTab = tabContent
            end)
            
            table.insert(tabObjects, {Button = tabButton, Content = tabContent})
        end
        
        table.insert(self.Elements, barFrame)
        return tabObjects
    end
    
    function windowObj:CreateSettingsFrame()
        local settingsFrame = Instance.new("Frame")
        settingsFrame.Name = "SettingsFrame"
        settingsFrame.Size = isMobile and UDim2.new(0, 220, 0, 160) or UDim2.new(0, 250, 0, 180)
        settingsFrame.Position = UDim2.new(0.5, isMobile and -110 or -125, 0.5, isMobile and -80 or -90)
        settingsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        settingsFrame.BorderSizePixel = 0
        settingsFrame.Visible = false
        settingsFrame.Parent = self.ScreenGui
        
        createShadow(settingsFrame)
        createCorner(settingsFrame, 8)
        createGradient(settingsFrame, Color3.fromRGB(40, 40, 50), Color3.fromRGB(25, 25, 35), 45)
        
        local settingsHeader = Instance.new("Frame")
        settingsHeader.Name = "SettingsHeader"
        settingsHeader.Size = UDim2.new(1, 0, 0, isMobile and 28 or 30)
        settingsHeader.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        settingsHeader.BorderSizePixel = 0
        settingsHeader.Parent = settingsFrame
        
        createGradient(settingsHeader, Color3.fromRGB(60, 60, 80), Color3.fromRGB(40, 40, 55))
        createCorner(settingsHeader, 8)
        
        local settingsTitle = Instance.new("TextLabel")
        settingsTitle.Name = "SettingsTitle"
        settingsTitle.Size = UDim2.new(1, -40, 1, 0)
        settingsTitle.Position = UDim2.new(0, 10, 0, 0)
        settingsTitle.BackgroundTransparency = 1
        settingsTitle.Text = "Settings"
        settingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        settingsTitle.Font = Enum.Font.GothamBold
        settingsTitle.TextSize = isMobile and 12 or 13
        settingsTitle.TextXAlignment = Enum.TextXAlignment.Left
        settingsTitle.Parent = settingsHeader
        
        local settingsClose = Instance.new("TextButton")
        settingsClose.Name = "SettingsClose"
        settingsClose.Size = UDim2.new(0, isMobile and 22 or 24, 0, isMobile and 22 or 24)
        settingsClose.Position = UDim2.new(1, isMobile and -26 or -28, 0, isMobile and 3 or 3)
        settingsClose.BackgroundColor3 = Color3.fromRGB(200, 70, 70)
        settingsClose.Text = ""
        settingsClose.Parent = settingsHeader
        
        createCorner(settingsClose, 6)
        createButtonGradient(settingsClose, Color3.fromRGB(200, 70, 70), false)
        createButtonText(settingsClose, "×", Color3.fromRGB(200, 70, 70), isMobile and 14 or 15, false)
        
        settingsClose.MouseButton1Down:Connect(function()
            createButtonGradient(settingsClose, Color3.fromRGB(200, 70, 70), true)
            createButtonText(settingsClose, "×", Color3.fromRGB(200, 70, 70), isMobile and 14 or 15, true)
        end)
        
        settingsClose.MouseButton1Up:Connect(function()
            createButtonGradient(settingsClose, Color3.fromRGB(200, 70, 70), false)
            createButtonText(settingsClose, "×", Color3.fromRGB(200, 70, 70), isMobile and 14 or 15, false)
        end)
        
        settingsClose.MouseLeave:Connect(function()
            createButtonGradient(settingsClose, Color3.fromRGB(200, 70, 70), false)
            createButtonText(settingsClose, "×", Color3.fromRGB(200, 70, 70), isMobile and 14 or 15, false)
        end)
        
        local settingsContainer = Instance.new("Frame")
        settingsContainer.Name = "SettingsContainer"
        settingsContainer.Size = UDim2.new(1, -12, 1, -(settingsHeader.Size.Y.Offset + 12))
        settingsContainer.Position = UDim2.new(0, 6, 0, settingsHeader.Size.Y.Offset + 6)
        settingsContainer.BackgroundTransparency = 1
        settingsContainer.Parent = settingsFrame
        
        local settingsScrolling = Instance.new("ScrollingFrame")
        settingsScrolling.Size = UDim2.new(1, 0, 1, 0)
        settingsScrolling.BackgroundTransparency = 1
        settingsScrolling.BorderSizePixel = 0
        settingsScrolling.ScrollBarThickness = 3
        settingsScrolling.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 130)
        settingsScrolling.Parent = settingsContainer
        settingsScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
        
        local settingsLayout = Instance.new("UIListLayout")
        settingsLayout.Padding = UDim.new(0, isMobile and 3 or 4)
        settingsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        settingsLayout.Parent = settingsScrolling
        
        local settingsPadding = Instance.new("UIPadding")
        settingsPadding.PaddingTop = UDim.new(0, 3)
        settingsPadding.PaddingBottom = UDim.new(0, 3)
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
            label.Size = UDim2.new(1, -6, 0, isMobile and 16 or 18)
            label.BackgroundTransparency = 1
            label.Text = text
            label.TextColor3 = Color3.fromRGB(200, 200, 255)
            label.Font = Enum.Font.GothamBold
            label.TextSize = isMobile and 10 or 11
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = self.Container
            
            self.Container.CanvasSize = UDim2.new(0, 0, 0, self.Layout.AbsoluteContentSize.Y + 6)
            self.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                self.Container.CanvasSize = UDim2.new(0, 0, 0, self.Layout.AbsoluteContentSize.Y + 6)
            end)
            
            return label
        end
        
        function settingsObj:AddButton(text, color, callback, toggleMode)
            if not callback and type(color) == "function" then
                callback = color
                color = Color3.fromRGB(80, 100, 220)
                toggleMode = false
            elseif type(toggleMode) == "function" then
                callback = toggleMode
                toggleMode = false
            end
            
            color = color or Color3.fromRGB(80, 100, 220)
            
            local button = Instance.new("TextButton")
            button.Name = text .. "Button"
            button.Size = UDim2.new(1, -6, 0, isMobile and 26 or 28)
            button.BackgroundColor3 = color
            button.Text = ""
            button.Parent = self.Container
            button.AutoButtonColor = false
            
            local isPressed = false
            local isToggled = false
            
            createCorner(button, 5)
            createButtonGradient(button, color, false)
            local buttonText = createButtonText(button, text, color, isMobile and 10 or 11, false)
            
            if toggleMode then
                button.MouseButton1Click:Connect(function()
                    isToggled = not isToggled
                    if isToggled then
                        createButtonGradient(button, color, true)
                        createButtonText(button, "✓ " .. text, color, isMobile and 10 or 11, true)
                    else
                        createButtonGradient(button, color, false)
                        createButtonText(button, text, color, isMobile and 10 or 11, false)
                    end
                    if callback then callback(isToggled) end
                end)
            else
                button.MouseButton1Down:Connect(function()
                    isPressed = true
                    createButtonGradient(button, color, true)
                    createButtonText(button, text, color, isMobile and 10 or 11, true)
                end)
                
                button.MouseButton1Up:Connect(function()
                    if isPressed then
                        isPressed = false
                        createButtonGradient(button, color, false)
                        createButtonText(button, text, color, isMobile and 10 or 11, false)
                        if callback then callback() end
                    end
                end)
                
                button.MouseLeave:Connect(function()
                    if isPressed then
                        isPressed = false
                        createButtonGradient(button, color, false)
                        createButtonText(button, text, color, isMobile and 10 or 11, false)
                    end
                end)
            end
            
            self.Container.CanvasSize = UDim2.new(0, 0, 0, self.Layout.AbsoluteContentSize.Y + 6)
            
            return button
        end
        
        function settingsObj:AddSlider(text, min, max, default, callback)
            local frame = Instance.new("Frame")
            frame.Name = text .. "Slider"
            frame.Size = UDim2.new(1, -6, 0, isMobile and 38 or 42)
            frame.BackgroundTransparency = 1
            frame.Parent = self.Container
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, isMobile and 16 or 18)
            label.BackgroundTransparency = 1
            label.Text = text .. ": " .. tostring(default or min)
            label.TextColor3 = Color3.fromRGB(220, 220, 255)
            label.Font = Enum.Font.GothamBold
            label.TextSize = isMobile and 10 or 11
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame
            
            local sliderBg = Instance.new("Frame")
            sliderBg.Name = "SliderBg"
            sliderBg.Size = UDim2.new(1, 0, 0, isMobile and 10 or 12)
            sliderBg.Position = UDim2.new(0, 0, 1, -(isMobile and 16 or 18))
            sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            sliderBg.BorderSizePixel = 0
            sliderBg.Parent = frame
            
            createCorner(sliderBg, 5)
            
            local fill = Instance.new("Frame")
            fill.Name = "Fill"
            fill.Size = UDim2.new((default or min) / max, 0, 1, 0)
            fill.BackgroundColor3 = Color3.fromRGB(80, 100, 220)
            fill.BorderSizePixel = 0
            fill.Parent = sliderBg
            
            createCorner(fill, 5)
            createButtonGradient(fill, Color3.fromRGB(80, 100, 220), false)
            
            local button = Instance.new("TextButton")
            button.Name = "DragButton"
            button.Size = UDim2.new(0, isMobile and 12 or 14, 0, isMobile and 12 or 14)
            button.Position = UDim2.new((default or min) / max, - (isMobile and 6 or 7), 0.5, - (isMobile and 6 or 7))
            button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            button.Text = ""
            button.BorderSizePixel = 0
            button.Parent = sliderBg
            button.AutoButtonColor = false
            
            createCorner(button, 6)
            createButtonGradient(button, Color3.fromRGB(255, 255, 255), false)
            
            local value = default or min
            local dragging = false
            
            local function updateFromMouse(input)
                local mousePos = input.Position.X
                local sliderPos = sliderBg.AbsolutePosition.X
                local sliderSize = sliderBg.AbsoluteSize.X
                local relativePos = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
                local newValue = min + (max - min) * relativePos
                newValue = math.floor(newValue * 100) / 100
                
                fill.Size = UDim2.new(relativePos, 0, 1, 0)
                button.Position = UDim2.new(relativePos, - (isMobile and 6 or 7), 0.5, - (isMobile and 6 or 7))
                label.Text = text .. ": " .. tostring(newValue)
                
                if callback then callback(newValue) end
            end
            
            button.MouseButton1Down:Connect(function()
                dragging = true
                createButtonGradient(button, Color3.fromRGB(255, 255, 255), true)
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                    createButtonGradient(button, Color3.fromRGB(255, 255, 255), false)
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateFromMouse(input)
                end
            end)
            
            sliderBg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    updateFromMouse(input)
                end
            end)
            
            self.Container.CanvasSize = UDim2.new(0, 0, 0, self.Layout.AbsoluteContentSize.Y + 6)
            
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
    frame.Size = isMobile and UDim2.new(0, 220, 0, 60) or UDim2.new(0, 260, 0, 70)
    frame.Position = UDim2.new(0.5, -130, 0, -90)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BorderSizePixel = 0
    frame.Parent = notifGui
    frame.ClipsDescendants = true
    frame.Draggable = true
    
    createShadow(frame)
    createCorner(frame, 8)
    createGradient(frame, Color3.fromRGB(40, 40, 50), Color3.fromRGB(25, 25, 35), 45)
    
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
    messageLabel.TextWrapped = true
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.Parent = frame
    
    local tweenIn = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -130, 0, 20)
    })
    tweenIn:Play()
    
    task.wait(duration)
    
    local tweenOut = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
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
