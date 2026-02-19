local YUUGLR = {}
local players = game:GetService("Players")
local player = players.LocalPlayer
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local isMobile = userInputService.TouchEnabled

function YUUGLR:CreateWindow(title, credits, size)
    size = size or (isMobile and UDim2.new(0, 280, 0, 320) or UDim2.new(0, 350, 0, 400))
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "YUUGLR_" .. title
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 999
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = size
    MainFrame.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
    })
    Gradient.Rotation = 45
    Gradient.Parent = MainFrame
    
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 15, 1, 15)
    Shadow.Position = UDim2.new(0, -7, 0, -7)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://1316045217"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.9
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    Shadow.Parent = MainFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 16)
    UICorner.Parent = MainFrame
    
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, isMobile and 35 or 45)
    Header.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Header.BorderSizePixel = 0
    Header.Parent = MainFrame
    
    local HeaderGradient = Instance.new("UIGradient")
    HeaderGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 80)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 55))
    })
    HeaderGradient.Parent = Header
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 16)
    HeaderCorner.Parent = Header
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -60, 1, 0)
    Title.Position = UDim2.new(0, 12, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = isMobile and 14 or 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header
    
    local VersionLabel = Instance.new("TextLabel")
    VersionLabel.Name = "VersionLabel"
    VersionLabel.Size = UDim2.new(1, -60, 0, isMobile and 12 or 14)
    VersionLabel.Position = UDim2.new(0, 12, 1, isMobile and -14 or -16)
    VersionLabel.BackgroundTransparency = 1
    VersionLabel.Text = credits
    VersionLabel.TextColor3 = Color3.fromRGB(170, 85, 255)
    VersionLabel.Font = Enum.Font.Gotham
    VersionLabel.TextSize = isMobile and 9 or 11
    VersionLabel.TextXAlignment = Enum.TextXAlignment.Left
    VersionLabel.Parent = Header
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, isMobile and 26 or 32, 0, isMobile and 26 or 32)
    CloseButton.Position = UDim2.new(1, isMobile and -30 or -37, 0, isMobile and 4 or 6)
    CloseButton.BackgroundColor3 = Color3.fromRGB(220, 70, 70)
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = isMobile and 16 or 20
    CloseButton.Parent = Header
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
    CloseCorner.Parent = CloseButton
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    return ScreenGui, MainFrame, Header
end

function YUUGLR:CreateButton(parent, text, position, size, color, callback)
    size = size or UDim2.new(1, -20, 0, isMobile and 28 or 35)
    position = position or UDim2.new(0, 10, 0, 0)
    color = color or Color3.fromRGB(80, 100, 220)
    
    local button = Instance.new("TextButton")
    button.Name = text .. "Button"
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = color
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = isMobile and 11 or 13
    button.Parent = parent
    
    local buttonGradient = Instance.new("UIGradient")
    buttonGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(math.min(color.R * 255 + 20, 255), math.min(color.G * 255 + 20, 255), math.min(color.B * 255 + 20, 255))),
        ColorSequenceKeypoint.new(1, color)
    })
    buttonGradient.Rotation = 90
    buttonGradient.Parent = button
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = tweenService:Create(button, tweenInfo, {BackgroundColor3 = Color3.fromRGB(60, 180, 80)})
        tween:Play()
        task.wait(0.2)
        tween = tweenService:Create(button, tweenInfo, {BackgroundColor3 = color})
        tween:Play()
        if callback then callback() end
    end)
    
    return button
end

function YUUGLR:CreateLabel(parent, text, position, size, color)
    size = size or UDim2.new(1, -20, 0, isMobile and 22 or 28)
    position = position or UDim2.new(0, 10, 0, 0)
    color = color or Color3.fromRGB(200, 200, 220)
    
    local label = Instance.new("TextLabel")
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color
    label.Font = Enum.Font.Gotham
    label.TextSize = isMobile and 12 or 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
    
    return label
end

function YUUGLR:CreateToggle(parent, text, default, position, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, isMobile and 22 or 28)
    frame.Position = position or UDim2.new(0, 10, 0, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text .. ":"
    label.TextColor3 = Color3.fromRGB(200, 200, 220)
    label.Font = Enum.Font.Gotham
    label.TextSize = isMobile and 12 or 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local value = Instance.new("TextLabel")
    value.Name = "Value"
    value.Size = UDim2.new(0.45, 0, 1, 0)
    value.Position = UDim2.new(0.55, 0, 0, 0)
    value.BackgroundTransparency = 1
    value.Text = tostring(default)
    value.TextColor3 = default and Color3.fromRGB(80, 220, 100) or Color3.fromRGB(220, 80, 80)
    value.Font = Enum.Font.GothamBold
    value.TextSize = isMobile and 12 or 14
    value.TextXAlignment = Enum.TextXAlignment.Left
    value.Parent = frame
    
    local state = default or false
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = frame
    
    button.MouseButton1Click:Connect(function()
        state = not state
        local targetColor = state and Color3.fromRGB(80, 220, 100) or Color3.fromRGB(220, 80, 80)
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = tweenService:Create(value, tweenInfo, {TextColor3 = targetColor})
        tween:Play()
        value.Text = tostring(state)
        if callback then callback(state) end
    end)
    
    return frame, function() return state end, function(newState)
        state = newState
        local targetColor = state and Color3.fromRGB(80, 220, 100) or Color3.fromRGB(220, 80, 80)
        value.TextColor3 = targetColor
        value.Text = tostring(state)
    end
end

function YUUGLR:CreateSlider(parent, text, default, min, max, position, callback)
    min = min or 0
    max = max or 100
    default = default or 0
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, isMobile and 45 or 55)
    frame.Position = position or UDim2.new(0, 10, 0, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, isMobile and 20 or 25)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. default
    label.TextColor3 = Color3.fromRGB(200, 200, 220)
    label.Font = Enum.Font.Gotham
    label.TextSize = isMobile and 12 or 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local slider = Instance.new("Frame")
    slider.Name = "Slider"
    slider.Size = UDim2.new(1, 0, 0, isMobile and 16 or 20)
    slider.Position = UDim2.new(0, 0, 0, isMobile and 25 or 30)
    slider.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    slider.BorderSizePixel = 0
    slider.Parent = frame
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 10)
    sliderCorner.Parent = slider
    
    local fill = Instance.new("Frame")
    fill.Name = "Fill"
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(80, 100, 220)
    fill.BorderSizePixel = 0
    fill.Parent = slider
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 10)
    fillCorner.Parent = fill
    
    local dragButton = Instance.new("TextButton")
    dragButton.Size = UDim2.new(0, isMobile and 20 or 24, 0, isMobile and 20 or 24)
    dragButton.Position = UDim2.new((default - min) / (max - min), -10, 0.5, -10)
    dragButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dragButton.Text = ""
    dragButton.BorderSizePixel = 0
    dragButton.Parent = slider
    
    local dragCorner = Instance.new("UICorner")
    dragCorner.CornerRadius = UDim.new(0, 12)
    dragCorner.Parent = dragButton
    
    local value = default
    local dragging = false
    
    dragButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    userInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    userInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = input.Position.X
            local sliderPos = slider.AbsolutePosition.X
            local sliderSize = slider.AbsoluteSize.X
            local relativePos = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
            local newValue = min + (relativePos * (max - min))
            value = newValue
            
            fill.Size = UDim2.new(relativePos, 0, 1, 0)
            dragButton.Position = UDim2.new(relativePos, -10, 0.5, -10)
            label.Text = text .. ": " .. math.floor(newValue)
            if callback then callback(newValue) end
        end
    end)
    
    return frame, function() return value end, function(newValue)
        value = newValue
        local relativePos = (value - min) / (max - min)
        fill.Size = UDim2.new(relativePos, 0, 1, 0)
        dragButton.Position = UDim2.new(relativePos, -10, 0.5, -10)
        label.Text = text .. ": " .. math.floor(value)
    end
end

function YUUGLR:CreateScrollingFrame(parent, size, position)
    size = size or UDim2.new(1, -20, 1, -60)
    position = position or UDim2.new(0, 10, 0, 50)
    
    local frame = Instance.new("ScrollingFrame")
    frame.Size = size
    frame.Position = position
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ScrollBarThickness = 4
    frame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 130)
    frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    frame.Parent = parent
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, isMobile and 4 or 6)
    layout.Parent = frame
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        frame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)
    
    return frame, layout
end

function YUUGLR:CreateTab(parent)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, isMobile and 120 or 160)
    frame.Position = UDim2.new(0, 10, 1, isMobile and -130 or -170)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    return frame
end

function YUUGLR:CreateNotification(text, duration)
    duration = duration or 3
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "YUUGLR_Notification"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 1000
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 50)
    frame.Position = UDim2.new(0.5, -150, 0, -100)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BorderSizePixel = 0
    frame.Parent = ScreenGui
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
    })
    gradient.Rotation = 45
    gradient.Parent = frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextWrapped = true
    label.Parent = frame
    
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local goal = {Position = UDim2.new(0.5, -150, 0, 50)}
    local tween = tweenService:Create(frame, tweenInfo, goal)
    tween:Play()
    
    task.wait(duration)
    
    local tweenInfo2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local goal2 = {Position = UDim2.new(0.5, -150, 0, -100)}
    local tween2 = tweenService:Create(frame, tweenInfo2, goal2)
    tween2:Play()
    tween2.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
end

return YUUGLR
