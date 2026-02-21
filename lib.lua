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
frame.Size = UDim2.new(0, 200, 0, 60)
frame.Position = UDim2.new(0.5, -100, 0, -70)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
frame.BackgroundTransparency = 0.3
frame.BorderSizePixel = 0
frame.Parent = splash

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 25))
})
gradient.Rotation = 90
gradient.Parent = frame

local text = Instance.new("TextLabel")
text.Size = UDim2.new(0.6, -5, 1, 0)
text.Position = UDim2.new(0, 10, 0, 0)
text.BackgroundTransparency = 1
text.Text = "YUUGTRL"
text.TextColor3 = Color3.fromRGB(255, 255, 255)
text.Font = Enum.Font.GothamBold
text.TextSize = 24
text.TextXAlignment = Enum.TextXAlignment.Left
text.Parent = frame

local loadedText = Instance.new("TextLabel")
loadedText.Size = UDim2.new(0.4, -5, 1, 0)
loadedText.Position = UDim2.new(0.6, 0, 0, 0)
loadedText.BackgroundTransparency = 1
loadedText.Text = "loaded"
loadedText.TextColor3 = Color3.fromRGB(255, 255, 255)
loadedText.Font = Enum.Font.Gotham
loadedText.TextSize = 16
loadedText.TextXAlignment = Enum.TextXAlignment.Left
loadedText.Parent = frame

frame:TweenPosition(UDim2.new(0.5, -100, 0, 30), "Out", "Quad", 0.9, true)

task.wait(0.4)

local textColorTween = TweenService:Create(text, TweenInfo.new(1.0, Enum.EasingStyle.Quad), {TextColor3 = Color3.fromRGB(170, 85, 255)})
textColorTween:Play()

task.wait(1.6)

local fadeTween = TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {BackgroundTransparency = 1})
fadeTween:Play()
TweenService:Create(text, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {TextTransparency = 1}):Play()
TweenService:Create(loadedText, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {TextTransparency = 1}):Play()

fadeTween.Completed:Connect(function()
    splash:Destroy()
end)

local languages = {}
local currentLanguage = "English"
local translatableElements = {}

function YUUGTRL:AddLanguage(name, translations)
    languages[name] = translations
end

function YUUGTRL:ChangeLanguage(lang)
    if languages[lang] then
        currentLanguage = lang
        self:UpdateAllTexts()
        return true
    end
    return false
end

function YUUGTRL:GetCurrentLanguage()
    return currentLanguage
end

function YUUGTRL:GetLanguages()
    local langs = {}
    for lang, _ in pairs(languages) do
        table.insert(langs, lang)
    end
    return langs
end

function YUUGTRL:GetText(key)
    return languages[currentLanguage] and languages[currentLanguage][key] or key
end

function YUUGTRL:RegisterTranslatable(element, key)
    if element and key then
        table.insert(translatableElements, {element = element, key = key})
    end
end

function YUUGTRL:UpdateAllTexts()
    for i = #translatableElements, 1, -1 do
        local item = translatableElements[i]
        if item.element and item.element.Parent then
            local newText = self:GetText(item.key)
            if newText then
                pcall(function()
                    if item.element:IsA("TextLabel") or item.element:IsA("TextButton") then
                        item.element.Text = newText
                    end
                end)
            end
        else
            table.remove(translatableElements, i)
        end
    end
end

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
    if not button then return end
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
    local brighter = Color3.fromRGB(math.min(color.R * 255 + 120, 255), math.min(color.G * 255 + 120, 255), math.min(color.B * 255 + 120, 255))
    button.TextColor3 = brighter
    button.Font = Enum.Font.GothamBold
    return button
end

function YUUGTRL:DarkenButton(button)
    if not button or not button:FindFirstChild("UIGradient") then return end
    local gradient = button:FindFirstChild("UIGradient")
    local color = gradient.Color.Keypoints[1].Value
    local darker = Color3.fromRGB(math.max(color.R * 255 - 90, 0), math.max(color.G * 255 - 90, 0), math.max(color.B * 255 - 90, 0))
    gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, darker),ColorSequenceKeypoint.new(1, darker)})
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
end

function YUUGTRL:LightenButton(button)
    if not button or not button:FindFirstChild("UIGradient") then return end
    local gradient = button:FindFirstChild("UIGradient")
    local color = gradient.Color.Keypoints[1].Value
    local lighter = Color3.fromRGB(math.min(color.R * 255 + 90, 255), math.min(color.G * 255 + 90, 255), math.min(color.B * 255 + 90, 255))
    gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, lighter),ColorSequenceKeypoint.new(1, lighter)})
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
end

function YUUGTRL:RestoreButtonStyle(button, color)
    if not button or not button:FindFirstChild("UIGradient") then return end
    local gradient = button:FindFirstChild("UIGradient")
    local darker = Color3.fromRGB(math.max(color.R * 255 - 50, 0), math.max(color.G * 255 - 50, 0), math.max(color.B * 255 - 50, 0))
    local brighter = Color3.fromRGB(math.min(color.R * 255 + 120, 255), math.min(color.G * 255 + 120, 255), math.min(color.B * 255 + 120, 255))
    gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, color),ColorSequenceKeypoint.new(1, darker)})
    button.TextColor3 = brighter
end

function YUUGTRL:MakeButton(button, color, style)
    if not button then return end
    local btnColor = color or Color3.fromRGB(60, 100, 200)
    local btnStyle = style or "darken"
    
    self:ApplyButtonStyle(button, btnColor)
    
    if btnStyle == "darken" then
        button.MouseButton1Down:Connect(function() 
            self:DarkenButton(button) 
        end)
        button.MouseButton1Up:Connect(function() 
            self:RestoreButtonStyle(button, btnColor) 
        end)
    elseif btnStyle == "lighten" then
        button.MouseButton1Down:Connect(function() 
            self:LightenButton(button) 
        end)
        button.MouseButton1Up:Connect(function() 
            self:RestoreButtonStyle(button, btnColor) 
        end)
    elseif btnStyle == "hover" then
        button.MouseEnter:Connect(function() 
            self:LightenButton(button) 
        end)
        button.MouseLeave:Connect(function() 
            self:RestoreButtonStyle(button, btnColor) 
        end)
    elseif btnStyle == "hover-dark" then
        button.MouseEnter:Connect(function() 
            self:DarkenButton(button) 
        end)
        button.MouseLeave:Connect(function() 
            self:RestoreButtonStyle(button, btnColor) 
        end)
    end
    
    return button
end

function YUUGTRL:CreateWindow(title, size, position, options)
    options = options or {}
    
    local ScreenGui = Create({
        type = "ScreenGui",
        Name = "YUUGTRL_" .. (title:gsub("%s+", "") or "Window"),
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 999,
        ResetOnSpawn = false,
        Parent = player:WaitForChild("PlayerGui")
    })
    
    local Main = Create({
        type = "Frame",
        Size = size or UDim2.new(0, 350, 0, 450),
        Position = position or UDim2.new(0.5, -175, 0.5, -225),
        BackgroundColor3 = options.MainColor or Color3.fromRGB(30, 30, 40),
        BorderSizePixel = 0,
        Parent = ScreenGui
    })
    
    Create({type = "UICorner",CornerRadius = UDim.new(0, 12),Parent = Main})
    
    local Header = Create({
        type = "Frame",
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = options.HeaderColor or Color3.fromRGB(40, 40, 50),
        BorderSizePixel = 0,
        Parent = Main
    })
    
    Create({type = "UICorner",CornerRadius = UDim.new(0, 12),Parent = Header})
    
    local Title = self:CreateLabel(Header, title, UDim2.new(0, 15, 0, 0), UDim2.new(1, -100, 1, 0), options.TextColor or Color3.fromRGB(255, 255, 255))
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextSize = 18
    if options.titleKey then
        self:RegisterTranslatable(Title, options.titleKey)
    end
    
    local SettingsBtn
    local CloseBtn
    local ResizeBtn
    
    if options.ShowSettings ~= false then
        SettingsBtn = self:CreateButton(Header, "⚙", nil, options.AccentColor or Color3.fromRGB(80, 100, 220), UDim2.new(1, -105, 0, 5), UDim2.new(0, 30, 0, 30), "darken")
    end
    
    if options.ShowResize ~= false then
        ResizeBtn = self:CreateButton(Header, "◢", nil, options.AccentColor or Color3.fromRGB(80, 100, 220), UDim2.new(1, -70, 0, 5), UDim2.new(0, 30, 0, 30), "hover")
    end
    
    if options.ShowClose ~= false then
        CloseBtn = self:CreateButton(Header, "X", nil, options.CloseColor or Color3.fromRGB(255, 100, 100), UDim2.new(1, -35, 0, 5), UDim2.new(0, 30, 0, 30), "darken")
        CloseBtn.MouseButton1Click:Connect(function() 
            ScreenGui:Destroy() 
        end)
    end
    
    local dragging, dragInput, dragStart, startPos
    local resizing = false
    local resizeStart = nil
    local resizeStartSize = nil
    
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
    
    if ResizeBtn then
        ResizeBtn.MouseButton1Down:Connect(function(input)
            resizing = true
            resizeStart = input.Position
            resizeStartSize = Main.Size
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                resizing = false
                resizeStart = nil
                resizeStartSize = nil
            end
        end)
    end
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
        
        if resizing and resizeStart and resizeStartSize and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - resizeStart
            local newWidth = math.max(200, resizeStartSize.X.Offset + delta.X)
            local newHeight = math.max(150, resizeStartSize.Y.Offset + delta.Y)
            Main.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end)
    
    local window = {
        ScreenGui = ScreenGui,
        Main = Main,
        Header = Header,
        Title = Title,
        SettingsBtn = SettingsBtn,
        CloseBtn = CloseBtn,
        ResizeBtn = ResizeBtn,
        elements = {}
    }
    
    function window:CreateFrame(size, position, color, radius)
        return YUUGTRL:CreateFrame(self.Main, size, position, color, radius)
    end
    
    function window:CreateScrollingFrame(size, position, color, radius)
        return YUUGTRL:CreateScrollingFrame(self.Main, size, position, color, radius)
    end
    
    function window:CreateLabel(text, position, size, color, translationKey)
        local label = YUUGTRL:CreateLabel(self.Main, text, position, size, color)
        if translationKey then
            YUUGTRL:RegisterTranslatable(label, translationKey)
        end
        return label
    end
    
    function window:CreateButton(text, callback, color, position, size, style, translationKey)
        local btn = YUUGTRL:CreateButton(self.Main, text, callback, color, position, size, style)
        if translationKey then
            YUUGTRL:RegisterTranslatable(btn, translationKey)
        end
        return btn
    end
    
    function window:CreateToggle(text, default, callback, color, position, size, translationKey)
        local frame = YUUGTRL:CreateFrame(self.Main, size or UDim2.new(0, 200, 0, 35), position, Color3.fromRGB(45, 45, 55), 8)
        
        local label = YUUGTRL:CreateLabel(frame, text, UDim2.new(0, 10, 0, 0), UDim2.new(1, -50, 1, 0))
        if translationKey then
            YUUGTRL:RegisterTranslatable(label, translationKey)
        end
        
        local toggleColor = default and Color3.fromRGB(80, 220, 100) or Color3.fromRGB(220, 80, 80)
        local toggleBtn = YUUGTRL:CreateButton(frame, "", nil, toggleColor, UDim2.new(1, -40, 0, 2.5), UDim2.new(0, 30, 0, 30), "darken")
        Create({type = "UICorner",CornerRadius = UDim.new(0, 15),Parent = toggleBtn})
        
        local toggled = default or false
        
        toggleBtn.MouseButton1Click:Connect(function()
            toggled = not toggled
            local newColor = toggled and Color3.fromRGB(80, 220, 100) or Color3.fromRGB(220, 80, 80)
            toggleBtn.BackgroundColor3 = newColor
            YUUGTRL:ApplyButtonStyle(toggleBtn, newColor)
            if callback then callback(toggled) end
        end)
        
        return toggleBtn
    end
    
    function window:CreateSlider(text, min, max, default, callback, position, size)
        return YUUGTRL:CreateSlider(self.Main, text, min, max, default, callback, position, size)
    end
    
    function window:SetSettingsCallback(callback)
        if SettingsBtn then
            SettingsBtn.MouseButton1Click:Connect(callback)
        end
    end
    
    function window:SetCloseCallback(callback)
        if CloseBtn then
            CloseBtn.MouseButton1Click:Connect(callback)
        end
    end
    
    function window:SetResizeEnabled(enabled)
        if ResizeBtn then
            ResizeBtn.Visible = enabled
        end
    end
    
    function window:Destroy()
        ScreenGui:Destroy()
    end
    
    function window:UpdateLanguage()
        YUUGTRL:UpdateAllTexts()
    end
    
    return window
end

function YUUGTRL:CreateFrame(parent, size, position, color, radius)
    if not parent then return end
    local frame = Create({
        type = "Frame",
        Size = size or UDim2.new(0, 100, 0, 100),
        Position = position or UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = color or Color3.fromRGB(35, 35, 45),
        BorderSizePixel = 0,
        Parent = parent
    })
    
    Create({type = "UICorner",CornerRadius = UDim.new(0, radius or 12),Parent = frame})
    
    return frame
end

function YUUGTRL:CreateScrollingFrame(parent, size, position, color, radius)
    if not parent then return end
    local frame = Instance.new("ScrollingFrame")
    frame.Size = size or UDim2.new(0, 200, 0, 200)
    frame.Position = position or UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = color or Color3.fromRGB(35, 35, 45)
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.ScrollBarThickness = 4
    frame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 150)
    frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    frame.Parent = parent
    
    if radius then
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, radius)
        corner.Parent = frame
    end
    
    return frame
end

function YUUGTRL:CreateLabel(parent, text, position, size, color)
    if not parent then return end
    return Create({
        type = "TextLabel",
        Size = size or UDim2.new(0, 100, 0, 30),
        Position = position or UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text or "Label",
        TextColor3 = color or Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = parent
    })
end

function YUUGTRL:CreateButton(parent, text, callback, color, position, size, style)
    if not parent then return end
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
    
    Create({type = "UICorner",CornerRadius = UDim.new(0, 8),Parent = btn})
    self:MakeButton(btn, color, style)
    
    if callback then
        btn.MouseButton1Click:Connect(callback)
    end
    
    return btn
end

function YUUGTRL:CreateSlider(parent, text, min, max, default, callback, position, size)
    if not parent then return end
    local frame = self:CreateFrame(parent, size or UDim2.new(0, 200, 0, 50), position, Color3.fromRGB(45, 45, 55), 8)
    
    self:CreateLabel(frame, text or "", UDim2.new(0, 10, 0, 5), UDim2.new(1, -60, 0, 20))
    
    local valueLabel = self:CreateLabel(frame, tostring(default or 0), UDim2.new(1, -50, 0, 5), UDim2.new(0, 40, 0, 20))
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    
    local slider = self:CreateFrame(frame, UDim2.new(1, -20, 0, 8), UDim2.new(0, 10, 0, 30), Color3.fromRGB(60, 60, 70), 4)
    
    local fill = self:CreateFrame(slider, UDim2.new((default or 0) / max, 0, 1, 0), UDim2.new(0, 0, 0, 0), Color3.fromRGB(80, 100, 220), 4)
    
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
            if callback then callback(value) end
        end
    end)
    
    return slider
end

return YUUGTRL
