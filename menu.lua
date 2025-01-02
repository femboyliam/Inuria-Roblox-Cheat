local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local Library = {
    Theme = {
        Background = Color3.fromRGB(43, 43, 43),
        Border = Color3.fromRGB(58, 58, 58),
        Text = Color3.fromRGB(224, 224, 224),
        TabBackground = Color3.fromRGB(34, 34, 34),
        TabActive = Color3.fromRGB(74, 74, 74),
        SliderBackground = Color3.fromRGB(58, 58, 58),
        SliderFill = Color3.fromRGB(216, 216, 216),
        ToggleEnabled = Color3.fromRGB(216, 216, 216)
    }
}

function Library:Create(title)
    local MenuGui = Instance.new("ScreenGui")
    MenuGui.Name = "ExternalMenu"
    MenuGui.Parent = CoreGui
    
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Size = UDim2.new(0, 450, 0, 400)
    Main.Position = UDim2.new(0.5, -225, 0.5, -200)
    Main.BackgroundColor3 = Library.Theme.Background
    Main.BorderSizePixel = 1
    Main.BorderColor3 = Library.Theme.Border
    Main.Parent = MenuGui
    
    -- Make window draggable
    local dragging
    local dragInput
    local dragStart
    local startPos

    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end
    end)

    Main.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    RunService.RenderStepped:Connect(function()
        if dragging then
            local delta = dragInput.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Create header
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 30)
    Header.BackgroundColor3 = Library.Theme.TabBackground
    Header.BorderSizePixel = 0
    Header.Parent = Main

    local HeaderText = Instance.new("TextLabel")
    HeaderText.Name = "Title"
    HeaderText.Text = title
    HeaderText.Size = UDim2.new(1, 0, 1, 0)
    HeaderText.BackgroundTransparency = 1
    HeaderText.Font = Enum.Font.Gotham
    HeaderText.TextColor3 = Library.Theme.Text
    HeaderText.TextSize = 14
    HeaderText.Parent = Header

    -- Create tab container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(1, 0, 0, 30)
    TabContainer.Position = UDim2.new(0, 0, 0, 30)
    TabContainer.BackgroundColor3 = Library.Theme.TabBackground
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = Main

    local TabList = Instance.new("UIListLayout")
    TabList.FillDirection = Enum.FillDirection.Horizontal
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Parent = TabContainer

    -- Create content container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, 0, 1, -60)
    ContentContainer.Position = UDim2.new(0, 0, 0, 60)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = Main

    local Window = {}
    Window.Tabs = {}
    Window.ActiveTab = nil

    function Window:AddTab(name)
        local Tab = Instance.new("TextButton")
        Tab.Name = name
        Tab.Size = UDim2.new(0.25, 0, 1, 0)
        Tab.BackgroundColor3 = Library.Theme.TabBackground
        Tab.BorderSizePixel = 0
        Tab.Font = Enum.Font.Gotham
        Tab.Text = name
        Tab.TextColor3 = Library.Theme.Text
        Tab.TextSize = 14
        Tab.Parent = TabContainer

        local Content = Instance.new("ScrollingFrame")
        Content.Name = name.."Content"
        Content.Size = UDim2.new(1, -20, 1, -10)
        Content.Position = UDim2.new(0, 10, 0, 5)
        Content.BackgroundTransparency = 1
        Content.BorderSizePixel = 0
        Content.ScrollBarThickness = 2
        Content.Visible = false
        Content.Parent = ContentContainer

        local ContentList = Instance.new("UIListLayout")
        ContentList.SortOrder = Enum.SortOrder.LayoutOrder
        ContentList.Padding = UDim.new(0, 5)
        ContentList.Parent = Content

        local TabObj = {
            Button = Tab,
            Container = Content
        }

        Tab.MouseButton1Click:Connect(function()
            if Window.ActiveTab then
                Window.ActiveTab.Button.BackgroundColor3 = Library.Theme.TabBackground
                Window.ActiveTab.Container.Visible = false
            end
            Window.ActiveTab = TabObj
            Tab.BackgroundColor3 = Library.Theme.TabActive
            Content.Visible = true
        end)

        if not Window.ActiveTab then
            Window.ActiveTab = TabObj
            Tab.BackgroundColor3 = Library.Theme.TabActive
            Content.Visible = true
        end

        return TabObj
    end

    return Window
end

return Library
