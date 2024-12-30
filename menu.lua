local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")

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
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

Title.Parent = MainFrame
Title.Text = "Inuria.us"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(147, 112, 219)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22

Watermark.Parent = MainFrame
Watermark.Text = "inuria private"
Watermark.Size = UDim2.new(0, 100, 0, 15)
Watermark.Position = UDim2.new(1, -105, 1, -20)
Watermark.BackgroundTransparency = 1
Watermark.TextColor3 = Color3.fromRGB(150, 150, 150)
Watermark.Font = Enum.Font.Gotham
Watermark.TextSize = 11
Watermark.TextXAlignment = Enum.TextXAlignment.Right

-- Content Frame Setup
ContentFrame.Parent = MainFrame
ContentFrame.Size = UDim2.new(1, -20, 1, -80)
ContentFrame.Position = UDim2.new(0, 10, 0, 60)
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

-- Section Buttons
Sections.Parent = MainFrame
Sections.Size = UDim2.new(1, 0, 0, 30)
Sections.Position = UDim2.new(0, 0, 0, 30)
Sections.BackgroundTransparency = 1

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

local function HandleButtonHover(button, underline)
    local textWidth = TextService:GetTextSize(
        button.Text,
        button.TextSize,
        button.Font,
        Vector2.new(1000, 1000)
    ).X
    
    button.MouseEnter:Connect(function()
        TweenService:Create(underline, TweenInfo.new(0.3), {Size = UDim2.new(0, textWidth, 0, 2)}):Play()
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
    
    connection = game:GetService("RunService").RenderStepped:Connect(function()
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

-- Toggle Menu
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
    MiscContent = MiscContent
}
