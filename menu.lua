local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")

local Menu = {}
Menu.Library = {}

-- Create Main UI
Menu.GUI = Instance.new("ScreenGui")
Menu.GUI.Name = "InuriaMenu"
Menu.GUI.Parent = game:GetService("CoreGui")

Menu.MainFrame = Instance.new("Frame")
Menu.MainFrame.Name = "MainFrame"
Menu.MainFrame.Size = UDim2.new(0, 600, 0, 400)
Menu.MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
Menu.MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Menu.MainFrame.BorderSizePixel = 0
Menu.MainFrame.Parent = Menu.GUI

-- Add UI Corner
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = Menu.MainFrame

-- Create Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Text = "Inuria.us"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(147, 112, 219)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.Parent = Menu.MainFrame

-- Create Tab Buttons
Menu.TabButtons = Instance.new("Frame")
Menu.TabButtons.Name = "TabButtons"
Menu.TabButtons.Size = UDim2.new(1, 0, 0, 30)
Menu.TabButtons.Position = UDim2.new(0, 0, 0, 30)
Menu.TabButtons.BackgroundTransparency = 1
Menu.TabButtons.Parent = Menu.MainFrame

-- Create Content Frame
Menu.ContentFrame = Instance.new("Frame")
Menu.ContentFrame.Name = "ContentFrame"
Menu.ContentFrame.Size = UDim2.new(1, -20, 1, -80)
Menu.ContentFrame.Position = UDim2.new(0, 10, 0, 70)
Menu.ContentFrame.BackgroundTransparency = 1
Menu.ContentFrame.Parent = Menu.MainFrame

-- Create Tab Content Frames
Menu.VisualTab = Instance.new("ScrollingFrame")
Menu.VisualTab.Name = "VisualTab"
Menu.VisualTab.Size = UDim2.new(1, 0, 1, 0)
Menu.VisualTab.BackgroundTransparency = 1
Menu.VisualTab.ScrollBarThickness = 4
Menu.VisualTab.Parent = Menu.ContentFrame

Menu.AimbotTab = Instance.new("ScrollingFrame")
Menu.AimbotTab.Name = "AimbotTab"
Menu.AimbotTab.Size = UDim2.new(1, 0, 1, 0)
Menu.AimbotTab.BackgroundTransparency = 1
Menu.AimbotTab.ScrollBarThickness = 4
Menu.AimbotTab.Visible = false
Menu.AimbotTab.Parent = Menu.ContentFrame

Menu.MiscTab = Instance.new("ScrollingFrame")
Menu.MiscTab.Name = "MiscTab"
Menu.MiscTab.Size = UDim2.new(1, 0, 1, 0)
Menu.MiscTab.BackgroundTransparency = 1
Menu.MiscTab.ScrollBarThickness = 4
Menu.MiscTab.Visible = false
Menu.MiscTab.Parent = Menu.ContentFrame

-- Create Tab Buttons
local function CreateTabButton(name, position)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(0.33, 0, 1, 0)
    button.Position = position
    button.BackgroundTransparency = 1
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.Parent = Menu.TabButtons
    
    local underline = Instance.new("Frame")
    underline.Size = UDim2.new(0, 0, 0, 2)
    underline.Position = UDim2.new(0.5, 0, 1, 0)
    underline.AnchorPoint = Vector2.new(0.5, 0)
    underline.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
    underline.BorderSizePixel = 0
    underline.Parent = button
    
    return button, underline
end

local VisualButton, VisualLine = CreateTabButton("Visual", UDim2.new(0, 0, 0, 0))
local AimbotButton, AimbotLine = CreateTabButton("Aimbot", UDim2.new(0.33, 0, 0, 0))
local MiscButton, MiscLine = CreateTabButton("Misc", UDim2.new(0.66, 0, 0, 0))

-- Tab System
local function SwitchTab(button, content)
    Menu.VisualTab.Visible = false
    Menu.AimbotTab.Visible = false
    Menu.MiscTab.Visible = false
    content.Visible = true
    
    -- Animate underlines
    local textWidth = TextService:GetTextSize(
        button.Text,
        button.TextSize,
        button.Font,
        Vector2.new(1000, 1000)
    ).X
    
    TweenService:Create(VisualLine, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 2)}):Play()
    TweenService:Create(AimbotLine, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 2)}):Play()
    TweenService:Create(MiscLine, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 2)}):Play()
    TweenService:Create(button:FindFirstChild("Frame"), TweenInfo.new(0.3), {Size = UDim2.new(0, textWidth, 0, 2)}):Play()
end

VisualButton.MouseButton1Click:Connect(function()
    SwitchTab(VisualButton, Menu.VisualTab)
end)

AimbotButton.MouseButton1Click:Connect(function()
    SwitchTab(AimbotButton, Menu.AimbotTab)
end)

MiscButton.MouseButton1Click:Connect(function()
    SwitchTab(MiscButton, Menu.MiscTab)
end)

-- UI Library Functions
function Menu.Library:CreateSection(parent, name)
    local section = Instance.new("Frame")
    section.Name = name .. "Section"
    section.Size = UDim2.new(1, 0, 0, 30)
    section.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    section.BorderSizePixel = 0
    
    local title = Instance.new("TextLabel")
    title.Text = name
    title.Size = UDim2.new(1, 0, 1, 0)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.Parent = section
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = section
    
    section.Parent = parent
    return section
end

function Menu.Library:CreateToggle(parent, name, default, callback)
    local toggle = Instance.new("TextButton")
    toggle.Name = name .. "Toggle"
    toggle.Size = UDim2.new(1, 0, 0, 30)
    toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    toggle.BorderSizePixel = 0
    toggle.Text = ""
    
    local title = Instance.new("TextLabel")
    title.Text = name
    title.Size = UDim2.new(1, -50, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.Gotham
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = toggle
    
    local status = Instance.new("Frame")
    status.Size = UDim2.new(0, 20, 0, 20)
    status.Position = UDim2.new(1, -30, 0.5, -10)
    status.BackgroundColor3 = default and Color3.fromRGB(147, 112, 219) or Color3.fromRGB(60, 60, 60)
    status.Parent = toggle
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = status
    
    local enabled = default
    toggle.MouseButton1Click:Connect(function()
        enabled = not enabled
        status.BackgroundColor3 = enabled and Color3.fromRGB(147, 112, 219) or Color3.fromRGB(60, 60, 60)
        callback(enabled)
    end)
    
    toggle.Parent = parent
    return toggle
end

function Menu.Library:CreateSlider(parent, name, min, max, default, callback)
    local slider = Instance.new("Frame")
    slider.Name = name .. "Slider"
    slider.Size = UDim2.new(1, 0, 0, 50)
    slider.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    slider.BorderSizePixel = 0
    
    local title = Instance.new("TextLabel")
    title.Text = name
    title.Size = UDim2.new(1, -10, 0, 20)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.Gotham
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = slider
    
    local value = Instance.new("TextLabel")
    value.Text = tostring(default)
    value.Size = UDim2.new(0, 30, 0, 20)
    value.Position = UDim2.new(1, -40, 0, 0)
    value.BackgroundTransparency = 1
    value.TextColor3 = Color3.fromRGB(255, 255, 255)
    value.Font = Enum.Font.Gotham
    value.TextSize = 14
    value.Parent = slider
    
    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(1, -20, 0, 4)
    sliderBar.Position = UDim2.new(0, 10, 0, 35)
    sliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    sliderBar.BorderSizePixel = 0
    sliderBar.Parent = slider
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 2)
    UICorner.Parent = sliderBar
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBar
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 2)
    UICorner.Parent = sliderFill
    
    local drag = Instance.new("TextButton")
    drag.Size = UDim2.new(0, 10, 0, 20)
    drag.Position = UDim2.new((default - min)/(max - min), -5, 0, -8)
    drag.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
    drag.Text = ""
    drag.Parent = sliderBar
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = drag
    
    local dragging = false
    drag.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mouseX = input.Position.X
            local sliderPosition = math.clamp((mouseX - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
            local newValue = math.floor(min + (sliderPosition * (max - min)))
            
            value.Text = tostring(newValue)
            sliderFill.Size = UDim2.new(sliderPosition, 0, 1, 0)
            drag.Position = UDim2.new(sliderPosition, -5, 0, -8)
            
            callback(newValue)
        end
    end)
    
    slider.Parent = parent
    return slider
end

function Menu.Library:CreateColorPicker(parent, name, default, callback)
    local picker = Instance.new("TextButton")
    picker.Name = name .. "ColorPicker"
    picker.Size = UDim2.new(1, 0, 0, 30)
    picker.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    picker.BorderSizePixel = 0
    picker.Text = ""
    
    local title = Instance.new("TextLabel")
    title.Text = name
    title.Size = UDim2.new(1, -50, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.Gotham
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = picker
    
    local preview = Instance.new("Frame")
    preview.Size = UDim2.new(0, 30, 0, 20)
    preview.Position = UDim2.new(1, -40, 0.5, -10)
    preview.BackgroundColor3 = default
    preview.Parent = picker
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = preview
    
    local colorPickerFrame = Instance.new("Frame")
    colorPickerFrame.Size = UDim2.new(0, 200, 0, 200)
    colorPickerFrame.Position = UDim2.new(1, 10, 0, 0)
    colorPickerFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    colorPickerFrame.BorderSizePixel = 0
    colorPickerFrame.Visible = false
    colorPickerFrame.Parent = picker
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = colorPickerFrame
    
    local colorSpace = Instance.new("ImageButton")
    colorSpace.Size = UDim2.new(1, -20, 1, -40)
    colorSpace.Position = UDim2.new(0, 10, 0, 10)
    colorSpace.Image = "rbxassetid://4155801252"
    colorSpace.Parent = colorPickerFrame
    
    local hueSlider = Instance.new("ImageButton")
    hueSlider.Size = UDim2.new(1, -20, 0, 20)
    hueSlider.Position = UDim2.new(0, 10, 1, -30)
    hueSlider.Image = "rbxassetid://3641079629"
    hueSlider.Parent = colorPickerFrame
    
    local pickerDot = Instance.new("Frame")
    pickerDot.Size = UDim2.new(0, 10, 0, 10)
    pickerDot.AnchorPoint = Vector2.new(0.5, 0.5)
    pickerDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    pickerDot.Parent = colorSpace
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = pickerDot
    
    local hueSliderDot = Instance.new("Frame")
    hueSliderDot.Size = UDim2.new(0, 10, 1, 0)
    hueSliderDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hueSliderDot.Parent = hueSlider
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = hueSliderDot
    
    local function updateColor()
        local hue = 1 - math.clamp((hueSliderDot.Position.X.Scale), 0, 1)
        local saturation = math.clamp((pickerDot.Position.X.Scale), 0, 1)
        local value = 1 - math.clamp((pickerDot.Position.Y.Scale), 0, 1)
        
        local color = Color3.fromHSV(hue, saturation, value)
        preview.BackgroundColor3 = color
        callback(color)
    end
    
    local draggingPicker = false
    local draggingHue = false
    
    colorSpace.MouseButton1Down:Connect(function()
        draggingPicker = true
    end)
    
    hueSlider.MouseButton1Down:Connect(function()
        draggingHue = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingPicker = false
            draggingHue = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if draggingPicker then
                local mousePos = input.Position
                local relativePos = Vector2.new(
                    mousePos.X - colorSpace.AbsolutePosition.X,
                    mousePos.Y - colorSpace.AbsolutePosition.Y
                )
                
                local pickerPosX = math.clamp(relativePos.X / colorSpace.AbsoluteSize.X, 0, 1)
                local pickerPosY = math.clamp(relativePos.Y / colorSpace.AbsoluteSize.Y, 0, 1)
                
                pickerDot.Position = UDim2.new(pickerPosX, 0, pickerPosY, 0)
                updateColor()
            elseif draggingHue then
                local mousePos = input.Position
                local relativePos = mousePos.X - hueSlider.AbsolutePosition.X
                
                local huePosX = math.clamp(relativePos / hueSlider.AbsoluteSize.X, 0, 1)
                hueSliderDot.Position = UDim2.new(huePosX, -5, 0, 0)
                updateColor()
            end
        end
    end)
    
    picker.MouseButton1Click:Connect(function()
        colorPickerFrame.Visible = not colorPickerFrame.Visible
    end)
    
    picker.Parent = parent
    return picker
end

-- Initialize Menu
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        Menu.GUI.Enabled = not Menu.GUI.Enabled
    end
end)

return Menu
