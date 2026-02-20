local YUUGTRL = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled

local theme = {
    primary = Color3.fromRGB(80, 100, 220),
    secondary = Color3.fromRGB(140, 80, 220),
    success = Color3.fromRGB(80, 180, 120),
    danger = Color3.fromRGB(200, 70, 70),
    background = Color3.fromRGB(25, 25, 35),
    header = Color3.fromRGB(35, 35, 45),
    text = Color3.fromRGB(255, 255, 255),
    textSecondary = Color3.fromRGB(200, 200, 220)
}

local languages = {
    English = {
        settings = "Settings",
        close = "Close",
        transparency = "Transparency",
        language = "Language"
    }
}

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

local function createGradient(parent, color1, color2)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1 or Color3.fromRGB(40, 40, 50)),
        ColorSequenceKeypoint.new(1, color2 or Color3.fromRGB(25, 25, 35))
    })
    gradient.Rotation = 45
    gradient.Parent = parent
    return gradient
end

local function animateButton(button, enabled, enabledColor, disabledColor)
    local targetColor = enabled and (enabledColor or theme.success) or (disabledColor or theme.primary)
    local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = targetColor})
    tween:Play()
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
    mainFrame.BackgroundColor3 = theme.background
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    createShadow(mainFrame)
    createCorner(mainFrame, 16)
    createGradient(mainFrame, Color3.fromRGB(40, 40, 50), theme.background)
    
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, isMobile and 35 or 45)
    header.BackgroundColor3 = theme.header
    header.BorderSizePixel = 0
    header.Parent = mainFrame
    
    local headerGradient = Instance.new("UIGradient")
    headerGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 80)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 55))
    })
    headerGradient.Parent = header
    
    createCorner(header, 16)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -60, 1, 0)
    titleLabel.Position = UDim2.new(0, 12, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = theme.text
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = isMobile and 14 or 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = header
    
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, isMobile and 26 or 32, 0, isMobile and 26 or 32)
    closeButton.Position = UDim2.new(1, isMobile and -30 or -37, 0, isMobile and 4 or 6)
    closeButton.BackgroundColor3 = theme.danger
    closeButton.Text = "×"
    closeButton.TextColor3 = theme.text
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = isMobile and 16 or 20
    closeButton.Parent = header
    
    createCorner(closeButton, 8)
    
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
    
    function windowObj:AddButton(text, callback)
        local button = Instance.new("TextButton")
        button.Name = text .. "Button"
        button.Size = UDim2.new(1, -10, 0, isMobile and 35 or 40)
        button.BackgroundColor3 = theme.primary
        button.Text = text
        button.TextColor3 = theme.text
        button.Font = Enum.Font.GothamBold
        button.TextSize = isMobile and 12 or 14
        button.Parent = self.Container
        
        createCorner(button, 10)
        createGradient(button, 
            Color3.fromRGB(theme.primary.R * 255 + 20, theme.primary.G * 255 + 20, theme.primary.B * 255 + 20),
            theme.primary
        )
        
        button.MouseButton1Click:Connect(function()
            animateButton(button, true, theme.success, theme.primary)
            if callback then callback() end
            task.wait(0.2)
            animateButton(button, false, theme.success, theme.primary)
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
        
        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = theme.textSecondary
        label.Font = Enum.Font.Gotham
        label.TextSize = isMobile and 12 or 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local toggleButton = Instance.new("TextButton")
        toggleButton.Name = "ToggleButton"
        toggleButton.Size = UDim2.new(0, isMobile and 50 or 60, 0, isMobile and 25 or 30)
        toggleButton.Position = UDim2.new(1, -(isMobile and 55 or 65), 0.5, -(isMobile and 12.5 or 15))
        toggleButton.BackgroundColor3 = default and theme.success or theme.danger
        toggleButton.Text = default and "ON" or "OFF"
        toggleButton.TextColor3 = theme.text
        toggleButton.Font = Enum.Font.GothamBold
        toggleButton.TextSize = isMobile and 10 or 12
        toggleButton.Parent = frame
        
        createCorner(toggleButton, 15)
        
        local toggled = default or false
        
        toggleButton.MouseButton1Click:Connect(function()
            toggled = not toggled
            toggleButton.Text = toggled and "ON" or "OFF"
            animateButton(toggleButton, toggled, theme.success, theme.danger)
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
        
        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Size = UDim2.new(1, 0, 0, isMobile and 20 or 25)
        label.BackgroundTransparency = 1
        label.Text = text .. ": " .. tostring(default or min)
        label.TextColor3 = theme.textSecondary
        label.Font = Enum.Font.Gotham
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
        fill.BackgroundColor3 = theme.primary
        fill.BorderSizePixel = 0
        fill.Parent = sliderBg
        
        createCorner(fill, 10)
        
        local button = Instance.new("TextButton")
        button.Name = "DragButton"
        button.Size = UDim2.new(0, isMobile and 16 or 20, 0, isMobile and 16 or 20)
        button.Position = UDim2.new((default or min) / max, -(isMobile and 8 or 10), 0.5, -(isMobile and 8 or 10))
        button.BackgroundColor3 = theme.text
        button.Text = ""
        button.BorderSizePixel = 0
        button.Parent = sliderBg
        
        createCorner(button, 10)
        
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
    
    function windowObj:AddDropdown(text, options, callback)
        local frame = Instance.new("Frame")
        frame.Name = text .. "Dropdown"
        frame.Size = UDim2.new(1, -10, 0, isMobile and 35 or 40)
        frame.BackgroundTransparency = 1
        frame.Parent = self.Container
        
        local button = Instance.new("TextButton")
        button.Name = "DropdownButton"
        button.Size = UDim2.new(1, 0, 1, 0)
        button.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        button.Text = text .. " ▼"
        button.TextColor3 = theme.textSecondary
        button.Font = Enum.Font.Gotham
        button.TextSize = isMobile and 11 or 13
        button.Parent = frame
        
        createCorner(button, 10)
        
        local dropdownFrame = Instance.new("Frame")
        dropdownFrame.Name = "DropdownFrame"
        dropdownFrame.Size = UDim2.new(1, 0, 0, #options * (isMobile and 30 or 35))
        dropdownFrame.Position = UDim2.new(0, 0, 1, 5)
        dropdownFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        dropdownFrame.BorderSizePixel = 0
        dropdownFrame.Visible = false
        dropdownFrame.Parent = frame
        
        createCorner(dropdownFrame, 8)
        createShadow(dropdownFrame)
        
        local dropdownList = Instance.new("ScrollingFrame")
        dropdownList.Size = UDim2.new(1, -10, 1, -10)
        dropdownList.Position = UDim2.new(0, 5, 0, 5)
        dropdownList.BackgroundTransparency = 1
        dropdownList.BorderSizePixel = 0
        dropdownList.ScrollBarThickness = 2
        dropdownList.Parent = dropdownFrame
        
        local dropdownLayout = Instance.new("UIListLayout")
        dropdownLayout.Padding = UDim.new(0, 2)
        dropdownLayout.Parent = dropdownList
        
        for _, option in ipairs(options) do
            local optionButton = Instance.new("TextButton")
            optionButton.Name = option .. "Option"
            optionButton.Size = UDim2.new(1, 0, 0, isMobile and 25 or 30)
            optionButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            optionButton.Text = option
            optionButton.TextColor3 = theme.textSecondary
            optionButton.Font = Enum.Font.Gotham
            optionButton.TextSize = isMobile and 10 or 12
            optionButton.Parent = dropdownList
            
            createCorner(optionButton, 6)
            
            optionButton.MouseButton1Click:Connect(function()
                button.Text = option .. " ▼"
                dropdownFrame.Visible = false
                if callback then callback(option) end
            end)
        end
        
        button.MouseButton1Click:Connect(function()
            dropdownFrame.Visible = not dropdownFrame.Visible
        end)
        
        table.insert(self.Elements, {frame, dropdownFrame})
        return dropdownFrame
    end
    
    function windowObj:AddLabel(text)
        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Size = UDim2.new(1, -10, 0, isMobile and 20 or 25)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = theme.textSecondary
        label.Font = Enum.Font.Gotham
        label.TextSize = isMobile and 11 or 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = self.Container
        
        table.insert(self.Elements, label)
        return label
    end
    
    function windowObj:AddTextBox(text, placeholder, callback)
        local frame = Instance.new("Frame")
        frame.Name = text .. "TextBox"
        frame.Size = UDim2.new(1, -10, 0, isMobile and 35 or 40)
        frame.BackgroundTransparency = 1
        frame.Parent = self.Container
        
        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Size = UDim2.new(0.3, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = theme.textSecondary
        label.Font = Enum.Font.Gotham
        label.TextSize = isMobile and 11 or 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local box = Instance.new("TextBox")
        box.Name = "TextBox"
        box.Size = UDim2.new(0.65, 0, 0, isMobile and 25 or 30)
        box.Position = UDim2.new(0.35, 0, 0.5, -(isMobile and 12.5 or 15))
        box.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        box.PlaceholderText = placeholder or ""
        box.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
        box.Text = ""
        box.TextColor3 = theme.text
        box.Font = Enum.Font.Gotham
        box.TextSize = isMobile and 10 or 12
        box.ClearTextOnFocus = false
        box.Parent = frame
        
        createCorner(box, 8)
        
        box.FocusLost:Connect(function(enterPressed)
            if enterPressed and callback then
                callback(box.Text)
            end
        end)
        
        table.insert(self.Elements, {frame, box})
        return box
    end
    
    function windowObj:AddTab(tabName)
        local tabFrame = Instance.new("Frame")
        tabFrame.Name = tabName .. "Tab"
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false
        tabFrame.Parent = self.Container
        
        local tabLayout = Instance.new("UIListLayout")
        tabLayout.Padding = UDim.new(0, isMobile and 4 or 6)
        tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        tabLayout.Parent = tabFrame
        
        local tabPadding = Instance.new("UIPadding")
        tabPadding.PaddingTop = UDim.new(0, 5)
        tabPadding.PaddingBottom = UDim.new(0, 5)
        tabPadding.Parent = tabFrame
        
        local tabObj = {
            Frame = tabFrame,
            Layout = tabLayout,
            Elements = {}
        }
        
        function tabObj:AddButton(text, callback)
            local btn = windowObj:AddButton(text, callback)
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
        
        function tabObj:AddDropdown(text, options, callback)
            local drop = windowObj:AddDropdown(text, options, callback)
            drop.Parent = tabFrame
            table.insert(self.Elements, drop)
            return drop
        end
        
        function tabObj:AddTextBox(text, placeholder, callback)
            local txt = windowObj:AddTextBox(text, placeholder, callback)
            txt.Parent = tabFrame
            table.insert(self.Elements, txt)
            return txt
        end
        
        table.insert(self.Elements, tabFrame)
        return tabObj
    end
    
    function windowObj:AddTabBar(tabs)
        local barFrame = Instance.new("Frame")
        barFrame.Name = "TabBar"
        barFrame.Size = UDim2.new(1, -10, 0, isMobile and 35 or 40)
        barFrame.BackgroundTransparency = 1
        barFrame.Parent = self.Container
        
        local barLayout = Instance.new("UIListLayout")
        barLayout.FillDirection = Enum.FillDirection.Horizontal
        barLayout.Padding = UDim.new(0, 5)
        barLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        barLayout.Parent = barFrame
        
        local tabObjects = {}
        local currentTab = nil
        
        for i, tabName in ipairs(tabs) do
            local tabButton = Instance.new("TextButton")
            tabButton.Name = tabName .. "TabButton"
            tabButton.Size = UDim2.new(0, (self.Container.AbsoluteSize.X - 30) / #tabs, 0, isMobile and 30 or 35)
            tabButton.BackgroundColor3 = theme.primary
            tabButton.Text = tabName
            tabButton.TextColor3 = theme.text
            tabButton.Font = Enum.Font.GothamBold
            tabButton.TextSize = isMobile and 10 or 12
            tabButton.Parent = barFrame
            
            createCorner(tabButton, 8)
            
            local tabContent = self:AddTab(tabName)
            tabContent.Frame.Position = UDim2.new(0, 0, 0, barFrame.Size.Y.Offset + 10)
            
            if i == 1 then
                tabContent.Frame.Visible = true
                tabButton.BackgroundColor3 = theme.secondary
                currentTab = tabContent
            end
            
            tabButton.MouseButton1Click:Connect(function()
                if currentTab then
                    currentTab.Frame.Visible = false
                end
                for _, btn in ipairs(barFrame:GetChildren()) do
                    if btn:IsA("TextButton") then
                        btn.BackgroundColor3 = theme.primary
                    end
                end
                tabButton.BackgroundColor3 = theme.secondary
                tabContent.Frame.Visible = true
                currentTab = tabContent
            end)
            
            table.insert(tabObjects, {Button = tabButton, Content = tabContent})
        end
        
        table.insert(self.Elements, barFrame)
        return tabObjects
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
    frame.BackgroundColor3 = theme.background
    frame.BorderSizePixel = 0
    frame.Parent = notifGui
    
    createShadow(frame)
    createCorner(frame, 16)
    createGradient(frame)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -20, 0, isMobile and 25 or 30)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = theme.text
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = isMobile and 14 or 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = frame
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Message"
    messageLabel.Size = UDim2.new(1, -20, 0, isMobile and 30 or 35)
    messageLabel.Position = UDim2.new(0, 10, 0, isMobile and 35 or 40)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.TextColor3 = theme.textSecondary
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextSize = isMobile and 11 or 13
    messageLabel.TextWrapped = true
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.Parent = frame
    
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

function YUUGTRL:SetTheme(newTheme)
    for key, value in pairs(newTheme) do
        theme[key] = value
    end
end

function YUUGTRL:IsMobile()
    return isMobile
end

return YUUGTRL
