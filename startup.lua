local T=game:GetService("TweenService")
local C=workspace.CurrentCamera
local S=game:GetService("SoundService")
local f=C.FieldOfView

local g=Instance.new("ScreenGui",game.CoreGui)
g.IgnoreGuiInset=true g.ResetOnSpawn=false

local b=Instance.new("Frame",g)
b.Size=UDim2.fromScale(1,1)
b.BackgroundColor3=Color3.fromRGB(5,5,15)

local a=Instance.new("Frame",b)
a.Size=UDim2.fromScale(.18,.3)
a.Position=UDim2.fromScale(.5,.5)
a.AnchorPoint=Vector2.new(.5,.5)
a.BackgroundColor3=Color3.fromRGB(90,170,255)
a.BackgroundTransparency=.15
Instance.new("UICorner",a).CornerRadius=UDim.new(1,0)

local s=Instance.new("UIStroke",a)
s.Thickness=7 s.Color=Color3.fromRGB(140,220,255)

local t=Instance.new("TextLabel",b)
t.Size=UDim2.new(1,0,0,60)
t.Position=UDim2.fromScale(.5,.68)
t.AnchorPoint=Vector2.new(.5,.5)
t.BackgroundTransparency=1
t.Text="POWER LEVEL RISING"
t.Font=Enum.Font.GothamBlack
t.TextSize=34
t.TextColor3=s.Color
t.TextTransparency=1

local l=Instance.new("Frame",b)
l.Size=UDim2.fromScale(.4,.02)
l.Position=UDim2.fromScale(.5,.78)
l.AnchorPoint=Vector2.new(.5,.5)
l.BackgroundColor3=Color3.fromRGB(30,30,50)
Instance.new("UICorner",l).CornerRadius=UDim.new(1,0)

local lf=Instance.new("Frame",l)
lf.Size=UDim2.fromScale(0,1)
lf.BackgroundColor3=s.Color
Instance.new("UICorner",lf).CornerRadius=UDim.new(1,0)

local sk=Instance.new("TextButton",b)
sk.Size=UDim2.fromScale(.08,.04)
sk.Position=UDim2.fromScale(.92,.05)
sk.AnchorPoint=Vector2.new(1,0)
sk.Text="SKIP"
sk.Font=Enum.Font.GothamBold
sk.TextSize=14
sk.TextColor3=Color3.new(1,1,1)
sk.BackgroundColor3=Color3.fromRGB(120,80,200)
Instance.new("UICorner",sk)

local snd=Instance.new("Sound",S)
snd.SoundId="rbxassetid://1843529637"
snd.Looped=true snd.Volume=.6 snd:Play()

local p=Instance.new("ParticleEmitter",a)
p.Rate=120
p.Speed=NumberRange.new(3,6)
p.Lifetime=NumberRange.new(.6,1)
p.Size=NumberSequence.new{{0,.6},{1,0}}
p.Color=ColorSequence.new(s.Color)

T:Create(a,TweenInfo.new(.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true),
{Size=UDim2.fromScale(.25,.4)}):Play()

T:Create(s,TweenInfo.new(.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true),
{Transparency=.7}):Play()

T:Create(t,TweenInfo.new(1),{TextTransparency=0}):Play()
T:Create(C,TweenInfo.new(2),{FieldOfView=55}):Play()
T:Create(lf,TweenInfo.new(3),{Size=UDim2.fromScale(1,1)}):Play()

task.delay(2,function()
 a.BackgroundColor3=Color3.fromRGB(255,210,90)
 s.Color=Color3.fromRGB(255,230,140)
 p.Color=ColorSequence.new(s.Color)
 lf.BackgroundColor3=s.Color
 t.Text="MAXIMUM POWER"
end)

local done=false
local function endit()
 if done then return end
 done=true
 snd:Stop()
 T:Create(C,TweenInfo.new(.8),{FieldOfView=f}):Play()
 T:Create(b,TweenInfo.new(.8),{BackgroundTransparency=1}):Play()
 task.wait(.8)
 g:Destroy()
end

sk.MouseButton1Click:Connect(endit)
task.delay(4,endit)
