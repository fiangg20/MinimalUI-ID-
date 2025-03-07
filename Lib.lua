local MinimalUI = {}
MinimalUI.__index = MinimalUI

-- Theme Configuration
local Theme = {
    Background = Color3.fromRGB(30, 30, 30),
    LightBackground = Color3.fromRGB(45, 45, 45),
    Text = Color3.fromRGB(245, 245, 245),
    Accent = Color3.fromRGB(0, 170, 255),
    CornerRadius = UDim.new(0, 8),
    StrokeColor = Color3.fromRGB(60, 60, 60)
}

-- Animation Presets
local Animations = {
    SlideInTop = function(gui)
        gui.Position = UDim2.new(0.5, 0, -0.5, 0)
        return {
            Position = UDim2.new(0.5, 0, 0.5, 0),
            EasingStyle = Enum.EasingStyle.Quad,
            EasingDirection = Enum.EasingDirection.Out
        }
    end,
    
    FadeOut = function(gui)
        return {
            BackgroundTransparency = 1,
            EasingStyle = Enum.EasingStyle.Quad
        }
    end
}

function MinimalUI.new()
    local self = setmetatable({}, MinimalUI)
    self.Components = {}
    return self
end

-- Base Component Creator
function MinimalUI:CreateElement(elementType, properties)
    local element = Instance.new(elementType)
    
    if element:IsA("GuiObject") then
        element.BackgroundColor3 = Theme.Background
        element.TextColor3 = Theme.Text
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = Theme.CornerRadius
        corner.Parent = element
        
        local stroke = Instance.new("UIStroke")
        stroke.Color = Theme.StrokeColor
        stroke.Thickness = 1
        stroke.Parent = element
    end
    
    for property, value in pairs(properties) do
        element[property] = value
    end
    
    return element
end

-- Window Component
function MinimalUI:Window(config)
    local window = {
        Title = config.Title or "Window",
        Size = config.Size or UDim2.new(0, 300, 0, 400)
    }
    
    local frame = self:CreateElement("Frame", {
        Size = window.Size,
        Position = UDim2.new(0.5, 0, -0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 0.1,
        Visible = false
    })
    
    local title = self:CreateElement("TextLabel", {
        Size = UDim2.new(1, 0, 0, 40),
        Text = window.Title,
        Font = Enum.Font.GothamMedium,
        TextSize = 20,
        BackgroundTransparency = 1
    })
    title.Parent = frame
    
    function window:Open()
        frame.Visible = true
        self:Animate("SlideInTop")
    end
    
    function window:Close()
        self:Animate("FadeOut", function()
            frame.Visible = false
        end)
    end
    
    function window:Animate(animationName, callback)
        local animation = Animations[animationName](frame)
        local tweenInfo = TweenInfo.new(
            animation.Duration or 0.5,
            animation.EasingStyle,
            animation.EasingDirection or Enum.EasingDirection.Out
        )
        
        local tween = game:GetService("TweenService"):Create(frame, tweenInfo, animation)
        tween:Play()
        
        if callback then
            tween.Completed:Connect(callback)
        end
    end
    
    function window:AddElement(element)
        element.Parent = frame
    end
    
    return window
end

-- Button Component
function MinimalUI:Button(config)
    local button = self:CreateElement("TextButton", {
        Size = UDim2.new(1, -20, 0, 40),
        Text = config.Text or "Button",
        Font = Enum.Font.Gotham,
        TextSize = 14,
        AutoButtonColor = false
    })
    
    local hoverTween
    button.MouseEnter:Connect(function()
        hoverTween = game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Theme.LightBackground,
            Size = UDim2.new(1, -15, 0, 42)
        })
        hoverTween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        if hoverTween then
            hoverTween:Cancel()
        end
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Theme.Background,
            Size = UDim2.new(1, -20, 0, 40)
        }):Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.1), {
            Position = button.Position + UDim2.new(0, 0, 0, 2)
        }):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.1), {
            Position = button.Position - UDim2.new(0, 0, 0, 2)
        }):Play()
    end)
    
    return button
end

-- Example usage:
local UI = MinimalUI.new()
local mainWindow = UI:Window({
    Title = "Main Menu",
    Size = UDim2.new(0, 300, 0, 500)
})

local testButton = UI:Button({Text = "Click Me!"})
testButton.MouseButton1Click:Connect(function()
    print("Button clicked!")
end)

mainWindow:AddElement(testButton)
mainWindow:Open()
