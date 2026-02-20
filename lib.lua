local YUUGTRL = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled

local splash = Instance.new("ScreenGui")
splash.Name = "YUUGTRLSplash"
splash.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
splash.DisplayOrder = 9999
splash.ResetOnSpawn = false
splash.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 80)
frame.Position = UDim2.new(0.5, -100, 0.5, -40)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0
frame.BorderSizePixel = 0
frame.Parent = splash

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local text = Instance.new("TextLabel")
text.Size = UDim2.new(1, 0, 1, 0)
text.BackgroundTransparency = 1
text.Text = "YUUGTRL"
text.TextColor3 = Color3.fromRGB(170, 85, 255)
text.Font = Enum.Font.GothamBold
text.TextSize = 30
text.Parent = frame

task.wait(1.5)

local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tween = TweenService:Create(frame, tweenInfo, {BackgroundTransparency = 1})
tween:Play()
TweenService:Create(text, tweenInfo, {TextTransparency = 1}):Play()

task.wait(0.5)
splash:Destroy()

local function Create(props)
    local obj = Instance.new(props.type)
    for i, v in pairs(props) do
        if i ~= "type" and i ~= "children" then
            obj[i] = v
        end
    end
    if props.children then
        for _, child in pairs(props.children) do
            child.Parent = obj
        end
    end
    return obj
end

function YUUGTRL:ApplyButtonStyle(button, color)
    for _, v in pairs(button:GetChildren()) do
        if v:IsA("UIGradient") then
            v:Destroy()
        end
    end
    local darker = Color3.fromRGB(math.max(color.R * 255 - 50, 0), math.max(color.G * 255 - 50, 0), math.max(color.B * 255 - 50, 0))
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, color),ColorSequenceKeypoint.new(1, darker)})
    gradient.Rotation = 90
    gradient.Parent = button
    local brighter = Color3.fromRGB(math.min(color.R * 255 + 100, 255), math.min(color.G * 255 + 100, 255), math.min(color.B * 255 + 100, 255))
    button.TextColor3 = brighter
    button.Font = Enum.Font.GothamBold
    return button
end

function YUUGTRL:SetButtonColor(button, color)
    self:ApplyButtonStyle(button, color)
    button.BackgroundColor3 = color
end

function YUUGTRL:DarkenButton(button)
    if not button:FindFirstChild("UIGradient") then return end
    local gradient = button:FindFirstChild("UIGradient")
    local color = gradient.Color.Keypoints[1].Value
    local darker = Color3.fromRGB(math.max(color.R * 255 - 70, 0), math.max(color.G * 255 - 70, 0), math.max(color.B * 255 - 70, 0))
    gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, darker),ColorSequenceKeypoint.new(1, darker)})
end

function YUUGTRL:LightenButton(button)
    if not button:FindFirstChild("UIGradient") then return end
    local gradient = button:FindFirstChild("UIGradient")
    local color = gradient.Color.Keypoints[1].Value
    local lighter = Color3.fromRGB(math.min(color.R * 255 + 70, 255), math.min(color.G * 255 + 70, 255), math.min(color.B * 255 + 70, 255))
    gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, lighter),ColorSequenceKeypoint.new(1, lighter)})
end

function YUUGTRL:RestoreButtonStyle(button, color)
    if not button:FindFirstChild("UIGradient") then return end
    local gradient = button:FindFirstChild("UIGradient")
    local darker = Color3.fromRGB(math.max(color.R * 255 - 50, 0), math.max(color.G * 255 - 50, 0), math.max(color.B * 255 - 50, 0))
    gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, color),ColorSequenceKeypoint.new(1, darker)})
end

function YUUGTRL:MakeButton(button, color, style)
    local btnColor = color or Color3.fromRGB(60, 100, 200)
    local btnStyle = style or "darken"
    local toggled = false
    local hovered = false
    
    self:ApplyButtonStyle(button, btnColor)
    
    if btnStyle == "darken" then
        button.MouseButton1Down:Connect(function() self:DarkenButton(button) end)
        button.MouseButton1Up:Connect(function() self:RestoreButtonStyle(button, btnColor) end)
        button.MouseLeave:Connect(function() if not toggled then self:RestoreButtonStyle(button, btnColor) end end)
    elseif btnStyle == "lighten" then
        button.MouseButton1Down:Connect(function() self:LightenButton(button) end)
        button.MouseButton1Up:Connect(function() self:RestoreButtonStyle(button, btnColor) end)
        button.MouseLeave:Connect(function() if not toggled then self:RestoreButtonStyle(button, btnColor) end end)
    elseif btnStyle == "toggle" then
        button.MouseButton1Click:Connect(function()
            toggled = not toggled
            if toggled then
                self:DarkenButton(button)
            else
                self:RestoreButtonStyle(button, btnColor)
            end
        end)
    elseif btnStyle == "hover" then
        button.MouseEnter:Connect(function() self:LightenButton(button) end)
        button.MouseLeave:Connect(function() self:RestoreButtonStyle(button, btnColor) end)
    elseif btnStyle == "hover-dark" then
        button.MouseEnter:Connect(function() self:DarkenButton(button) end)
        button.MouseLeave:Connect(function() self:RestoreButtonStyle(button, btnColor) end)
    end
    
    function button:SetStyle(newStyle, newColor)
        if newColor then
            btnColor = newColor
            self.BackgroundColor3 = btnColor
        end
        toggled = false
        self:RestoreButtonStyle(button, btnColor)
    end
    
    function button:SetToggled(state)
        toggled = state
        if toggled then
            self:DarkenButton(button)
        else
            self:RestoreButtonStyle(button, btnColor)
        end
    end
    
    return button
end

function YUUGTRL:CreateWindow(title, size, position)
    local ScreenGui = Create({
        type = "ScreenGui",
        Name = "YUUGTRL",
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 999,
        ResetOnSpawn = false
    })
    
    local Main = Create({
        type = "Frame",
        Size = size or (isMobile and UDim2.new(0, 280, 0, 400) or UDim2.new(0, 350, 0, 450)),
        Position = position or UDim2.new(0.5, -175, 0.5, -225),
        BackgroundColor3 = Color3.fromRGB(30, 30, 40),
        BorderSizePixel = 0,
        Parent = ScreenGui
    })
    
    Create({type = "UICorner",CornerRadius = UDim.new(0, 8),Parent = Main})
    
    local Header = Create({
        type = "Frame",
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Color3.fromRGB(40, 40, 50),
        BorderSizePixel = 0,
        Parent = Main
    })
    
    Create({type = "UICorner",CornerRadius = UDim.new(0, 8),Parent = Header})
    
    local Title = self:CreateLabel(Header, title or "YUUGTRL", UDim2.new(0, 15, 0, 0), UDim2.new(1, -100, 1, 0))
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    local Close = self:CreateButton(Header, "X", nil, Color3.fromRGB(255, 50, 50), UDim2.new(1, -70, 0, 5), UDim2.new(0, 30, 0, 30), "darken")
    Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
    
    local CustomBtn = self:CreateButton(Header, "...", nil, Color3.fromRGB(80, 100, 220), UDim2.new(1, -35, 0, 5), UDim2.new(0, 30, 0, 30), "hover")
    
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
    
    local dragging, dragInput, dragStart, startPos
    
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
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
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    local window = {
        ScreenGui = ScreenGui,
        Main = Main,
        Header = Header,
        Title = Title,
        Close = Close,
        CustomBtn = CustomBtn
    }
    
    function window:AddToHeader(instance, position, size)
        instance.Parent = Header
        if position then instance.Position = position end
        if size then instance.Size = size end
    end
    
    function window:AddToMain(instance, position, size)
        instance.Parent = Main
        if position then instance.Position = position end
        if size then instance.Size = size end
    end
    
    function window:Destroy()
        ScreenGui:Destroy()
    end
    
    return window
end

function YUUGTRL:CreateFrame(parent, size, position, color)
    return Create({
        type = "Frame",
        Size = size or UDim2.new(0, 100, 0, 100),
        Position = position or UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = color or Color3.fromRGB(40, 40, 50),
        BorderSizePixel = 0,
        Parent = parent
    })
end

function YUUGTRL:CreateLabel(parent, text, position, size, color)
    return Create({
        type = "TextLabel",
        Size = size or UDim2.new(0, 100, 0, 30),
        Position = position or UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text or "Label",
        TextColor3 = color or Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        Parent = parent
    })
end

function YUUGTRL:CreateButton(parent, text, callback, color, position, size, style)
    local btn = Create({
        type = "TextButton",
        Size = size or UDim2.new(0, 100, 0, 35),
        Position = position or UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = color or Color3.fromRGB(60, 100, 200),
        Text = text or "Button",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        Parent = parent
    })
    
    Create({type = "UICorner",CornerRadius = UDim.new(0, 6),Parent = btn})
    self:MakeButton(btn, color, style)
    
    if callback then
        btn.MouseButton1Click:Connect(function()
            local success, err = pcall(callback)
            if not success then warn(err) end
        end)
    end
    
    return btn
end

function YUUGTRL:CreateToggle(parent, text, default, callback, color, position, size, style)
    local frame = self:CreateFrame(parent, size or UDim2.new(0, 200, 0, 35), position, Color3.fromRGB(60, 60, 70))
    Create({type = "UICorner",CornerRadius = UDim.new(0, 6),Parent = frame})
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 100, 120)),ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 70))})
    gradient.Rotation = 90
    gradient.Parent = frame
    
    self:CreateLabel(frame, text, UDim2.new(0, 10, 0, 0), UDim2.new(1, -50, 1, 0))
    
    local toggleColor = default and Color3.fromRGB(80, 220, 100) or Color3.fromRGB(220, 80, 80)
    local toggleBtn = self:CreateButton(frame, "", nil, toggleColor, UDim2.new(1, -40, 0, 2.5), UDim2.new(0, 30, 0, 30), style or "toggle")
    Create({type = "UICorner",CornerRadius = UDim.new(0, 15),Parent = toggleBtn})
    
    local toggled = default or false
    
    toggleBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        local newColor = toggled and Color3.fromRGB(80, 220, 100) or Color3.fromRGB(220, 80, 80)
        toggleBtn.BackgroundColor3 = newColor
        self:ApplyButtonStyle(toggleBtn, newColor)
        if callback then
            local success, err = pcall(callback, toggled)
            if not success then warn(err) end
        end
    end)
    
    return toggleBtn
end

function YUUGTRL:CreateSlider(parent, text, min, max, default, callback, position, size)
    local frame = self:CreateFrame(parent, size or UDim2.new(0, 200, 0, 50), position, Color3.fromRGB(60, 60, 70))
    Create({type = "UICorner",CornerRadius = UDim.new(0, 6),Parent = frame})
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 100, 120)),ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 70))})
    gradient.Rotation = 90
    gradient.Parent = frame
    
    self:CreateLabel(frame, text, UDim2.new(0, 10, 0, 5), UDim2.new(1, -20, 0, 20))
    
    local valueLabel = self:CreateLabel(frame, tostring(default or 0), UDim2.new(1, -50, 0, 5), UDim2.new(0, 40, 0, 20))
    
    local slider = self:CreateFrame(frame, UDim2.new(1, -30, 0, 10), UDim2.new(0, 15, 0, 30), Color3.fromRGB(40, 40, 50))
    Create({type = "UICorner",CornerRadius = UDim.new(0, 5),Parent = slider})
    
    local fill = self:CreateFrame(slider, UDim2.new((default or 0) / max, 0, 1, 0), UDim2.new(0, 0, 0, 0), Color3.fromRGB(80, 100, 220))
    Create({type = "UICorner",CornerRadius = UDim.new(0, 5),Parent = fill})
    self:ApplyButtonStyle(fill, Color3.fromRGB(80, 100, 220))
    
    local dragging = false
    
    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pos = input.Position.X - slider.AbsolutePosition.X
            local size = slider.AbsoluteSize.X
            local percent = math.clamp(pos / size, 0, 1)
            local value = math.floor(min + (max - min) * percent)
            fill.Size = UDim2.new(percent, 0, 1, 0)
            valueLabel.Text = tostring(value)
            if callback then
                local success, err = pcall(callback, value)
                if not success then warn(err) end
            end
        end
    end)
    
    return slider
end

return YUUGTRL
