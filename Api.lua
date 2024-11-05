-- shitty gradient field of view frame lmfao @greg
Wowzers = {}

function Wowzers.new(type, properties)
    if type == "Circle" then
        local ScreenGui = Instance.new("ScreenGui")
        local Frame = Instance.new("Frame")
        local gradient = Instance.new("UIGradient")
        local UICorner = Instance.new("UICorner")
        local UIStroke = Instance.new("UIStroke")
        local ballsarelife = Color3.fromRGB(255, 255, 255)

        ScreenGui.Parent = game:GetService("CoreGui")
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        local visible = properties.Gradient ~= nil and properties.Gradient or true
        local transparency = properties.Transparency ~= nil and properties.Transparency or 1
        local radius = properties.Radius ~= nil and properties.Radius or 200
        local color1 = properties.GradientColors and properties.GradientColors[1] or Color3.fromRGB(255, 0, 0)
        local color2 = properties.GradientColors and properties.GradientColors[2] or Color3.fromRGB(0, 0, 255)
        local strokeThickness = properties.StrokeThickness ~= nil and properties.StrokeThickness or 1
        local positioning = properties.Positioning or "Center" 

        Frame.Parent = ScreenGui
        Frame.Visible = visible
        Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Frame.BackgroundTransparency = transparency
        Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Frame.BorderSizePixel = 0

        UICorner.CornerRadius = UDim.new(1, 0)
        UICorner.Parent = Frame

        UIStroke.Thickness = strokeThickness
        UIStroke.Color = ballsarelife
        UIStroke.Parent = Frame

        gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, color1),
            ColorSequenceKeypoint.new(1, color2)
        }
        gradient.Parent = Frame

        local function UpdateStrokeColor()
            local color1 = gradient.Color.Keypoints[1].Value
            UIStroke.Color = Color3.new(color1.R, color1.G, color1.B)
        end

        Frame.Transparency = (properties.Filled and "0.6") or "1"

        local function ChangeFOVSize(size)
            Frame.Size = UDim2.new(0, size, 0, size)
            Frame.Position = UDim2.new(0.5, -size / 2, 0.5, -size / 2)
        end

        ChangeFOVSize(radius)

        local player = game:GetService("Players").LocalPlayer
        local mouse = player:GetMouse()

        mouse.Move:Connect(function()
            if mouse and positioning == "Mouse" then
                Frame.Position = UDim2.new(0, mouse.X - Frame.Size.X.Offset / 2, 0, mouse.Y - Frame.Size.Y.Offset / 2)
            else
                Frame.Position = UDim2.new(0.5, -Frame.Size.X.Offset / 2, 0.5, -Frame.Size.Y.Offset / 2)
            end
        end)

        local rotateSpeed = 4

        spawn(function()
            while true do
                gradient.Rotation = gradient.Rotation + rotateSpeed
                UpdateStrokeColor()
                wait(0.01)
            end
        end)
    else
        warn("Wowzers.new only supports 'Circle' at the moment.")
    end
end
