local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Loading UI
local LoadingUI = Instance.new("ScreenGui")
local LoadingCircle = Instance.new("ImageLabel")
local LoadingText = Instance.new("TextLabel")

-- Menu UI
local MenuUI = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local Watermark = Instance.new("TextLabel")
local Sections = Instance.new("Frame")
local ContentFrame = Instance.new("Frame")
local VisualContent = Instance.new("Frame")
local AimbotContent = Instance.new("Frame")
local MiscContent = Instance.new("Frame")

-- Set up Loading UI
LoadingUI.Parent = game:GetService("CoreGui")
LoadingCircle.Parent = LoadingUI
LoadingCircle.Size = UDim2.new(0, 100, 0, 100)
LoadingCircle.Position = UDim2.new(0.5, -50, 0.5, -50)
LoadingCircle.BackgroundTransparency = 1
LoadingCircle.Image = "rbxassetid://3570695787"
LoadingCircle.ImageColor3 = Color3.fromRGB(255, 255, 255)

LoadingText.Parent = LoadingUI
LoadingText.Size = UDim2.new(1, 0, 0, 30)
LoadingText.Position = UDim2.new(0, 0, 0.6, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Loading..."
LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.Font = Enum.Font.GothamBold
LoadingText.TextSize = 18

-- Set up Menu UI
MenuUI.Parent = game:GetService("CoreGui")
MainFrame.Parent = MenuUI
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

Title.Parent = MainFrame
Title.Text = "Inuria.us"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 10)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(147, 112, 219)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Center

Watermark.Parent = MainFrame
Watermark.Text = "inuria private"
Watermark.Size = UDim2.new(0, 100, 0, 15)
Watermark.Position = UDim2.new(1, -115, 1, -25)
Watermark.BackgroundTransparency = 1
Watermark.TextColor3 = Color3.fromRGB(150, 150, 150)
Watermark.Font = Enum.Font.Gotham
Watermark.TextSize = 14

-- Sections Setup
Sections.Parent = MainFrame
Sections.Size = UDim2.new(1, 0, 0, 35)
Sections.Position = UDim2.new(0, 0, 0, 40)  -- Moved up from 50
Sections.BackgroundTransparency = 1

-- Content Frame Setup
ContentFrame.Parent = MainFrame
ContentFrame.Size = UDim2.new(1, -30, 1, -100)
ContentFrame.Position = UDim2.new(0, 15, 0, 85)  -- Adjusted to match new button position
ContentFrame.BackgroundTransparency = 1

-- Content Pages
VisualContent.Parent = ContentFrame
VisualContent.Size = UDim2.new(1, 0, 1, 0)
VisualContent.BackgroundTransparency = 1
VisualContent.Visible = true

AimbotContent.Parent = ContentFrame
AimbotContent.Size = UDim2.new(1, 0, 1, 0)
AimbotContent.BackgroundTransparency = 1
AimbotContent.Visible = false

MiscContent.Parent = ContentFrame
MiscContent.Size = UDim2.new(1, 0, 1, 0)
MiscContent.BackgroundTransparency = 1
MiscContent.Visible = false

-- Library Functions
local Library = {}

function Library:CreateToggle(parent, name, default, callback)
    local ToggleFrame = Instance.new("Frame")
    local ToggleButton = Instance.new("TextButton")
    local ToggleTitle = Instance.new("TextLabel")
    local ToggleIndicator = Instance.new("Frame")
    
    ToggleFrame.Name = "Toggle"
    ToggleFrame.Parent = parent
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = ToggleFrame
    
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = ToggleFrame
    ToggleButton.BackgroundTransparency = 1
    ToggleButton.Size = UDim2.new(1, 0, 1, 0)
    ToggleButton.Font = Enum.Font.SourceSans
    ToggleButton.Text = ""
    ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    ToggleButton.TextSize = 14
    
    ToggleTitle.Name = "Title"
    ToggleTitle.Parent = ToggleFrame
    ToggleTitle.BackgroundTransparency = 1
    ToggleTitle.Position = UDim2.new(0, 15, 0, 0)
    ToggleTitle.Size = UDim2.new(1, -65, 1, 0)
    ToggleTitle.Font = Enum.Font.Gotham
    ToggleTitle.Text = name
    ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleTitle.TextSize = 14
    ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    ToggleIndicator.Name = "Indicator"
    ToggleIndicator.Parent = ToggleFrame
    ToggleIndicator.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ToggleIndicator.Position = UDim2.new(1, -45, 0.5, -10)
    ToggleIndicator.Size = UDim2.new(0, 35, 0, 20)
    
    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(1, 0)
    IndicatorCorner.Parent = ToggleIndicator
    
    local enabled = default or false
    
    local function UpdateToggle()
        enabled = not enabled
        TweenService:Create(ToggleIndicator, TweenInfo.new(0.2), {
            BackgroundColor3 = enabled and Color3.fromRGB(147, 112, 219) or Color3.fromRGB(50, 50, 50)
        }):Play()
        if callback then callback(enabled) end
    end
    
    ToggleButton.MouseButton1Click:Connect(UpdateToggle)
    if enabled then UpdateToggle() end
    
    return ToggleFrame
end

function Library:CreateSlider(parent, name, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    local SliderTitle = Instance.new("TextLabel")
    local SliderValue = Instance.new("TextLabel")
    local SliderBackground = Instance.new("Frame")
    local SliderFill = Instance.new("Frame")
    local SliderButton = Instance.new("TextButton")
    
    SliderFrame.Name = "Slider"
    SliderFrame.Parent = parent
    SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    SliderFrame.Size = UDim2.new(1, 0, 0, 50)
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = SliderFrame
    
    SliderTitle.Name = "Title"
    SliderTitle.Parent = SliderFrame
    SliderTitle.BackgroundTransparency = 1
    SliderTitle.Position = UDim2.new(0, 15, 0, 0)
    SliderTitle.Size = UDim2.new(1, -15, 0, 25)
    SliderTitle.Font = Enum.Font.Gotham
    SliderTitle.Text = name
    SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderTitle.TextSize = 14
    SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    SliderValue.Name = "Value"
    SliderValue.Parent = SliderFrame
    SliderValue.BackgroundTransparency = 1
    SliderValue.Position = UDim2.new(1, -55, 0, 0)
    SliderValue.Size = UDim2.new(0, 40, 0, 25)
    SliderValue.Font = Enum.Font.Gotham
    SliderValue.Text = tostring(default or min)
    SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderValue.TextSize = 14
    
    SliderBackground.Name = "Background"
    SliderBackground.Parent = SliderFrame
    SliderBackground.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    SliderBackground.Position = UDim2.new(0, 15, 0, 35)
    SliderBackground.Size = UDim2.new(1, -30, 0, 5)
    
    local BackgroundCorner = Instance.new("UICorner")
    BackgroundCorner.CornerRadius = UDim.new(1, 0)
    BackgroundCorner.Parent = SliderBackground
    
    SliderFill.Name = "Fill"
    SliderFill.Parent = SliderBackground
    SliderFill.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
    SliderFill.Size = UDim2.new(0, 0, 1, 0)
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = SliderFill
    
    SliderButton.Name = "SliderButton"
    SliderButton.Parent = SliderBackground
    SliderButton.BackgroundTransparency = 1
    SliderButton.Size = UDim2.new(1, 0, 1, 0)
    SliderButton.Text = ""
    
    local function UpdateSlider(input)
        local pos = UDim2.new(math.clamp((input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1), 0, 1, 0)
        SliderFill.Size = pos
        local value = math.floor(min + ((max - min) * pos.X.Scale))
        SliderValue.Text = tostring(value)
        if callback then callback(value) end
    end
    
    SliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local connection
            connection = RunService.RenderStepped:Connect(function()
                UpdateSlider(input)
            end)
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    return SliderFrame
end

-- Section Buttons
local function CreateSection(name, position)
    local button = Instance.new("TextButton")
    local underline = Instance.new("Frame")
    
    button.Size = UDim2.new(0.33, 0, 1, 0)
    button.Position = position
    button.BackgroundTransparency = 1
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = Sections
    
    underline.Size = UDim2.new(0, 0, 0, 2)
    underline.AnchorPoint = Vector2.new(0.5, 0)
    underline.Position = UDim2.new(0.5, 0, 1, 0)
    underline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    underline.BorderSizePixel = 0
    underline.Parent = button
    
    return button, underline
end

local VisualButton, VisualLine = CreateSection("Visual", UDim2.new(0, 0, 0, 0))
local AimbotButton, AimbotLine = CreateSection("Aimbot", UDim2.new(0.33, 0, 0, 0))
local MiscButton, MiscLine = CreateSection("Misc", UDim2.new(0.66, 0, 0, 0))

-- Tab System
local function SwitchTab(button, content)
    VisualContent.Visible = false
    AimbotContent.Visible = false
    MiscContent.Visible = false
    content.Visible = true
end

VisualButton.MouseButton1Click:Connect(function()
    SwitchTab(VisualButton, VisualContent)
end)

AimbotButton.MouseButton1Click:Connect(function()
    SwitchTab(AimbotButton, AimbotContent)
end)

MiscButton.MouseButton1Click:Connect(function()
    SwitchTab(MiscButton, MiscContent)
end)

-- Button Hover Effects
local function HandleButtonHover(button, underline)
    button.MouseEnter:Connect(function()
        TweenService:Create(underline, TweenInfo.new(0.3), {Size = UDim2.new(0.8, 0, 0, 2)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(underline, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 2)}):Play()
    end)
end

HandleButtonHover(VisualButton, VisualLine)
HandleButtonHover(AimbotButton, AimbotLine)
HandleButtonHover(MiscButton, MiscLine)

-- Loading Animation
local function PlayLoadingAnimation()
    local rotation = 0
    local connection
    
    connection = RunService.RenderStepped:Connect(function()
        rotation = rotation + 5
        LoadingCircle.Rotation = rotation
    end)
    
    task.wait(2)
    LoadingText.Text = "Initializing..."
    task.wait(0.5)
    LoadingText.Text = "Loading Features..."
    task.wait(0.5)
    LoadingText.Text = "Ready!"
    task.wait(0.3)
    
    connection:Disconnect()
    LoadingUI:Destroy()
    MainFrame.Visible = true
end

-- Make UI Draggable
local dragging
local dragInput
local dragStart
local startPos

local function UpdateDrag(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        UpdateDrag(input)
    end
end)

-- Toggle UI
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Initialize
PlayLoadingAnimation()

-- Return content frames for external access
return {
    VisualContent = VisualContent,
    AimbotContent = AimbotContent,
    MiscContent = MiscContent,
    Library = Library
}
