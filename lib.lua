local YUUGTRL = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled

-- Показываем сообщение о загрузке (нельзя убрать)
local function showLoadMessage()
    local msgGui = Instance.new("ScreenGui")
    msgGui.Name = "YUUGTRL_LoadMessage"
    msgGui.ResetOnSpawn = false
    msgGui.Parent = player:WaitForChild("PlayerGui")
    
    local msgFrame = Instance.new("Frame")
    msgFrame.Size = UDim2.new(0, 300, 0, 50)
    msgFrame.Position = UDim2.new(0.5, -150, 0, 10)
    msgFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    msgFrame.BorderSizePixel = 0
    msgFrame.Parent = msgGui
    
    local msgCorner = Instance.new("UICorner")
    msgCorner.CornerRadius = UDim.new(0, 8)
    msgCorner.Parent = msgFrame
    
    local msgText = Instance.new("TextLabel")
    msgText.Size = UDim2.new(1, 0, 1, 0)
    msgText.BackgroundTransparency = 1
    msgText.Text = "YUUGTRL Library loaded!"
    msgText.TextColor3 = Color3.fromRGB(170, 85, 255)
    msgText.Font = Enum.Font.GothamBold
    msgText.TextSize = 16
    msgText.Parent = msgFrame
    
    task.wait(3)
    msgGui:Destroy()
end

-- Запускаем сообщение
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

-- Функция для создания градиента на кнопке (сверху светлее, снизу темнее)
local function createButtonGradient(button, baseColor)
    -- Делаем верхнюю часть светлее на 20%, нижнюю часть темнее на 20%
    local r, g, b = baseColor.R, baseColor.G, baseColor.B
    
    local lighter = Color3.new(
        math.min(r * 1.3, 1),
        math.min(g * 1.3, 1),
        math.min(b * 1.3, 1)
    )
    
    local darker = Color3.new(
        r * 0.7,
        g * 0.7,
        b * 0.7
    )
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, lighter),
        ColorSequenceKeypoint.new(1, darker)
    })
    gradient.Rotation = 90 -- Вертикальный градиент (сверху вниз)
    gradient.Parent = button
    return gradient
end

-- Функция для создания яркого текста
local function createBrightText(parent, text, size)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255) -- Чисто белый яркий текст
    label.Font = Enum.Font.GothamBold
    label.TextSize = size or (isMobile and 12 or 14)
    label.TextStrokeTransparency = 0.8 -- Легкая обводка для контраста
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.Parent = parent
    return label
end

local function animateButton(button, enabled, enabledColor, disabledColor)
    local targetColor = enabled and (enabledColor or Color3.fromRGB(80, 180, 120)) or (disabledColor or button.BaseColor or Color3.fromRGB(80, 100, 220))
    local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = targetColor})
    tween:Play()
    
    -- Обновляем градиент при изменении цвета
    for _, child in pairs(button:GetChildren()) do
        if child:IsA("UIGradient") then
            child:Destroy()
        end
    end
    createButtonGradient(button, targetColor)
end

local function makeDraggable(frame, handle)
    local dragging = false
    local dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
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
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = size
    mainFrame.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    createShadow(mainFrame)
    createCorner(mainFrame, 16)
    
    -- Градиент для фона окна
    local windowGradient = Instance.new("UIGradient")
    windowGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
    })
    windowGradient.Rotation = 45
    windowGradient.Parent = mainFrame
    
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, isMobile and 35 or 45)
    header.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    header.BorderSizePixel = 0
    header.Parent = mainFrame
    
    -- Градиент для хедера
    local headerGradient = Instance.new("UIGradient")
    headerGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 80)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 55))
    })
    headerGradient.Parent = header
    
    createCorner(header, 16)
    
    local titleLabel = createBrightText(header, title, isMobile and 14 or 18)
    titleLabel.Size = UDim2.new(1, -60, 1, 0)
    titleLabel.Position = UDim2.new(0, 12, 0, 0)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, isMobile and 26 or 32, 0, isMobile and 26 or 32)
    closeButton.Position = UDim2.new(1, isMobile and -30 or -37, 0, isMobile and 4 or 6)
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 70, 70)
    closeButton.BaseColor = Color3.fromRGB(200, 70, 70)
    closeButton.Text = ""
    closeButton.Parent = header
    
    createCorner(closeButton, 8)
    createButtonGradient(closeButton, Color3.fromRGB(200, 70, 70))
    
    local closeText = createBrightText(closeButton, "×", isMobile and 16 or 20)
    closeText.Size = UDim2.new(1, 0, 1, 0)
    
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    makeDraggable(mainFrame, header)
    
    local container = Instance.new("Frame")
    container.Name = "Container"
    container.Size = UDim2.new(1, -20, 1, -(header.Size.Y.Offset + 20))
    container.Position = UDim2.new(0, 10, 0, header.Size.Y.Offset + 10)
    container.BackgroundTransparency = 1
    container.Parent = mainFrame
    
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollingFrame.BackgroundTransparency = 1
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.ScrollBarThickness = 4
    scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 130)
    scrollingFrame.Parent = container
    
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
        button.BaseColor = color
        button.Text = ""
        button.Parent = self.Container
        
        createCorner(button, 10)
        createButtonGradient(button, color)
        
        local buttonText = createBrightText(button, text, isMobile and 12 or 14)
        buttonText.Size = UDim2.new(1, 0, 1, 0)
        
        button.MouseButton1Click:Connect(function()
            animateButton(button, true, Color3.fromRGB(80, 180, 120), color)
            if callback then callback() end
            task.wait(0.2)
            animateButton(button, false, Color3.fromRGB(80, 180, 120), color)
        end)
        
        table.insert(self.Elements, button)
        return button
    end
    
    function windowObj:AddToggle(text, default, callback)
        local frame = Instance.new("Frame")
        frame.Name = text .. "Toggle"
        frame.Size = UDim2.new(1, -10, 0, isMobile and 35 or 40)
        frame.BackgroundTransparency = 1
        frame.Parent = self.Container
        
        local label = createBrightText(frame, text, isMobile and 12 or 14)
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.TextColor3 = Color3.fromRGB(220, 220, 255)
        label.TextXAlignment = Enum.TextXAlignment.Left
        
        local toggleButton = Instance.new("TextButton")
        toggleButton.Name = "ToggleButton"
        toggleButton.Size = UDim2.new(0, isMobile and 50 or 60, 0, isMobile and 25 or 30)
        toggleButton.Position = UDim2.new(1, -(isMobile and 55 or 65), 0.5, -(isMobile and 12.5 or 15))
        toggleButton.BackgroundColor3 = default and Color3.fromRGB(80, 180, 120) or Color3.fromRGB(200, 70, 70)
        toggleButton.BaseColor = toggleButton.BackgroundColor3
        toggleButton.Text = ""
        toggleButton.Parent = frame
        
        createCorner(toggleButton, 15)
        createButtonGradient(toggleButton, toggleButton.BackgroundColor3)
        
        local toggleText = createBrightText(toggleButton, default and "ON" or "OFF", isMobile and 10 or 12)
        toggleText.Size = UDim2.new(1, 0, 1, 0)
        
        local toggled = default or false
        
        toggleButton.MouseButton1Click:Connect(function()
            toggled = not toggled
            toggleText.Text = toggled and "ON" or "OFF"
            local newColor = toggled and Color3.fromRGB(80, 180, 120) or Color3.fromRGB(200, 70, 70)
            toggleButton.BackgroundColor3 = newColor
            toggleButton.BaseColor = newColor
            
            for _, child in pairs(toggleButton:GetChildren()) do
                if child:IsA("UIGradient") then
                    child:Destroy()
                end
            end
            createButtonGradient(toggleButton, newColor)
            
            if callback then callback(toggled) end
        end)
        
        table.insert(self.Elements, {frame, toggleButton})
        return toggleButton
    end
    
    function windowObj:AddSlider(text, min, max, default, callback)
        local frame = Instance.new("Frame")
        frame.Name = text .. "Slider"
        frame.Size = UDim2.new(1, -10, 0, isMobile and 45 or 55)
        frame.BackgroundTransparency = 1
        frame.Parent = self.Container
        
        local label = createBrightText(frame, text .. ": " .. tostring(default or min), isMobile and 11 or 13)
        label.Size = UDim2.new(1, 0, 0, isMobile and 20 or 25)
        label.TextColor3 = Color3.fromRGB(220, 220, 255)
        label.TextXAlignment = Enum.TextXAlignment.Left
        
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
        return sliderBg
    end
    
    function windowObj:AddLabel(text)
        local label = createBrightText(self.Container, text, isMobile and 11 or 13)
        label.Size = UDim2.new(1, -10, 0, isMobile and 20 or 25)
        label.TextColor3 = Color3.fromRGB(200, 200, 255)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = self.Container
        
        table.insert(self.Elements, label)
        return label
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
    notifGui.DisplayOrder = 1000
    notifGui.ResetOnSpawn = false
    notifGui.Parent = player:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Name = "Notification"
    frame.Size = isMobile and UDim2.new(0, 250, 0, 80) or UDim2.new(0, 300, 0, 100)
    frame.Position = UDim2.new(0.5, -150, 0, -100)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BorderSizePixel = 0
    frame.Parent = notifGui
    
    createShadow(frame)
    createCorner(frame, 16)
    
    local frameGradient = Instance.new("UIGradient")
    frameGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
    })
    frameGradient.Rotation = 45
    frameGradient.Parent = frame
    
    local titleLabel = createBrightText(frame, title, isMobile and 14 or 16)
    titleLabel.Size = UDim2.new(1, -20, 0, isMobile and 25 or 30)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local messageLabel = createBrightText(frame, message, isMobile and 11 or 13)
    messageLabel.Size = UDim2.new(1, -20, 0, isMobile and 30 or 35)
    messageLabel.Position = UDim2.new(0, 10, 0, isMobile and 35 or 40)
    messageLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
    messageLabel.TextWrapped = true
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local tween = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5, -150, 0, 20)
    })
    tween:Play()
    
    task.wait(duration)
    
    local tweenOut = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
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
