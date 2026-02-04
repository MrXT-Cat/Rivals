--[[ 
   MrXT Hub - Premium UI v2
   Cheats intact, toggles start OFF
--]]

-- SERVICES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

-- CONFIG
local Settings = {
	Aimbot = false,
	TeamCheck = false,
	WallCheck = false,
	FOV = 100,
	Part = "Head",
	FOVVisible = true,
	RGB = true,
	AimStrength = 0.5,
}

-- SOUND
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://2556932492"
clickSound.Parent = SoundService

-- GUI ROOT
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "MrXTHub"
ScreenGui.ResetOnSpawn = false

-- FLOAT BUTTON (QUADRADO)
local FloatBtn = Instance.new("ImageButton", ScreenGui)
FloatBtn.Size = UDim2.new(0,50,0,50)
FloatBtn.Position = UDim2.new(0,25,0.18,0)
FloatBtn.Image = "rbxthumb://type=Asset&id=96866982801235&w=150&h=150"
FloatBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
FloatBtn.Active = true
FloatBtn.Draggable = true
FloatBtn.AutoButtonColor = false

Instance.new("UICorner", FloatBtn).CornerRadius = UDim.new(0,6)

local FloatText = Instance.new("TextLabel", FloatBtn)
FloatText.Size = UDim2.new(1,0,0,14)
FloatText.Position = UDim2.new(0,0,1,0)
FloatText.BackgroundTransparency = 1
FloatText.Text = "MrXT"
FloatText.Font = Enum.Font.GothamBold
FloatText.TextSize = 11
FloatText.TextColor3 = Color3.new(1,1,1)

-- MAIN WINDOW (APARECE AUTOMATICAMENTE)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,560,0,340)
Main.Position = UDim2.new(0.5,-280,0.5,-170)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.Visible = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

-- TOP BAR
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1,0,0,56)
Top.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", Top).CornerRadius = UDim.new(0,16)

-- USER IMAGE (NO UI, NÃO RODA)
local TopIcon = Instance.new("ImageLabel", Top)
TopIcon.Size = UDim2.new(0,36,0,36)
TopIcon.Position = UDim2.new(0,14,0.5,-18)
TopIcon.Image = "rbxthumb://type=Asset&id=96866982801235&w=150&h=150"
TopIcon.BackgroundTransparency = 1
Instance.new("UICorner", TopIcon).CornerRadius = UDim.new(0,6)

-- TITLE
local Title = Instance.new("TextLabel", Top)
Title.Position = UDim2.new(0,60,0,0)
Title.Size = UDim2.new(0.4,0,1,0)
Title.BackgroundTransparency = 1
Title.Text = "MrXT Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.new(1,1,1)
Title.TextXAlignment = Enum.TextXAlignment.Left

-- TAB BUTTONS
local function tabButton(text,x)
	local b = Instance.new("TextButton", Top)
	b.Size = UDim2.new(0,120,0,36)
	b.Position = UDim2.new(1,x,0.5,-18)
	b.BackgroundColor3 = Color3.fromRGB(35,35,35)
	b.Text = text
	b.TextColor3 = Color3.fromRGB(245,245,245)
	b.Font = Enum.Font.GothamMedium
	b.TextSize = 14
	b.AutoButtonColor = false
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)
	return b
end

local AimbotTab = tabButton("Aimbot",-250)
local SettingsTab = tabButton("Settings",-120)

-- CONTENT
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0,20,0,70)
Content.Size = UDim2.new(1,-40,1,-90)
Content.BackgroundTransparency = 1

local AimbotFrame = Instance.new("Frame", Content)
AimbotFrame.Size = UDim2.new(1,0,1,0)
AimbotFrame.BackgroundTransparency = 1

local SettingsFrame = Instance.new("Frame", Content)
SettingsFrame.Size = UDim2.new(1,0,1,0)
SettingsFrame.BackgroundTransparency = 1
SettingsFrame.Visible = false

local function layout(frame)
	local l = Instance.new("UIGridLayout", frame)
	l.CellSize = UDim2.new(0,250,0,46)
	l.CellPadding = UDim2.new(0,14,0,14)
end

layout(AimbotFrame)
layout(SettingsFrame)

-- PREMIUM TOGGLE
local function createToggle(parent,text,default,callback)
	local b = Instance.new("TextButton", parent)
	b.BackgroundColor3 = Color3.fromRGB(32,32,32)
	b.TextColor3 = Color3.fromRGB(240,240,240)
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.AutoButtonColor = false
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)

	local stroke = Instance.new("UIStroke", b)
	stroke.Color = Color3.fromRGB(45,45,45)
	stroke.Thickness = 1

	local state = false -- todos OFF
	b.Text = text.." : OFF"

	b.MouseButton1Click:Connect(function()
		state = not state
		b.Text = text.." : "..(state and "ON" or "OFF")
		callback(state)
		clickSound:Play()
	end)
end

-- AIMBOT TAB
createToggle(AimbotFrame,"Aimbot",false,function(v) Settings.Aimbot=v end)
createToggle(AimbotFrame,"Show FOV",false,function(v) Settings.FOVVisible=v end)
createToggle(AimbotFrame,"RGB FOV",false,function(v) Settings.RGB=v end)

-- SETTINGS TAB
createToggle(SettingsFrame,"Team Check",false,function(v) Settings.TeamCheck=v end)
createToggle(SettingsFrame,"Wall Check",false,function(v) Settings.WallCheck=v end)

-- TAB SWITCH
AimbotTab.MouseButton1Click:Connect(function()
	AimbotFrame.Visible = true
	SettingsFrame.Visible = false
end)

SettingsTab.MouseButton1Click:Connect(function()
	AimbotFrame.Visible = false
	SettingsFrame.Visible = true
end)

-- FLOAT TOGGLE
FloatBtn.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
	clickSound:Play()
end)

-- ================= CHEAT LOGIC (UNCHANGED) =================
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.NumSides = 100
FOVCircle.Filled = false
local hue = 0

local function isVisible(part)
	local origin = Camera.CFrame.Position
	local direction = (part.Position - origin)
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {LocalPlayer.Character, part.Parent}
	params.FilterType = Enum.RaycastFilterType.Blacklist
	return not workspace:Raycast(origin, direction, params)
end

local function getClosest()
	local closest, dist = nil, Settings.FOV
	for _,p in pairs(Players:GetPlayers()) do
		if p~=LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health>0 then
			if Settings.TeamCheck and p.Team==LocalPlayer.Team then continue end
			local part = p.Character:FindFirstChild(Settings.Part)
			if not part then continue end
			local pos,onScreen = Camera:WorldToViewportPoint(part.Position)
			if not onScreen then continue end
			local mag = (Vector2.new(pos.X,pos.Y)-Camera.ViewportSize/2).Magnitude
			if mag<dist and (not Settings.WallCheck or isVisible(part)) then
				closest=part
				dist=mag
			end
		end
	end
	return closest
end

RunService.RenderStepped:Connect(function()
	FOVCircle.Visible = Settings.FOVVisible
	FOVCircle.Radius = Settings.FOV
	FOVCircle.Position = Camera.ViewportSize/2

	if Settings.RGB then
		hue=(hue+1)%360
		FOVCircle.Color = Color3.fromHSV(hue/360,1,1)
	end

	if Settings.Aimbot then
		local t=getClosest()
		if t then
			local cf=CFrame.new(Camera.CFrame.Position,t.Position)
			Camera.CFrame = Camera.CFrame:Lerp(cf,Settings.AimStrength)
		end
	end
end)

game:GetService("StarterGui"):SetCore("SendNotification", { 
    Title = "MrXT";
    Text = "BY MrXT";
    Icon = "rbxthumb://type=Asset&id=96866982801235&w=150&h=150";
    Duration = 5;
})

local p=game.Players.LocalPlayer local g=Instance.new("ScreenGui",p.PlayerGui) g.ResetOnSpawn=false local f=Instance.new("Frame",g) f.Size=UDim2.new(0,190,0,40) f.Position=UDim2.new(.5,-100,0,12) f.BackgroundColor3=Color3.fromRGB(5,5,5) f.BackgroundTransparency=.1 Instance.new("UICorner",f).CornerRadius=UDim.new(0,10) local i=Instance.new("ImageLabel",f) i.Size=UDim2.new(0,28,0,28) i.Position=UDim2.new(0,8,.5,-14) i.BackgroundTransparency=1 i.Image="rbxthumb://type=Asset&id=96866982801235&w=150&h=150" Instance.new("UICorner",i).CornerRadius=UDim.new(1,0) local t=Instance.new("TextLabel",f) t.Size=UDim2.new(1,-54,1,0) t.Position=UDim2.new(0,40,0,0) t.BackgroundTransparency=1 t.Text="By MrXT" t.TextColor3=Color3.new(1,1,1) t.Font=Enum.Font.GothamBold t.TextSize=16 t.TextYAlignment=Enum.TextYAlignment.Center
