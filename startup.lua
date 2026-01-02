local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local SoundService = game:GetService("SoundService")

local originalFOV = Camera.FieldOfView
local finished = false

-- ================= GUI =================

local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local bg = Instance.new("Frame")
bg.Size = UDim2.fromScale(1,1)
bg.BackgroundColor3 = Color3.fromRGB(5,5,15)
bg.Parent = gui

-- ================= AURA =================

local aura = Instance.new("Frame")
aura.Size = UDim2.fromScale(0.18,0.3)
aura.Position = UDim2.fromScale(0.5,0.45)
aura.AnchorPoint = Vector2.new(0.5,0.5)
aura.BackgroundColor3 = Color3.fromRGB(90,170,255)
aura.BackgroundTransparency = 0.15
aura.Parent = bg
Instance.new("UICorner",aura).CornerRadius = UDim.new(1,0)

local stroke = Instance.new("UIStroke",aura)
stroke.Thickness = 6
stroke.Color = Color3.fromRGB(140,220,255)

-- ================= TEXT =================

local text = Instance.new("TextLabel")
text.Size = UDim2.new(1,0,0,50)
text.Position = UDim2.fromScale(0.5,0.65)
text.AnchorPoint = Vector2.new(0.5,0.5)
text.BackgroundTransparency = 1
text.Text = "POWER LEVEL RISING"
text.Font = Enum.Font.GothamBlack
text.TextSize = 32
text.TextTransparency = 1
text.TextColor3 = stroke.Color
text.Parent = bg

-- ================= LOADING BAR =================

local barBG = Instance.new("Frame")
barBG.Size = UDim2.fromScale(0.4,0.02)
barBG.Position = UDim2.fromScale(0.5,0.75)
barBG.AnchorPoint = Vector2.new(0.5,0.5)
barBG.BackgroundColor3 = Color3.fromRGB(35,35,55)
barBG.Parent = bg
Instance.new("UICorner",barBG).CornerRadius = UDim.new(1,0)

local bar = Instance.new("Frame")
bar.Size = UDim2.fromScale(0,1)
bar.BackgroundColor3 = stroke.Color
bar.Parent = barBG
Instance.new("UICorner",bar).CornerRadius = UDim.new(1,0)

-- ================= SKIP BUTTON =================

local skip = Instance.new("TextButton")
skip.Size = UDim2.fromScale(0.1,0.045)
skip.Position = UDim2.fromScale(0.95,0.06)
skip.AnchorPoint = Vector2.new(1,0)
skip.Text = "SKIP"
skip.Font = Enum.Font.GothamBold
skip.TextSize = 14
skip.TextColor3 = Color3.new(1,1,1)
skip.BackgroundColor3 = Color3.fromRGB(120,80,200)
skip.Parent = bg
Instance.new("UICorner",skip).CornerRadius = UDim.new(0,10)

-- ================= SOUND =================

local hum = Instance.new("Sound")
hum.SoundId = "rbxassetid://1843529637"
hum.Looped = true
hum.Volume = 0.5
hum.Parent = SoundService
hum:Play()

-- ================= PARTICLES =================

local particles = Instance.new("ParticleEmitter")
particles.Rate = 100
particles.Speed = NumberRange.new(3,6)
particles.Lifetime = NumberRange.new(0.6,1)
particles.Size = NumberSequence.new{
    NumberSequenceKeypoint.new(0,0.6),
    NumberSequenceKeypoint.new(1,0)
}
particles.Color = ColorSequence.new(stroke.Color)
particles.Parent = aura

-- ================= ANIMATIONS =================

TweenService:Create(
    aura,
    TweenInfo.new(0.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true),
    {Size = UDim2.fromScale(0.25,0.4)}
):Play()

TweenService:Create(
    stroke,
    TweenInfo.new(0.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true),
    {Transparency = 0.7}
):Play()

TweenService:Create(text,TweenInfo.new(1),{TextTransparency = 0}):Play()
TweenService:Create(Camera,TweenInfo.new(1.5),{FieldOfView = 55}):Play()
TweenService:Create(bar,TweenInfo.new(3),{Size = UDim2.fromScale(1,1)}):Play()

-- ================= TRANSFORM =================

task.delay(2,function()
    aura.BackgroundColor3 = Color3.fromRGB(255,210,90)
    stroke.Color = Color3.fromRGB(255,230,140)
    particles.Color = ColorSequence.new(stroke.Color)
    bar.BackgroundColor3 = stroke.Color
    text.Text = "MAXIMUM POWER"
end)

-- ================= FINISH =================

local function finish()
    if finished then return end
    finished = true

    hum:Stop()
    TweenService:Create(Camera,TweenInfo.new(0.6),{FieldOfView = originalFOV}):Play()
    TweenService:Create(bg,TweenInfo.new(0.6),{BackgroundTransparency = 1}):Play()

    task.wait(0.6)
    gui:Destroy()
end

skip.MouseButton1Click:Connect(finish)
task.delay(4,finish)

