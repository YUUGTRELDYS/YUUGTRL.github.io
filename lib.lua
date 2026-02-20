--[[
    YUUGTR Library v1.0
    Красивые кнопки и окна в стиле Trade Script
]]

local YUUGTR = {}
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Показываем приветственное сообщение
local function showWelcomeMessage()
    local msg = Instance.new("ScreenGui")
    msg.Name = "YUUGTR_Message"
    msg.DisplayOrder = 9999
    msg.Parent = player:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 40)
    frame.Position = UDim2.new(0.5, -100, 0, 20)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Parent = msg
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 100, 220)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 85, 255))
    })
    gradient.Rotation = 45
    gradient.Parent = frame
    
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = "YUUGTR Library"
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.Font = Enum.Font.GothamBold
    text.TextSize = 18
    text.TextStrokeTransparency = 0.5
    text.Parent = frame
    
    local shadow = Instance.new("ImageLabel")
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(170, 85, 255)
    shadow.ImageTransparency = 0.7
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = frame
    
    task.wait(2)
    
    local tween = TweenService:Create(frame, TweenInfo.new(0.5), {BackgroundTransparency = 1})
    tween:Play()
    tween.Completed:Connect(function()
        msg:Destroy()
    end)
    
    local textTween = TweenService:Create(text, TweenInfo.new(0.5), {TextTransparency = 1})
    textTween:Play()
end

showWelcomeMessage()

-- Основные цвета из панели
local colors = {
    background = Color3.fromRGB(25, 25, 35),
    header = Color3.fromRGB(35, 35, 45),
    button = {
        primary = Color3.fromRGB(80, 100, 220),
        success = Color3.fromRGB(60, 180, 80),
        warning = Color3.fromRGB(220, 70, 70),
        xray = Color3.fromRGB(140, 80, 220),
        jump = Color3.fromRGB(80, 180, 120),
        reset = Color3.fromRGB(200, 70, 70),
        settings = Color3.fromRGB(80, 100, 220)
    },
    text = {
        primary = Color3.fromRGB(255, 255, 255),
        secondary = Color3.fromRGB(200, 200, 220),
        accent = Color3.fromRGB(170, 85, 255)
    },
    status = {
        true = Color3.fromRGB(80, 220, 100),
        false = Color3.fromRGB(220, 80, 80)
    }
}

-- Создание градиента для кнопок
local function addGradient(instance, color1, color2)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1 or Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(1, color2 or color1 or Color3.fromRGB(200,200,200))
    })
    gradient.Rotation = 90
    gradient.Parent = instance
    return gradient
end

-- Функция анимации кнопки
local function animateButton(button, enabled)
    local targetColor = enabled and colors.button.success or colors.button.primary
    if button._originalColor then
        targetColor = enabled and colors.button.success or button._originalColor
    end
    
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(button, tweenInfo, {BackgroundColor3 = targetColor})
    tween:Play()
end

-- Создание нового окна
function YUUGTR:CreateWindow(title, size, position)
    size = size or UDim2.new(0, 350, 0, 400)
    position = position or UDim2.new(0.5, -175, 0.5, -200)
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "YUUGTR_" .. title:gsub("%s+", "")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 999
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = size
    MainFrame.Position = position
    MainFrame.BackgroundColor3 = colors.background
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
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
    
    local WindowCorner = Instance.new("UICorner")
    WindowCorner.CornerRadius = UDim.new(0, 16)
    WindowCorner.Parent = MainFrame
    
    local WindowGradient = addGradient(MainFrame, Color3.fromRGB(40, 40, 50), colors.background)
    WindowGradient.Rotation = 45
    
    -- Заголовок окна
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 45)
    Header.BackgroundColor3 = colors.header
    Header.BorderSizePixel = 0
    Header.Parent = MainFrame
    
    local HeaderGradient = addGradient(Header, Color3.fromRGB(60, 60, 80), Color3.fromRGB(40, 40, 55))
    HeaderGradient.Rotation = 45
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 16)
    HeaderCorner.Parent = Header
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(1, -60, 1, 0)
    TitleLabel.Position = UDim2.new(0, 12, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = colors.text.primary
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Header
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 32, 0, 32)
    CloseButton.Position = UDim2.new(1, -37, 0, 6)
    CloseButton.BackgroundColor3 = colors.button.warning
    CloseButton.Text = "×"
    CloseButton.TextColor3 = colors.text.primary
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 20
    CloseButton.Parent = Header
    CloseButton._originalColor = colors.button.warning
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
    CloseCorner.Parent = CloseButton
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    CloseButton.MouseEnter:Connect(function()
        animateButton(CloseButton, true)
    end)
    
    CloseButton.MouseLeave:Connect(function()
        animateButton(CloseButton, false)
    end)
    
    -- Создаем контейнер для контента
    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Size = UDim2.new(1, -20, 1, -65)
    Container.Position = UDim2.new(0, 10, 0, 55)
    Container.BackgroundTransparency = 1
    Container.Parent = MainFrame
    
    local ContainerList = Instance.new("UIListLayout")
    ContainerList.Padding = UDim.new(0, 10)
    ContainerList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ContainerList.Parent = Container
    
    -- Функция для перетаскивания
    local function setupDragging()
        local dragging = false
        local dragInput, dragStart, startPos
        
        local function update(input)
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
        
        Header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or 
               input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = MainFrame.Position
                
                local connection
                connection = input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                        connection:Disconnect()
                    end
                end)
            end
        end)
        
        Header.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or 
               input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    end
    
    setupDragging()
    
    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        Container = Container,
        ContainerList = ContainerList
    }
end

-- Создание кнопки
function YUUGTR:CreateButton(parent, text, callback, buttonColor)
    buttonColor = buttonColor or colors.button.primary
    
    local Button = Instance.new("TextButton")
    Button.Name = text .. "Button"
    Button.Size = UDim2.new(1, 0, 0, 35)
    Button.BackgroundColor3 = buttonColor
    Button.Text = text
    Button.TextColor3 = colors.text.primary
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 13
    Button.Parent = parent
    Button._originalColor = buttonColor
    
    local ButtonGradient = addGradient(Button, 
        Color3.fromRGB(math.min(buttonColor.R * 255 + 20, 255)/255, 
                      math.min(buttonColor.G * 255 + 20, 255)/255, 
                      math.min(buttonColor.B * 255 + 20, 255)/255), 
        buttonColor)
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 10)
    ButtonCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
        animateButton(Button, true)
        task.wait(0.2)
        animateButton(Button, false)
    end)
    
    Button.MouseEnter:Connect(function()
        animateButton(Button, true)
    end)
    
    Button.MouseLeave:Connect(function()
        animateButton(Button, false)
    end)
    
    return Button
end

-- Создание панели статусов (как в оригинале)
function YUUGTR:CreateStatusPanel(parent, items)
    local Panel = Instance.new("Frame")
    Panel.Name = "StatusPanel"
    Panel.Size = UDim2.new(1, 0, 0, 180)
    Panel.BackgroundTransparency = 1
    Panel.Parent = parent
    
    local Background = Instance.new("Frame")
    Background.Name = "Background"
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.BackgroundColor3 = colors.header
    Background.BorderSizePixel = 0
    Background.Parent = Panel
    
    local PanelCorner = Instance.new("UICorner")
    PanelCorner.CornerRadius = UDim.new(0, 12)
    PanelCorner.Parent = Background
    
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1, -10, 1, -10)
    ScrollingFrame.Position = UDim2.new(0, 5, 0, 5)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.ScrollBarThickness = 4
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 130)
    ScrollingFrame.Parent = Background
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 6)
    ListLayout.Parent = ScrollingFrame
    
    local statusItems = {}
    
    for i, itemName in ipairs(items) do
        local ItemFrame = Instance.new("Frame")
        ItemFrame.Name = itemName
        ItemFrame.Size = UDim2.new(1, 0, 0, 28)
        ItemFrame.BackgroundTransparency = 1
        ItemFrame.Parent = ScrollingFrame
        
        local Label = Instance.new("TextLabel")
        Label.Name = "Label"
        Label.Size = UDim2.new(0.5, 0, 1, 0)
        Label.BackgroundTransparency = 1
        Label.Text = itemName .. ":"
        Label.TextColor3 = colors.text.secondary
        Label.Font = Enum.Font.Gotham
        Label.TextSize = 14
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = ItemFrame
        
        local Value = Instance.new("TextLabel")
        Value.Name = "Value"
        Value.Size = UDim2.new(0.45, 0, 1, 0)
        Value.Position = UDim2.new(0.55, 0, 0, 0)
        Value.BackgroundTransparency = 1
        Value.Text = "false"
        Value.TextColor3 = colors.status.false
        Value.Font = Enum.Font.GothamBold
        Value.TextSize = 14
        Value.TextXAlignment = Enum.TextXAlignment.Left
        Value.Parent = ItemFrame
        
        statusItems[itemName] = {
            frame = ItemFrame,
            label = Label,
            value = Value
        }
    end
    
    -- Функция обновления статуса
    local function updateStatus(name, state)
        if statusItems[name] then
            local valueLabel = statusItems[name].value
            valueLabel.Text = tostring(state)
            
            local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(valueLabel, tweenInfo, 
                {TextColor3 = state and colors.status.true or colors.status.false})
            tween:Play()
        end
    end
    
    return Panel, updateStatus
end

-- Создание слайдера (как в оригинале)
function YUUGTR:CreateSlider(parent, text, min, max, default, callback)
    min = min or 0
    max = max or 100
    default = default or 0
    
    local Container = Instance.new("Frame")
    Container.Name = text .. "Slider"
    Container.Size = UDim2.new(1, 0, 0, 45)
    Container.BackgroundTransparency = 1
    Container.Parent = parent
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -10, 0, 20)
    Label.Position = UDim2.new(0, 5, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text .. ": " .. default
    Label.TextColor3 = colors.text.secondary
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container
    
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = "SliderFrame"
    SliderFrame.Size = UDim2.new(1, -10, 0, 16)
    SliderFrame.Position = UDim2.new(0, 5, 0, 25)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = Container
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 10)
    SliderCorner.Parent = SliderFrame
    
    local Fill = Instance.new("Frame")
    Fill.Name = "Fill"
    Fill.Size = UDim2.new(default/(max-min), 0, 1, 0)
    Fill.BackgroundColor3 = colors.button.primary
    Fill.BorderSizePixel = 0
    Fill.Parent = SliderFrame
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 10)
    FillCorner.Parent = Fill
    
    local Knob = Instance.new("TextButton")
    Knob.Name = "Knob"
    Knob.Size = UDim2.new(0, 16, 0, 16)
    Knob.Position = UDim2.new(default/(max-min), -8, 0, 0)
    Knob.BackgroundColor3 = colors.text.primary
    Knob.Text = ""
    Knob.BorderSizePixel = 0
    Knob.Parent = SliderFrame
    
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(0, 10)
    KnobCorner.Parent = Knob
    
    local dragging = false
    
    Knob.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    Knob.TouchLongPress:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
                        input.UserInputType == Enum.UserInputType.Touch) then
            local mousePos = input.Position.X
            local sliderPos = SliderFrame.AbsolutePosition.X
            local sliderSize = SliderFrame.AbsoluteSize.X
            local relativePos = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
            
            local value = min + (max - min) * relativePos
            value = math.floor(value * 10) / 10 -- Округляем до 1 знака
            
            Fill.Size = UDim2.new(relativePos, 0, 1, 0)
            Knob.Position = UDim2.new(relativePos, -8, 0, 0)
            Label.Text = text .. ": " .. value
            
            if callback then
                callback(value)
            end
        end
    end)
    
    return Container
end

-- Создание текстового поля
function YUUGTR:CreateTextLabel(parent, text, textColor)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -10, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = textColor or colors.text.primary
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = parent
    
    return Label
end

-- Создание переключателя (Toggle)
function YUUGTR:CreateToggle(parent, text, default, callback)
    default = default or false
    
    local Container = Instance.new("Frame")
    Container.Name = text .. "Toggle"
    Container.Size = UDim2.new(1, 0, 0, 30)
    Container.BackgroundTransparency = 1
    Container.Parent = parent
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, -5, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = colors.text.secondary
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 50, 0, 24)
    ToggleButton.Position = UDim2.new(1, -50, 0.5, -12)
    ToggleButton.BackgroundColor3 = default and colors.status.true or colors.status.false
    ToggleButton.Text = default and "ON" or "OFF"
    ToggleButton.TextColor3 = colors.text.primary
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.TextSize = 12
    ToggleButton.Parent = Container
    ToggleButton._originalColor = ToggleButton.BackgroundColor3
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 12)
    ToggleCorner.Parent = ToggleButton
    
    local state = default
    
    local function updateToggle()
        state = not state
        ToggleButton.Text = state and "ON" or "OFF"
        
        local targetColor = state and colors.status.true or colors.status.false
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(ToggleButton, tweenInfo, {BackgroundColor3 = targetColor})
        tween:Play()
        
        if callback then
        callback(state)
    end
end
    
    ToggleButton.MouseButton1Click:Connect(updateToggle)
    
    ToggleButton.MouseEnter:Connect(function()
        animateButton(ToggleButton, true)
    end)
    
    ToggleButton.MouseLeave:Connect(function()
        animateButton(ToggleButton, false)
    end)
    
    return ToggleButton, function() return state end
end

return YUUGTR
