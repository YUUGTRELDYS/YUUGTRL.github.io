
local Yuugtlr = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local libraryVisible = true
local libraryMessage = Instance.new("ScreenGui")
libraryMessage.Name = "YuugtlrLibrary"
libraryMessage.ResetOnSpawn = false

local messageFrame = Instance.new("Frame")
messageFrame.Size = UDim2.new(0, 200, 0, 40)
messageFrame.Position = UDim2.new(0.5, -100, 0, 10)
messageFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
messageFrame.BorderSizePixel = 0

local messageGradient = Instance.new("UIGradient")
messageGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 80, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 60))
})
messageGradient.Rotation = 45
messageGradient.Parent = messageFrame

local messageCorner = Instance.new("UICorner")
messageCorner.CornerRadius = UDim.new(0, 12)
messageCorner.Parent = messageFrame

local messageText = Instance.new("TextLabel")
messageText.Size = UDim2.new(1, 0, 1, 0)
messageText.BackgroundTransparency = 1
messageText.Text = "YUUGTLR LIBRARY v1.0"
messageText.TextColor3 = Color3.fromRGB(170, 85, 255)
messageText.Font = Enum.Font.GothamBold
messageText.TextSize = 14
messageText.Parent = messageFrame

messageFrame.Parent = libraryMessage
libraryMessage.Parent = player:WaitForChild("PlayerGui")

function Yuugtlr:CreateWindow(title)
    local windowInfo = {}
    local isMobile = UserInputService.TouchEnabled
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "YuugtlrWindow"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 999
    ScreenGui.ResetOnSpawn = false
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = isMobile and UDim2.new(0, 280, 0, 320) or UDim2.new(0, 350, 0, 400)
    MainFrame.Position = isMobile and UDim2.new(1, -295, 0.5, -160) or UDim2.new(1, -375, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BorderSizePixel = 0
    
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
    
    local HeaderGradient = Instance.new("UIGradient")
    HeaderGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 80)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 55))
    })
    HeaderGradient.Parent = Header
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 16)
    HeaderCorner.Parent = Header
    Header.Parent = MainFrame
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(1, -60, 1, 0)
    TitleLabel.Position = UDim2.new(0, 12, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title or "YUUGTLR WINDOW"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = isMobile and 14 or 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Header
    
    local VersionLabel = Instance.new("TextLabel")
    VersionLabel.Name = "VersionLabel"
    VersionLabel.Size = UDim2.new(1, -60, 0, isMobile and 12 or 14)
    VersionLabel.Position = UDim2.new(0, 12, 1, isMobile and -14 or -16)
    VersionLabel.BackgroundTransparency = 1
    VersionLabel.Text = "yuugtlr library v1.0"
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
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
    CloseCorner.Parent = CloseButton
    CloseButton.Parent = Header
    
    local function animateButton(button, enabled)
        local targetColor = enabled and button.OriginalColor or button.OriginalColor:Lerp(Color3.fromRGB(255, 255, 255), 0.2)
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(button, tweenInfo, {BackgroundColor3 = targetColor})
        tween:Play()
    end
    
    local function setupDragging()
        local dragging = false
        local dragInput, dragStart, startPos

        local function update(input)
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end

        Header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
    
    setupDragging()
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    MainFrame.Parent = ScreenGui
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
    
    windowInfo.ScreenGui = ScreenGui
    windowInfo.MainFrame = MainFrame
    windowInfo.Header = Header
    
    function windowInfo:SetVisible(visible)
        MainFrame.Visible = visible
    end
    
    function Yuugtlr:CreateButton(text, callback)
        local buttonInfo = {}
        
        local Button = Instance.new("TextButton")
        Button.Name = text .. "Button"
        Button.Size = UDim2.new(1, 0, 0, 35)
        Button.BackgroundColor3 = Color3.fromRGB(80, 100, 220)
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.GothamBold
        Button.TextSize = 13
        Button.OriginalColor = Button.BackgroundColor3
        
        local buttonGradient = Instance.new("UIGradient")
        buttonGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 120, 240)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 100, 220))
        })
        buttonGradient.Rotation = 90
        buttonGradient.Parent = Button
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = Button
        
        local function animate(enabled)
            local targetColor = enabled and Color3.fromRGB(60, 180, 80) or Button.OriginalColor
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(Button, tweenInfo, {BackgroundColor3 = targetColor})
            tween:Play()
        end
        
        Button.MouseButton1Click:Connect(function()
            animate(true)
            if callback then
                callback()
            end
            task.wait(0.2)
            animate(false)
        end)
        
        buttonInfo.Button = Button
        buttonInfo:SetText = function(newText)
            Button.Text = newText
        end
        
        return buttonInfo
    end
    
    function Yuugtlr:CreateToggle(text, default, callback)
        local toggleInfo = {}
        local toggled = default or false
        
        local Toggle = Instance.new("TextButton")
        Toggle.Name = text .. "Toggle"
        Toggle.Size = UDim2.new(1, 0, 0, 35)
        Toggle.BackgroundColor3 = toggled and Color3.fromRGB(60, 180, 80) or Color3.fromRGB(80, 100, 220)
        Toggle.Text = (toggled and "[✓] " or "[ ] ") .. text
        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.Font = Enum.Font.GothamBold
        Toggle.TextSize = 13
        
        local toggleGradient = Instance.new("UIGradient")
        toggleGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 120, 240)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 100, 220))
        })
        toggleGradient.Rotation = 90
        toggleGradient.Parent = Toggle
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = Toggle
        
        local function updateVisual()
            Toggle.Text = (toggled and "[✓] " or "[ ] ") .. text
            local targetColor = toggled and Color3.fromRGB(60, 180, 80) or Color3.fromRGB(80, 100, 220)
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(Toggle, tweenInfo, {BackgroundColor3 = targetColor})
            tween:Play()
        end
        
        Toggle.MouseButton1Click:Connect(function()
            toggled = not toggled
            updateVisual()
            if callback then
                callback(toggled)
            end
        end)
        
        toggleInfo.Toggle = Toggle
        toggleInfo:SetValue = function(value)
            toggled = value
            updateVisual()
        end
        toggleInfo:GetValue = function()
            return toggled
        end
        
        return toggleInfo
    end
    
    function Yuugtlr:CreateSlider(text, min, max, default, callback)
        local sliderInfo = {}
        local value = default or min
        local dragging = false
        
        local SliderFrame = Instance.new("Frame")
        SliderFrame.Name = text .. "Slider"
        SliderFrame.Size = UDim2.new(1, 0, 0, 50)
        SliderFrame.BackgroundTransparency = 1
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 0, 20)
        Label.BackgroundTransparency = 1
        Label.Text = text .. ": " .. value
        Label.TextColor3 = Color3.fromRGB(200, 200, 220)
        Label.Font = Enum.Font.Gotham
        Label.TextSize = 13
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = SliderFrame
        
        local SliderBg = Instance.new("Frame")
        SliderBg.Size = UDim2.new(1, 0, 0, 16)
        SliderBg.Position = UDim2.new(0, 0, 0, 25)
        SliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        SliderBg.BorderSizePixel = 0
        
        local SliderCorner = Instance.new("UICorner")
        SliderCorner.CornerRadius = UDim.new(0, 10)
        SliderCorner.Parent = SliderBg
        
        local Fill = Instance.new("Frame")
        Fill.Name = "Fill"
        Fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
        Fill.BackgroundColor3 = Color3.fromRGB(80, 100, 220)
        Fill.BorderSizePixel = 0
        
        local FillCorner = Instance.new("UICorner")
        FillCorner.CornerRadius = UDim.new(0, 10)
        FillCorner.Parent = Fill
        Fill.Parent = SliderBg
        
        local Knob = Instance.new("TextButton")
        Knob.Name = "Knob"
        Knob.Size = UDim2.new(0, 16, 0, 16)
        Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Knob.Text = ""
        Knob.BorderSizePixel = 0
        
        local KnobCorner = Instance.new("UICorner")
        KnobCorner.CornerRadius = UDim.new(0, 10)
        KnobCorner.Parent = Knob
        Knob.Parent = SliderBg
        
        SliderBg.Parent = SliderFrame
        
        local function updatePosition()
            local fillWidth = (SliderBg.AbsoluteSize.X - Knob.AbsoluteSize.X) * ((value - min) / (max - min))
            Fill.Size = UDim2.new(0, fillWidth + Knob.AbsoluteSize.X/2, 1, 0)
            Knob.Position = UDim2.new(0, fillWidth, 0, 0)
        end
        
        Knob.MouseButton1Down:Connect(function()
            dragging = true
        end)
        
        Knob.TouchLongPress:Connect(function()
            dragging = true
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local mousePos = input.Position.X
                local sliderPos = SliderBg.AbsolutePosition.X
                local sliderSize = SliderBg.AbsoluteSize.X
                local relativePos = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
                value = min + (max - min) * relativePos
                value = math.floor(value * 100) / 100
                Label.Text = text .. ": " .. value
                updatePosition()
                if callback then
                    callback(value)
                end
            end
        end)
        
        sliderInfo.Frame = SliderFrame
        sliderInfo:SetValue = function(newValue)
            value = math.clamp(newValue, min, max)
            Label.Text = text .. ": " .. value
            updatePosition()
        end
        sliderInfo:GetValue = function()
            return value
        end
        
        return sliderInfo
    end
    
    function Yuugtlr:CreateLabel(text)
        local labelInfo = {}
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 0, 25)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(200, 200, 220)
        Label.Font = Enum.Font.Gotham
        Label.TextSize = 13
        Label.TextXAlignment = Enum.TextXAlignment.Left
        
        labelInfo.Label = Label
        labelInfo:SetText = function(newText)
            Label.Text = newText
        end
        
        return labelInfo
    end
    
    function windowInfo:AddSection(name)
        local Section = Instance.new("Frame")
        Section.Name = name .. "Section"
        Section.Size = UDim2.new(1, -20, 0, 0)
        Section.BackgroundTransparency = 1
        Section.Parent = nil
        
        local SectionTitle = Instance.new("TextLabel")
        SectionTitle.Size = UDim2.new(1, 0, 0, 30)
        SectionTitle.BackgroundTransparency = 1
        SectionTitle.Text = name
        SectionTitle.TextColor3 = Color3.fromRGB(170, 85, 255)
        SectionTitle.Font = Enum.Font.GothamBold
        SectionTitle.TextSize = 14
        SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        SectionTitle.Parent = Section
        
        local SectionContent = Instance.new("Frame")
        SectionContent.Name = "Content"
        SectionContent.Size = UDim2.new(1, 0, 0, 0)
        SectionContent.Position = UDim2.new(0, 0, 0, 30)
        SectionContent.BackgroundTransparency = 1
        SectionContent.Parent = Section
        
        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Padding = UDim.new(0, 6)
        UIListLayout.Parent = SectionContent
        
        local function addElement(element)
            element.Parent = SectionContent
            Section.Size = UDim2.new(1, -20, 0, 30 + SectionContent.Size.Y.Offset)
        end
        
        return {
            Section = Section,
            Content = SectionContent,
            AddButton = function(text, callback)
                local btn = Yuugtlr:CreateButton(text, callback)
                addElement(btn.Button)
                return btn
            end,
            AddToggle = function(text, default, callback)
                local tog = Yuugtlr:CreateToggle(text, default, callback)
                addElement(tog.Toggle)
                return tog
            end,
            AddSlider = function(text, min, max, default, callback)
                local slid = Yuugtlr:CreateSlider(text, min, max, default, callback)
                addElement(slid.Frame)
                return slid
            end,
            AddLabel = function(text)
                local lbl = Yuugtlr:CreateLabel(text)
                addElement(lbl.Label)
                return lbl
            end
        }
    end
    
    return windowInfo
end

return Yuugtlr
