local YUUGTRL = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled
local viewportSize = workspace.CurrentCamera.ViewportSize

local scale = 1
if isMobile then
    scale = math.min(viewportSize.X / 600, 0.9)
end

local splash = Instance.new("ScreenGui")
splash.Name = "YUUGTRLSplash"
splash.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
splash.DisplayOrder = 9999
splash.ResetOnSpawn = false
splash.Parent = player:WaitForChild("PlayerGui")

local splashWidth = 200 * scale
local splashHeight = 50 * scale
local splashFrame = Instance.new("Frame")
splashFrame.Size = UDim2.new(0, splashWidth, 0, splashHeight)
splashFrame.Position = UDim2.new(1, -splashWidth - 15, 0, 15)
splashFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
splashFrame.BackgroundTransparency = 0.2
splashFrame.BorderSizePixel = 0
splashFrame.Parent = splash

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10 * scale)
corner.Parent = splashFrame

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 25))
})
gradient.Rotation = 90
gradient.Parent = splashFrame

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(0.6, -5 * scale, 1, 0)
logo.Position = UDim2.new(0, 8 * scale, 0, 0)
logo.BackgroundTransparency = 1
logo.Text = "YUUGTRL"
logo.TextColor3 = Color3.fromRGB(255, 255, 255)
logo.Font = Enum.Font.GothamBold
logo.TextSize = 22 * scale
logo.TextXAlignment = Enum.TextXAlignment.Left
logo.Parent = splashFrame

local loaded = Instance.new("TextLabel")
loaded.Size = UDim2.new(0.4, -5 * scale, 1, 0)
loaded.Position = UDim2.new(0.6, 0, 0, 0)
loaded.BackgroundTransparency = 1
loaded.Text = "loaded"
loaded.TextColor3 = Color3.fromRGB(255, 255, 255)
loaded.Font = Enum.Font.Gotham
loaded.TextSize = 14 * scale
loaded.TextXAlignment = Enum.TextXAlignment.Left
loaded.Parent = splashFrame

splashFrame:TweenPosition(UDim2.new(1, -splashWidth - 15, 0, 15), "Out", "Quad", 0.3, true)

task.wait(0.2)

local textColorTween = TweenService:Create(logo, TweenInfo.new(0.8, Enum.EasingStyle.Quad), {TextColor3 = Color3.fromRGB(170, 85, 255)})
textColorTween:Play()

task.wait(1.2)

local fadeTween = TweenService:Create(splashFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
    Position = UDim2.new(1, -splashWidth - 15, 1, splashHeight + 15),
    BackgroundTransparency = 1
})
fadeTween:Play()
TweenService:Create(logo, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {TextTransparency = 1}):Play()
TweenService:Create(loaded, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {TextTransparency = 1}):Play()

fadeTween.Completed:Connect(function()
    splash:Destroy()
end)

local languages = {}
local currentLanguage = "English"
local translatableElements = {}
local themes = {
    dark = {
        MainColor = Color3.fromRGB(30, 30, 40),
        HeaderColor = Color3.fromRGB(40, 40, 50),
        TextColor = Color3.fromRGB(255, 255, 255),
        AccentColor = Color3.fromRGB(80, 100, 220),
        ButtonColor = Color3.fromRGB(60, 100, 200),
        FrameColor = Color3.fromRGB(35, 35, 45),
        InputColor = Color3.fromRGB(40, 40, 50),
        ScrollBarColor = Color3.fromRGB(100, 100, 150),
        DangerColor = Color3.fromRGB(255, 100, 100),
        SuccessColor = Color3.fromRGB(100, 255, 100),
        WarningColor = Color3.fromRGB(255, 200, 100)
    },
    black = {
        MainColor = Color3.fromRGB(10, 10, 10),
        HeaderColor = Color3.fromRGB(20, 20, 20),
        TextColor = Color3.fromRGB(255, 255, 255),
        AccentColor = Color3.fromRGB(100, 100, 100),
        ButtonColor = Color3.fromRGB(80, 80, 80),
        FrameColor = Color3.fromRGB(15, 15, 15),
        InputColor = Color3.fromRGB(25, 25, 25),
        ScrollBarColor = Color3.fromRGB(150, 150, 150),
        DangerColor = Color3.fromRGB(255, 100, 100),
        SuccessColor = Color3.fromRGB(100, 255, 100),
        WarningColor = Color3.fromRGB(255, 200, 100)
    },
    purple = {
        MainColor = Color3.fromRGB(25, 20, 35),
        HeaderColor = Color3.fromRGB(35, 30, 45),
        TextColor = Color3.fromRGB(255, 255, 255),
        AccentColor = Color3.fromRGB(160, 90, 255),
        ButtonColor = Color3.fromRGB(140, 70, 230),
        FrameColor = Color3.fromRGB(30, 25, 40),
        InputColor = Color3.fromRGB(35, 30, 45),
        ScrollBarColor = Color3.fromRGB(180, 120, 255),
        DangerColor = Color3.fromRGB(255, 100, 100),
        SuccessColor = Color3.fromRGB(100, 255, 100),
        WarningColor = Color3.fromRGB(255, 200, 100)
    }
}
local currentTheme = themes.dark

function YUUGTRL:SetTheme(themeName)
    if themes[themeName] then
        currentTheme = themes[themeName]
        return true
    end
    return false
end

function YUUGTRL:GetTheme()
    return currentTheme
end

function YUUGTRL:AddTheme(name, themeTable)
    themes[name] = themeTable
end

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

local function IsEmojiOrSymbol(text)
    if not text then return false end
    local emojiPattern = "[\226-\231][\128-\191]+"
    local symbolPattern = "[!@#$%%^&*()_+=\\-\\[\\]{}|;:',.<>?/~`]"
    return string.find(text, emojiPattern) or string.find(text, symbolPattern)
end

function YUUGTRL:CreateButton(parent, text, callback, color, position, size)
    if not parent then return end

    local btnColor = color or currentTheme.ButtonColor

    local btn = Create({
        type = "TextButton",
        Size = size or UDim2.new(0, 120 * scale, 0, 35 * scale),
        Position = position or UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = btnColor,
        Text = text or "Button",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 14 * scale,
        Parent = parent
    })

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8 * scale)
    corner.Parent = btn

    local darker = Color3.fromRGB(
        math.max(btnColor.R * 255 - 50, 0),
        math.max(btnColor.G * 255 - 50, 0),
        math.max(btnColor.B * 255 - 50, 0)
    )

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, btnColor),
        ColorSequenceKeypoint.new(1, darker)
    })
    gradient.Rotation = 90
    gradient.Parent = btn

    local brighter = Color3.fromRGB(
        math.min(btnColor.R * 255 + 200, 255),
        math.min(btnColor.G * 255 + 200, 255),
        math.min(btnColor.B * 255 + 200, 255)
    )
    
    if IsEmojiOrSymbol(text) then
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        btn.TextColor3 = brighter
    end

    btn.MouseEnter:Connect(function()
        local hoverColor = Color3.fromRGB(
            math.min(btnColor.R * 255 + 30, 255),
            math.min(btnColor.G * 255 + 30, 255),
            math.min(btnColor.B * 255 + 30, 255)
        )
        local hoverDarker = Color3.fromRGB(
            math.max(hoverColor.R * 255 - 50, 0),
            math.max(hoverColor.G * 255 - 50, 0),
            math.max(hoverColor.B * 255 - 50, 0)
        )
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, hoverColor),
            ColorSequenceKeypoint.new(1, hoverDarker)
        })
        if not IsEmojiOrSymbol(btn.Text) then
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)

    btn.MouseLeave:Connect(function()
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, btnColor),
            ColorSequenceKeypoint.new(1, darker)
        })
        if not IsEmojiOrSymbol(btn.Text) then
            btn.TextColor3 = brighter
        end
    end)

    if callback then
        btn.MouseButton1Click:Connect(callback)
    end

    return btn
end

function YUUGTRL:DarkenButton(button)
    if not button then return end
    local gradient = button:FindFirstChildOfClass("UIGradient")
    if gradient then
        local currentColor = gradient.Color.Keypoints[1].Value
        local darker = Color3.fromRGB(
            math.max(currentColor.R * 255 - 70, 0),
            math.max(currentColor.G * 255 - 70, 0),
            math.max(currentColor.B * 255 - 70, 0)
        )
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, darker),
            ColorSequenceKeypoint.new(1, darker)
        })
    end
end

function YUUGTRL:RestoreButtonStyle(button, color)
    if not button then return end
    local gradient = button:FindFirstChildOfClass("UIGradient")
    if gradient then
        local darker = Color3.fromRGB(
            math.max(color.R * 255 - 50, 0),
            math.max(color.G * 255 - 50, 0),
            math.max(color.B * 255 - 50, 0)
        )
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, color),
            ColorSequenceKeypoint.new(1, darker)
        })
        local brighter = Color3.fromRGB(
            math.min(color.R * 255 + 200, 255),
            math.min(color.G * 255 + 200, 255),
            math.min(color.B * 255 + 200, 255)
        )
        if not IsEmojiOrSymbol(button.Text) then
            button.TextColor3 = brighter
        end
    end
end

function YUUGTRL:CreateButtonToggle(parent, text, default, callback, position, size, colors)
    if not parent then return end

    colors = colors or {}
    local isOn = default or false

    local buttonColor = colors.off or currentTheme.ButtonColor
    if colors.on then
        buttonColor = colors.on
    end

    local button = Instance.new("TextButton")
    button.Size = size or UDim2.new(0, 120 * scale, 0, 35 * scale)
    button.Position = position or UDim2.new(0, 0, 0, 0)
    button.BackgroundColor3 = buttonColor
    button.Text = text or "Button"
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14 * scale
    button.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8 * scale)
    corner.Parent = button

    local gradient = Instance.new("UIGradient")
    gradient.Rotation = 90
    gradient.Parent = button

    local brighter = Color3.fromRGB(
        math.min(buttonColor.R * 255 + 200, 255),
        math.min(buttonColor.G * 255 + 200, 255),
        math.min(buttonColor.B * 255 + 200, 255)
    )

    local function updateGradient()
        local grad = button:FindFirstChildOfClass("UIGradient")
        if not grad then
            grad = Instance.new("UIGradient")
            grad.Rotation = 90
            grad.Parent = button
        end

        local currentColor = buttonColor
        local darkAmount = isOn and 70 or 50
        local darker2 = Color3.fromRGB(
            math.max(currentColor.R * 255 - darkAmount, 0),
            math.max(currentColor.G * 255 - darkAmount, 0),
            math.max(currentColor.B * 255 - darkAmount, 0)
        )

        grad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, isOn and darker2 or currentColor),
            ColorSequenceKeypoint.new(1, darker2)
        })

        if not IsEmojiOrSymbol(button.Text) then
            if isOn then
                button.TextColor3 = Color3.fromRGB(
                    math.min(currentColor.R * 255 + 230, 255),
                    math.min(currentColor.G * 255 + 230, 255),
                    math.min(currentColor.B * 255 + 230, 255)
                )
            else
                button.TextColor3 = brighter
            end
        end
    end

    updateGradient()

    button.MouseEnter:Connect(function()
        local currentColor = buttonColor
        local hoverColor = Color3.fromRGB(
            math.min(currentColor.R * 255 + 30, 255),
            math.min(currentColor.G * 255 + 30, 255),
            math.min(currentColor.B * 255 + 30, 255)
        )
        local hoverDarker = Color3.fromRGB(
            math.max(hoverColor.R * 255 - 50, 0),
            math.max(hoverColor.G * 255 - 50, 0),
            math.max(hoverColor.B * 255 - 50, 0)
        )

        local grad = button:FindFirstChildOfClass("UIGradient")
        if grad then
            grad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, hoverColor),
                ColorSequenceKeypoint.new(1, hoverDarker)
            })
        end

        if not IsEmojiOrSymbol(button.Text) then
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)

    button.MouseLeave:Connect(function()
        updateGradient()
    end)

    button.MouseButton1Click:Connect(function()
        isOn = not isOn
        updateGradient()
        if callback then
            pcall(callback, isOn)
        end
    end)

    local toggleObject = {}

    function toggleObject:SetState(state)
        isOn = state
        updateGradient()
        if callback then pcall(callback, isOn) end
    end

    function toggleObject:GetState()
        return isOn
    end

    function toggleObject:Toggle()
        isOn = not isOn
        updateGradient()
        if callback then pcall(callback, isOn) end
    end

    function toggleObject:SetText(newText)
        button.Text = newText
    end

    function toggleObject:SetColors(newColors)
        if newColors.on then buttonColor = newColors.on end
        if newColors.off then buttonColor = newColors.off end
        updateGradient()
    end

    function toggleObject:Destroy()
        button:Destroy()
    end

    toggleObject.button = button

    return toggleObject
end

local antiSitInstances = {}
local walkFlingInstances = {}

function YUUGTRL:CreateAntiSitButton(parent, text, default, callback, position, size, colors)
    if not parent then return end

    local antiSitEnabled = default or false
    local antiSitConnection = nil

    local colors = colors or {}
    local buttonColor = colors.off or currentTheme.ButtonColor
    if colors.on then
        buttonColor = colors.on
    end

    local button = Instance.new("TextButton")
    button.Size = size or UDim2.new(0, 140 * scale, 0, 40 * scale)
    button.Position = position or UDim2.new(0, 0, 0, 0)
    button.BackgroundColor3 = buttonColor
    button.Text = text or "ANTI SIT"
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14 * scale
    button.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8 * scale)
    corner.Parent = button

    local gradient = Instance.new("UIGradient")
    gradient.Rotation = 90
    gradient.Parent = button

    local brighter = Color3.fromRGB(
        math.min(buttonColor.R * 255 + 200, 255),
        math.min(buttonColor.G * 255 + 200, 255),
        math.min(buttonColor.B * 255 + 200, 255)
    )

    local function updateGradient()
        local grad = button:FindFirstChildOfClass("UIGradient")
        if not grad then
            grad = Instance.new("UIGradient")
            grad.Rotation = 90
            grad.Parent = button
        end

        local currentColor = buttonColor
        local darkAmount = antiSitEnabled and 70 or 50
        local darker2 = Color3.fromRGB(
            math.max(currentColor.R * 255 - darkAmount, 0),
            math.max(currentColor.G * 255 - darkAmount, 0),
            math.max(currentColor.B * 255 - darkAmount, 0)
        )

        grad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, antiSitEnabled and darker2 or currentColor),
            ColorSequenceKeypoint.new(1, darker2)
        })

        if not IsEmojiOrSymbol(button.Text) then
            if antiSitEnabled then
                button.TextColor3 = Color3.fromRGB(
                    math.min(currentColor.R * 255 + 230, 255),
                    math.min(currentColor.G * 255 + 230, 255),
                    math.min(currentColor.B * 255 + 230, 255)
                )
            else
                button.TextColor3 = brighter
            end
        end
    end

    local function updateCharacter()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            return char.Humanoid
        end
        return nil
    end

    local function startAntiSit()
        local humanoid = updateCharacter()
        if humanoid then
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        end

        if antiSitConnection then antiSitConnection:Disconnect() end
        antiSitConnection = RunService.Heartbeat:Connect(function()
            local char = player.Character
            if char and char:FindFirstChild("Humanoid") then
                local hum = char.Humanoid
                if hum:GetState() == Enum.HumanoidStateType.Seated then
                    hum:ChangeState(Enum.HumanoidStateType.Running)
                end
            end
        end)
    end

    local function stopAntiSit()
        if antiSitConnection then
            antiSitConnection:Disconnect()
            antiSitConnection = nil
        end
        local humanoid = updateCharacter()
        if humanoid then
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        end
    end

    updateGradient()

    button.MouseEnter:Connect(function()
        local currentColor = buttonColor
        local hoverColor = Color3.fromRGB(
            math.min(currentColor.R * 255 + 30, 255),
            math.min(currentColor.G * 255 + 30, 255),
            math.min(currentColor.B * 255 + 30, 255)
        )
        local hoverDarker = Color3.fromRGB(
            math.max(hoverColor.R * 255 - 50, 0),
            math.max(hoverColor.G * 255 - 50, 0),
            math.max(hoverColor.B * 255 - 50, 0)
        )

        local grad = button:FindFirstChildOfClass("UIGradient")
        if grad then
            grad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, hoverColor),
                ColorSequenceKeypoint.new(1, hoverDarker)
            })
        end

        if not IsEmojiOrSymbol(button.Text) then
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)

    button.MouseLeave:Connect(function()
        updateGradient()
    end)

    button.MouseButton1Click:Connect(function()
        antiSitEnabled = not antiSitEnabled
        if antiSitEnabled then
            startAntiSit()
        else
            stopAntiSit()
        end
        updateGradient()
        if callback then
            pcall(callback, antiSitEnabled)
        end
    end)

    player.CharacterAdded:Connect(function()
        if antiSitEnabled then
            task.wait(0.5)
            local char = player.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            end
        end
    end)

    local antiSitObject = {}

    function antiSitObject:SetState(state)
        antiSitEnabled = state
        if antiSitEnabled then
            startAntiSit()
        else
            stopAntiSit()
        end
        updateGradient()
        if callback then pcall(callback, antiSitEnabled) end
    end

    function antiSitObject:GetState()
        return antiSitEnabled
    end

    function antiSitObject:Toggle()
        antiSitEnabled = not antiSitEnabled
        if antiSitEnabled then
            startAntiSit()
        else
            stopAntiSit()
        end
        updateGradient()
        if callback then pcall(callback, antiSitEnabled) end
    end

    function antiSitObject:SetText(newText)
        button.Text = newText
    end

    function antiSitObject:SetColors(newColors)
        if newColors.on then buttonColor = newColors.on end
        if newColors.off then buttonColor = newColors.off end
        updateGradient()
    end

    function antiSitObject:Destroy()
        if antiSitConnection then antiSitConnection:Disconnect() end
        button:Destroy()
    end

    antiSitObject.button = button
    table.insert(antiSitInstances, antiSitObject)

    return antiSitObject
end

function YUUGTRL:CreateWalkFlingButton(parent, text, default, callback, position, size, colors)
    if not parent then return end

    local walkFlingEnabled = default or false
    local walkFlingConnection = nil
    local jumpConnection = nil
    local character = nil
    local root = nil
    local humanoid = nil

    local colors = colors or {}
    local buttonColor = colors.off or currentTheme.ButtonColor
    if colors.on then
        buttonColor = colors.on
    end

    local button = Instance.new("TextButton")
    button.Size = size or UDim2.new(0, 140 * scale, 0, 40 * scale)
    button.Position = position or UDim2.new(0, 0, 0, 0)
    button.BackgroundColor3 = buttonColor
    button.Text = text or "WALK FLING"
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14 * scale
    button.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8 * scale)
    corner.Parent = button

    local gradient = Instance.new("UIGradient")
    gradient.Rotation = 90
    gradient.Parent = button

    local brighter = Color3.fromRGB(
        math.min(buttonColor.R * 255 + 200, 255),
        math.min(buttonColor.G * 255 + 200, 255),
        math.min(buttonColor.B * 255 + 200, 255)
    )

    local function updateCharacter()
        character = player.Character
        if character then
            root = character:FindFirstChild("HumanoidRootPart")
            humanoid = character:FindFirstChild("Humanoid")
        end
    end

    local function startWalkFling()
        updateCharacter()
        if not character or not root or not humanoid then return end

        root.CanCollide = false
        humanoid:ChangeState(11)

        if jumpConnection then jumpConnection:Disconnect() end
        jumpConnection = UserInputService.JumpRequest:Connect(function()
            if humanoid and humanoid.Health > 0 then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)

        if walkFlingConnection then walkFlingConnection:Disconnect() end

        walkFlingConnection = RunService.Heartbeat:Connect(function()
            if not walkFlingEnabled or not root or not humanoid then return end
            if humanoid.Health <= 0 then 
                walkFlingEnabled = false 
                updateGradient()
                return 
            end

            local vel = root.Velocity
            root.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
            RunService.RenderStepped:Wait()
            if root then root.Velocity = vel end
            RunService.Stepped:Wait()
            if root then root.Velocity = vel + Vector3.new(0, 0.1, 0) end
        end)
    end

    local function stopWalkFling()
        if walkFlingConnection then 
            walkFlingConnection:Disconnect() 
            walkFlingConnection = nil 
        end
        if jumpConnection then 
            jumpConnection:Disconnect() 
            jumpConnection = nil 
        end
        if root then root.CanCollide = true end
        if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Running) end
    end

    local function updateGradient()
        local grad = button:FindFirstChildOfClass("UIGradient")
        if not grad then
            grad = Instance.new("UIGradient")
            grad.Rotation = 90
            grad.Parent = button
        end

        local currentColor = buttonColor
        local darkAmount = walkFlingEnabled and 70 or 50
        local darker2 = Color3.fromRGB(
            math.max(currentColor.R * 255 - darkAmount, 0),
            math.max(currentColor.G * 255 - darkAmount, 0),
            math.max(currentColor.B * 255 - darkAmount, 0)
        )

        grad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, walkFlingEnabled and darker2 or currentColor),
            ColorSequenceKeypoint.new(1, darker2)
        })

        if not IsEmojiOrSymbol(button.Text) then
            if walkFlingEnabled then
                button.TextColor3 = Color3.fromRGB(
                    math.min(currentColor.R * 255 + 230, 255),
                    math.min(currentColor.G * 255 + 230, 255),
                    math.min(currentColor.B * 255 + 230, 255)
                )
            else
                button.TextColor3 = brighter
            end
        end
    end

    updateGradient()

    button.MouseEnter:Connect(function()
        local currentColor = buttonColor
        local hoverColor = Color3.fromRGB(
            math.min(currentColor.R * 255 + 30, 255),
            math.min(currentColor.G * 255 + 30, 255),
            math.min(currentColor.B * 255 + 30, 255)
        )
        local hoverDarker = Color3.fromRGB(
            math.max(hoverColor.R * 255 - 50, 0),
            math.max(hoverColor.G * 255 - 50, 0),
            math.max(hoverColor.B * 255 - 50, 0)
        )

        local grad = button:FindFirstChildOfClass("UIGradient")
        if grad then
            grad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, hoverColor),
                ColorSequenceKeypoint.new(1, hoverDarker)
            })
        end

        if not IsEmojiOrSymbol(button.Text) then
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)

    button.MouseLeave:Connect(function()
        updateGradient()
    end)

    button.MouseButton1Click:Connect(function()
        walkFlingEnabled = not walkFlingEnabled
        if walkFlingEnabled then
            startWalkFling()
        else
            stopWalkFling()
        end
        updateGradient()
        if callback then
            pcall(callback, walkFlingEnabled)
        end
    end)

    player.CharacterAdded:Connect(function(newChar)
        character = newChar
        task.wait(0.5)
        root = character:FindFirstChild("HumanoidRootPart")
        humanoid = character:FindFirstChild("Humanoid")
        if walkFlingEnabled and root and humanoid then
            root.CanCollide = false
            humanoid:ChangeState(11)
        end
    end)

    local walkFlingObject = {}

    function walkFlingObject:SetState(state)
        walkFlingEnabled = state
        if walkFlingEnabled then
            startWalkFling()
        else
            stopWalkFling()
        end
        updateGradient()
        if callback then pcall(callback, walkFlingEnabled) end
    end

    function walkFlingObject:GetState()
        return walkFlingEnabled
    end

    function walkFlingObject:Toggle()
        walkFlingEnabled = not walkFlingEnabled
        if walkFlingEnabled then
            startWalkFling()
        else
            stopWalkFling()
        end
        updateGradient()
        if callback then pcall(callback, walkFlingEnabled) end
    end

    function walkFlingObject:SetText(newText)
        button.Text = newText
    end

    function walkFlingObject:SetColors(newColors)
        if newColors.on then buttonColor = newColors.on end
        if newColors.off then buttonColor = newColors.off end
        updateGradient()
    end

    function walkFlingObject:Destroy()
        if walkFlingConnection then walkFlingConnection:Disconnect() end
        if jumpConnection then jumpConnection:Disconnect() end
        button:Destroy()
    end

    walkFlingObject.button = button
    table.insert(walkFlingInstances, walkFlingObject)

    return walkFlingObject
end

function YUUGTRL:CreateWindow(title, size, position, options)
    options = options or {}

    local screenSize = workspace.CurrentCamera.ViewportSize
    local scale = 1
    if isMobile then
        scale = math.min(screenSize.X / 600, 0.9)
    end

    local windowSize = size
    if size then
        windowSize = UDim2.new(size.X.Scale, size.X.Offset * scale, size.Y.Scale, size.Y.Offset * scale)
    else
        windowSize = UDim2.new(0, 350 * scale, 0, 450 * scale)
    end

    local windowPos = position
    if not windowPos then
        windowPos = UDim2.new(0.5, -(175 * scale), 0.5, -(225 * scale))
    elseif position then
        windowPos = UDim2.new(position.X.Scale, position.X.Offset * scale, position.Y.Scale, position.Y.Offset * scale)
    end

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
        Size = windowSize,
        Position = windowPos,
        BackgroundColor3 = options.MainColor or currentTheme.MainColor,
        BorderSizePixel = 0,
        Parent = ScreenGui
    })

    Create({type = "UICorner",CornerRadius = UDim.new(0, 12 * scale),Parent = Main})

    local Header = Create({
        type = "Frame",
        Size = UDim2.new(1, 0, 0, 40 * scale),
        BackgroundColor3 = options.HeaderColor or currentTheme.HeaderColor,
        BorderSizePixel = 0,
        Parent = Main
    })

    Create({type = "UICorner",CornerRadius = UDim.new(0, 12 * scale),Parent = Header})

    local Title = self:CreateLabel(Header, title, UDim2.new(0, 15 * scale, 0, 0), UDim2.new(1, -100 * scale, 1, 0), options.TextColor or currentTheme.TextColor)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextSize = 18 * scale
    if options.titleKey then
        self:RegisterTranslatable(Title, options.titleKey)
    end

    local SettingsBtn
    local CloseBtn

    if options.ShowSettings ~= false then
        SettingsBtn = self:CreateButton(Header, "⚙", nil, options.AccentColor or currentTheme.AccentColor, UDim2.new(1, -70 * scale, 0, 5 * scale), UDim2.new(0, 30 * scale, 0, 30 * scale))
    end

    if options.ShowClose ~= false then
        CloseBtn = self:CreateButton(Header, "X", nil, options.CloseColor or Color3.fromRGB(255, 100, 100), UDim2.new(1, -35 * scale, 0, 5 * scale), UDim2.new(0, 30 * scale, 0, 30 * scale))
        CloseBtn.MouseButton1Click:Connect(function() 
            ScreenGui:Destroy() 
        end)
    end

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
        SettingsBtn = SettingsBtn,
        CloseBtn = CloseBtn,
        elements = {},
        scale = scale,
        options = options
    }

    function window:SetMainColor(color)
        self.Main.BackgroundColor3 = color
    end

    function window:SetHeaderColor(color)
        self.Header.BackgroundColor3 = color
    end

    function window:SetTextColor(color)
        self.Title.TextColor3 = color
        for _, element in pairs(self.elements) do
            if element.type == "label" and element.obj then
                element.obj.TextColor3 = color
            end
        end
    end

    function window:SetCornerRadius(radius)
        for _, v in pairs(self.Main:GetChildren()) do
            if v:IsA("UICorner") then
                v.CornerRadius = UDim.new(0, radius * self.scale)
            end
        end
        for _, v in pairs(self.Header:GetChildren()) do
            if v:IsA("UICorner") then
                v.CornerRadius = UDim.new(0, radius * self.scale)
            end
        end
    end

    function window:CreateFrame(size, position, color, radius)
        local frameSize = size and UDim2.new(size.X.Scale, size.X.Offset * self.scale, size.Y.Scale, size.Y.Offset * self.scale) or nil
        local framePos = position and UDim2.new(position.X.Scale, position.X.Offset * self.scale, position.Y.Scale, position.Y.Offset * self.scale) or nil
        return YUUGTRL:CreateFrame(self.Main, frameSize, framePos, color, radius and radius * self.scale)
    end

    function window:CreateScrollingFrame(size, position, color, radius)
        local frameSize = size and UDim2.new(size.X.Scale, size.X.Offset * self.scale, size.Y.Scale, size.Y.Offset * self.scale) or nil
        local framePos = position and UDim2.new(position.X.Scale, position.X.Offset * self.scale, position.Y.Scale, position.Y.Offset * self.scale) or nil
        return YUUGTRL:CreateScrollingFrame(self.Main, frameSize, framePos, color, radius and radius * self.scale)
    end

    function window:CreateLabel(text, position, size, color, translationKey)
        local labelPos = position and UDim2.new(position.X.Scale, position.X.Offset * self.scale, position.Y.Scale, position.Y.Offset * self.scale) or nil
        local labelSize = size and UDim2.new(size.X.Scale, size.X.Offset * self.scale, size.Y.Scale, size.Y.Offset * self.scale) or nil
        local label = YUUGTRL:CreateLabel(self.Main, text, labelPos, labelSize, color)
        label.TextSize = label.TextSize * self.scale
        if translationKey then
            YUUGTRL:RegisterTranslatable(label, translationKey)
        end
        table.insert(self.elements, {type = "label", obj = label})
        return label
    end

    function window:CreateButton(text, callback, color, position, size, translationKey)
        local btnPos = position and UDim2.new(position.X.Scale, position.X.Offset * self.scale, position.Y.Scale, position.Y.Offset * self.scale) or nil
        local btnSize = size and UDim2.new(size.X.Scale, size.X.Offset * self.scale, size.Y.Scale, size.Y.Offset * self.scale) or nil
        local btn = YUUGTRL:CreateButton(self.Main, text, callback, color, btnPos, btnSize)
        btn.TextSize = btn.TextSize * self.scale
        if translationKey then
            YUUGTRL:RegisterTranslatable(btn, translationKey)
        end
        table.insert(self.elements, {type = "button", obj = btn})
        return btn
    end

    function window:CreateSlider(text, min, max, default, callback, position, size)
        local sliderPos = position and UDim2.new(position.X.Scale, position.X.Offset * self.scale, position.Y.Scale, position.Y.Offset * self.scale) or nil
        local sliderSize = size and UDim2.new(size.X.Scale, size.X.Offset * self.scale, size.Y.Scale, size.Y.Offset * self.scale) or nil
        return YUUGTRL:CreateSlider(self.Main, text, min, max, default, callback, sliderPos, sliderSize)
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

    function window:Destroy()
        ScreenGui:Destroy()
    end

    function window:UpdateLanguage()
        YUUGTRL:UpdateAllTexts()
    end

    function window:CreateButtonToggle(text, default, callback, position, size, colors, translationKey)
        local btnPos = position
        if btnPos then
            btnPos = UDim2.new(position.X.Scale, position.X.Offset * self.scale, position.Y.Scale, position.Y.Offset * self.scale)
        end

        local btnSize = size
        if btnSize then
            btnSize = UDim2.new(size.X.Scale, size.X.Offset * self.scale, size.Y.Scale, size.Y.Offset * self.scale)
        end

        local toggle = YUUGTRL:CreateButtonToggle(self.Main, text, default, callback, btnPos, btnSize, colors)

        if translationKey and toggle and toggle.button then
            YUUGTRL:RegisterTranslatable(toggle.button, translationKey)
        end

        if toggle and toggle.button then
            table.insert(self.elements, {type = "button-toggle", obj = toggle})
        end

        return toggle
    end

    function window:CreateAntiSitButton(text, default, callback, position, size, colors, translationKey)
        local btnPos = position
        if btnPos then
            btnPos = UDim2.new(position.X.Scale, position.X.Offset * self.scale, position.Y.Scale, position.Y.Offset * self.scale)
        end

        local btnSize = size
        if btnSize then
            btnSize = UDim2.new(size.X.Scale, size.X.Offset * self.scale, size.Y.Scale, size.Y.Offset * self.scale)
        end

        local antiSit = YUUGTRL:CreateAntiSitButton(self.Main, text, default, callback, btnPos, btnSize, colors)

        if translationKey and antiSit and antiSit.button then
            YUUGTRL:RegisterTranslatable(antiSit.button, translationKey)
        end

        if antiSit and antiSit.button then
            table.insert(self.elements, {type = "anti-sit", obj = antiSit})
        end

        return antiSit
    end

    function window:CreateWalkFlingButton(text, default, callback, position, size, colors, translationKey)
        local btnPos = position
        if btnPos then
            btnPos = UDim2.new(position.X.Scale, position.X.Offset * self.scale, position.Y.Scale, position.Y.Offset * self.scale)
        end

        local btnSize = size
        if btnSize then
            btnSize = UDim2.new(size.X.Scale, size.X.Offset * self.scale, size.Y.Scale, size.Y.Offset * self.scale)
        end

        local walkFling = YUUGTRL:CreateWalkFlingButton(self.Main, text, default, callback, btnPos, btnSize, colors)

        if translationKey and walkFling and walkFling.button then
            YUUGTRL:RegisterTranslatable(walkFling.button, translationKey)
        end

        if walkFling and walkFling.button then
            table.insert(self.elements, {type = "walk-fling", obj = walkFling})
        end

        return walkFling
    end

    return window
end

function YUUGTRL:CreateFrame(parent, size, position, color, radius)
    if not parent then return end
    local frame = Create({
        type = "Frame",
        Size = size or UDim2.new(0, 100 * scale, 0, 100 * scale),
        Position = position or UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = color or currentTheme.FrameColor,
        BorderSizePixel = 0,
        Parent = parent
    })

    Create({type = "UICorner",CornerRadius = UDim.new(0, radius or 12 * scale),Parent = frame})

    return frame
end

function YUUGTRL:CreateScrollingFrame(parent, size, position, color, radius)
    if not parent then return end
    local frame = Instance.new("ScrollingFrame")
    frame.Size = size or UDim2.new(0, 200 * scale, 0, 200 * scale)
    frame.Position = position or UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = color or currentTheme.FrameColor
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.ScrollBarThickness = 4 * scale
    frame.ScrollBarImageColor3 = currentTheme.ScrollBarColor
    frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    frame.Parent = parent

    if radius then
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, radius or 12 * scale)
        corner.Parent = frame
    end

    return frame
end

function YUUGTRL:CreateLabel(parent, text, position, size, color)
    if not parent then return end
    return Create({
        type = "TextLabel",
        Size = size or UDim2.new(0, 100 * scale, 0, 30 * scale),
        Position = position or UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text or "Label",
        TextColor3 = color or currentTheme.TextColor,
        Font = Enum.Font.GothamBold,
        TextSize = 14 * scale,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = parent
    })
end

function YUUGTRL:CreateSlider(parent, text, min, max, default, callback, position, size)
    if not parent then return end
    local frame = self:CreateFrame(parent, size or UDim2.new(0, 200 * scale, 0, 50 * scale), position, currentTheme.FrameColor, 8 * scale)

    self:CreateLabel(frame, text or "", UDim2.new(0, 10 * scale, 0, 5 * scale), UDim2.new(1, -60 * scale, 0, 20 * scale))

    local valueLabel = self:CreateLabel(frame, tostring(default or 0), UDim2.new(1, -50 * scale, 0, 5 * scale), UDim2.new(0, 40 * scale, 0, 20 * scale))
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right

    local slider = self:CreateFrame(frame, UDim2.new(1, -20 * scale, 0, 8 * scale), UDim2.new(0, 10 * scale, 0, 30 * scale), Color3.fromRGB(60, 60, 70), 4 * scale)

    local fill = self:CreateFrame(slider, UDim2.new((default or 0) / max, 0, 1, 0), UDim2.new(0, 0, 0, 0), currentTheme.AccentColor, 4 * scale)

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
            if callback then pcall(callback, value) end
        end
    end)

    return slider
end

return YUUGTRL
