repeat wait() until game:IsLoaded()

local resp
local dec 

local http_request = http_request or request or (http and http.request) or (syn and syn.request)

if KRNL_LOADED then getgenv().syn = nil end 
local exploit_type
if PROTOSMASHER_LOADED then
	exploit_type = "ProtoSmasher"
elseif is_sirhurt_closure then
	exploit_type = "Sirhurt"
elseif SENTINEL_LOADED then
	exploit_type = "Sentinel"
elseif syn then
	exploit_type = "Synapse X"
elseif KRNL_LOADED then
    exploit_type = "KRNL"
elseif hookfunction_raw and hmjdfk then
    exploit_type = "Fluxus Mac Free"
    print("fluxus")
    if not getconnections then
        getgenv().getconnections = function()
            return {}
        end
        getgenv().set_thread_context = function() return end
        getgenv().fluxus_loaded = true
    end
elseif FLUXUS_LOADED then
    exploit_type = "Fluxus"
elseif getexecutorname then 
	exploit_type = "Script-Ware"
else
    game.Players.LocalPlayer:Kick("Your executor is not supported! Please go to https://alphax.soldr.xyz/supported/ for the list of supported executors.")
    error("Executor not Supported!")
end
if true then
    -- sorry no whitelist source for you
    print("[Alpha X]: Authenticated!")
end
--// Init 

--code for alpha's stupid ratelimit
local response = http_request({Url="https://alpha1004.tech/scripts/assets/Init.lua", Method="GET"})
while response.StatusCode ~= 200 do
    warn("[Alpha X / INFO]: We are being ratelimited! Re-trying in 1 second")
    wait(1)
    response = http_request({Url="https://alpha1004.tech/scripts/assets/Init.lua", Method="GET"})
end 
loadstring(response.Body)()

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

do
	local ui = game:GetService("CoreGui"):FindFirstChild("FluxLib")
	if ui then
		ui:Destroy()
	end
end

local Flux = {RainbowColorValue = 0, HueSelectionPosition = 0}
local PresetColor = Color3.fromRGB(66, 134, 255)
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CloseBind = Enum.KeyCode.RightControl

Flags = {}

local FluxLib = Instance.new("ScreenGui")
FluxLib.Name = "FluxLib"
FluxLib.Parent = game.CoreGui
FluxLib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

coroutine.wrap(
	function()
		while wait() do
			Flux.RainbowColorValue = Flux.RainbowColorValue + 1 / 255
			Flux.HueSelectionPosition = Flux.HueSelectionPosition + 1

			if Flux.RainbowColorValue >= 1 then
				Flux.RainbowColorValue = 0
			end

			if Flux.HueSelectionPosition == 80 then
				Flux.HueSelectionPosition = 0
			end
		end
	end
)()

local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		object.Position = pos
	end

	topbarobject.InputBegan:Connect(
		function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(
					function()
						if input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end
				)
			end
		end
	)

	topbarobject.InputChanged:Connect(
		function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
					input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end
	)

	UserInputService.InputChanged:Connect(
		function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end
	)
end

function Flux:Destroy()
FluxLib:Destroy()
end

function Flux:Window(text, bottom,mainclr,toclose)
	CloseBind = toclose or Enum.KeyCode.RightControl
	PresetColor = mainclr or Color3.fromRGB(66, 134, 255)
	local fs = false
	local MainFrame = Instance.new("Frame")
	local MainCorner = Instance.new("UICorner")
	local LeftFrame = Instance.new("Frame")
	local LeftCorner = Instance.new("UICorner")
	local GlowTabHolder = Instance.new("ImageLabel")
	local Title = Instance.new("TextLabel")
	local BottomText = Instance.new("TextLabel")
	local TabHold = Instance.new("Frame")
	local TabLayout = Instance.new("UIListLayout")
	local Drag = Instance.new("Frame")
	local ContainerFolder = Instance.new("Folder")

	MainFrame.Name = "MainFrame"
	MainFrame.Parent = FluxLib
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Color3.fromRGB(50, 53, 59)
	MainFrame.ClipsDescendants = true
	MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	MainFrame.Size = UDim2.new(0, 0, 0, 0)

	MainCorner.CornerRadius = UDim.new(0, 5)
	MainCorner.Name = "MainCorner"
	MainCorner.Parent = MainFrame

	LeftFrame.Name = "LeftFrame"
	LeftFrame.Parent = MainFrame
	LeftFrame.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
	LeftFrame.Size = UDim2.new(0, 205, 0, 484)

	LeftCorner.CornerRadius = UDim.new(0, 5)
	LeftCorner.Name = "LeftCorner"
	LeftCorner.Parent = LeftFrame

	GlowTabHolder.Name = "GlowTabHolder"
	GlowTabHolder.Parent = LeftFrame
	GlowTabHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	GlowTabHolder.BackgroundTransparency = 1.000
	GlowTabHolder.BorderSizePixel = 0
	GlowTabHolder.Position = UDim2.new(0, -15, 0, -15)
	GlowTabHolder.Size = UDim2.new(1, 30, 1, 30)
	GlowTabHolder.ZIndex = 0
	GlowTabHolder.Image = "rbxassetid://4996891970"
	GlowTabHolder.ImageColor3 = Color3.fromRGB(15, 15, 15)
	GlowTabHolder.ScaleType = Enum.ScaleType.Slice
	GlowTabHolder.SliceCenter = Rect.new(20, 20, 280, 280)

	Title.Name = "Title"
	Title.Parent = LeftFrame
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0.097560972, 0, 0.0475206636, 0)
	Title.Size = UDim2.new(0, 111, 0, 34)
	Title.Font = Enum.Font.GothamBold
	Title.Text = text
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 25.000
	Title.TextXAlignment = Enum.TextXAlignment.Left

	BottomText.Name = "BottomText"
	BottomText.Parent = LeftFrame
	BottomText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BottomText.BackgroundTransparency = 1.000
	BottomText.Position = UDim2.new(0.097560972, 0, 0.0889999792, 0)
	BottomText.Size = UDim2.new(0, 113, 0, 28)
	BottomText.Font = Enum.Font.Gotham
	BottomText.Text = bottom
	BottomText.TextColor3 = Color3.fromRGB(255, 255, 255)
	BottomText.TextSize = 14.000
	BottomText.TextTransparency = 0.300
	BottomText.TextXAlignment = Enum.TextXAlignment.Left

	TabHold.Name = "TabHold"
	TabHold.Parent = LeftFrame
	TabHold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabHold.BackgroundTransparency = 1.000
	TabHold.Position = UDim2.new(0, 0, 0.167355374, 0)
	TabHold.Size = UDim2.new(0, 205, 0, 403)

	TabLayout.Name = "TabLayout"
	TabLayout.Parent = TabHold
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.Padding = UDim.new(0, 3)

	Drag.Name = "Drag"
	Drag.Parent = MainFrame
	Drag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Drag.BackgroundTransparency = 1.000
	Drag.Position = UDim2.new(0.290368259, 0, 0, 0)
	Drag.Size = UDim2.new(0, 501, 0, 23)

	ContainerFolder.Name = "ContainerFolder"
	ContainerFolder.Parent = MainFrame
	
	MakeDraggable(Drag,MainFrame)
	MakeDraggable(LeftFrame,MainFrame)
	MainFrame:TweenSize(UDim2.new(0, 706, 0, 484), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
	
	local uitoggled = false
	UserInputService.InputBegan:Connect(
		function(io, p)
			if io.KeyCode == CloseBind then
				if uitoggled == false then
					MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					uitoggled = true
					wait(.5)
					FluxLib.Enabled = false
				else
					MainFrame:TweenSize(UDim2.new(0, 706, 0, 484), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					FluxLib.Enabled = true
					uitoggled = false
				end
			end
		end
	)
	
	function Flux:Notification(desc,buttontitle)
		for i, v in next, MainFrame:GetChildren() do
			if v.Name == "NotificationBase" then
				v:Destroy()
			end
		end
		local NotificationBase = Instance.new("TextButton")
		local NotificationBaseCorner = Instance.new("UICorner")
		local NotificationFrame = Instance.new("Frame")
		local NotificationFrameCorner = Instance.new("UICorner")
		local NotificationFrameGlow = Instance.new("ImageLabel")
		local NotificationTitle = Instance.new("TextLabel")
		local CloseBtn = Instance.new("TextButton")
		local CloseBtnCorner = Instance.new("UICorner")
		local NotificationDesc = Instance.new("TextLabel")

		NotificationBase.Name = "NotificationBase"
		NotificationBase.Parent = MainFrame
		NotificationBase.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		NotificationBase.BackgroundTransparency = 1
		NotificationBase.Size = UDim2.new(0, 706, 0, 484)
		NotificationBase.AutoButtonColor = false
		NotificationBase.Font = Enum.Font.SourceSans
		NotificationBase.Text = ""
		NotificationBase.TextColor3 = Color3.fromRGB(0, 0, 0)
		NotificationBase.TextSize = 14.000
		NotificationBase.Visible = true

		NotificationBaseCorner.CornerRadius = UDim.new(0, 5)
		NotificationBaseCorner.Name = "NotificationBaseCorner"
		NotificationBaseCorner.Parent = NotificationBase

		NotificationFrame.Name = "NotificationFrame"
		NotificationFrame.Parent = NotificationBase
		NotificationFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		NotificationFrame.BackgroundColor3 = Color3.fromRGB(50, 53, 59)
		NotificationFrame.ClipsDescendants = true
		NotificationFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		NotificationFrame.Size = UDim2.new(0, 0, 0, 0)

		NotificationFrameCorner.CornerRadius = UDim.new(0, 5)
		NotificationFrameCorner.Name = "NotificationFrameCorner"
		NotificationFrameCorner.Parent = NotificationFrame

		NotificationFrameGlow.Name = "NotificationFrameGlow"
		NotificationFrameGlow.Parent = NotificationFrame
		NotificationFrameGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotificationFrameGlow.BackgroundTransparency = 1.000
		NotificationFrameGlow.BorderSizePixel = 0
		NotificationFrameGlow.Position = UDim2.new(0, -15, 0, -15)
		NotificationFrameGlow.Size = UDim2.new(1, 30, 1, 30)
		NotificationFrameGlow.ZIndex = 0
		NotificationFrameGlow.Image = "rbxassetid://4996891970"
		NotificationFrameGlow.ImageColor3 = Color3.fromRGB(15, 15, 15)
		NotificationFrameGlow.ScaleType = Enum.ScaleType.Slice
		NotificationFrameGlow.SliceCenter = Rect.new(20, 20, 280, 280)

		NotificationTitle.Name = "NotificationTitle"
		NotificationTitle.Parent = NotificationFrame
		NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotificationTitle.BackgroundTransparency = 1.000
		NotificationTitle.Position = UDim2.new(0.0400609747, 0, 0.0761325806, 0)
		NotificationTitle.Size = UDim2.new(0, 111, 0, 34)
		NotificationTitle.Font = Enum.Font.GothamBold
		NotificationTitle.Text = Title.Text .. " | NOTIFICATION"
		NotificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
		NotificationTitle.TextSize = 24.000
		NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
		NotificationTitle.TextTransparency = 1

		CloseBtn.Name = "CloseBtn"
		CloseBtn.Parent = NotificationFrame
		CloseBtn.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
		CloseBtn.ClipsDescendants = true
		CloseBtn.Position = UDim2.new(0.0403124988, 0, 0.720855951, 0)
		CloseBtn.Size = UDim2.new(0, 366, 0, 43)
		CloseBtn.AutoButtonColor = false
		CloseBtn.Font = Enum.Font.Gotham
		CloseBtn.Text = buttontitle
		CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		CloseBtn.TextSize = 15.000
		CloseBtn.TextTransparency = 1
		CloseBtn.BackgroundTransparency = 1

		CloseBtnCorner.CornerRadius = UDim.new(0, 4)
		CloseBtnCorner.Name = "CloseBtnCorner"
		CloseBtnCorner.Parent = CloseBtn

		NotificationDesc.Name = "NotificationDesc"
		NotificationDesc.Parent = NotificationFrame
		NotificationDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotificationDesc.BackgroundTransparency = 1.000
		NotificationDesc.Position = UDim2.new(0.112499997, 0, 0.266355127, 0)
		NotificationDesc.Size = UDim2.new(0, 309, 0, 82)
		NotificationDesc.Font = Enum.Font.Gotham
		NotificationDesc.Text = desc
		NotificationDesc.TextColor3 = Color3.fromRGB(255, 255, 255)
		NotificationDesc.TextSize = 15.000
		NotificationDesc.TextWrapped = true
		NotificationDesc.TextTransparency = 1
		
		CloseBtn.MouseEnter:Connect(function()
			TweenService:Create(
				CloseBtn,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{TextTransparency = 0}
			):Play()
		end)

		CloseBtn.MouseLeave:Connect(function()
			TweenService:Create(
				CloseBtn,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{TextTransparency = 0.3}
			):Play()
		end)
		
		CloseBtn.MouseButton1Click:Connect(function()
			
			TweenService:Create(
				NotificationDesc,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{TextTransparency = 1}
			):Play()
			TweenService:Create(
				CloseBtn,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{TextTransparency = 1}
			):Play()
			TweenService:Create(
				NotificationTitle,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{TextTransparency = 1}
			):Play()
			TweenService:Create(
				CloseBtn,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			
			wait(.4)
			CloseBtn.Visible = false
			NotificationFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)

			wait(.2)
			
			TweenService:Create(
				NotificationBase,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			
			wait(.2)
			
			NotificationBase.Visible = false
		end)

		
		TweenService:Create(
			NotificationBase,
			TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{BackgroundTransparency = 0.550}
		):Play()
		
		wait(.1)
		
		NotificationFrame:TweenSize(UDim2.new(0, 400, 0, 214), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
		
		wait(.4)
		TweenService:Create(
			NotificationDesc,
			TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{TextTransparency = .3}
		):Play()
		TweenService:Create(
			CloseBtn,
			TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{TextTransparency = .3}
		):Play()
		TweenService:Create(
			NotificationTitle,
			TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{TextTransparency = 0}
		):Play()
		TweenService:Create(
			CloseBtn,
			TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{BackgroundTransparency = 0}
		):Play()
	end
	local Tabs = {}
	function Tabs:Tab(text,ico)
		local Tab = Instance.new("TextButton")
		local TabIcon = Instance.new("ImageLabel")
		local TabTitle = Instance.new("TextLabel")

		Tab.Name = "Tab"
		Tab.Parent = TabHold
		Tab.BackgroundColor3 = PresetColor
		Tab.BorderSizePixel = 0
		Tab.Size = UDim2.new(0, 205, 0, 40)
		Tab.AutoButtonColor = false
		Tab.Font = Enum.Font.SourceSans
		Tab.Text = ""
		Tab.TextColor3 = Color3.fromRGB(0, 0, 0)
		Tab.TextSize = 14.000
		Tab.BackgroundTransparency = 1

		TabIcon.Name = "TabIcon"
		TabIcon.Parent = Tab
		TabIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabIcon.BackgroundTransparency = 1.000
		TabIcon.Position = UDim2.new(0.0634146333, 0, 0.25, 0)
		TabIcon.Size = UDim2.new(0, 20, 0, 20)
		TabIcon.Image = ico
		TabIcon.ImageTransparency = .3

		TabTitle.Name = "TabTitle"
		TabTitle.Parent = Tab
		TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabTitle.BackgroundTransparency = 1.000
		TabTitle.Position = UDim2.new(0.1902439, 0, 0.25, 0)
		TabTitle.Size = UDim2.new(0, 113, 0, 19)
		TabTitle.Font = Enum.Font.Gotham
		TabTitle.Text = text
		TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabTitle.TextSize = 15.000
		TabTitle.TextXAlignment = Enum.TextXAlignment.Left
		TabTitle.TextTransparency = .3
		
		local Container = Instance.new("ScrollingFrame")
		local ContainerLayout = Instance.new("UIListLayout")


		Container.Name = "Container"
		Container.Parent = ContainerFolder
		Container.Active = true
		Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Container.BackgroundTransparency = 1.000
		Container.BorderSizePixel = 0
		Container.Position = UDim2.new(0.321529746, 0, 0.0475206599, 0)
		Container.Size = UDim2.new(0, 470, 0, 438)
		Container.CanvasSize = UDim2.new(0, 0, 0, 0)
		Container.ScrollBarThickness = 5
		Container.Visible = false
		Container.ScrollBarImageColor3 = Color3.fromRGB(71, 76, 84)

		ContainerLayout.Name = "ContainerLayout"
		ContainerLayout.Parent = Container
		ContainerLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ContainerLayout.Padding = UDim.new(0, 15)
		
		if fs == false then
			fs = true
			TabTitle.TextTransparency = 0
			TabIcon.ImageTransparency = 0
			Tab.BackgroundTransparency = 0
			Container.Visible = true
		end
		
		Tab.MouseButton1Click:Connect(function()
			for i, v in next, ContainerFolder:GetChildren() do
				if v.Name == "Container" then
					v.Visible = false
				end
				Container.Visible = true
			end
			for i, v in next, TabHold:GetChildren() do
				if v.Name == "Tab" then
					TweenService:Create(
						v,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						v.TabIcon,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						v.TabTitle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = .3}
					):Play()
					TweenService:Create(
						Tab,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						TabIcon,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = 0}
					):Play()
					TweenService:Create(
						TabTitle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
				end
			end
		end)
		local ContainerContent = {}
		function ContainerContent:Button(text, desc, callback)
			if desc == "" then
				desc = "There is no description for this button."
			end
			local BtnDescToggled = false
			local Button = Instance.new("TextButton")
			local ButtonCorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local Circle = Instance.new("Frame")
			local CircleCorner = Instance.new("UICorner")
			local CircleSmall = Instance.new("Frame")
			local CircleSmallCorner = Instance.new("UICorner")
			local Description = Instance.new("TextLabel")
			local ArrowBtn = Instance.new("ImageButton")
			local ArrowIco = Instance.new("ImageLabel")

			Button.Name = "Button"
			Button.Parent = Container
			Button.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			Button.ClipsDescendants = true
			Button.Position = UDim2.new(0.370312512, 0, 0.552631557, 0)
			Button.Size = UDim2.new(0, 457, 0, 43)
			Button.AutoButtonColor = false
			Button.Font = Enum.Font.SourceSans
			Button.Text = ""
			Button.TextColor3 = Color3.fromRGB(0, 0, 0)
			Button.TextSize = 14.000

			ButtonCorner.CornerRadius = UDim.new(0, 4)
			ButtonCorner.Name = "ButtonCorner"
			ButtonCorner.Parent = Button

			Title.Name = "Title"
			Title.Parent = Button
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0822437406, 0, 0, 0)
			Title.Size = UDim2.new(0, 113, 0, 42)
			Title.Font = Enum.Font.Gotham
			Title.Text = text
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 15.000
			Title.TextTransparency = 0.300
			Title.TextXAlignment = Enum.TextXAlignment.Left

			Circle.Name = "Circle"
			Circle.Parent = Title
			Circle.Active = true
			Circle.AnchorPoint = Vector2.new(0.5, 0.5)
			Circle.BackgroundColor3 = Color3.fromRGB(211, 211, 211)
			Circle.Position = UDim2.new(-0.150690272, 0, 0.503000021, 0)
			Circle.Size = UDim2.new(0, 11, 0, 11)

			CircleCorner.CornerRadius = UDim.new(2, 6)
			CircleCorner.Name = "CircleCorner"
			CircleCorner.Parent = Circle

			CircleSmall.Name = "CircleSmall"
			CircleSmall.Parent = Circle
			CircleSmall.Active = true
			CircleSmall.AnchorPoint = Vector2.new(0.5, 0.5)
			CircleSmall.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			CircleSmall.BackgroundTransparency = 1.000
			CircleSmall.Position = UDim2.new(0.485673368, 0, 0.503000021, 0)
			CircleSmall.Size = UDim2.new(0, 9, 0, 9)

			CircleSmallCorner.CornerRadius = UDim.new(2, 6)
			CircleSmallCorner.Name = "CircleSmallCorner"
			CircleSmallCorner.Parent = CircleSmall

			Description.Name = "Description"
			Description.Parent = Title
			Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Description.BackgroundTransparency = 1.000
			Description.Position = UDim2.new(-0.200942323, 0, 0.785714269, 0)
			Description.Size = UDim2.new(0, 432, 0, 31)
			Description.Font = Enum.Font.Gotham
			Description.Text = desc
			Description.TextColor3 = Color3.fromRGB(255, 255, 255)
			Description.TextSize = 15.000
			Description.TextTransparency = 1
			Description.TextWrapped = true
			Description.TextXAlignment = Enum.TextXAlignment.Left

			ArrowBtn.Name = "ArrowBtn"
			ArrowBtn.Parent = Button
			ArrowBtn.BackgroundColor3 = Color3.fromRGB(86, 86, 86)
			ArrowBtn.BackgroundTransparency = 1.000
			ArrowBtn.Position = UDim2.new(0.903719902, 0, 0, 0)
			ArrowBtn.Size = UDim2.new(0, 33, 0, 37)
			ArrowBtn.SliceCenter = Rect.new(30, 30, 30, 30)
			ArrowBtn.SliceScale = 7.000

			ArrowIco.Name = "ArrowIco"
			ArrowIco.Parent = ArrowBtn
			ArrowIco.AnchorPoint = Vector2.new(0.5, 0.5)
			ArrowIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ArrowIco.BackgroundTransparency = 1.000
			ArrowIco.Position = UDim2.new(0.495753437, 0, 0.554054081, 0)
			ArrowIco.Selectable = true
			ArrowIco.Size = UDim2.new(0, 28, 0, 24)
			ArrowIco.Image = "http://www.roblox.com/asset/?id=6034818372"
			ArrowIco.ImageTransparency = .3
			
			Button.MouseEnter:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play()
			end)
			
			Button.MouseLeave:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0.3}
				):Play()
			end)
			
			Button.MouseButton1Click:Connect(function()
				pcall(callback)
			end)
			
			ArrowBtn.MouseButton1Click:Connect(function()
				if BtnDescToggled == false then
					Button:TweenSize(UDim2.new(0, 457, 0, 74), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = 0}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 180}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = PresetColor}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					TweenService:Create(
						Description,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				else
					Button:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(211, 211, 211)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					TweenService:Create(
						Description,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 1}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
				BtnDescToggled = not BtnDescToggled
			end)
            Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
            
            local Button = {}

            function Button:updateButton(txt)
                Title.Text = txt
            end 

            return Button
		end
		function ContainerContent:Toggle(text, desc, default, flagname, callback)
			local ToggleDescToggled = false
			local Toggled = false
			if desc == "" then
				desc = "There is no description for this toggle."
			end
			local Toggle = Instance.new("TextButton")
			local ToggleCorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local Circle = Instance.new("Frame")
			local CircleCorner = Instance.new("UICorner")
			local CircleSmall = Instance.new("Frame")
			local CircleSmallCorner = Instance.new("UICorner")
			local ToggleFrame = Instance.new("Frame")
			local ToggleFrameCorner = Instance.new("UICorner")
			local ToggleCircle = Instance.new("Frame")
			local ToggleCircleCorner = Instance.new("UICorner")
			local Description = Instance.new("TextLabel")
			local ArrowBtn = Instance.new("ImageButton")
			local ArrowIco = Instance.new("ImageLabel")

			Toggle.Name = "Toggle"
			Toggle.Parent = Container
			Toggle.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			Toggle.ClipsDescendants = true
			Toggle.Position = UDim2.new(0.110937506, 0, 0.67653507, 0)
			Toggle.Size = UDim2.new(0, 457, 0, 43)
			Toggle.AutoButtonColor = false
			Toggle.Font = Enum.Font.SourceSans
			Toggle.Text = ""
			Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.TextSize = 14.000

			ToggleCorner.CornerRadius = UDim.new(0, 4)
			ToggleCorner.Name = "ToggleCorner"
			ToggleCorner.Parent = Toggle

			Title.Name = "Title"
			Title.Parent = Toggle
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0822437406, 0, 0, 0)
			Title.Size = UDim2.new(0, 113, 0, 42)
			Title.Font = Enum.Font.Gotham
			Title.Text = text
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 15.000
			Title.TextTransparency = 0.300
			Title.TextXAlignment = Enum.TextXAlignment.Left

			Circle.Name = "Circle"
			Circle.Parent = Title
			Circle.Active = true
			Circle.AnchorPoint = Vector2.new(0.5, 0.5)
			Circle.BackgroundColor3 = Color3.fromRGB(211, 211, 211)
			Circle.Position = UDim2.new(-0.150690272, 0, 0.503000021, 0)
			Circle.Size = UDim2.new(0, 11, 0, 11)

			CircleCorner.CornerRadius = UDim.new(2, 6)
			CircleCorner.Name = "CircleCorner"
			CircleCorner.Parent = Circle

			CircleSmall.Name = "CircleSmall"
			CircleSmall.Parent = Circle
			CircleSmall.Active = true
			CircleSmall.AnchorPoint = Vector2.new(0.5, 0.5)
			CircleSmall.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			CircleSmall.BackgroundTransparency = 1.000
			CircleSmall.Position = UDim2.new(0.485673368, 0, 0.503000021, 0)
			CircleSmall.Size = UDim2.new(0, 9, 0, 9)

			CircleSmallCorner.CornerRadius = UDim.new(2, 6)
			CircleSmallCorner.Name = "CircleSmallCorner"
			CircleSmallCorner.Parent = CircleSmall

			ToggleFrame.Name = "ToggleFrame"
			ToggleFrame.Parent = Circle
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(226, 227, 227)
			ToggleFrame.Position = UDim2.new(33.0856934, 0, 0, 0)
			ToggleFrame.Size = UDim2.new(0, 27, 0, 11)

			ToggleFrameCorner.Name = "ToggleFrameCorner"
			ToggleFrameCorner.Parent = ToggleFrame

			ToggleCircle.Name = "ToggleCircle"
			ToggleCircle.Parent = ToggleFrame
			ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleCircle.Position = UDim2.new(0, 0, -0.272727281, 0)
			ToggleCircle.Selectable = true
			ToggleCircle.Size = UDim2.new(0, 17, 0, 17)

			ToggleCircleCorner.CornerRadius = UDim.new(2, 8)
			ToggleCircleCorner.Name = "ToggleCircleCorner"
			ToggleCircleCorner.Parent = ToggleCircle

			Description.Name = "Description"
			Description.Parent = Title
			Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Description.BackgroundTransparency = 1.000
			Description.Position = UDim2.new(-0.200942323, 0, 0.785714269, 0)
			Description.Size = UDim2.new(0, 432, 0, 31)
			Description.Font = Enum.Font.Gotham
			Description.Text = desc
			Description.TextColor3 = Color3.fromRGB(255, 255, 255)
			Description.TextSize = 15.000
			Description.TextTransparency = 1
			Description.TextWrapped = true
			Description.TextXAlignment = Enum.TextXAlignment.Left

			ArrowBtn.Name = "ArrowBtn"
			ArrowBtn.Parent = Toggle
			ArrowBtn.BackgroundColor3 = Color3.fromRGB(86, 86, 86)
			ArrowBtn.BackgroundTransparency = 1.000
			ArrowBtn.Position = UDim2.new(0.903719902, 0, 0, 0)
			ArrowBtn.Size = UDim2.new(0, 33, 0, 37)
			ArrowBtn.SliceCenter = Rect.new(30, 30, 30, 30)
			ArrowBtn.SliceScale = 7.000

			ArrowIco.Name = "ArrowIco"
			ArrowIco.Parent = ArrowBtn
			ArrowIco.AnchorPoint = Vector2.new(0.5, 0.5)
			ArrowIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ArrowIco.BackgroundTransparency = 1.000
			ArrowIco.Position = UDim2.new(0.495753437, 0, 0.554054081, 0)
			ArrowIco.Selectable = true
			ArrowIco.Size = UDim2.new(0, 28, 0, 24)
			ArrowIco.Image = "http://www.roblox.com/asset/?id=6034818372"
			ArrowIco.ImageTransparency = .3
			
		    Toggle.MouseEnter:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play()
			end)

			Toggle.MouseLeave:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0.3}
				):Play()
			end)

			Toggle.MouseButton1Click:Connect(function()
				if Toggled == false then
					ToggleCircle:TweenPosition(UDim2.new(0.37, 0,-0.273, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
					TweenService:Create(
						ToggleCircle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =PresetColor}
					):Play()
				else
					ToggleCircle:TweenPosition(UDim2.new(0, 0,-0.273, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
					TweenService:Create(
						ToggleCircle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(255,255,255)}
					):Play()
                end
                Toggled = not Toggled
                Flags[flagname] = Toggled
                pcall(callback, Toggled)
			end)
			
			ArrowBtn.MouseButton1Click:Connect(function()
				if ToggleDescToggled == false then
					Toggle:TweenSize(UDim2.new(0, 457, 0, 74), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = 0}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 180}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = PresetColor}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					TweenService:Create(
						Description,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				else
					Toggle:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(211, 211, 211)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					TweenService:Create(
						Description,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 1}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
				ToggleDescToggled = not ToggleDescToggled
			end)
			if default == true then
				ToggleCircle:TweenPosition(UDim2.new(0.37, 0,-0.273, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
				TweenService:Create(
					ToggleCircle,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundColor3 =PresetColor}
				):Play()
				Toggled = not Toggled
				pcall(callback, Toggled)
			end
			Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
		end
		
		function ContainerContent:Slider(text,desc,min,max,start,callback)
			local SliderFunc = {}
                        local dragging = false
			local SliderDescToggled = false
			if desc == "" then
				desc = "There is no description for this slider."
			end
			local Slider = Instance.new("TextButton")
			local SliderCorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local Circle = Instance.new("Frame")
			local CircleCorner = Instance.new("UICorner")
			local CircleSmall = Instance.new("Frame")
			local CircleSmallCorner = Instance.new("UICorner")
			local Description = Instance.new("TextLabel")
			local SlideFrame = Instance.new("Frame")
			local CurrentValueFrame = Instance.new("Frame")
			local SlideCircle = Instance.new("ImageButton")
			local ArrowBtn = Instance.new("ImageButton")
			local ArrowIco = Instance.new("ImageLabel")
			local Value = Instance.new("TextLabel")

			Slider.Name = "Slider"
			Slider.Parent = Container
			Slider.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			Slider.ClipsDescendants = true
			Slider.Position = UDim2.new(0.189062506, 0, 0.648612201, 0)
			Slider.Size = UDim2.new(0, 457, 0, 60)
			Slider.AutoButtonColor = false
			Slider.Font = Enum.Font.SourceSans
			Slider.Text = ""
			Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
			Slider.TextSize = 14.000

			SliderCorner.CornerRadius = UDim.new(0, 4)
			SliderCorner.Name = "SliderCorner"
			SliderCorner.Parent = Slider

			Title.Name = "Title"
			Title.Parent = Slider
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0822437406, 0, 0, 0)
			Title.Size = UDim2.new(0, 113, 0, 42)
			Title.Font = Enum.Font.Gotham
			Title.Text = text
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 15.000
			Title.TextTransparency = 0.300
			Title.TextXAlignment = Enum.TextXAlignment.Left

			Circle.Name = "Circle"
			Circle.Parent = Title
			Circle.Active = true
			Circle.AnchorPoint = Vector2.new(0.5, 0.5)
			Circle.BackgroundColor3 = Color3.fromRGB(211, 211, 211)
			Circle.Position = UDim2.new(-0.150690272, 0, 0.503000021, 0)
			Circle.Size = UDim2.new(0, 11, 0, 11)


			CircleCorner.CornerRadius = UDim.new(2, 6)
			CircleCorner.Name = "CircleCorner"
			CircleCorner.Parent = Circle

			CircleSmall.Name = "CircleSmall"
			CircleSmall.Parent = Circle
			CircleSmall.Active = true
			CircleSmall.AnchorPoint = Vector2.new(0.5, 0.5)
			CircleSmall.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			CircleSmall.BackgroundTransparency = 1.000
			CircleSmall.Position = UDim2.new(0.485673368, 0, 0.503000021, 0)
			CircleSmall.Size = UDim2.new(0, 9, 0, 9)

			CircleSmallCorner.CornerRadius = UDim.new(2, 6)
			CircleSmallCorner.Name = "CircleSmallCorner"
			CircleSmallCorner.Parent = CircleSmall

			Description.Name = "Description"
			Description.Parent = Title
			Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Description.BackgroundTransparency = 1.000
			Description.Position = UDim2.new(-0.201000005, 0, 1.38600004, 0)
			Description.Size = UDim2.new(0, 432, 0, 31)
			Description.Font = Enum.Font.Gotham
			Description.Text = desc
			Description.TextColor3 = Color3.fromRGB(255, 255, 255)
			Description.TextSize = 15.000
			Description.TextTransparency = 0.300
			Description.TextWrapped = true
			Description.TextXAlignment = Enum.TextXAlignment.Left

			SlideFrame.Name = "SlideFrame"
			SlideFrame.Parent = Title
			SlideFrame.BackgroundColor3 = Color3.fromRGB(235, 234, 235)
			SlideFrame.BorderSizePixel = 0
			SlideFrame.Position = UDim2.new(-0.197140202, 0, 0.986091495, 0)
			SlideFrame.Size = UDim2.new(0, 426, 0, 3)

			CurrentValueFrame.Name = "CurrentValueFrame"
			CurrentValueFrame.Parent = SlideFrame
			CurrentValueFrame.BackgroundColor3 = PresetColor
			CurrentValueFrame.BorderSizePixel = 0
			CurrentValueFrame.Size = UDim2.new((start or 0) / max, 0, 0, 3)

			SlideCircle.Name = "SlideCircle"
			SlideCircle.Parent = SlideFrame
			SlideCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SlideCircle.BackgroundTransparency = 1.000
			SlideCircle.Position = UDim2.new((start or 0)/max, -6,-1.30499995, 0)
			SlideCircle.Size = UDim2.new(0, 11, 0, 11)
			SlideCircle.Image = "rbxassetid://3570695787"
			SlideCircle.ImageColor3 = PresetColor

			ArrowBtn.Name = "ArrowBtn"
			ArrowBtn.Parent = Slider
			ArrowBtn.BackgroundColor3 = Color3.fromRGB(86, 86, 86)
			ArrowBtn.BackgroundTransparency = 1.000
			ArrowBtn.Position = UDim2.new(0.903719902, 0, 0, 0)
			ArrowBtn.Size = UDim2.new(0, 33, 0, 37)
			ArrowBtn.SliceCenter = Rect.new(30, 30, 30, 30)
			ArrowBtn.SliceScale = 7.000

			ArrowIco.Name = "ArrowIco"
			ArrowIco.Parent = ArrowBtn
			ArrowIco.AnchorPoint = Vector2.new(0.5, 0.5)
			ArrowIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ArrowIco.BackgroundTransparency = 1.000
			ArrowIco.Position = UDim2.new(0.495753437, 0, 0.554054081, 0)
			ArrowIco.Selectable = true
			ArrowIco.Size = UDim2.new(0, 28, 0, 24)
			ArrowIco.Image = "http://www.roblox.com/asset/?id=6034818372"
			ArrowIco.ImageTransparency = .3

			Value.Name = "Value"
			Value.Parent = Title
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1.000
			Value.Position = UDim2.new(2.27693367, 0, 0, 0)
			Value.Size = UDim2.new(0, 113, 0, 41)
			Value.Font = Enum.Font.Gotham
			Value.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0)
			Value.TextColor3 = Color3.fromRGB(255, 255, 255)
			Value.TextSize = 15.000
			Value.TextTransparency = 0.300
			Value.TextXAlignment = Enum.TextXAlignment.Right
			
			ArrowBtn.MouseButton1Click:Connect(function()
				if SliderDescToggled == false then
					Slider:TweenSize(UDim2.new(0, 457, 0, 101), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						Value,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = 0}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 180}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =PresetColor}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					TweenService:Create(
						Description,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				else
					Slider:TweenSize(UDim2.new(0, 457, 0, 60), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						Value,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(211, 211, 211)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					TweenService:Create(
						Description,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 1}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
				SliderDescToggled = not SliderDescToggled
			end)
			
				local function move(input)
					local pos =
						UDim2.new(
							math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
							-6,
						-1.30499995,
							0
						)
					local pos1 =
						UDim2.new(
							math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
							0,
							0,
							3
						)
					CurrentValueFrame:TweenSize(pos1, "Out", "Sine", 0.1, true)
					SlideCircle:TweenPosition(pos, "Out", "Sine", 0.1, true)
					local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
					Value.Text = tostring(value)
					pcall(callback, value)
				end
				SlideCircle.InputBegan:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = true
						end
					end
				)
				SlideCircle.InputEnded:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = false
						end
					end
				)
				game:GetService("UserInputService").InputChanged:Connect(
				function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						move(input)
					end
				end
				)
			Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
			function SliderFunc:Change(tochange)
				CurrentValueFrame.Size = UDim2.new((tochange or 0) / max, 0, 0, 3)
				SlideCircle.Position = UDim2.new((tochange or 0)/max, -6,-1.30499995, 0)
				Value.Text = tostring(tochange and math.floor((tochange / max) * (max - min) + min) or 0)
				pcall(callback,tochange)
			end
			return SliderFunc
		end
		function ContainerContent:Dropdown(text,list,callback)
			local DropFunc = {}
			local Selected = text
			local FrameSize = 43
			local ItemCount = 0
			local DropToggled = false
			local Dropdown = Instance.new("TextButton")
			local DropdownCorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local Circle = Instance.new("Frame")
			local CircleCorner = Instance.new("UICorner")
			local CircleSmall = Instance.new("Frame")
			local CircleSmallCorner = Instance.new("UICorner")
			local ArrowIco = Instance.new("ImageLabel")
			local DropItemHolder = Instance.new("ScrollingFrame")
			local DropLayout = Instance.new("UIListLayout")

			Dropdown.Name = "Dropdown"
			Dropdown.Parent = Container
			Dropdown.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			Dropdown.ClipsDescendants = true
			Dropdown.Position = UDim2.new(0.110937499, 0, 0.67653507, 0)
			Dropdown.Size = UDim2.new(0, 457, 0, 43)
			Dropdown.AutoButtonColor = false
			Dropdown.Font = Enum.Font.SourceSans
			Dropdown.Text = ""
			Dropdown.TextColor3 = Color3.fromRGB(0, 0, 0)
			Dropdown.TextSize = 14.000

			DropdownCorner.CornerRadius = UDim.new(0, 4)
			DropdownCorner.Name = "DropdownCorner"
			DropdownCorner.Parent = Dropdown

			Title.Name = "Title"
			Title.Parent = Dropdown
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0822437406, 0, 0, 0)
			Title.Size = UDim2.new(0, 113, 0, 42)
			Title.Font = Enum.Font.Gotham
			Title.Text = text
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 15.000
			Title.TextTransparency = 0.300
			Title.TextXAlignment = Enum.TextXAlignment.Left

			Circle.Name = "Circle"
			Circle.Parent = Title
			Circle.Active = true
			Circle.AnchorPoint = Vector2.new(0.5, 0.5)
			Circle.BackgroundColor3 = Color3.fromRGB(211, 211, 211)
			Circle.Position = UDim2.new(-0.150690272, 0, 0.503000021, 0)
			Circle.Size = UDim2.new(0, 11, 0, 11)

			CircleCorner.CornerRadius = UDim.new(2, 6)
			CircleCorner.Name = "CircleCorner"
			CircleCorner.Parent = Circle

			CircleSmall.Name = "CircleSmall"
			CircleSmall.Parent = Circle
			CircleSmall.Active = true
			CircleSmall.AnchorPoint = Vector2.new(0.5, 0.5)
			CircleSmall.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			CircleSmall.BackgroundTransparency = 1.000
			CircleSmall.Position = UDim2.new(0.485673368, 0, 0.503000021, 0)
			CircleSmall.Size = UDim2.new(0, 9, 0, 9)

			CircleSmallCorner.CornerRadius = UDim.new(2, 6)
			CircleSmallCorner.Name = "CircleSmallCorner"
			CircleSmallCorner.Parent = CircleSmall

			ArrowIco.Name = "ArrowIco"
			ArrowIco.Parent = Title
			ArrowIco.AnchorPoint = Vector2.new(0.5, 0.5)
			ArrowIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ArrowIco.BackgroundTransparency = 1.000
			ArrowIco.Position = UDim2.new(3.45979357, 0, 0.508096159, 0)
			ArrowIco.Selectable = true
			ArrowIco.Size = UDim2.new(0, 28, 0, 24)
			ArrowIco.Image = "http://www.roblox.com/asset/?id=6035047377"
			ArrowIco.ImageTransparency = .3

			DropItemHolder.Name = "DropItemHolder"
			DropItemHolder.Parent = Title
			DropItemHolder.Active = true
			DropItemHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropItemHolder.BackgroundTransparency = 1.000
			DropItemHolder.BorderSizePixel = 0
			DropItemHolder.Position = UDim2.new(-0.203539819, 0, 1.02380955, 0)
			DropItemHolder.Size = UDim2.new(0, 436, 0, 82)
			DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
			DropItemHolder.ScrollBarThickness = 5
			DropItemHolder.ScrollBarImageColor3 = Color3.fromRGB(41, 42, 48)

			DropLayout.Name = "DropLayout"
			DropLayout.Parent = DropItemHolder
			DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
			DropLayout.Padding = UDim.new(0, 2)
			
			Dropdown.MouseEnter:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play()
			end)

			Dropdown.MouseLeave:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0.3}
				):Play()
			end)

			
			Dropdown.MouseButton1Click:Connect(function()
				if DropToggled == false then
					Title.Text = Selected
					Dropdown:TweenSize(UDim2.new(0, 457, 0, FrameSize), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = 0}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 180}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = PresetColor}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				else
					Title.Text = Selected
					Dropdown:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(211, 211, 211)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
			DropToggled = not DropToggled
			end)
			
			for i,v in next, list do
				ItemCount = ItemCount + 1
				
				if ItemCount == 1 then
					FrameSize = 78
				elseif ItemCount == 2 then
					FrameSize = 107
				elseif ItemCount >= 3 then
					FrameSize = 133
				end
				local Item = Instance.new("TextButton")
				local ItemCorner = Instance.new("UICorner")
				
			Item.Name = "Item"
			Item.Parent = DropItemHolder
			Item.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			Item.ClipsDescendants = true
			Item.Size = UDim2.new(0, 427, 0, 25)
			Item.AutoButtonColor = false
			Item.Font = Enum.Font.Gotham
			Item.Text = v
			Item.TextColor3 = Color3.fromRGB(255, 255, 255)
			Item.TextSize = 15.000
			Item.TextTransparency = 0.300

			ItemCorner.CornerRadius = UDim.new(0, 4)
			ItemCorner.Name = "ItemCorner"
				ItemCorner.Parent = Item
				DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y)
				
				Item.MouseEnter:Connect(function()
					TweenService:Create(
						Item,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
				end)

				Item.MouseLeave:Connect(function()
					TweenService:Create(
						Item,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
				end)
				
				Item.MouseButton1Click:Connect(function()
					pcall(callback, v)
					Title.Text = text
					Selected = v
					DropToggled = not DropToggled
					Dropdown:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(211, 211, 211)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
					
				end)
			end
			function DropFunc:Add(addtext)
				ItemCount = ItemCount + 1

				if ItemCount == 1 then
					FrameSize = 78
				elseif ItemCount == 2 then
					FrameSize = 107
				elseif ItemCount >= 3 then
					FrameSize = 133
				end
				local Item = Instance.new("TextButton")
				local ItemCorner = Instance.new("UICorner")

				Item.Name = "Item"
				Item.Parent = DropItemHolder
				Item.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
				Item.ClipsDescendants = true
				Item.Size = UDim2.new(0, 427, 0, 25)
				Item.AutoButtonColor = false
				Item.Font = Enum.Font.Gotham
				Item.Text = addtext
				Item.TextColor3 = Color3.fromRGB(255, 255, 255)
				Item.TextSize = 15.000
				Item.TextTransparency = 0.300

				ItemCorner.CornerRadius = UDim.new(0, 4)
				ItemCorner.Name = "ItemCorner"
				ItemCorner.Parent = Item
				DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y)

				Item.MouseEnter:Connect(function()
					TweenService:Create(
						Item,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
				end)

				Item.MouseLeave:Connect(function()
					TweenService:Create(
						Item,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
				end)

				Item.MouseButton1Click:Connect(function()
					pcall(callback, addtext)
					Title.Text = text
					Selected = addtext
					DropToggled = not DropToggled
					Dropdown:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(211, 211, 211)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end)
				if DropToggled == true then
					Title.Text = Selected
					Dropdown:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(211, 211, 211)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
			end
			function DropFunc:Clear()
				Title.Text = text
				FrameSize = 0
				ItemCount = 0
				for i, v in next, DropItemHolder:GetChildren() do
					if v.Name == "Item" then
						v:Destroy()
					end
				end
				if DropToggled == true then
					Title.Text = Selected
					Dropdown:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(211, 211, 211)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
			end
			return DropFunc
		end
		function ContainerContent:Colorpicker(text,preset,callback)
			local ColorPickerToggled = false
			local OldToggleColor = Color3.fromRGB(0, 0, 0)
			local OldColor = Color3.fromRGB(0, 0, 0)
			local OldColorSelectionPosition = nil
			local OldHueSelectionPosition = nil
			local ColorH, ColorS, ColorV = 1, 1, 1
			local RainbowColorPicker = false
			local ColorPickerInput = nil
			local ColorInput = nil
			local HueInput = nil
			
			local Colorpicker = Instance.new("Frame")
			local ColorpickerCorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local Circle = Instance.new("Frame")
			local CircleCorner = Instance.new("UICorner")
			local CircleSmall = Instance.new("Frame")
			local CircleSmallCorner = Instance.new("UICorner")
			local Hue = Instance.new("ImageLabel")
			local HueCorner = Instance.new("UICorner")
			local HueGradient = Instance.new("UIGradient")
			local HueSelection = Instance.new("ImageLabel")
			local Color = Instance.new("ImageLabel")
			local ColorCorner = Instance.new("UICorner")
			local ColorSelection = Instance.new("ImageLabel")
			local Toggle = Instance.new("TextLabel")
			local ToggleFrame = Instance.new("Frame")
			local ToggleFrameCorner = Instance.new("UICorner")
			local ToggleCircle = Instance.new("Frame")
			local ToggleCircleCorner = Instance.new("UICorner")
			local Confirm = Instance.new("TextButton")
			local ConfirmCorner = Instance.new("UICorner")
			local ConfirmTitle = Instance.new("TextLabel")
			local BoxColor = Instance.new("Frame")
			local BoxColorCorner = Instance.new("UICorner")
			local ColorpickerBtn = Instance.new("TextButton")
			local ToggleBtn = Instance.new("TextButton")


			Colorpicker.Name = "Colorpicker"
			Colorpicker.Parent = Container
			Colorpicker.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			Colorpicker.ClipsDescendants = true
			Colorpicker.Position = UDim2.new(0.110937499, 0, 0.67653507, 0)
			Colorpicker.Size = UDim2.new(0, 457, 0, 43)

			ColorpickerCorner.CornerRadius = UDim.new(0, 4)
			ColorpickerCorner.Name = "ColorpickerCorner"
			ColorpickerCorner.Parent = Colorpicker

			Title.Name = "Title"
			Title.Parent = Colorpicker
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0822437406, 0, 0, 0)
			Title.Size = UDim2.new(0, 113, 0, 42)
			Title.Font = Enum.Font.Gotham
			Title.Text = text
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 15.000
			Title.TextTransparency = 0.300
			Title.TextXAlignment = Enum.TextXAlignment.Left
			

			ColorpickerBtn.Name = "ColorpickerBtn"
			ColorpickerBtn.Parent = Title
			ColorpickerBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ColorpickerBtn.BackgroundTransparency = 1.000
			ColorpickerBtn.Position = UDim2.new(-0.336283177, 0, 0, 0)
			ColorpickerBtn.Size = UDim2.new(0, 457, 0, 42)
			ColorpickerBtn.Font = Enum.Font.SourceSans
			ColorpickerBtn.Text = ""
			ColorpickerBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
			ColorpickerBtn.TextSize = 14.000

			Circle.Name = "Circle"
			Circle.Parent = Title
			Circle.Active = true
			Circle.AnchorPoint = Vector2.new(0.5, 0.5)
			Circle.BackgroundColor3 = Color3.fromRGB(211, 211, 211)
			Circle.Position = UDim2.new(-0.150690272, 0, 0.503000021, 0)
			Circle.Size = UDim2.new(0, 11, 0, 11)

			CircleCorner.CornerRadius = UDim.new(2, 6)
			CircleCorner.Name = "CircleCorner"
			CircleCorner.Parent = Circle

			CircleSmall.Name = "CircleSmall"
			CircleSmall.Parent = Circle
			CircleSmall.Active = true
			CircleSmall.AnchorPoint = Vector2.new(0.5, 0.5)
			CircleSmall.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			CircleSmall.BackgroundTransparency = 1.000
			CircleSmall.Position = UDim2.new(0.485673368, 0, 0.503000021, 0)
			CircleSmall.Size = UDim2.new(0, 9, 0, 9)

			CircleSmallCorner.CornerRadius = UDim.new(2, 6)
			CircleSmallCorner.Name = "CircleSmallCorner"
			CircleSmallCorner.Parent = CircleSmall

			Hue.Name = "Hue"
			Hue.Parent = Title
			Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Hue.Position = UDim2.new(0, 229, 0, 46)
			Hue.Size = UDim2.new(0, 25, 0, 80)

			HueCorner.CornerRadius = UDim.new(0, 3)
			HueCorner.Name = "HueCorner"
			HueCorner.Parent = Hue

			HueGradient.Color = ColorSequence.new {
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)),
				ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)),
				ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)),
				ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)),
				ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)),
				ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))
			}			
			HueGradient.Rotation = 270
			HueGradient.Name = "HueGradient"
			HueGradient.Parent = Hue

			HueSelection.Name = "HueSelection"
			HueSelection.Parent = Hue
			HueSelection.AnchorPoint = Vector2.new(0.5, 0.5)
			HueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HueSelection.BackgroundTransparency = 1.000
			HueSelection.Position = UDim2.new(0.48, 0, 1 - select(1, Color3.toHSV(preset)))
			HueSelection.Size = UDim2.new(0, 18, 0, 18)
			HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
			HueSelection.Visible = false

			Color.Name = "Color"
			Color.Parent = Title
			Color.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
			Color.Position = UDim2.new(0, -23, 0, 46)
			Color.Size = UDim2.new(0, 246, 0, 80)
			Color.ZIndex = 10
			Color.Image = "rbxassetid://4155801252"

			ColorCorner.CornerRadius = UDim.new(0, 3)
			ColorCorner.Name = "ColorCorner"
			ColorCorner.Parent = Color

			ColorSelection.Name = "ColorSelection"
			ColorSelection.Parent = Color
			ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
			ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ColorSelection.BackgroundTransparency = 1.000
			ColorSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)))
			ColorSelection.Size = UDim2.new(0, 18, 0, 18)
			ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
			ColorSelection.ScaleType = Enum.ScaleType.Fit
			ColorSelection.Visible = false

			Toggle.Name = "Toggle"
			Toggle.Parent = Title
			Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Toggle.BackgroundTransparency = 1.000
			Toggle.Position = UDim2.new(2.37430048, 0, 1.07157099, 0)
			Toggle.Size = UDim2.new(0, 137, 0, 38)
			Toggle.Font = Enum.Font.Gotham
			Toggle.Text = "Rainbow"
			Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
			Toggle.TextSize = 15.000
			Toggle.TextTransparency = 0.300
			Toggle.TextXAlignment = Enum.TextXAlignment.Left

			ToggleFrame.Name = "ToggleFrame"
			ToggleFrame.Parent = Toggle
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(226, 227, 227)
			ToggleFrame.Position = UDim2.new(0.778387249, 0, 0.357142866, 0)
			ToggleFrame.Size = UDim2.new(0, 27, 0, 11)

			ToggleFrameCorner.Name = "ToggleFrameCorner"
			ToggleFrameCorner.Parent = ToggleFrame

			ToggleCircle.Name = "ToggleCircle"
			ToggleCircle.Parent = ToggleFrame
			ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleCircle.Position = UDim2.new(0, 0, -0.273000002, 0)
			ToggleCircle.Selectable = true
			ToggleCircle.Size = UDim2.new(0, 17, 0, 17)

			ToggleCircleCorner.CornerRadius = UDim.new(2, 8)
			ToggleCircleCorner.Name = "ToggleCircleCorner"
			ToggleCircleCorner.Parent = ToggleCircle

			Confirm.Name = "Confirm"
			Confirm.Parent = Title
			Confirm.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			Confirm.ClipsDescendants = true
			Confirm.Position = UDim2.new(2.3791616, 0, 1.97633278, 0)
			Confirm.Size = UDim2.new(0, 144, 0, 42)
			Confirm.AutoButtonColor = false
			Confirm.Font = Enum.Font.SourceSans
			Confirm.Text = ""
			Confirm.TextColor3 = Color3.fromRGB(0, 0, 0)
			Confirm.TextSize = 14.000

			ConfirmCorner.CornerRadius = UDim.new(0, 4)
			ConfirmCorner.Name = "ConfirmCorner"
			ConfirmCorner.Parent = Confirm

			ConfirmTitle.Name = "ConfirmTitle"
			ConfirmTitle.Parent = Confirm
			ConfirmTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ConfirmTitle.BackgroundTransparency = 1.000
			ConfirmTitle.Size = UDim2.new(0, 116, 0, 40)
			ConfirmTitle.Font = Enum.Font.Gotham
			ConfirmTitle.Text = "Confirm"
			ConfirmTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
			ConfirmTitle.TextSize = 15.000
			ConfirmTitle.TextTransparency = 0.300
			ConfirmTitle.TextXAlignment = Enum.TextXAlignment.Left

			BoxColor.Name = "BoxColor"
			BoxColor.Parent = Title
			BoxColor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			BoxColor.Position = UDim2.new(3.26915574, 0, 0.261904776, 0)
			BoxColor.Size = UDim2.new(0, 35, 0, 19)

			BoxColorCorner.CornerRadius = UDim.new(0, 4)
			BoxColorCorner.Name = "BoxColorCorner"
			BoxColorCorner.Parent = BoxColor

			ToggleBtn.Name = "ToggleBtn"
			ToggleBtn.Parent = Toggle
			ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleBtn.BackgroundTransparency = 1.000
			ToggleBtn.Size = UDim2.new(0, 137, 0, 38)
			ToggleBtn.Font = Enum.Font.SourceSans
			ToggleBtn.Text = ""
			ToggleBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
			ToggleBtn.TextSize = 14.000
			
			ColorpickerBtn.MouseEnter:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play()
			end)

			ColorpickerBtn.MouseLeave:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0.3}
				):Play()
			end)
		 	
			ColorpickerBtn.MouseButton1Click:Connect(function()
				if ColorPickerToggled == false then
					ColorSelection.Visible = true
					HueSelection.Visible = true
					Colorpicker:TweenSize(UDim2.new(0, 457, 0, 138), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = PresetColor}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				else
					ColorSelection.Visible = false
					HueSelection.Visible = false
					Colorpicker:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(211, 211, 211)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
				ColorPickerToggled = not ColorPickerToggled
			end)
			

			local function UpdateColorPicker(nope)
				BoxColor.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
				Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)

				pcall(callback, BoxColor.BackgroundColor3)
			end

			ColorH =
				1 -
				(math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
					Hue.AbsoluteSize.Y)
			ColorS =
				(math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
					Color.AbsoluteSize.X)
			ColorV =
				1 -
				(math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
					Color.AbsoluteSize.Y)

			BoxColor.BackgroundColor3 = preset
			Color.BackgroundColor3 = preset
			pcall(callback, BoxColor.BackgroundColor3)

			Color.InputBegan:Connect(
				function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if RainbowColorPicker then
							return
						end

						if ColorInput then
							ColorInput:Disconnect()
						end

						ColorInput =
							RunService.RenderStepped:Connect(
								function()
								local ColorX =
									(math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
										Color.AbsoluteSize.X)
								local ColorY =
									(math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
										Color.AbsoluteSize.Y)

								ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
								ColorS = ColorX
								ColorV = 1 - ColorY

								UpdateColorPicker(true)
							end
							)
					end
				end
			)

			Color.InputEnded:Connect(
				function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if ColorInput then
							ColorInput:Disconnect()
						end
					end
				end
			)

			Hue.InputBegan:Connect(
				function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if RainbowColorPicker then
							return
						end

						if HueInput then
							HueInput:Disconnect()
						end

						HueInput =
							RunService.RenderStepped:Connect(
								function()
								local HueY =
									(math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
										Hue.AbsoluteSize.Y)

								HueSelection.Position = UDim2.new(0.48, 0, HueY, 0)
								ColorH = 1 - HueY

								UpdateColorPicker(true)
							end
							)
					end
				end
			)

			Hue.InputEnded:Connect(
				function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if HueInput then
							HueInput:Disconnect()
						end
					end
				end
			)

			ToggleBtn.MouseButton1Down:Connect(
				function()
					RainbowColorPicker = not RainbowColorPicker

					if ColorInput then
						ColorInput:Disconnect()
					end

					if HueInput then
						HueInput:Disconnect()
					end

					if RainbowColorPicker then
						ToggleCircle:TweenPosition(UDim2.new(0.37, 0,-0.273, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
						TweenService:Create(
							ToggleCircle,
							TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundColor3 =PresetColor}
						):Play()

						OldToggleColor = BoxColor.BackgroundColor3
						OldColor = Color.BackgroundColor3
						OldColorSelectionPosition = ColorSelection.Position
						OldHueSelectionPosition = HueSelection.Position

						while RainbowColorPicker do
							BoxColor.BackgroundColor3 = Color3.fromHSV(Flux.RainbowColorValue, 1, 1)
							Color.BackgroundColor3 = Color3.fromHSV(Flux.RainbowColorValue, 1, 1)

							ColorSelection.Position = UDim2.new(1, 0, 0, 0)
							HueSelection.Position = UDim2.new(0.48, 0, 0, Flux.HueSelectionPosition)

							pcall(callback, BoxColor.BackgroundColor3)
							wait()
						end
					elseif not RainbowColorPicker then
						ToggleCircle:TweenPosition(UDim2.new(0, 0,-0.273, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
						TweenService:Create(
							ToggleCircle,
							TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundColor3 = Color3.fromRGB(255,255,255)}
						):Play()

						BoxColor.BackgroundColor3 = OldToggleColor
						Color.BackgroundColor3 = OldColor

						ColorSelection.Position = OldColorSelectionPosition
						HueSelection.Position = OldHueSelectionPosition

						pcall(callback, BoxColor.BackgroundColor3)
					end
				end
			)

			Confirm.MouseButton1Click:Connect(
				function()
					ColorSelection.Visible = false
					HueSelection.Visible = false
					ColorPickerToggled = not ColorPickerToggled
					Colorpicker:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(211, 211, 211)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
			)
			Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
		end
		function ContainerContent:Line()
			local Line = Instance.new("TextButton")
			local LineCorner = Instance.new("UICorner")

			Line.Name = "Line"
			Line.Parent = Container
			Line.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			Line.ClipsDescendants = true
			Line.Position = UDim2.new(0, 0, 0.70091325, 0)
			Line.Size = UDim2.new(0, 457, 0, 4)
			Line.AutoButtonColor = false
			Line.Font = Enum.Font.SourceSans
			Line.Text = ""
			Line.TextColor3 = Color3.fromRGB(0, 0, 0)
			Line.TextSize = 14.000

			LineCorner.CornerRadius = UDim.new(0, 4)
			LineCorner.Name = "LineCorner"
			LineCorner.Parent = Line
			
			Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
		end
		function ContainerContent:Label(text)
			local Label = Instance.new("TextButton")
			local LabelCorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")

			Label.Name = "Label"
			Label.Parent = Container
			Label.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			Label.ClipsDescendants = true
			Label.Position = UDim2.new(0.370312512, 0, 0.552631557, 0)
			Label.Size = UDim2.new(0, 457, 0, 43)
			Label.AutoButtonColor = false
			Label.Font = Enum.Font.SourceSans
			Label.Text = ""
			Label.TextColor3 = Color3.fromRGB(0, 0, 0)
			Label.TextSize = 14.000

			LabelCorner.CornerRadius = UDim.new(0, 4)
			LabelCorner.Name = "LabelCorner"
			LabelCorner.Parent = Label

			Title.Name = "Title"
			Title.Parent = Label
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.038480062, 0, 0, 0)
			Title.Size = UDim2.new(0, 113, 0, 42)
			Title.Font = Enum.Font.Gotham
			Title.Text = text
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 15.000
			Title.TextTransparency = 0.300
			Title.TextXAlignment = Enum.TextXAlignment.Left
			
            Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
            
            local Label = {}

            function Label:Update(txt)
                Title.Text = txt
            end

            return Label
		end
		function ContainerContent:Textbox(text,desc,disapper,callback)
			if desc == "" then
				desc = "There is no description for this textbox."
			end
			local TextboxDescToggled = false
			local Textbox = Instance.new("TextButton")
			local TextboxCorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local Circle = Instance.new("Frame")
			local CircleCorner = Instance.new("UICorner")
			local CircleSmall = Instance.new("Frame")
			local CircleSmallCorner = Instance.new("UICorner")
			local Description = Instance.new("TextLabel")
			local TextboxFrame = Instance.new("Frame")
			local TextboxFrameCorner = Instance.new("UICorner")
			local TextBox = Instance.new("TextBox")
			local ArrowBtn = Instance.new("ImageButton")
			local ArrowIco = Instance.new("ImageLabel")

			Textbox.Name = "Textbox"
			Textbox.Parent = Container
			Textbox.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			Textbox.ClipsDescendants = true
			Textbox.Position = UDim2.new(0.0459499061, 0, 0.734449744, 0)
			Textbox.Size = UDim2.new(0, 457, 0, 43)
			Textbox.AutoButtonColor = false
			Textbox.Font = Enum.Font.SourceSans
			Textbox.Text = ""
			Textbox.TextColor3 = Color3.fromRGB(0, 0, 0)
			Textbox.TextSize = 14.000

			TextboxCorner.CornerRadius = UDim.new(0, 4)
			TextboxCorner.Name = "TextboxCorner"
			TextboxCorner.Parent = Textbox

			Title.Name = "Title"
			Title.Parent = Textbox
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0822437406, 0, 0, 0)
			Title.Size = UDim2.new(0, 113, 0, 42)
			Title.Font = Enum.Font.Gotham
			Title.Text = text
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 15.000
			Title.TextTransparency = 0.300
			Title.TextXAlignment = Enum.TextXAlignment.Left

			Circle.Name = "Circle"
			Circle.Parent = Title
			Circle.Active = true
			Circle.AnchorPoint = Vector2.new(0.5, 0.5)
			Circle.BackgroundColor3 = Color3.fromRGB(211, 211, 211)
			Circle.Position = UDim2.new(-0.150690272, 0, 0.503000021, 0)
			Circle.Size = UDim2.new(0, 11, 0, 11)

			CircleCorner.CornerRadius = UDim.new(2, 6)
			CircleCorner.Name = "CircleCorner"
			CircleCorner.Parent = Circle

			CircleSmall.Name = "CircleSmall"
			CircleSmall.Parent = Circle
			CircleSmall.Active = true
			CircleSmall.AnchorPoint = Vector2.new(0.5, 0.5)
			CircleSmall.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			CircleSmall.BackgroundTransparency = 1.000
			CircleSmall.Position = UDim2.new(0.485673368, 0, 0.503000021, 0)
			CircleSmall.Size = UDim2.new(0, 9, 0, 9)

			CircleSmallCorner.CornerRadius = UDim.new(2, 6)
			CircleSmallCorner.Name = "CircleSmallCorner"
			CircleSmallCorner.Parent = CircleSmall

			Description.Name = "Description"
			Description.Parent = Title
			Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Description.BackgroundTransparency = 1.000
			Description.Position = UDim2.new(-0.200942323, 0, 0.985714269, 0)
			Description.Size = UDim2.new(0, 432, 0, 31)
			Description.Font = Enum.Font.Gotham
			Description.Text = desc
			Description.TextColor3 = Color3.fromRGB(255, 255, 255)
			Description.TextSize = 15.000
			Description.TextTransparency = 1
			Description.TextWrapped = true
			Description.TextXAlignment = Enum.TextXAlignment.Left

			TextboxFrame.Name = "TextboxFrame"
			TextboxFrame.Parent = Title
			TextboxFrame.BackgroundColor3 = Color3.fromRGB(50, 53, 59)
			TextboxFrame.Position = UDim2.new(1.82300889, 0, 0.202380955, 0)
			TextboxFrame.Size = UDim2.new(0, 161, 0, 26)

			TextboxFrameCorner.CornerRadius = UDim.new(0, 4)
			TextboxFrameCorner.Name = "TextboxFrameCorner"
			TextboxFrameCorner.Parent = TextboxFrame

			TextBox.Parent = TextboxFrame
			TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.BackgroundTransparency = 1.000
			TextBox.Size = UDim2.new(0, 161, 0, 26)
			TextBox.Font = Enum.Font.Gotham
			TextBox.Text = ""
			TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.TextSize = 15.000
			TextBox.TextTransparency = 0.300

			ArrowBtn.Name = "ArrowBtn"
			ArrowBtn.Parent = Textbox
			ArrowBtn.BackgroundColor3 = Color3.fromRGB(86, 86, 86)
			ArrowBtn.BackgroundTransparency = 1.000
			ArrowBtn.Position = UDim2.new(0.903719902, 0, 0, 0)
			ArrowBtn.Size = UDim2.new(0, 33, 0, 37)
			ArrowBtn.SliceCenter = Rect.new(30, 30, 30, 30)
			ArrowBtn.SliceScale = 7.000

			ArrowIco.Name = "ArrowIco"
			ArrowIco.Parent = ArrowBtn
			ArrowIco.AnchorPoint = Vector2.new(0.5, 0.5)
			ArrowIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ArrowIco.BackgroundTransparency = 1.000
			ArrowIco.Position = UDim2.new(0.495753437, 0, 0.554054081, 0)
			ArrowIco.Selectable = true
			ArrowIco.Size = UDim2.new(0, 28, 0, 24)
			ArrowIco.Image = "http://www.roblox.com/asset/?id=6034818372"
            
			TextBox.FocusLost:Connect(function()
                if #TextBox.Text > 0 then
                    pcall(callback, TextBox.Text)
                    if disapper then
                        TextBox.Text = ""
                    end
                end
			end)
			
			ArrowBtn.MouseButton1Click:Connect(function()
				if TextboxDescToggled == false then
					Textbox:TweenSize(UDim2.new(0, 457, 0, 81), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = PresetColor}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = 0}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 180}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = PresetColor}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					TweenService:Create(
						Description,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				else
					Textbox:TweenSize(UDim2.new(0, 457, 0, 43), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageTransparency = .3}
					):Play()
					TweenService:Create(
						ArrowIco,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(211, 211, 211)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					TweenService:Create(
						Description,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 1}
					):Play()
					wait(.4)
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
				end
				TextboxDescToggled = not TextboxDescToggled
			end)
			Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
		end
		function ContainerContent:Bind(text,presetbind,callback)
			local Key = presetbind.Name
			local Bind = Instance.new("TextButton")
			local BindCorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local Circle = Instance.new("Frame")
			local CircleCorner = Instance.new("UICorner")
			local CircleSmall = Instance.new("Frame")
			local CircleSmallCorner = Instance.new("UICorner")
			local BindLabel = Instance.new("TextLabel")

			Bind.Name = "Bind"
			Bind.Parent = Container
			Bind.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			Bind.ClipsDescendants = true
			Bind.Position = UDim2.new(0.40625, 0, 0.828947306, 0)
			Bind.Size = UDim2.new(0, 457, 0, 43)
			Bind.AutoButtonColor = false
			Bind.Font = Enum.Font.SourceSans
			Bind.Text = ""
			Bind.TextColor3 = Color3.fromRGB(0, 0, 0)
			Bind.TextSize = 14.000

			BindCorner.CornerRadius = UDim.new(0, 4)
			BindCorner.Name = "BindCorner"
			BindCorner.Parent = Bind

			Title.Name = "Title"
			Title.Parent = Bind
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.Position = UDim2.new(0.0822437406, 0, 0, 0)
			Title.Size = UDim2.new(0, 113, 0, 42)
			Title.Font = Enum.Font.Gotham
			Title.Text = text
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 15.000
			Title.TextTransparency = 0.300
			Title.TextXAlignment = Enum.TextXAlignment.Left

			Circle.Name = "Circle"
			Circle.Parent = Title
			Circle.Active = true
			Circle.AnchorPoint = Vector2.new(0.5, 0.5)
			Circle.BackgroundColor3 = Color3.fromRGB(211, 211, 211)
			Circle.Position = UDim2.new(-0.150690272, 0, 0.503000021, 0)
			Circle.Size = UDim2.new(0, 11, 0, 11)

			CircleCorner.CornerRadius = UDim.new(2, 6)
			CircleCorner.Name = "CircleCorner"
			CircleCorner.Parent = Circle

			CircleSmall.Name = "CircleSmall"
			CircleSmall.Parent = Circle
			CircleSmall.Active = true
			CircleSmall.AnchorPoint = Vector2.new(0.5, 0.5)
			CircleSmall.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
			CircleSmall.BackgroundTransparency = 1.000
			CircleSmall.Position = UDim2.new(0.485673368, 0, 0.503000021, 0)
			CircleSmall.Size = UDim2.new(0, 9, 0, 9)

			CircleSmallCorner.CornerRadius = UDim.new(2, 6)
			CircleSmallCorner.Name = "CircleSmallCorner"
			CircleSmallCorner.Parent = CircleSmall

			BindLabel.Name = "BindLabel"
			BindLabel.Parent = Title
			BindLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			BindLabel.BackgroundTransparency = 1.000
			BindLabel.Position = UDim2.new(2.56011987, 0, 0, 0)
			BindLabel.Size = UDim2.new(0, 113, 0, 42)
			BindLabel.Font = Enum.Font.Gotham
			BindLabel.Text = Key
			BindLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			BindLabel.TextSize = 15.000
			BindLabel.TextTransparency = 0.300
			BindLabel.TextXAlignment = Enum.TextXAlignment.Right
			
			Bind.MouseEnter:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play()
			end)

			Bind.MouseLeave:Connect(function()
				TweenService:Create(
					Title,
					TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0.3}
				):Play()
			end)

			Bind.MouseButton1Click:connect(
				function()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						BindLabel,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = PresetColor}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = PresetColor}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					TweenService:Create(
						BindLabel,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					BindLabel.Text = "..."
					local inputwait = game:GetService("UserInputService").InputBegan:wait()
					if inputwait.KeyCode.Name ~= "Unknown" then
						BindLabel.Text = inputwait .KeyCode.Name
						Key = inputwait .KeyCode.Name
					end
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						BindLabel,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255,255)}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(211, 211, 211)}
					):Play()
					TweenService:Create(
						CircleSmall,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
					TweenService:Create(
						BindLabel,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.3}
					):Play()
				end
			)

			game:GetService("UserInputService").InputBegan:connect(
			function(current, pressed)
				if not pressed then
					if current.KeyCode.Name == Key then
						pcall(callback, current)
					end
				end
			end
			)
			
			Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
		end
		return ContainerContent
	end
	return Tabs
end

local UI_Init

local GameFunctions = {
    [2377868063] = function()
        InstNew = hookfunction(Instance.new, function(...)
            local args = {...} 
            if args[1] == "RemoteEvent" then 
                return
            end
            return InstNew(...)
        end)

        local NetworkModule = require(ReplicatedStorage.NetworkModule);

        local UI_Sections = {
            Combat = UI_Init:Tab("Combat", "http://www.roblox.com/asset/?id=6034287513");
            GunMod = UI_Init:Tab("Gun Mods", "http://www.roblox.com/asset/?id=6034328955");
            Character = UI_Init:Tab("Character", "http://www.roblox.com/asset/?id=6023426915");
            AutoBuild = UI_Init:Tab("Auto Build", "http://www.roblox.com/asset/?id=6034744057");
        }

        local function Create(class, props)
            local inst = Instance.new(class)
            for i,v in next, props do 
                inst[i] = v 
            end 
            return inst
        end
        
        local Camera = workspace.CurrentCamera
        
        local BodyVelocity
        local BodyAngularVelocity
        
        local function ToggleFly(toggle)
            if player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("MainGui") then
                if toggle then
                    player.Character.Humanoid.PlatformStand = true
        
                    BodyVelocity = Create("BodyVelocity", {
                        Velocity = Vector3.new(0, 0, 0);
                        MaxForce = Vector3.new(10000, 10000, 10000);
                        P = 1000;
                        Parent = player.Character.Head;
                    })
        
                    BodyAngularVelocity = Create("BodyAngularVelocity", {
                        AngularVelocity = Vector3.new(0, 0, 0);
                        MaxTorque = Vector3.new(10000, 10000, 10000);
                        P = 1000;
                        Parent = player.Character.Head;
                    })
                else
                    player.Character.Humanoid.PlatformStand = false
                    BodyVelocity:Destroy()
                    BodyAngularVelocity:Destroy()
                end
            end
        end

        local GlobalStuff = require(ReplicatedStorage.GlobalStuff)
        local BuildModule = require(ReplicatedStorage.BuildModule)
        
        local Angles = {
            -pi / 2, pi, pi / 2, -pi, pi / 2
        }
        
        local Offsets = {
            Vector3.new(9, 0, 0), Vector3.new(0, 0, 9), Vector3.new(-9, 0, 0), Vector3.new(0, 0, -9), Vector3.new(0, 9, 0) 
        }
        
        
        local function GetClosest(Pos)
            return Vector3.new(floor((Pos.X / 9) + 0.5) * 9, floor((Pos.Y / 18) + 0.5) * 18, floor((Pos.Z / 9) + 0.5) * 9)
        end
        
        local function Build(delta)
            for i = 1, 5 do
                spawn(function()
                    local Offset = Offsets[i]
                    local Position = GetClosest(delta + Offset)
                    local AnglesY = GlobalStuff:Round(Angles[i], pi / 2)
                    local ObjectName = "Wall"
        
                    if i == 5 then 
                        ObjectName = "Floor"
                        Position = Position + Offset 
                    end
        
                    BuildModule:UpdateGridData(Position.X, Position.Y, Position.Z, ObjectName, AnglesY, player.Name);
                    local Response = NetworkModule:InvokeServer("Build", Position.X, Position.Y, Position.Z, ObjectName, AnglesY)
        
                    if Response == true then
                        local UpdateResourceCount = getsenv(player.PlayerGui.MainGui.MainLocal).UpdateResourceCount
                        setupvalue(UpdateResourceCount, 2, getupvalue(UpdateResourceCount, 2) - 10)
                        UpdateResourceCount()
                    elseif Response == false then
                        BuildModule:UpdateGridData(Position.X, Position.Y, Position.Z, nil);
                    end 
                end)
            end
        end

        local Variables = {
            FireRate = 0;
            FlySpeed = 50;
        }

        local ToggleUnlockall

        UI_Sections.GunMod:Toggle("Infinite Ammo", "Gives your weapon unlimited ammo", false, "InfiniteAmmo")

        UI_Sections.GunMod:Toggle("Modify Firerate", "Allows your weapon to shoot at a modified speed", false, "RapidFire")

        UI_Sections.GunMod:Slider("Firerate (ms)", "Sets your weapon's firerate in ms", 0, 1000, 0, function(value)
            Variables.FireRate = value / 1000
        end)

        UI_Sections.GunMod:Toggle("No Recoil", "Disables camera recoil", false, "NoRecoil")
        
        UI_Sections.GunMod:Toggle("No Spread", "Disables weapon spread", false, "NoSpread")
        
        UI_Sections.Combat:Toggle("Silent Aim", "Always registers a hit on the nearest enemy", false, "SilentAim")

        UI_Sections.Combat:Toggle("Wallbang", "Allows you to shoot through objects", false, "Wallbang")

        UI_Sections.Combat:Toggle("Pickaxe Aura", "Does melee damage to anyone within distance with your pickaxe", false, "PickaxeAura")
        
        UI_Sections.Combat:Toggle("Auto Shoot", "Automatically fires your weapon", false, "AutoShoot")

        UI_Sections.Character:Toggle("Godmode", "Enables you to never take damage", false, "Godmode")

        UI_Sections.Character:Toggle("No Fall Damage", "Enables you to never take damage from falling", false, "NoFallDamage")

        UI_Sections.Character:Toggle("Unlock All", "Unlocks all weapons", false, "UnlockAll", function(value)
            ToggleUnlockall(value)
        end)

        UI_Sections.Character:Toggle("Fly", "Allows your character to fly", false, "Fly", function(value)
            ToggleFly(value)
        end)

        UI_Sections.Character:Slider("Fly Speed", "The speed at which your character will fly", 10, 250, 50, function(value)
            Variables.FlySpeed = value
        end)

        UI_Sections.Character:Toggle("Infinite Jump", 'Allows you to continously jump', false, "InfiniteJump")

        UI_Sections.Character:Button("Destroy All Windows", "Destroys all of the windows in the map", function()
            for i,v in next, workspace:GetDescendants() do
                if v.Name == "Glass" then
                    NetworkModule:FireServer("CrackGlass", v)
                end
            end   
        end)

        UI_Sections.AutoBuild:Toggle("Auto Build Enabled", 'Enables Auto Build', false, "AutoBuildEnabled")

        UI_Sections.AutoBuild:Bind("Build Cube Around Closest Player", Enum.KeyCode.K, function()
            if player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("MainGui") and player.PlayerGui.MainGui:FindFirstChild("MainLocal") then
                local closest = getsenv(player.PlayerGui.MainGui.MainLocal).GetClosestPlayer()
                if closest and closest.Character and closest.Character:FindFirstChild("HumanoidRootPart") then
                    Build(closest.Character.HumanoidRootPart.Position)
                end
            end
        end)

        UI_Sections.AutoBuild:Bind("Build Cube Around Yourself", Enum.KeyCode.Z, function()
            if player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("MainGui") and player.PlayerGui.MainGui:FindFirstChild("MainLocal") then
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then 
                    Build(player.Character.HumanoidRootPart.Position)
                end
            end
        end)
        
        local UnlockConnections = {}
        
        player.PlayerGui.ChildAdded:connect(function(child)
            if child.Name == "MainGui" then 
                if Flags.Fly then 
                    ToggleFly(true)
                end
            end
        end)
        
        player.Character.Humanoid.Died:connect(function()
            if Flags.Fly then 
                ToggleFly(false)
            end
        end)
        
        local Weapons, Thing 
        
        ToggleUnlockall = function(toggle)
            if toggle then 
                Weapons, Thing = NetworkModule:InvokeServer("GetWeapons")
                local LoadoutFrame = player.PlayerGui.MenuGUI.Top.Loadout
        
                local ScrollingFrame = LoadoutFrame:WaitForChild("Left"):WaitForChild("ScrollingFrame")
                local MainBar = LoadoutFrame:WaitForChild("MainBar")
                local Right = LoadoutFrame:WaitForChild("Right")
        
                for i,v in next, ScrollingFrame:GetChildren() do
                    if v:IsA("ImageButton") then 
                        v.Lock.Visible = false
                        UnlockConnections[#UnlockConnections + 1] = v.Activated:connect(function()
                            for k,x in next, MainBar:GetChildren() do 
                                if tostring(x.BackgroundColor3) == "0.439216, 1, 0.67451" then 
                                    x.Image = v.Image
                                    Right:WaitForChild("LvlUnlock").Visible = false 
                                    Right:WaitForChild("Unlocked").Visible = true
                                    Right:WaitForChild("UnlockFrame").Visible = false
                                    local Selected = Weapons[tonumber(x.Name)]
                                    Selected[1] = v.Name 
                                    Selected[2] = require(WeaponModulesFolder:FindFirstChild(v.Name)).ClipAmmo
                                end
                            end
                        end)
                    end 
                end
                
                UnlockConnections[#UnlockConnections + 1] = ScrollingFrame.ChildAdded:connect(function(v)
                    if v:IsA("ImageButton") then 
                        v.Lock.Visible = false
                        UnlockConnections[#UnlockConnections + 1] = v.Activated:connect(function()
                            for k,x in next, MainBar:GetChildren() do 
                                if tostring(x.BackgroundColor3) == "0.439216, 1, 0.67451" then 
                                    x.Image = v.Image
                                    Right:WaitForChild("LvlUnlock").Visible = false 
                                    Right:WaitForChild("Unlocked").Visible = true
                                    Right:WaitForChild("UnlockFrame").Visible = false
                                    local Selected = Weapons[tonumber(x.Name)]
                                    Selected[1] = v.Name 
                                    Selected[2] = require(WeaponModulesFolder:FindFirstChild(v.Name)).ClipAmmo
                                end
                            end
                        end)
                    end 
                end)
            else 
                for i,v in next, UnlockConnections do 
                    v:Disconnect()
                end
            end
        end
        
        StringFind = hookfunction(string.find, function(...)
            local args = {...}
            if args[2] == "inf" then 
                return 
            end 
            return StringFind(...)
        end)
        
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall 
        setreadonly(mt, false)
            
        mt.__namecall = newcclosure(function(self, ...)
            local args = {...}
            if getnamecallmethod() == "FindPartOnRayWithIgnoreList" and (Flags.Wallbang or Flags.SilentAim) then
                return oldNamecall(self, args[1], {workspace.IgnoreThese, player.Character, workspace.BuildStuff, workspace.Map})
            end
            if args[1] == "Recoil" and Flags.NoRecoil then
                return
            end
            return oldNamecall(self, ...)
        end)
                
        setreadonly(mt, true)
        
        local oldNetworkFireServer = NetworkModule.FireServer
                
        NetworkModule.FireServer = newcclosure(function(self, action, ...)
            if action == "FallDamage" and Flags.NoFallDamage then
                return
            end
            return oldNetworkFireServer(self, action, ...)
        end)
        
        local OldIS = NetworkModule.InvokeServer
                
        NetworkModule.InvokeServer = newcclosure(function(self, action, ...)
            local args = {...}
            if not checkcaller() then
                if Flags.UnlockAll and Weapons and Thing then
                    if action == "GetWeapons" then
                        return Weapons, Thing
                    elseif action == "GetData" and args[1] == "Loadout4" then 
                        return {Weapons[1][1], Weapons[2][1], Weapons[3][1], Weapons[4][1], Weapons[5][1]}
                    end
                end
            end
            return OldIS(self, action, ...)
        end)
        
        local function GetPlayersWithinRange()
            local plrs = {}
            for i,v in next, Players:GetPlayers() do
                if v ~= player and (v.Character.Head.Position - player.Character.Head.Position).Magnitude < 20 then
                    table.insert(plrs, v)
                end
            end
            return plrs
        end
        
        coroutine.resume(coroutine.create(function()
            while wait() do
                if Flags.PickaxeAura then
                    for i,v in next, GetPlayersWithinRange() do
                        if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("Head") and not getsenv(player.PlayerGui.MainGui.MainLocal).SameTeam(v) then
                            ReplicatedStorage.Network.ClientToClient:Fire("DamageMarker", v.Character, 20)
                            NetworkModule:FireServer("MeleeDamage", v.Character.Humanoid, v.Character.Head)
                            wait(0.5)
                        end
                    end
                end
            end
        end))
        
        Hook = hookfunction(workspace.FindPartOnRayWithIgnoreList, function(...)
            local args = {...}
            if Flags.Wallbang or Flags.SilentAim then
                args[3] = {workspace.IgnoreThese, player.Character, workspace.BuildStuff, workspace.Map}
            end
            return Hook(unpack(args))
        end)
        
        local BodyParts = {"UpperTorso", "LowerTorso", "Head", "HumanoidRootPart", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperLeg", "RightLowerLeg", "RightFoot", "RightHand", "RightLowerArm", "RightUpperArm", "LeftHand", "LeftLowerArm", "LeftUpperArm"}
        local body_part_index = 0
        
        local oldConeOfFire = GlobalStuff.ConeOfFire
        GlobalStuff.ConeOfFire = function(...)
            local args = {...}
            if tostring(getcallingscript()) == "MainListener" then
                return oldConeOfFire(...)
            end
            local closest = getsenv(player.PlayerGui.MainGui.MainLocal).GetClosestPlayer()
            if Flags.SilentAim then
                if body_part_index == #BodyParts then 
                    body_part_index = 0 
                end
                body_part_index = body_part_index + 1
                if closest and closest.Character and closest.Character:FindFirstChild(BodyParts[body_part_index]) then
                    return closest.Character:FindFirstChild(BodyParts[body_part_index]).Position
                else
                    return oldConeOfFire(...)
                end
            end
            if Flags.NoSpread and (not Flags.SilentAim or not closest) then 
                return args[3]
            else
                return oldConeOfFire(...)
            end
        end
        
        UserInputService.JumpRequest:connect(function()
            if Flags.InfiniteJump and player.Character and player.Character:FindFirstChild("Humanoid") then 
                JumpPower(50)
                player.Character.Humanoid:ChangeState("Jumping")
            end
        end)
        
        local Controls = {W = false, S = false, A = false, D = false, Moving = false}
        
        RunService.Heartbeat:Connect(function(step)
            if player.Character and player.Character:FindFirstChild("Shield") and Flags.Godmode then
                player.Character.Shield:Destroy()
            end
            if player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("MainGui") and player.PlayerGui.MainGui:FindFirstChild("MainLocal") then
                if Flags.Fly then 
                    local pos = player.Character.HumanoidRootPart.Position
                    local CameraCF = Camera.CFrame
                    local hrp = player.Character.HumanoidRootPart
                    hrp.Parent = nil 
                    hrp.CFrame = CFrame.new(pos) * CFrame.Angles(CameraCF:toEulerAnglesXYZ())
                    hrp.Parent = player.Character
                    if Controls.Moving then
                        local Vector
                        local look, right = CameraCF.lookVector * Variables.FlySpeed, CameraCF.rightVector * Variables.FlySpeed
                        if Controls.W then 
                            Vector = look
                            if Controls.A then 
                                Vector = Vector - right
                            elseif Controls.D then
                                Vector = Vector + right
                            end
                        elseif Controls.S then 
                            Vector = -look
                            if Controls.A then 
                                Vector = Vector - right
                            elseif Controls.D then
                                Vector = Vector + right
                            end
                        elseif Controls.A then 
                            Vector = -right
                        elseif Controls.D then 
                            Vector = right
                        end
                        player.Character:TranslateBy(Vector * step)
                    end
                end
                if Flags.RapidFire and getsenv(player.PlayerGui.MainGui.MainLocal).Reload then
                    if not getupvalue(getsenv(player.PlayerGui.MainGui.MainLocal).Reload, 3).Pickaxe then
                        getupvalue(getsenv(player.PlayerGui.MainGui.MainLocal).Reload, 3).Debounce = Variables.FireRate
                    end
                end
                if Flags.InfiniteAmmo or Flags.UnlockAll then 
                    NetworkModule:FireServer("Animate", "Reload", nil, huge) 
                end
                if Flags.InfiniteAmmo and getsenv(player.PlayerGui.MainGui.MainLocal).Reload then
                    for i,v in next, getupvalue(getsenv(player.PlayerGui.MainGui.MainLocal).Reload, 7) do
                        if not getupvalue(getsenv(player.PlayerGui.MainGui.MainLocal).Reload, 3).Pickaxe then
                            v[2] = huge
                        end 
                    end
                end
                if Flags.NoRecoil then
                    getsenv(player.PlayerGui.MainGui.MainLocal).CameraRecoil = function() end
                end
                if Flags.AutoShoot and getsenv(player.PlayerGui.MainGui.MainLocal).Reload then 
                    if not getupvalue(getsenv(player.PlayerGui.MainGui.MainLocal).Reload, 3).Pickaxe then
                        getsenv(player.PlayerGui.MainGui.MainLocal).Shoot()
                    end
                end
            end 
        end)
        
        UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard  then
                if Flags.Fly then
                    local key = string.split(tostring(input.KeyCode), ".")[3]
                    if Controls[key] ~= nil then
                        Controls[key] = true 
                        Controls.Moving = true
                    end
                end
            end
        end)
        
        UserInputService.InputEnded:connect(function(input) 
            if Flags.Fly then 
                local key = string.split(tostring(input.KeyCode), ".")[3]
                if Controls[key] ~= nil then 
                    Controls[key] = false
                end
                if Controls.W or Controls.A or Controls.S or Controls.D then
                    Controls.Moving = true 
                else 
                    Controls.Moving = false 
                end
            end
        end)
    end;

    [113491250] = function()
        local Combat = UI_Init:Tab("Combat", "http://www.roblox.com/asset/?id=6034287513")
        local GunMods = UI_Init:Tab("Gun Mods", "http://www.roblox.com/asset/?id=6034328955")
        local Character = UI_Init:Tab("Character", "http://www.roblox.com/asset/?id=6023426915")

        local Client
        local getbodyparts
        local gamelogic
        local menu
        local oldloadmenu
        local Vector = Vector3.new()
        local CF = CFrame.new()
        local network 
        local effects
        local char
        local particle 

        for i,v in next, getgc(true) do
            if type(v) == "table" then
                if rawget(v, "_cache") then
                    Client = v
                end
                if rawget(v, "getbodyparts") then 
                    getbodyparts = v.getbodyparts 
                end
                if rawget(v, "gammo") then 
                    gamelogic = v
                end
                if rawget(v, "deploy") then 
                    menu = v
                    oldloadmenu = v.loadmenu
                end
                if rawget(v, "send") then 
                    network = v 
                end
                if rawget(v, "bullethit") then 
                    effects = v 
                end
                if rawget(v, "setbasewalkspeed") then 
                    char = v 
                end
                if rawget(v, "new") and rawget(v, "step") and rawget(v, "reset") then 
                    particle = v 
                end
            end
        end 

        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local old = network.send
        local __old = particle.new
        local _old = effects.bullethit
        local cam = workspace.CurrentCamera

        local physics = {}

        local v3 = Vector3.new
        local dot = v3().Dot
        local g = v3(0, 196.2, 0)

        physics.solvebiquadratic = function(a, b, c)
            local p = (b * b - 4 * a * c) ^ 0.5
            local r0 = (-b - p) / (2 * a)
            return r0 ^ 0.5
        end

        physics.trajectory = function(o, t, v)
            local vec = t - o
            local r = physics.solvebiquadratic(dot(g, g) / 4, dot(g, vec) - v * v, dot(vec, vec))
            return (r and g * r / 2 + vec / r), r
        end

        local StoredVariables = {}
        local GunVariables = {
            NoRecoil = {
                {'camkickmin', Vector};
                {'camkickmax', Vector};
                {'aimcamkickmin', Vector};
                {'aimcamkickmax', Vector};
                {'aimtranskickmin', Vector};
                {'aimtranskickmax', Vector};
                {'transkickmin', Vector};
                {'transkickmax', Vector};
                {'rotkickmin', Vector};
                {'rotkickmax', Vector};
                {'aimrotkickmin', Vector};
                {'aimrotkickmax', Vector};
            };
            NoSway = {
                {'swayamp', 0};
                {'swayspeed', 0};
                {'steadyspeed', 0};
                {'breathspeed', 0};
            };
            NoSpread = {
                {'hipfirespread', 0.00001};
                {'hipfirestability', 0.00001};
                {'hipfirespreadrecover', 0.00001};
            };
            FullAuto = {
                {'firemodes', {true, 3, 1}}
            };
            NoFlash = {
                {"hideflash", true};
                {"hideminimap", true};
            };
            InstantEquip = {
                {"equipspeed", 100};
            };
            InstantReload = function(req)
                for k,x in next, req.animations do
                    if (k:lower():find("reload") or k:lower():find("pullbolt") or k:lower():find("onfire")) and type(x) == "table" then
                        x.timescale = 0
                    end
                end
                return req.animations;
            end;
        }

        local function EditGun(Type, Enabled)    
            for i,v in next, ReplicatedStorage.GunModules:GetChildren() do 
                local req = require(v)

                if rawget(req, "firemodes") then 
                    if Enabled then 
                        if not StoredVariables[v.Name] then
                            StoredVariables[v.Name] = req 
                        end

                        local NewVariables = GunVariables[Type]

                        if type(NewVariables) == 'table' then
                            for k,x in next, NewVariables do
                                rawset(req, x[1], x[2])
                            end
                        elseif type(NewVariables) == 'function' then
                            rawset(req, "animations", NewVariables(req))
                        end
                    else 
                        if StoredVariables[v.Name] then
                            rawset(req, Type, StoredVariables[v.Name][Type])
                            StoredVariables[v.Name][Type] = nil
                        end
                    end
                end
            end
        end

        local Variables = {
            SilentAimHitPart = "head";
            SilentAimHitChance = 100;
            Walkspeed = 16;
        }

        GunMods:Label("Camera")

        GunMods:Toggle("No Recoil", "Disables weapon recoil", false, "NoRecoil", function(value) 
            EditGun("NoRecoil", value)
        end)

        GunMods:Toggle("No Flash", "Disables camera flash", false, "NoFlash", function(value) 
            EditGun("NoFlash", value)
        end)

        GunMods:Label("Weapon")

        GunMods:Toggle("No Spread", "Disables weapon spread", false, "NoSpread", function(value) 
            EditGun("NoSpread", value)
        end)

        GunMods:Toggle("No Sway", "Disables weapon sway", false, "NoSway", function(value) 
            EditGun("NoSway", value)
        end)

        GunMods:Toggle("Full Auto", "Makes your weapon automatic", false, "FullAuto", function(value) 
            EditGun("FullAuto", value)
        end)

        GunMods:Toggle("Instant Reload", "Instantly reloads weapin ammo", false, "InstantReload", function(value) 
            EditGun("InstantReload", value)
        end)

        GunMods:Toggle("Instant Equip", "Instantly equips weapons", false, "InstantEquip", function(value) 
            EditGun("InstantEquip", value)
        end)

        Combat:Label("Silent Aim")

        Combat:Toggle("Silent Aim", "Always registers a hit to the nearest player", false, "SilentAim")

        Combat:Dropdown("Silent Aim Hit Part", {"rootpart", "head"}, function(value)
            Variables.SilentAimHitPart = value
        end)

        Combat:Slider("Silent Aim Hit Chance", "The percentage of times silent aim will hit", 0, 100, 100, function(value)
            Variables.SilentAimHitChance = value
        end)

        Character:Label("Local")

        Character:Slider("Walkspeed", "The movement speed of your character", 0, 100, 16, function(value)
            Variables.Walkspeed = value
            char.setbasewalkspeed(value, value)
        end)

        Character:Toggle("Fly", "Allows your character to fly", false, "Fly")

        Character:Label("Other")

        Character:Toggle("No Fall Damage", "Disables your character taking fall damage", false, "NoFallDamage")

        Character:Toggle("Anti Aim", "Protects you from being aimed at", false, "AntiAim")

        Character:Toggle("Auto Deploy", "Automatically deploys your character", false, "AutoDeploy")

        Character:Label("Killsay")

        Character:Toggle("Killsay", "Sends a message in chat when you kill a player", false, "Killsay")

        Combat:Label("Melee")

        Combat:Toggle("Knife Aura", "Deals knife damage to nearby players", false, "KnifeAura")

        Combat:Label("Nades")

        Combat:Toggle("Frag TP", "Teleports frags to the nearest enemy", false, "FragTP")

        Combat:Toggle("Visibility Check", "Checks if the nearest enemy to teleport the frag to is visible", false, "NadeVisCheck")

        local KillSayMessages = {
            "Like ya cut G",
            "You just got poopity scooped",
            "Haha u thought",
            "It's not hacks, just my 3090, my gaming chair and my G-Fuel",
            "Ur bad",
            "Your mother would be disappointed",
            "Git gud",
            "You just got dominated",
            "Yikes",
        }

        local function isMelee(gun)
            return gun.id == 3
        end

        menu.loadmenu = function(...)
            if Flags.AutoDeploy then
                spawn(function()
                    repeat wait() until not menu.isdeployed()
                    
                    repeat
                        menu.deploy()
                    wait(1) until menu.isdeployed()
                end)
            end

            return oldloadmenu(...)
        end

        local ___old = char.setbasewalkspeed
        char.setbasewalkspeed = function(...) 
            local args = {...}
            args[2] = Variables.Walkspeed
            return ___old(unpack(args))
        end

        local KillFeed = player.PlayerGui.MainGui.GameGui:WaitForChild("Killfeed")
        local players = game:GetService("Players")

        KillFeed.ChildAdded:Connect(function(child)
            if child:IsA("TextLabel") and child.Name == "Feed" and Flags.Killsay then
                repeat wait() until child.Text ~= "Shedletsky"
                if child.Text == player.Name then 
                    local Victim = child:WaitForChild("Victim")
                    network:send("chatted",  KillSayMessages[math.random(1, #KillSayMessages)] .. " " ..Victim.Text, nil)
                end
            end
        end)

        local function GetClosestPlayer()
            local closestPlayer
            local shortestDistance = math.huge
            
            for i, v in next, players:GetPlayers() do
                if v.Name ~= player.Name then
                    if getbodyparts(v) and v.Team ~= player.Team then
                        local pos = cam:WorldToViewportPoint(getbodyparts(v).rootpart.Position);
                        if #cam:GetPartsObscuringTarget({getbodyparts(v).rootpart.Position}, {workspace.Players}) == 0 then
                            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude;

                            if magnitude < shortestDistance then
                                closestPlayer = v;
                                shortestDistance = magnitude;
                            end
                        end
                    end
                end
            end
            
            return closestPlayer
        end

        local function GetClosestPlayerFromDistance()
            local closest 
            local last = math.huge
            
            for i, v in next, players:GetPlayers() do
                if v ~= player and getbodyparts(v) and v.Team ~= player.Team then
                    if #cam:GetPartsObscuringTarget({getbodyparts(v).rootpart.Position}, {workspace.Players}) == 0 or not Flags.NadeVisCheck then
                        local mag = (player.Character.HumanoidRootPart.Position - getbodyparts(v).rootpart.Position).magnitude 
                        if last > mag then 
                            last = mag 
                            closest = v 
                        end
                    end
                end
            end
            
            return closest
        end

        local function IsSilentAimValid()
            local Enabled = Flags.SilentAim and Variables.SilentAimHitChance >= math.random(1, 100)

            if Enabled then 
                local closestPlayer = GetClosestPlayer()
                local body = getbodyparts(closestPlayer)
                if body and body[Variables.SilentAimHitPart] then
                    local currentGun = gamelogic.currentgun 
                    if currentGun and not isMelee(currentGun) then 
                        return body
                    end
                end
            end

            return false
        end

        local mt = getrawmetatable(game)
        local oldIndex = mt.__index 
        setreadonly(mt, false)

        mt.__index = newcclosure(function(tbl, idx)
            local currentGun = gamelogic.currentgun

            if currentGun and (tbl == currentGun.barrel or tostring(tbl) == "SightMark") and idx == "CFrame" then
                local closestPlayer = IsSilentAimValid()
                if closestPlayer then
                    local HitPart = closestPlayer[Variables.SilentAimHitPart] 
                    if HitPart then
                        local _, TimeToHit = physics.trajectory(tbl.Position, HitPart.Position, currentGun.data.bulletspeed)
                        return CFrame.new(tbl.Position, HitPart.Position + (Vector3.new(0, 98.1, 0) * (TimeToHit ^ 2)))
                    end
                end
            end

            return oldIndex(tbl, idx)
        end)

        setreadonly(mt, true)

        network.send = function(self, ...)
            local args = {...}

            if args[1] == "falldamage" and Flags.NoFallDamage then 
                return
            end
            
            if Flags.AntiAim then
                if args[1] == "stance" then 
                    args[2] = "prone"
                elseif args[1] == "repupdate" then 
                    args[3] = Vector3.new(-5, math.random(-50, 50), 0)
                end
            end

            if args[1] == "newgrenade" and args[2] == "FRAG" and Flags.FragTP then 
                local closest = GetClosestPlayerFromDistance()
                if closest and getbodyparts(closest) then
                    args[3]["frames"][#args[3]["frames"]] = {
                        ["v0"] = Vector,
                        ["glassbreaks"] = {},
                        ["t0"] = 0,
                        ["offset"] = Vector,
                        ["rot0"] = CF,
                        ["a"] = Vector,
                        ["p0"] = getbodyparts(closest).rootpart.Position,
                        ["rotv"] = Vector
                    }
                    args[3]["blowuptime"] = 0.001
                end
            end

            return old(self, unpack(args))
        end

        effects.bullethit = function(self, ...)
            local Args = {...}
            local plr = IsSilentAimValid()

            if plr then
                Args[2] = plr[Variables.SilentAimHitPart].Position
            end

            return _old(self, unpack(Args))
        end

        particle.new = function(data, ...)
            local plr = IsSilentAimValid()
            local currentGun = gamelogic.currentgun

            if plr and data.visualorigin == currentGun.barrel.Position then
                data.position = plr[Variables.SilentAimHitPart].Position
                data.velocity = physics.trajectory(currentGun.barrel.Position, plr[Variables.SilentAimHitPart].Position, currentGun.data.bulletspeed)
            end
            
            return __old(data, ...)    
        end

        local Controls = {W = false, S = false, A = false, D = false, Moving = false}

        game:GetService("RunService").RenderStepped:connect(function(step)
            if Flags.Fly and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.Humanoid.PlatformStand = true 
                player.Character.HumanoidRootPart.Velocity = Vector3.new(0, 2, 0)
                local pos = player.Character.HumanoidRootPart.Position
                local CameraCF = cam.CFrame
                local hrp = player.Character.HumanoidRootPart
                hrp.CFrame = CFrame.new(pos) * CFrame.Angles(CameraCF:toEulerAnglesXYZ())
                if Controls.Moving then
                    local ToMove
                    local look, right = CameraCF.lookVector * 50, CameraCF.rightVector * 50
                    if Controls.W then 
                        ToMove = look
                        if Controls.A then 
                            ToMove = ToMove - right
                        elseif Controls.D then
                            ToMove = ToMove + right
                        end
                    elseif Controls.S then 
                        ToMove = -look
                        if Controls.A then 
                            ToMove = ToMove - right
                        elseif Controls.D then
                            ToMove = ToMove + right
                        end
                    elseif Controls.A then 
                        ToMove = -right
                    elseif Controls.D then 
                        ToMove = right
                    end
                    player.Character:TranslateBy(ToMove * step)
                end
            end
            if Flags.KnifeAura then
                local closestp = GetClosestPlayer() 
                if closestp then 
                    local closest = getbodyparts(closestp)
                    if closest and closest.head then 
                        network:send("knifehit", closestp, tick(), closest.head)
                    end
                end
            end
        end)

        UserInputService.InputBegan:Connect(function(input)
            local key = string.split(tostring(input.KeyCode), ".")[3]
            if Controls[key] ~= nil then
                Controls[key] = true 
                Controls.Moving = true
            end
        end)

        UserInputService.InputEnded:connect(function(input) 
            local key = string.split(tostring(input.KeyCode), ".")[3]
            if Controls[key] ~= nil then 
                Controls[key] = false
            end
            if Controls.W or Controls.A or Controls.S or Controls.D then
                Controls.Moving = true 
            else 
                Controls.Moving = false 
            end
        end)
    end;

    [1168263273] = function()
        local RunService = game:GetService("RunService")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Camera = workspace.CurrentCamera
        local TS = require(ReplicatedStorage.TS)
        local OldNetworkFire = TS.Network.Fire
        local OldRecoilFire = TS.Camera.Recoil.Fire
        local raycasts = TS.Raycast
        local Players = game:GetService("Players")
        local OldLV = TS.Input.Reticle.LookVector

        local UI_Sections = {
            Combat = UI_Init:Tab("Combat", "http://www.roblox.com/asset/?id=6034287513");
            Character = UI_Init:Tab("Character", "http://www.roblox.com/asset/?id=6023426915");
        }

        local Variables = {
            SilentAimHitChance = 100;
            InfiniteJumpHeight = 36;
            SprintSpeed = 3;
            FlySpeed = 100;
            Extend = false;
            HitboxSize = 50;
            SilentAimHitPart = "Head";
        }

        local ExtendHitboxes

        UI_Sections.Combat:Label("Silent Aim")

        UI_Sections.Combat:Toggle("Silent Aim", "Always registers a hit to the nearest player", false, "SilentAim")

        UI_Sections.Combat:Slider("Silent Aim Hit Chance", "The percentage of times silent aim will hit", 0, 100, 100, function(value)
            Variables.SilentAimHitChance = value
        end)

        UI_Sections.Combat:Dropdown("Silent Aim Hit Part", {"Head", "Chest"}, function(value)
            Variables.SilentAimHitPart = value
        end)

        UI_Sections.Combat:Label("Frags")

        UI_Sections.Combat:Toggle("Frag Teleport", "Teleports frags to the nearest enemy", false, "FragTP")

        UI_Sections.Combat:Toggle("Visibility Check", "Checks if the nearest enemy to teleport the frag to is visible", false, "FragTPVisCheck")

        UI_Sections.Character:Label("Local")

        UI_Sections.Character:Toggle("Infinite Jump", "Allows your character to continuously jump", false, "InfJump")

        UI_Sections.Character:Slider("Infinite Jump Height", "The height increment at which you will jump", 0, 250, 36, function(value)
            Variables.InfiniteJumpHeight = value
        end)

        UI_Sections.Character:Toggle("Fast Sprint", "Allows your character to go faster while sprinting", false, "FastSprint")

        UI_Sections.Character:Slider("Sprint Speed", "The speed at which your character will sprint while fast sprint is enabled", 1, 3, 3, function(value)
            Variables.SprintSpeed = value
        end)

        UI_Sections.Character:Toggle("Fly", "Allows your character to fly", false, "Fly")

        UI_Sections.Character:Slider("Fly Speed", "The speed at which your character will fly if fly is enabled", 0, 250, 100, function(value)
            Variables.FlySpeed = value
        end)

        UI_Sections.Character:Label("Other")

        UI_Sections.Character:Toggle("Hitbox Extender", "Extends player hitboxes", false, "HitboxExtend", function(value)
            Variables.Extend = value
            ExtendHitboxes()
        end)

        UI_Sections.Character:Slider("Hitbox Size", "The size to extend player hitboxes to", 10, 100, 50, function(value)
            Variables.HitboxSize = value
            if Variables.Extend then 
                ExtendHitboxes()
            end
        end)

        UI_Sections.Combat:Label("Gun Mods")

        UI_Sections.Combat:Toggle("No Recoil", "Disables camera recoil", false, "NoRecoil")

        UI_Sections.Combat:Toggle("No Spread", "Disables weapon spread", false, "NoSpread", function(value)
            if value then 
                TS.Input.Reticle.LookVector = function()
                    return Camera.CFrame.LookVector 
                end
            else 
                TS.Input.Reticle.LookVector = OldLV
            end
        end)

        UI_Sections.Combat:Toggle("Rapidfire", "Allows your weapon to rapidly fire", false, "Rapidfire")

        UI_Sections.Combat:Label("Other")

        UI_Sections.Combat:Toggle("Wallbang", "Allows your weapon to shoot through objects", false, "Wallbang", function(value)
            setupvalue(raycasts.CastGeometryAndEnemies, 1, value and nil or workspace.Geometry)
            setupvalue(raycasts.CastGeometryAndEnemies, 2, value and nil or workspace.Terrain)
        end)

        UI_Sections.Combat:Label("Melee")

        UI_Sections.Combat:Toggle("Knife Aura", "Does knife damage to nearby enemies", false, "KnifeAura")

        local DoubleMeleeDamage = UI_Sections.Combat:Toggle("Double Melee Damage", "Doubles the amount of damage your melee weapon will do", false, "DoubleMeleeDamage")

        local StoredSizes = {}

        local Wait = TS.Timer.Wait
        TS.Timer.Wait = function(self, Time)
            local upv = getupvalues(2)
            if Flags.Rapidfire and type(upv[1]) == "table" and rawget(upv[1], "Equipped") and typeof(upv[7]) == "Instance" and upv[7]:IsA("IntValue") then
                return Wait(self, 0)
            end
            return Wait(self, Time)
        end

        local function ExtendHitboxes()
            if Variables.Extend then
                for i,v in next, Players:GetPlayers() do
                    if v ~= player and not TS.Teams:ArePlayersFriendly(player, v) then
                        local Character = TS.Characters:GetCharacter(v)
                    
                        if Character then
                            local Hitbox = Character:WaitForChild("Hitbox")
                            for k,x in next, Hitbox:GetChildren() do 
                                for a,b in next, getconnections(x:GetPropertyChangedSignal("Size")) do 
                                    b:Disable()
                                end
                                
                                local s = Variables.HitboxSize
                                
                                if not StoredSizes[x.Name] then 
                                    StoredSizes[x.Name] = x.Size
                                end
                                
                                x.Size = Vector3.new(s, s, s)
                            end
                        end
                    end
                end
            else 
                for i,v in next, Players:GetPlayers() do
                    if v ~= player and not TS.Teams:ArePlayersFriendly(player, v) then
                        local Character = TS.Characters:GetCharacter(v)
                    
                        if Character then
                            local Hitbox = Character:WaitForChild("Hitbox")
                            for k,x in next, Hitbox:GetChildren() do 
                                if StoredSizes[x.Name] then 
                                    x.Size = StoredSizes[x.Name]
                                end
                            end
                        end
                    end
                end
            end
        end

        local function GetClosestPlayer()
            if not TS.Characters:GetCharacter(player) then return end 

            local closest
            local last = math.huge
            
            for i, v in next, Players:GetPlayers() do
                if v ~= player and not TS.Teams:ArePlayersFriendly(player, v) then
                    local Character = TS.Characters:GetCharacter(v)
                    if Character and Character:FindFirstChild("Root") then
                        local pos = Camera:WorldToViewportPoint(Character.Root.Position)
                        local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude

                        if mag < last then
                            closest = v 
                            last = mag
                        end
                    end
                end
            end
            
            return closest
        end

        local Vector = Vector3.new(0, 0, 0)

        TS.Camera.Recoil.Fire = function(...) 
            if Flags.NoRecoil then 
                return 
            end 
            return OldRecoilFire(...)
        end

        TS.Network.Fire = function(self, ...)
            local args = {...}
            if (args[1] == "Admin" or args[1] == "ClientErrorLogs" or args[1] == "Votekick") then return end
            if Flags.DoubleMeleeDamage and args[1] == "Item_Melee" and args[2] == "Stab" then 
                OldNetworkFire(self, ...)
            end
            if args[2] == "Shoot" and Flags.SilentAim then 
                local ClosestPlayer = GetClosestPlayer()
                if ClosestPlayer then 
                    local Closest = TS.Characters:GetCharacter(ClosestPlayer)
                    local HitPart = Variables.SilentAimHitPart
                    if Closest and math.random(1, 100) <= Variables.SilentAimHitChance and Closest:FindFirstChild("Hitbox") and Closest.Hitbox:FindFirstChild("Head") and Closest.Hitbox:FindFirstChild("Chest") then
                        local check = #Camera:GetPartsObscuringTarget({Closest.Root.Position}, {workspace.Characters}) == 0
                        if check then 
                            local direction = (Closest.Hitbox[HitPart].Position - Camera.CFrame.p).Unit
                            for i,v in next, args[5] do
                                v[1] = direction
                            end
                        end
                    end 
                end
            end
            return OldNetworkFire(self, unpack(args))
        end

        workspace.Characters.ChildAdded:connect(function()
            if Variables.Extend then 
                ExtendHitboxes()
            end
        end)

        workspace.Throwables.ChildAdded:Connect(function(child)
            if Flags.FragTP then
                local PrimaryBody = child:WaitForChild("Body"):WaitForChild("BodyPrimary")
                local ClosestPlayer = GetClosestPlayer()
                if ClosestPlayer then 
                    local ClosestCharacter = TS.Characters:GetCharacter(ClosestPlayer)
                    local check = #Camera:GetPartsObscuringTarget({ClosestCharacter.Root.Position}, {workspace.Characters}) == 0
                    if not Flags.FragTPVisCheck or check then
                        repeat  
                            ClosestCharacter = TS.Characters:GetCharacter(ClosestPlayer)
                            if ClosestCharacter and ClosestCharacter.PrimaryPart then
                                PrimaryBody.CFrame = ClosestCharacter:GetPrimaryPartCFrame()
                            end
                        wait() until child == nil or not child:IsDescendantOf(workspace)
                    end
                end
            end
        end)

        UserInputService.InputBegan:connect(function(input)
            if Flags.InfJump and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Space then
                local LocalChar = TS.Characters:GetCharacter(player)
                if LocalChar and LocalChar:FindFirstChild("Root") then
                    LocalChar.Root.Velocity = Vector3.new(0, Variables.InfiniteJumpHeight, 0)
                end
            end
        end)

        local function GetKnife()
            local Character = TS.Characters:GetCharacter(player)
            for i, v in next, Character.Backpack.Items:GetChildren() do
                if v:FindFirstChild("Config") then
                    local Category = require(v.Config).Category
                    if Category == "Knife" or Category == "Melee" then
                        return v
                    end
                end
            end
        end

        local Controls = {W = false, S = false, A = false, D = false, Moving = false}

        RunService.RenderStepped:Connect(function(step)
            local Character = TS.Characters:GetCharacter(player)
            if Flags.FastSpring and Character and Character:FindFirstChild("State") and (Character.State.Sprinting.Value == true or Character.State.SuperSprinting.Value == true) then
                Character.Root.Velocity = Character.Root.Velocity * Vector3.new(Variables.SprintSpeed, 1, Variables.SprintSpeed)
            end
            if Character and Flags.KnifeAura then 
                local ClosestPlayer = GetClosestPlayer()
                if ClosestPlayer then 
                    local Knife = GetKnife()
                    local ClosestCharacter = TS.Characters:GetCharacter(ClosestPlayer)

                    if ClosestCharacter and ClosestCharacter:FindFirstChild("Hitbox") and ClosestCharacter.Hitbox:FindFirstChild("Head") and ClosestCharacter.Hitbox:FindFirstChild("Chest") and Knife then
                        TS.Network:Fire("Item_Melee", "Stab", Knife, ClosestCharacter.Hitbox.Head, ClosestCharacter.Hitbox.Head.Position, Vector)
                    end
                end 
            end
            if Flags.Fly and Character and Character:FindFirstChild("Root") then
                Character.Root.Velocity = Vector3.new(0, 2, 0)
                local pos = Character.Root.Position
                local CameraCF = Camera.CFrame
                Character.Root.CFrame = CFrame.new(pos) * CFrame.Angles(CameraCF:toEulerAnglesXYZ())
                if Controls.Moving then
                    local ToMove
                    local look, right = CameraCF.lookVector * Variables.FlySpeed, CameraCF.rightVector * Variables.FlySpeed
                    if Controls.W then 
                        ToMove = look
                        if Controls.A then 
                            ToMove = ToMove - right
                        elseif Controls.D then
                            ToMove = ToMove + right
                        end
                    elseif Controls.S then 
                        ToMove = -look
                        if Controls.A then 
                            ToMove = ToMove - right
                        elseif Controls.D then
                            ToMove = ToMove + right
                        end
                    elseif Controls.A then 
                        ToMove = -right
                    elseif Controls.D then 
                        ToMove = right
                    end
                    Character:TranslateBy(ToMove * step)
                end
            end
        end)

        UserInputService.InputBegan:Connect(function(input)
            local key = string.split(tostring(input.KeyCode), ".")[3]
            if Controls[key] ~= nil then
                Controls[key] = true 
                Controls.Moving = true
            end
        end)

        UserInputService.InputEnded:connect(function(input) 
            local key = string.split(tostring(input.KeyCode), ".")[3]
            if Controls[key] ~= nil then 
                Controls[key] = false
            end
            if Controls.W or Controls.A or Controls.S or Controls.D then
                Controls.Moving = true 
            else 
                Controls.Moving = false 
            end
        end)
    end;

    [301252049] = function()
        local UI_Sections = {
            Autoplayer = UI_Init:Tab("Autoplayer", "http://www.roblox.com/asset/?id=6034837797");
            Misc = UI_Init:Tab("Misc", "http://www.roblox.com/asset/?id=6022668907");
        }
        
        local HitPercentages = {
            Perfect = 100;
            Great = 0;
            Okay = 0;
            Miss = 0;
            Combined = 0;
        }

        local HeldNotes = {}

        local Bounds = {
            Perfect = -20;
            Great = -50;
            Okay = -100;
            Miss = -500;
        }
        
        local RELEASE_TRACK = 'release_track_index';
        local PRESS_TRACK = 'press_track_index';
        local TEST_HIT = 'get_delta_time_from_hit_time';
        local TEST_RELEASE = 'get_delta_time_from_release_time';
        visit_webnpc = nil
        WebNPCManager = nil
        
        local function GetHitPercentage(a) 
            return HitPercentages[a] 
        end
        
        local function Calculate(a, b, c, d)
            local Total = a + b + c + d
            return a / Total * 100, b / Total * 100, c / Total * 100, d / Total * 100
        end
        
        local Utilities
        Utilities = {
        
            get_target_delay_from_noteresult = function(noteresult)
                return Bounds[noteresult]
            end;
            
            get_noteresult = function()
        
                local P, G, O, M = Calculate(GetHitPercentage("Perfect"), GetHitPercentage("Great"), GetHitPercentage("Okay"), GetHitPercentage("Miss"))
                local Target = P + G + O + M
                local Total = 0
                
                local ChanceTBL = {}
                local chs = {"Miss", "Okay", "Great", "Perfect"}
        
                for i,v in next, {M, O, G, P} do 
                    if v > 0 then 
                        ChanceTBL[chs[i]] = v
                    end
                end
        
                local Entries = {}
                for i,v in next, ChanceTBL do
                    Entries[i] = {Min = Total, Max = Total + v}
                    Total = Total + v
                end
                
                local Number = random(0, floor(Target));
        
                for i,v in next, Entries do
                    if v.Min <= Number and v.Max >= Number then
                        return i
                    end
                end
            end;
        
            updatehitpct = function()
                local P, G, O, M = GetHitPercentage('Perfect'), GetHitPercentage('Great'), GetHitPercentage('Okay'), GetHitPercentage('Miss')
                HitPercentages.Combined = P + G + O + M
            end;
        
            determine = function(key, constants)
                local finding
            
                if (key == RELEASE_TRACK) then
                    finding = 'release'
                elseif (key == PRESS_TRACK) then
                    finding = 'press'
                elseif (key == TEST_HIT) then
                    finding = 'get_delta_time_from_hit_time'
                elseif (key == TEST_RELEASE) then
                    finding = 'get_delta_time_from_release_time'
                end
            
                if finding == nil then return false end
            
                if table.find(constants, finding) then 
                    return true 
                end
                
                return false
            end;
            
            get_notes = function(tracksystem)
                for i,v in next, tracksystem do 
                    if type(v) == "function" then 
                        local c = getconstants(v)
                        if table.find(c, "do_remove") and table.find(c, "clear") then
                            return getupvalue(v, 1)
                        end 
                    end 
                end
            end;
            
            get_tracksystems = function(_game)
                for i,v in next, _game do
                    if (type(v) == 'function') then
                        local obj = getupvalue(v, 1)
                        if (type(obj) == 'table' and rawget(obj, '_table') and rawget(obj, 'count')) then
                            if (obj:count() <= 4) then
                                return obj
                            end
                        end
                    end
                end
            end;
            
            get_func = function(parent, func)
                for i,v in next, parent do
                    local consts = type(v) == 'function' and getconstants(v) or {}
                    if (type(v) == 'function' and Utilities.determine(func, consts)) then
                        return v
                    end
                end
            end;
        };
        
        Database = nil
        local AllSongs;
        Applying = {}
        StoredSongs = {}
        
        local function Apply(as,db)
            local MNM = db:name_to_key('MondayNightMonsters1')
        
            local old_new = as.new
            
            as.new = function(...)
                local as_self = old_new(...)
                local old_skp = as_self.on_songkey_pressed;
                as_self.on_songkey_pressed = function(self, song)
                    
                    local actual = tonumber(song);
                    
                    if Flags.UnlockAllSongs then
                        song = MNM
                    end
                    
                    local song_name = db:key_to_name(song)
                    local actual_name = db:key_to_name(actual)
                    local title = db:get_title_for_key(actual)
                    local data = StoredSongs[title]
                    
                    local all = getupvalue(db.add_key_to_data, 1);
        
                    all:add(song, data);
                    data.__key = song;
                    
                    setupvalue(db.add_key_to_data, 1, all)
                     
                    return old_skp(self, song)
                end
                
                return as_self
            end
        end
        
        colors = {
            [1] = Color3.fromRGB(255, 0, 0);
            [2] = Color3.fromRGB(255, 0, 0);
            [3] = Color3.fromRGB(255, 0, 0);
            [4] = Color3.fromRGB(255, 0, 0);
        }

        TrackSystem = nil
        get_local_elements_folder = nil
        vip = nil
        WebNPCManager = nil
        visit_webnpc = nil
        SongSpeedValue = 1000

        UI_Sections.Autoplayer:Label("Main")

        UI_Sections.Autoplayer:Toggle("Block Input", "Blocks manual keyboard input", false, "BlockInput")

        UI_Sections.Misc:Label("Utilities")

        UI_Sections.Misc:Slider("Song Speed", "The playback speed of the song", 0, 5000, 1000, function(value)
            SongSpeedValue = value
        end)
        
        loadstring([[for i,v in next, getgc(true) do
            if type(v) == 'table' then
                if rawget(v, 'key_has_combineinfo') then
                    Database = v;
                end
                if rawget(v, "input_began") then 
                    local input_began = v.input_began
                    v.input_began = function(_, input) 
                        if type(input) ~= "number" and Flags.BlockInput then 
                            return
                        end 
                        return input_began(_, input)
                    end
                end
                if rawget(v, "visit_webnpc") then
                    visit_webnpc = v.visit_webnpc
                end 
                if rawget(v, "webnpcid_should_trigger_reward") then 
                    WebNPCManager = v
                end
                if rawget(v, 'playerblob_has_vip_for_current_day') then
                    vip = v
                end
                if type(rawget(v, 'new')) == 'function' and islclosure(v.new) then
                    local new = v.new
                    local finding = {"get_default_base_color_list", "get_default_fever_color_list"};
                    local found = 0;
                    for _,bruh in next, getconstants(new) do
                        if (bruh == 'on_songkey_pressed') then
                            table.insert(Applying, #Applying+1, v)
                        end
                        if (table.find(finding, bruh)) then
                            found = found + 1
                        end
                    end
                    if (found >= #finding) and not TrackSystem then
                        TrackSystem = v;
                    end
                end	
                if rawget(v, "TimescaleToDeltaTime") then 
                    local OldTTDT = v.TimescaleToDeltaTime
                    v.TimescaleToDeltaTime = function(...)
                        local args = {...}
                        args[2] = args[2] * (SongSpeedValue / 1000)
                        return OldTTDT(unpack(args))
                    end
                end
                if rawget(v, 'color3_for_slot') then 
                    local old = v.color3_for_slot
                    v.color3_for_slot = function(self, ...)
                        local orig = old(self, ...)
                        if not Flags.NoteColors then 
                            return orig 
                        end
                        return colors[self:get_track_index()] or orig
                    end
                end
                if rawget(v, 'get_local_elements_folder') then 
                    get_local_elements_folder = v.get_local_elements_folder 
                end
                if rawget(v, 'HitObjects') then 
                    StoredSongs[v.AudioFilename] = v
                end
            end
        end]])()
        
        for _,AllSongs in next, Applying do
            Apply(AllSongs, Database)
        end
        
        local playerblob_has_vip_for_current_day = vip.playerblob_has_vip_for_current_day
        
        UI_Sections.Autoplayer:Toggle("Autoplayer", "Toggles the autoplayer", false, "Autoplayer")
    
        UI_Sections.Autoplayer:Label("Percentages")
        
        UI_Sections.Autoplayer:Slider("Perfect Percentage", "The percentage that the autoplayer will hit perfect", 0, 100, 100, function(value)
            HitPercentages.Perfect = value
            Utilities.updatehitpct();
        end)

        UI_Sections.Autoplayer:Slider("Great Percentage", "The percentage that the autoplayer will hit great", 0, 100, 0, function(value)
            HitPercentages.Great = value
            Utilities.updatehitpct();
        end)

        UI_Sections.Autoplayer:Slider("Okay Percentage", "The percentage that the autoplayer will hit okay", 0, 100, 0, function(value)
            HitPercentages.Okay = value
            Utilities.updatehitpct();
        end)

        UI_Sections.Autoplayer:Slider("Miss Percentage", "The percentage that the autoplayer will hit miss", 0, 100, 0, function(value)
            HitPercentages.Okay = value
            Utilities.updatehitpct();
        end)

        UI_Sections.Misc:Toggle("Unlock All Songs (locks score)", "Unlocks all songs, note: this will lock your score while playing", false, "UnlockAllSongs", function(value)
            if value then 
                vip.playerblob_has_vip_for_current_day = function()
                    return true 
                end 
            else 
                vip.playerblob_has_vip_for_current_day = playerblob_has_vip_for_current_day
            end
        end)

        UI_Sections.Misc:Button("Collect NPC Rewards", "Collects all NPC gifts", function()
            loadstring([[
                for i,v in next, getgc(true) do
                    if type(v) == "table" and rawget(v, "WebNPCID") then
                        local WebNPCID = v.WebNPCID
                        if WebNPCManager:webnpcid_should_trigger_reward(WebNPCID) then
                            visit_webnpc(nil, WebNPCID, function() end)
                        end
                    end
                end
            ]])()
        end)

        UI_Sections.Misc:Label("Note Colors") 

        UI_Sections.Misc:Toggle("Note Colors Enabled", "Toggles note color modification", false, "NoteColors")

        for i = 1, 4 do 
            UI_Sections.Misc:Colorpicker("Note Track "..tostring(i), Color3.fromRGB(255, 0, 0), function(value)
                colors[i] = value
            end)
        end
        
        local function update_autoplayer(_game, target_delay)
            local localSlot = getupvalue(_game.set_local_game_slot, 1)
            local trackSystem = Utilities.get_tracksystems(_game)._table[localSlot]
            local Notes = Utilities.get_notes(trackSystem)
            local Target = -abs(target_delay)
            local current_song = get_local_elements_folder():FindFirstChildWhichIsA("Sound")
        
            if current_song then 
                current_song.PlaybackSpeed = SongSpeedValue / 1000
            end
        
            for Index = 1, Notes:count() do
                local Note = Notes:get(Index)
                if Note then
                    local NoteTrack = Note:get_track_index(Index)
                    if ( HeldNotes[NoteTrack] and Utilities.get_func(Note, TEST_RELEASE) ) then
                        local released, result, delay = Utilities.get_func(Note, TEST_RELEASE)(Note, _game, 0)
                        if (released and delay >= Target) then
                            HeldNotes[NoteTrack] = nil
                            Utilities.get_func(trackSystem, RELEASE_TRACK)(trackSystem, _game, NoteTrack)
                            return true
                        end
                    elseif (Flags.Autoplayer and Utilities.get_func(Note, TEST_HIT)) then
                        local hit, result, delay = Utilities.get_func(Note, TEST_HIT)(Note, _game, 0)
                        if hit and delay >= Target then
                            Utilities.get_func(trackSystem, PRESS_TRACK)(trackSystem, _game, NoteTrack)
                            _game:debug_any_press()
            
                            if (type(Note.get_time_to_end) == 'nil') then
                                HeldNotes[NoteTrack] = true
                            else
                                wait(0.05)
                                Utilities.get_func(trackSystem, RELEASE_TRACK)(trackSystem, _game, NoteTrack)
                            end
                        end
                    end
                end
            end
        end
        
        local old_new = TrackSystem.new;
        TrackSystem.new = function(...)
            local self = old_new(...)
            local old_update
            for i,v in next, self do 
                if type(v) == "function" then 
                    local c = getconstants(v)
                    if table.find(c, "do_remove") and table.find(c, "remove_at") then 
                        old_update = v
                        rawset(self, getinfo(v).name, function(shit, slot, _game)
                            if Flags.Autoplayer then
                                local delay = Utilities.get_target_delay_from_noteresult(Utilities.get_noteresult()) or 25
                                coroutine.wrap(update_autoplayer)(_game, delay)
                            end
                            return old_update(self, slot, _game)
                        end)
                        break
                    end
                end 
            end
            return self;
        end
    end;

    [1643537246] = function()
        local UI_Sections = {
            AutoplayerSection = UI_Init:Tab("Autoplayer", "http://www.roblox.com/asset/?id=6034837797");
        }
        
        local Percentages = {Miss = 0, Bad = 0, Okay = 0, Great = 0, Perfect = 10, Marvelous = 90}
        local Autoplay = false

        UI_Sections.AutoplayerSection:Label("Main")

        UI_Sections.AutoplayerSection:Toggle("Autoplayer", "Toggles the map autoplayer", false, "Autoplayer")
        
        UI_Sections.AutoplayerSection:Label("Percentages")

        UI_Sections.AutoplayerSection:Slider("Marvelous Percentage (100% is risky)", "The percentage the autoplayer will hit marvelous", 0, 100, 90, function(value)
            Percentages.Marvelous = value
        end)

        UI_Sections.AutoplayerSection:Slider("Perfect Percentage", "The percentage the autoplayer will hit perfect", 0, 100, 10, function(value)
            Percentages.Perfect = value
        end)

        UI_Sections.AutoplayerSection:Slider("Great Percentage", "The percentage the autoplayer will hit great", 0, 100, 0, function(value)
            Percentages.Great = value
        end)

        UI_Sections.AutoplayerSection:Slider("GOkay Percentage", "The percentage the autoplayer will hit okay", 0, 100, 0, function(value)
            Percentages.Okay = value
        end)

        UI_Sections.AutoplayerSection:Slider("Bad Percentage", "The percentage the autoplayer will hit bad", 0, 100, 0, function(value)
            Percentages.Bad = value
        end)

        UI_Sections.AutoplayerSection:Slider("Miss Percentage", "The percentage the autoplayer will hit miss", 0, 100, 0, function(value)
            Percentages.Miss = value
        end)
        
        local function Calculate(a, b, c, d, e, f)
            local Total = a + b + c + d + e + f 
            return a / Total * 100, b / Total * 100, c / Total * 100, d / Total * 100, e / Total * 100, f / Total * 100
        end
        
        local function GetPercentage()
            local M, P, G, GO, B, MI = Calculate(Percentages.Marvelous, Percentages.Perfect, Percentages.Great, Percentages.Okay, Percentages.Bad, Percentages.Miss)
            local Target = M + P + G + GO + B + MI
            local Total = 0
            
            local chs = {"Miss", "Bad", "Okay", "Great", "Perfect", "Marvelous"}
            local ChanceTBL = {}
            for i = 1, #chs do
                if Percentages[chs[i]] > 0 then
                    ChanceTBL[Percentages[chs[i]]] = chs[i]
                end
            end
        
            local Entries = {}
        
            for i,v in next, ChanceTBL do
                Entries[v] = {Min = Total, Max = Total + i};
                Total = Total + i;
            end
            
            local Number = random(0, floor(Target));
            for i,v in next, Entries do
                if v.Min <= Number and v.Max >= Number then
                    return table.find(chs, i)
                end
            end
        end

        local LocalGame
        local NoteResult = require(ReplicatedStorage.Shared.NoteResult)
        local GameLocalModule = require(ReplicatedStorage.Local.GameLocal)
        local GameLocalNew = GameLocalModule.new
        GameLocalModule.new = function(...)
            LocalGame = GameLocalNew(...)
            return LocalGame
        end

        local ID;
        local NoteModule = require(ReplicatedStorage.Local.Note);
        local NoteNew = NoteModule.new
        NoteModule.new = function(...)
            local Args = {...}
            ID = Args[#Args]
            return NoteNew(...);
        end

        local HeldID;
        local HeldNoteModule = require(ReplicatedStorage.Local.HeldNote)
        local HeldNoteNew = HeldNoteModule.new
        HeldNoteModule.new = function(...)
            local Args = {...}
            HeldID = Args[#Args]
            return HeldNoteNew(...);
        end

        local TrackSystemModule = require(ReplicatedStorage.Local.TrackSystem)
        local TrackSystemNew = TrackSystemModule.new
        TrackSystemModule.new = function(...)
            TrackSystem = TrackSystemNew(...)
            local TrackUpdate = TrackSystem.update
            TrackSystem.update = function(...)
                if Flags.Autoplayer then
                    local _notes = TrackSystem._notes
                    for i = 1, _notes:count() do
                        local Note = _notes._table[i]
                        local Accuracy = GetPercentage()
                        local Hit, Result = Note:test_hit(LocalGame)
                        
                        local Release, ReleaseResult = Note:test_release(LocalGame)
                        local Track = TrackSystem:get_track(Note:get_track_index()) 
                        
                        if Hit and Result == Accuracy then
                            Track:press()
                            Note:on_hit(LocalGame, Accuracy, i, Note.Type ~= 'HeldNote' and ID or HeldID)
                            if Note.Type ~= "HeldNote" then
                                spawn(function()
                                    wait()
                                    Track:release()
                                end)
                            end
                        elseif Note.Type == "HeldNote" and Release and ReleaseResult == Accuracy then 
                            Note:on_release(LocalGame, Accuracy, i, HeldID)
                            spawn(function()
                                wait()
                                Track:release()
                            end)
                        end
                    end
                end
                return TrackUpdate(...)
            end
            return TrackSystem
        end
    end;

    [88070565] = function()

        local ScriptVersion = '0.9.4b'
        local Player = player

        local SaveLoaderVersion = 'alpha x bloxburg base file v2 (center : water)'
        
        local Network = nil
            
        local BypassedNet = nil
        
        for i, v in pairs(getgc(true)) do
            if type(v) == "table" then 
                if rawget(v, 'Shared') and rawget(v, 'net') then
                    Network = v 
                end
            elseif type(v) == 'function' then
                if getfenv(v).script == ReplicatedStorage.Modules.DataManager then
                    local const = getconstants(v)
                    if table.find(const, 'RemoteFunction') and table.find(const, 'RemoteEvent') then
                        BypassedNet = v
                    end
                end
            end
        end
        
        local Call = 0
        
        local Net = {
            ['FireServer'] = function(self, arg)
                local Remote = BypassedNet(arg.Type)
                if Remote then
                    arg.Type = nil
                    Remote:FireServer(arg)
                else
                    warn('Alpha X Error, "' .. arg.Type .. '" Remote Is Not Found...')
                end
            end,
            ['InvokeServer'] = function(self, arg)
                local Remote = BypassedNet(arg.Type, true)
                if Remote then
                    arg.Type = nil
                    local result = Remote:InvokeServer(arg) 
                    return result
                else
                    warn('Alpha X Error, "' .. arg.Type .. '" Remote Is Not Found...')
                end
            end
        }
        
        local Handler = Network.Modules.GUIHandler
        local Notification = Network.Modules.NotificationHandler
        local JobManager = Network.Modules.JobManager
        local GameVersion = player.PlayerGui.MainGUI.VersionLabel.Text 
        
        if GameVersion ~= ScriptVersion then
            Notification:CreateNotification('Warnings', nil, 'Looks like Bloxburg has been updated.\nThis script has has not been tested yet and might pose a ban risk!') 
        end
        if getgenv().fluxus_loaded then
            Notification:CreateNotification('Warning', nil, 'Fluxus Detected! You might get banned due to the executor lacking getconnections!') 
        end
        
        wait()
        
        
        --Teleport
        local ToPlotQueue = {}
        
        function ToPlot(player)
            local done = false
            table.insert(ToPlotQueue, { 
                player = player, 
                callback = function()
                    done = true
                end
            })
            repeat wait() until done
        end
        
        spawn(function()
            while wait() do
                if ToPlotQueue[1] then
                    local player = ToPlotQueue[1].player
                    to, cooldown = Net:InvokeServer({
                        Type = "ToPlot", 
                        Player = player
                    })
                    if to then
                        player.Character:SetPrimaryPartCFrame(to)
                        ToPlotQueue[1].callback()
                        wait(cooldown)
                    end
                    table.remove(ToPlotQueue, 1)
                end
            end
        end)
        
        local ToWorkQueue = {}
        
        function ToWork(place)
            table.insert(ToWorkQueue, place)
        end
        
        spawn(function()
            while wait() do
                if ToWorkQueue[1] then
                    local place = ToWorkQueue[1]
                    to, cooldown = Net:InvokeServer({
                        Type = "ToWork", 
                        Name = place
                    })
                    if to then
                        player.Character:SetPrimaryPartCFrame(to)
                        wait(cooldown)
                    end
                    table.remove(ToWorkQueue, 1)
                end
            end
        end)
        --End
        
        local backup = Network.task.run
        Network.task.run = newcclosure(function(t, ...)
            local const = getconstants(t)
            if table.find(const, 'EndShift') then
                wait(9e9)
            else
                return backup(t, ...)
            end
        end)
        
        local function tweenPosition(Destination_CFrame)
            local Speed = 1
            Speed = player.Character.Humanoid.WalkSpeed
        
            local oldgravity = game.Workspace.Gravity
            game.Workspace.Gravity = 0
        
            local tween = TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new(((player.Character.HumanoidRootPart.Position - Destination_CFrame.p).Magnitude / Speed), Enum.EasingStyle.Linear), {CFrame = Destination_CFrame})
            tween:Play()
            tween.Completed:wait()
        
            game.Workspace.Gravity = oldgravity
        end
        
        local function _autodrive(Pos)
            print("Teleporting...")
            local Speed = 1
            if player.Character:FindFirstChildOfClass('Model') then
                Speed = Network.Shared.VehicleHandler.VehicleData[string.split(player.Character:FindFirstChildOfClass('Model').Name, '_')[2]].ForwardSpeed
            else
                Speed = player.Character.Humanoid.WalkSpeed
            end
        
            --local oldgravity = game.Workspace.Gravity
            
            
            local function teleport(TargetFrame)
                local Teleporter = Instance.new('CFrameValue')
        
                Teleporter.Value = player.Character.HumanoidRootPart.CFrame
        
                Teleporter.Changed:Connect(function()
                    player.Character:SetPrimaryPartCFrame(Teleporter.Value)
                end)
            
                local tween = TweenService:Create(Teleporter, TweenInfo.new(((player.Character.HumanoidRootPart.Position - TargetFrame.p).Magnitude / (Speed*1)), Enum.EasingStyle.Linear), {Value = TargetFrame})
                tween:Play()
                tween.Completed:wait()
                Teleporter:Destroy()
                
            end
            local total_mass = 0
            for i, v in pairs(player.Character:GetDescendants()) do
                if v:IsA("Union") or v:IsA("BasePart") then
                    total_mass = total_mass + v.Mass
                end
            end
            local nograv = Instance.new("BodyForce", player.Character.HumanoidRootPart)
            nograv.Force = Vector3.new(0, total_mass*game.Workspace.Gravity, 0)
            local Origin = player.Character.HumanoidRootPart.CFrame
            player.Character:SetPrimaryPartCFrame(CFrame.new(Origin.X, -50, Origin.Z))
            wait(.1)
            teleport(CFrame.new(Pos.X, -50, Pos.Z))
            nograv:Destroy()
            wait(.1)
            player.Character:SetPrimaryPartCFrame(CFrame.new(Pos))
            
           
            --game.Workspace.Gravity = oldgravity
            print("Teleported")
        end
        local function AutoDrive(pos)
            local success, result = pcall(_autodrive, pos)
            if not success then
                warn("Teleport Failure: ", result)
            end
        end
        
        local Job = nil
        spawn(function()
            wait(1)
            while wait(1) do
                local new = JobManager.GetJob()
                if Job ~= new then
                    Job = new
                    if Job == nil then
                        wait()
                        Notification:CreateNotification('Job', nil, "Detected Job Changes, You do not currently have a job.")
                    else
                        wait()
                        Notification:CreateNotification('Job', nil, 'Detected Job Changes, New Job is ' .. tostring(Job))
                    end
                end
            end
        end)

        local PlayersList = {}
        local loadplayerbox
        local targetplayerbox

        for i,v in next, Players:GetPlayers() do 
            table.insert(PlayersList, v.Name)
        end
        
        do --Auto Build
            --[[
            local Build = UI_Init:Tab("Auto Build", 'https://www.roblox.com/asset/?id=6034275725')
        
            function EncodeC(encode)
                return {encode:components()}
            end
            function DecodeC(decode)
                return CFrame.new(unpack(decode))
            end
        
            function EncodeV(encode)
                return {encode.X, encode.Y, encode.Z}
            end
            function DecodeV(decode)
                return Vector3.new(unpack(decode))
            end

            Build:Line()
            Build:Label('AutoBuild - Save')
            
            
            local SavePlayer = player.Name
        
            --
            --local savedelay = 0
            --Build:Slider('Threshold (ms)', "Sets save delay", 0, 1000, 0, function(value)
            --    savedelay = tonumber(value)/1000
            --end)
            
        
            targetplayerbox = Build:Dropdown('Target Player', PlayersList, function(value)
                SavePlayer = value
            end)
        
            Build:Button("Save Target's Base", "Saves target's base", function()
                local Plot = workspace.Plots:FindFirstChild('Plot_' .. SavePlayer)
                if not Plot then
                    Notification:CreateNotification('Error', nil, 'Wrong Player Name')
                    return
                end
                if Plot:FindFirstChild('LODModel') then
                    Notification:CreateNotification('Error', nil, "Please go closer to target's base to save.")
                    return
                end
                local keep = Handler.ConfirmBox(nil, 'Do you really want to save this base?', 'Info', 3)
                if not keep then
                    return
                end
                function GetSaveVector(CF)
                    local CF = Network.Shared.ObjectManager:RoundToSaveResolution(CFrame.new(CF)).p
                    return EncodeV(Plot.Water.CFrame:PointToObjectSpace(CF))
                end
                function GetSaveCFrame(CF)
                    local CF = Network.Shared.ObjectManager:RoundToSaveResolution(CF)
                    return EncodeC(Plot.Water.CFrame:ToObjectSpace(CF))
                end
        
                local money = 0
        
                local Total = {}
        
                local Walls = {}
                local Floors = {}
                local Roofs = {}
                local Fences = {}
                local Counters = {}
                local Objects = {}
                local Basements = {}
                local Pools = {}
                local Paths = {}
        
                local FrontObject = {
                    Objects = {}
                }
                
                local function getColorData(object)
                    local Name = {}
                    local Number = Network.Shared.ObjectManager:GetAppearanceData(object)
                    for i, v in pairs(Number) do
                        if #v == 0 then
                            Name[i] = {}
                        else
                            local insert = {}
                            insert[1] = BrickColor.new(tonumber(v[1])).Name
                            if tonumber(v[2]) == 0 then
                                insert[2] = 0
                            else
                                insert[2] = Network.Shared.MaterialData:GetMaterialFromID(tonumber(v[2])).Name
                            end
                            Name[i] = insert
                        end
                    end
                    return Name
                end
                
                print("[Alpha X /DEBUG]: Saving Walls")

                for i, v in pairs(Plot.House.Walls:GetChildren()) do
                    --if savedelay ~= 0 then
                    --    wait(savedelay)
                    -- end
                    if v.Name == 'Wall' then
                        local insertval = {}
                        local from, to = Network.Shared.WallHandler:GetWallEdges(v)
                        insertval['From'] = GetSaveVector(from)
                        insertval['To'] = GetSaveVector(to)
                        local R = getColorData(v.RPart)[1]
                        local L = getColorData(v.LPart)[2]
                        insertval['Color'] = 
                        {
                            ['L'] = R, 
                            ['R'] = L
                        }
                        money = money + Network.Shared.PlotHandler:GetObjectValue(v)
                        if v:FindFirstChild('ItemHolder') then
                            local Objects = {}
                
                            for j, k in pairs(v.ItemHolder:GetChildren()) do
                                if k:IsA'BasePart' then
                                    local object = {}
                                    object['Name'] = k.Name
                                    object['Color'] = getColorData(k)
                                    object['CF'] =  GetSaveCFrame(k.CFrame)
                                    object['Side'] = k.SideValue.Value == 1
                                    money = money + Network.Shared.PlotHandler:GetObjectValue(k)
                                    table.insert(Objects, object)
                                end
                            end
                            insertval['Objects'] = Objects
                        end
                        
                        table.insert(Walls, insertval)
                    end
                end

                print("[Alpha X /DEBUG]: Saving Floors")
                for i, v in pairs(Plot.House.Floor:GetChildren()) do
                    --if savedelay ~= 0 then
                    --    wait(savedelay)
                    --end
                    local inputval = {}
                    local points = {}
                    for j, k in pairs(v.PointData:GetChildren()) do
                        local CF = k.Value
                        table.insert(points, GetSaveVector(Plot.Ground.CFrame:PointToWorldSpace(CF) + Vector3.new(0, 0.05, 0)))
                    end
                    inputval['Points'] = points
                    money = money + Network.Shared.PlotHandler:GetObjectValue(v)
                    inputval['Color'] = getColorData(v)
                    if v:FindFirstChild('ItemHolder') then
                        local Objects = {}
            
                        for j, k in pairs(v.ItemHolder:GetChildren()) do
                            if k:IsA'BasePart' then
                                local object = {}
                                object['Name'] = k.Name
                                object['Color'] = getColorData(k)
                                object['CF'] =  GetSaveCFrame(k.CFrame)
                                money = money + Network.Shared.PlotHandler:GetObjectValue(k)
                                table.insert(Objects, object)
                            end
                        end
                        inputval['Objects'] = Objects
                    end
                    table.insert(Floors, inputval)
                end
                
                print("[Alpha X /DEBUG]: Saving Roofs")
                for i, v in pairs(Plot.House.Roof:GetChildren()) do
                    --if savedelay ~= 0 then
                    --    wait(savedelay)
                    --end
                    local inputval = {}
                    local points = {}
                    for j, k in pairs(v.PointData:GetChildren()) do
                        local CF = k.Value
                        table.insert(points, GetSaveVector(Plot.Ground.CFrame:PointToWorldSpace(CF) + Vector3.new(0, 0.05, 0)))
                    end
                    inputval['Points'] = points
                    inputval['Settings'] = {
                        ['Type'] = v.Name,
                        ['IsPreview'] = false,
                        ['RotateNum'] = 0
                    }
                    for i, v in pairs(v.PropertyData:GetChildren()) do
                        inputval['Settings'][v.Name] = v.Value
                    end
                    money = money + Network.Shared.PlotHandler:GetObjectValue(v)
                    inputval['Color'] = getColorData(v)
                    if v:FindFirstChild('ItemHolder') then
                        local Objects = {}
            
                        for j, k in pairs(v.ItemHolder:GetChildren()) do
                            if k:IsA'BasePart' then
                                local object = {}
                                object['Name'] = k.Name
                                object['Color'] = getColorData(k)
                                object['CF'] =  GetSaveCFrame(k.CFrame)
                                money = money + Network.Shared.PlotHandler:GetObjectValue(k)
                                table.insert(Objects, object)
                            end
                        end
                        inputval['Objects'] = Objects
                    end
                    table.insert(Roofs, inputval)
                end
                
                print("[Alpha X /DEBUG]: Saving Fences")
                for i, v in pairs(Plot.House.Fences:GetChildren()) do
                    --if savedelay ~= 0 then
                    --    wait(savedelay)
                    --end
                    if v.Name ~= 'Poles' then
                        local inputval = {}
                        local from, to = Network.Shared.FenceHandler:GetEdges(v)
                        inputval['From'] = GetSaveVector(from.p)
                        inputval['To'] = GetSaveVector(to.p)
                        inputval['Name'] = v.Name
                        inputval['Color'] = getColorData(v)
                        money = money + Network.Shared.PlotHandler:GetObjectValue(v)
                        if v:FindFirstChild('ItemHolder') then
                            local Objects = {}
                
                            for j, k in pairs(v.ItemHolder:GetChildren()) do
                                if k:IsA'BasePart' then
                                    local object = {}
                                    object['Name'] = k.Name
                                    object['CF'] =  GetSaveCFrame(k.CFrame)
                                    money = money + Network.Shared.PlotHandler:GetObjectValue(k)
                                    object['Color'] = getColorData(k)
                                    table.insert(Objects, object)
                                end
                            end
                            inputval['Objects'] = Objects
                        end
                        table.insert(Fences, inputval)
                    end
                end
                
                print("[Alpha X /DEBUG]: Saving Counters")
                for i, v in pairs(Plot.House.Counters:GetChildren()) do
                    --if savedelay ~= 0 then
                    --    wait(savedelay)
                    --end
                    local inputval = {}
                    inputval['Name'] = v.Name
                    inputval['CF'] = GetSaveCFrame(v.CFrame) 
                    money = money + Network.Shared.PlotHandler:GetObjectValue(v)
                    inputval['Color'] = getColorData(v)
                    if v:FindFirstChild('ItemHolder') then
                        local Objects = {}
                
                        for j, k in pairs(v.ItemHolder:GetChildren()) do
                            if k:IsA'BasePart' then
                                local object = {}
                                object['Name'] = k.Name
                                object['CF'] =  GetSaveCFrame(k.CFrame)
                                object['Color'] = getColorData(k)
                                money = money + Network.Shared.PlotHandler:GetObjectValue(k)
                                table.insert(Objects, object)
                            end
                        end
                        inputval['Objects'] = Objects
                    end
                    table.insert(Counters, inputval)
                end
                
                print("[Alpha X /DEBUG]: Saving Loose Objects")
                for i, v in pairs(Plot.House.Objects:GetChildren()) do
                    --if savedelay ~= 0 then
                    --    wait(savedelay)
                    --end
                    local inputval = {}
                    inputval['Name'] = v.Name
                    inputval['Color'] = getColorData(v)
                    inputval['CF'] = GetSaveCFrame(v.CFrame)
                    money = money + Network.Shared.PlotHandler:GetObjectValue(v)
                    if v:FindFirstChild('ItemHolder') then
                        local Objects = {}
                
                        for j, k in pairs(v.ItemHolder:GetChildren()) do
                            if k:IsA'BasePart' then
                                local object = {}
                                object['Name'] = k.Name
                                object['Color'] = getColorData(k)
                                object['CF'] =  GetSaveCFrame(k.CFrame)
                                money = money + Network.Shared.PlotHandler:GetObjectValue(k)
                                table.insert(Objects, object)
                            end
                        end
                        inputval['Objects'] = Objects
                    end
                    table.insert(Objects, inputval)
                end
                
                print("[Alpha X /DEBUG]: Saving Basements")
                for i, v in pairs(Plot.House.Basements:GetChildren()) do
                    --if savedelay ~= 0 then
                    --    wait(savedelay)
                    --end
                    local object = {}
                    object['Name'] = v.Name
                    object['Center'] = GetSaveCFrame(v.PrimaryPart.CFrame)
                    object['Size'] = { v.PrimaryPart.Size.X, v.PrimaryPart.Size.Z }
                    money = money + Network.Shared.PlotHandler:GetObjectValue(v)
                    if v:FindFirstChild('ItemHolder') then
                        local Objects = {}
            
                        for j, k in pairs(v.ItemHolder:GetChildren()) do
                            if k:IsA'BasePart' then
                                local object = {}
                                object['Name'] = k.Name
                                object['Color'] = getColorData(k)
                                object['CF'] =  GetSaveCFrame(k.CFrame)
                                money = money + Network.Shared.PlotHandler:GetObjectValue(k)
                                table.insert(Objects, object)
                            end
                        end
                        object['Objects'] = Objects
                    end
                    table.insert(Basements, object)
                end
                
                print("[Alpha X /DEBUG]: Saving Pools")
                for i, v in pairs(Plot.House.Pools:GetChildren()) do
                    --if savedelay ~= 0 then
                    --    wait(savedelay)
                    --end
                    local object = {}
                    object['Name'] = v.Name
                    object['Center'] = GetSaveCFrame(v.PrimaryPart.CFrame)
                    object['Size'] = { v.PrimaryPart.Size.X, v.PrimaryPart.Size.Z }
                    money = money + Network.Shared.PlotHandler:GetObjectValue(v)
                    if v:FindFirstChild('ItemHolder') then
                        local Objects = {}
            
                        for j, k in pairs(v.ItemHolder:GetChildren()) do
                            if k:IsA'BasePart' then
                                local object = {}
                                object['Name'] = k.Name
                                object['Color'] = getColorData(k)
                                object['CF'] =  GetSaveCFrame(k.CFrame)
                                money = money + Network.Shared.PlotHandler:GetObjectValue(k)
                                table.insert(Objects, object)
                            end
                        end
                        object['Objects'] = Objects
                    end
                    table.insert(Pools, object)
                end
                
                print("[Alpha X /DEBUG]: Saving Paths")
                for i, v in pairs(Plot.House.Paths:GetChildren()) do
                    --if savedelay ~= 0 then
                    --    wait(savedelay)
                    --end
                    if v.Name ~= 'Poles' then
                        local object = {}
                        object['Name'] = v.Name
                        object['Color'] = getColorData(v)
                        object['To'] = GetSaveVector(v.BPole.Value.Parent.Position)
                        object['From'] = GetSaveVector(v.FPole.Value.Parent.Position)
                        money = money + Network.Shared.PlotHandler:GetObjectValue(v)
                        if v:FindFirstChild('ItemHolder') then
                            local Objects = {}
                
                            for j, k in pairs(v.ItemHolder:GetChildren()) do
                                if k:IsA'BasePart' then
                                    local object = {}
                                    object['Name'] = k.Name
                                    object['Color'] = getColorData(k)
                                    object['CF'] =  GetSaveCFrame(k.CFrame)
                                    money = money + Network.Shared.PlotHandler:GetObjectValue(k)
                                    table.insert(Objects, object)
                                end
                            end
                            object['Objects'] = Objects
                        end
                        table.insert(Paths, object)
                    end
                end
        
                Total['FrontObjects'] = {
                    Move = nil,
                    Objects = {}
                }
                
                Total['Walls'] = Walls
                Total['Floors'] = Floors
                Total['Roofs'] = Roofs
                Total['Counters'] = Counters
                Total['Fences'] = Fences
                Total['Objects'] = Objects
                Total['Basements'] = Basements
                Total['Pools'] = Pools
                Total['Paths'] = Paths
        
                Total['Money'] = money
        
                Total['FileVersion'] = SaveLoaderVersion
        
                Total['user_id'] = player.UserId

                print("[Alpha X /DEBUG]: Uploading Base...")
                local Response = HttpService:JSONDecode(request({
                    Url = 'https://api.applebee1558.com/alphax/v2/bloxburg_bases',
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = game.HttpService:JSONEncode(Total)
                }).Body)
        
                print("[Alpha X /DEBUG]: Uploading Done!")
                if Response.code == 200 then
                    setclipboard(tostring(Response.inserted_id))
                    Notification:CreateNotification('Success', nil, 'Saved The Base!\nSaved Base ID : '..tostring(Response.inserted_id)..'\nMoney Reqired : ' .. tostring(money) .. '\nBase ID Copied To Clipboard')
                elseif Response.code == 5002 then
                    setclipboard(tostring(Response.existing_id))
                    Notification:CreateNotification('Info', nil, 'The base you are trying to save already exists!\nExisting Base ID : '..tostring(Response.existing_id)..'\nBase ID Copied To Your Clipboard.')
                elseif Response.code == 5000 then
                    warn(game.HttpService:JSONEncode(Response))
                    Notification:CreateNotification('Error', nil, 'Failed to save the base!\nReport to applebee#3071.')
                elseif Response.code == 404 then
                    Notification:CreateNotification('Error', nil, 'Failed to find API.\nReport to applebee#3071')
                else
                    warn(game.HttpService:JSONEncode(Response))
                    if Response.message then
                        Notification:CreateNotification('API-Error', nil, 'Internal API Error!\nMessage: '..Response.message.."\nCode: "..tostring(Response.code).."\nPlease report this to applebee#3071")
                    else
                        Notification:CreateNotification('API-Error', nil, 'Internal API Error: Press F9, Screenshot, and report to applebee#3071')
                    end
                end
            end)
            
            Build:Line()
            Build:Label('AutoBuild - Load')
            Build:Label('AutoBuild loading is removed! You can use BET for autobuild, join their Discord at https://discord.gg/ugBAUkh3yB')
            ]]

            --[[
            local counter = 1
            local function build_wait()
                counter = counter + 1
                if counter > 4 then
                    wait(3)
                    counter = 1
                end
            end
            
            local LoadPlayer = player.Name
            local LoadName = ''
            local loaddelay = 0
            local UseBloxbucks = true
            local MethodToLoad = 1
            local IDBox
        
            
            Build:Slider('Threshold (ms)', "Sets load delay", 0, 1000, 0, function(value)
                loaddelay = tonumber(value)/1000
            end)
            

            IDBox = Build:Textbox('ID', "Build ID to load", false, function(value)
                LoadName = value
            end)
        
            
            loadplayerbox = Build:Dropdown('Target Player', PlayersList, function(value)
                LoadPlayer = value
            end, true)
        
            Build:Toggle('Use Bloxbucks', 'Uses blockbux during loading', true, function(value)
                UseBloxbucks = value
            end)
        
        
            Build:Button('Load Base', 'Loads the Base', function()      
                local Plot = workspace.Plots:FindFirstChild('Plot_' .. LoadPlayer)
                if not Plot then
                    Notification:CreateNotification('Error', nil, 'Wrong Player Name')
                    return
                end
                if (not pcall(function() a = readfile(LoadName .. '.axb') end)) and (MethodToLoad == 2) then
                    Notification:CreateNotification('Error', nil, 'File does not exist')
                    return
                end
                local json
                if MethodToLoad == 2 then
                    json = readfile(LoadName .. '.axb')
                else
                    json = request({
                        Url = 'https://api.applebee1558.com/alphax/v2/bloxburg_bases/' .. tostring(LoadName)
                    }).Body
                end
                local Table = game.HttpService:JSONDecode(json)
                if MethodToLoad == 1 then
                    if Table.code == 5003 then
                        Notification:CreateNotification('Error', nil, 'Base ID does not exist!')
                        return
                    elseif Table.code == 400 then
                        Notification:CreateNotification('Error', nil, 'Base ID is invalid!')
                        return
                    elseif Table.code == 5004 then
                        Notification:CreateNotification('Error', nil, 'The base you are trying to load is suspended!')
                        return
                    elseif Table.base_payload == nil then
                        if Table.message then
                            Notification:CreateNotification('Error', nil, 'API Error: '..Table.message.." | Code: "..tostring(Table.code))
                            return
                        end
                        Notification:CreateNotification('Error', nil, 'API Error! Contact applebee#3071')
                        return
                    end 
                    Table = Table.base_payload
                end 
        
                if Table.FileVersion ~= SaveLoaderVersion then
                    Notification:CreateNotification('Error', nil, 'File version does not match with script!')
                    return
                end
        
                if tostring(Network.Shared.PlotHandler:GetBuildPlot(Player)) ~= ('Plot_' .. LoadPlayer) then
                    Notification:CreateNotification('Error', nil, "Please enter build mode in ".. LoadPlayer .."'s plot first before auto-building!")
                    return
                end
        
                if ReplicatedStorage.Stats[LoadPlayer].Money.Value < Table.Money then
                    local Countiune = Handler.ConfirmBox(nil, "You don't have enough money to load this base.\nThis base will not be loaded fully.\n You need " .. tostring(Table.Money - ReplicatedStorage.Stats[player.Name].Money.Value) .. '$ more to load this base fully.\nDo you still want to load?', 'Error', 0)
                    if not Countiune then
                        return
                    end
                end
        
                local BSPrice = 0
                for i, v in pairs(Table.Objects) do
                    if Network.Items:GetItem(v.Name).BSPrice then
                        BSPrice = BSPrice + Network.Items:GetItem(v.Name).BSPrice
                    end
                end
        
                local Text = "Do you really want to load this base?\nMoney Required: $" .. tostring(Table.Money - BSPrice) .. '\nSell Value: $' .. tostring(round(Table.Money * Network.Shared.PlotHandler.SellPercentage)) 
                if UseBloxbucks and (BSPrice ~= 0) then
                    Text = Text .. '\nBloxbucks Value : ' .. tostring(BSPrice)
                end
                local keep = Handler.ConfirmBox(nil, Text..'\nUse '..tostring(BSPrice)..'Bloxbucks for this build?\nNote: This house may need gamepasses!', 'Info', 3)
                if not keep then
                    return
                end
        
                function GetLoadVector(CF)
                    return (Plot.Water.CFrame:PointToWorldSpace(DecodeV(CF)))
                end
                function GetLoadCFrame(CF)
                    return (Plot.Water.CFrame:ToWorldSpace(DecodeC(CF)))
                end
                
                function getFloor(position)
                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterType = Enum.RaycastFilterType.Whitelist
                    raycastParams.FilterDescendantsInstances = {Plot}
                    raycastParams.IgnoreWater = true
                    local FloorPart = game.Workspace:Raycast(position, Vector3.new(0, -100, 0), raycastParams)
                    local Instance
                    if FloorPart then
                        if FloorPart.Instance then
                            Instance = FloorPart.Instance
                            if (Instance.Parent ~= Plot.GroundParts) and (Instance.Parent ~= Plot) then
                                if Instance.Parent then
                                    while Instance.Parent.Parent ~= Plot.House do
                                        Instance = Instance.Parent
                                    end
                                else
                                    return Plot.PrimaryPart
                                end
                            end
                        else
                            --warn('Debug. Returned Ground (Case 2)')
                            return Plot.PrimaryPart
                        end
                    else
                        --warn('Debug. Returned Ground (Case 3)')
                        return Plot.PrimaryPart
                    end
                    --warn('Debug. Returned ' .. Instance:GetFullName())
                    return Instance
                end
                
                function getRotFromCFrame(CF)
                    local value = -atan2(CF.lookVector.z, CF.lookVector.x) - pi * 0.5
                    if value < 0 then
                        value = 2 * pi + value
                    end
                    return value
                end
                
                function ColorArgs(origin)
                    local obj = {}
                    for i = 1, 4 do
                        if origin[i] and (#origin[i] ~= 0) then
                            obj[i] = {}
                            if origin[i][1] ~= 0 then
                                obj[i][1] = BrickColor.new(origin[i][1]).Number
                            else
                                obj[i][1] = 0
                            end
                            if origin[i][2] ~= 0 then
                                if Network.Shared.MaterialData.Materials[tostring(origin[i][2])] then
                                    obj[i][2] = Network.Shared.MaterialData.Materials[tostring(origin[i][2])].ID
                                else
                                    obj[i][2] = 0
                                end
                            else
                                obj[i][2] = 0
                            end
                        else
                            obj[i] = {}
                        end
                    end
                    return obj
                end
                
                function IsPlaceAble(ItemName)
                    local Item = Network.Items:GetItem(ItemName)
                    if Item then
                        if Item.Price or Item.BSPrice then
                            if Item.Hidden then
                                return false
                            end
                            if Item.BSPrice then
                                if not UseBloxbucks then
                                    warn('Skipped '.. ItemName .. ' because you chose to not use bloxbucks!')
                                    return false
                                end
                            end
                            if Network.Shared.ItemManager:IsLocked(Item, Player) then
                                warn('Skipped ' .. ItemName .. '. Because of your skill levels.')
                                return false
                            end
                            return true
                        end
                    end
                    return false
                end
                
                
                function waitDelay()
                    if loaddelay == 0 then
                        if random(1, 5) == 1 then
                            RunService.Stepped:Wait()
                        else
                            wait(0)
                        end
                    else
                        wait(loaddelay)
                    end
                end
                
                local function waitDelay()
                    return build_wait()
                end
        
                local OldMoney = ReplicatedStorage.Stats[LoadPlayer].Money.Value
        
                local Failed = 0
        
                local Completed = {}
        
                if Table.FrontObjects then
                    Net:InvokeServer({
                        ['Type'] = 'MoveFrontObjects',
                        ['Pos'] = Table.FrontObjects.Move
                    })
                end
        
                Completed['Floors'] = 0
                spawn(function()
                    for i, v in pairs(Table.Floors) do
                        waitDelay()
                        spawn(function()
                            local LoadPoints = {}
                            for j, k in pairs(v.Points) do 
                                table.insert(LoadPoints, GetLoadVector(k))
                            end
                            local get, money = Net:InvokeServer({
                                ['Type'] = 'PlaceFloor',
                                ['Points'] = LoadPoints
                            })
                            Completed['Floors'] = Completed['Floors'] + 1
                            if not get then
                                Failed = Failed + 1
                            end
                            Net:InvokeServer({
                                ['Type'] = 'ColorObject',
                                ['Object'] = get,
                                ['UseMaterials'] = true,
                                ['Data'] = ColorArgs(v.Color),
                            })
                            if v.Objects then
                                for j, k in pairs(v.Objects) do
                                    if IsPlaceAble(k.Name) then
                                        if not k.Side then 
                                            k.Side = true
                                        end
                                        local object, money = Net:InvokeServer({
                                            ['Type'] = 'PlaceObject',
                                            ['Name'] = k.Name,
                                            ['Side'] = k.Side,
                                            ['TargetModel'] = get,
                                            ['Pos'] = GetLoadCFrame(k.CF).p,
                                            ['Rot'] = getRotFromCFrame(GetLoadCFrame(k.CF)) 
                                        })
                                        Net:InvokeServer({
                                            ['Type'] = 'ColorObject',
                                            ['Object'] = object,
                                            ['UseMaterials'] = true,
                                            ['Data'] = ColorArgs(k.Color),
                                        })
                                    end
                                end
                            end
                        end)
                    end
                end)
        
                repeat waitDelay() until (#Table.Floors == Completed['Floors'])
        
                Completed['Basements'] = 0
                spawn(function()
                    for i, v in pairs(Table.Basements) do
                        waitDelay()
                        spawn(function()
                            local OriginalPosition = Plot.Ground.CFrame:ToObjectSpace(GetLoadCFrame(v.Center))
                            local OriginalTable = {OriginalPosition:components()}
                            OriginalTable[2] = 0.0000001
                            local NewPosition = CFrame.new(unpack(OriginalTable))
        
                            local get, money = Net:InvokeServer({
                                ['Type'] = 'PlaceBasement',
                                ['ItemType'] = 'Basements',
                                ['Center'] = NewPosition,
                                ['Size'] = Vector2.new(unpack(v.Size))
                            })
        
                            Completed['Basements'] = Completed['Basements'] + 1
                            if not get then
                                Failed = Failed + 1
                            end
                            if v.Objects then
                                for j, k in pairs(v.Objects) do
                                    if IsPlaceAble(k.Name) then
                                        if not k.Side then 
                                            k.Side = true
                                        end
                                        local object, money = Net:InvokeServer({
                                            ['Type'] = 'PlaceObject',
                                            ['Name'] = k.Name,
                                            ['Side'] = k.Side,
                                            ['TargetModel'] = get,
                                            ['Pos'] = GetLoadCFrame(k.CF).p,
                                            ['Rot'] = getRotFromCFrame(GetLoadCFrame(k.CF)) 
                                        })
                                        Net:InvokeServer({
                                            ['Type'] = 'ColorObject',
                                            ['Object'] = object,
                                            ['UseMaterials'] = true,
                                            ['Data'] = ColorArgs(k.Color),
                                        })
                                    end
                                end
                            end
                        end)
                    end
                end)
        
                Completed['Walls'] = 0
                spawn(function()
                    for i, v in pairs(Table.Walls) do
                        waitDelay()
                        spawn(function()
                            local get, money = Net:InvokeServer({
                                ['Type'] = 'PlaceWall',
                                ['To'] = GetLoadVector(v.To),
                                ['From'] = GetLoadVector(v.From)
                            })
                            if not get then
                                Failed = Failed + 1
                            end
                            Completed['Walls'] = Completed['Walls'] + 1
                            if #v.Color.R == 2 then
                                Net:InvokeServer({
                                    ['Type'] = 'ColorObject',
                                    ['Object'] = get,
                                    ['UseMaterials'] = true,
                                    ['Data'] = ColorArgs({v.Color.R}),
                                    ['Side'] = 'R'
                                })
                                Net:InvokeServer({
                                    ['Type'] = 'ColorObject',
                                    ['Object'] = get,
                                    ['UseMaterials'] = true,
                                    ['Data'] = ColorArgs({v.Color.L}),
                                    ['Side'] = 'L'
                                })
                            else
                                Net:InvokeServer({
                                    ['Type'] = 'ColorObject',
                                    ['Object'] = get,
                                    ['UseMaterials'] = true,
                                    ['Data'] = ColorArgs(v.Color.R),
                                    ['Side'] = 'R'
                                })
                                Net:InvokeServer({
                                    ['Type'] = 'ColorObject',
                                    ['Object'] = get,
                                    ['UseMaterials'] = true,
                                    ['Data'] = ColorArgs(v.Color.L),
                                    ['Side'] = 'L'
                                })
                            end
                            if not get then
                                return
                            end
                            if v.Objects then
                                for j, k in pairs(v.Objects) do
                                    if IsPlaceAble(k.Name) then
                                        if not k.Side then 
                                            k.Side = true
                                        end
                                        local object, money = Net:InvokeServer({
                                            ['Type'] = 'PlaceObject',
                                            ['Name'] = k.Name,
                                            ['Side'] = k.Side,
                                            ['TargetModel'] = get,
                                            ['Pos'] = GetLoadCFrame(k.CF).p,
                                            ['Rot'] = getRotFromCFrame(GetLoadCFrame(k.CF)) 
                                        })
                                        Net:InvokeServer({
                                            ['Type'] = 'ColorObject',
                                            ['Object'] = object,
                                            ['UseMaterials'] = true,
                                            ['Data'] = ColorArgs(k.Color),
                                        })
                                    end
                                end
                            end
                        end)
                    end
                end)
        
                Completed['Roofs'] = 0
                spawn(function()
                    for i, v in pairs(Table.Roofs) do
                        waitDelay()
                        spawn(function()
                            local LoadPoints = {}
                            for j, k in pairs(v.Points) do 
                                table.insert(LoadPoints, GetLoadVector(k))
                            end
                            local get, money = Net:InvokeServer({
                                ['Type'] = 'PlaceRoof',
                                ['Settings'] = v.Settings,
                                ['Start'] = LoadPoints[1],
                                ['Points'] = LoadPoints
                            })
                            Completed['Roofs'] = Completed['Roofs'] + 1
                            if not get then
                                Failed = Failed + 1
                            end
                            Net:InvokeServer({
                                ['Type'] = 'ColorObject',
                                ['Object'] = get,
                                ['UseMaterials'] = true,
                                ['Data'] = ColorArgs(v.Color),
                            })
                            if v.Objects then
                                for j, k in pairs(v.Objects) do
                                    if IsPlaceAble(k.Name) then
                                        if not k.Side then 
                                            k.Side = true
                                        end
                                        local object, money = Net:InvokeServer({
                                            ['Type'] = 'PlaceObject',
                                            ['Name'] = k.Name,
                                            ['Side'] = k.Side,
                                            ['TargetModel'] = get,
                                            ['Pos'] = GetLoadCFrame(k.CF).p,
                                            ['Rot'] = getRotFromCFrame(GetLoadCFrame(k.CF)) 
                                        })
                                        Net:InvokeServer({
                                            ['Type'] = 'ColorObject',
                                            ['Object'] = object,
                                            ['UseMaterials'] = true,
                                            ['Data'] = ColorArgs(k.Color),
                                        })
                                    end
                                end
                            end
                        end)
                    end
                end)
                
                Completed['Fences'] = 0
                spawn(function()
                    for i, v in pairs(Table.Fences) do
                        waitDelay()
                        spawn(function()
                            local get, money = Net:InvokeServer({
                                ['Type'] = 'PlaceFence',
                                ['To'] = GetLoadVector(v.To),
                                ['From'] = GetLoadVector(v.From),
                                ['ItemType'] = v.Name
                            })
                            Completed['Fences'] = Completed['Fences'] + 1
                            Net:InvokeServer({
                                ['Type'] = 'ColorObject',
                                ['Object'] = get,
                                ['UseMaterials'] = true,
                                ['Data'] = ColorArgs(v.Color),
                            })
                            if not get then
                                Failed = Failed + 1
                            end
                            if not get then
                                return
                            end
                            if v.Objects then
                                for j, k in pairs(v.Objects) do
                                    if IsPlaceAble(k.Name) then
                                        local object, money = Net:InvokeServer({
                                            ['Type'] = 'PlaceObject',
                                            ['Name'] = k.Name,
                                            ['TargetModel'] = get,
                                            ['Pos'] = GetLoadCFrame(k.CF).p,
                                            ['Rot'] = getRotFromCFrame(GetLoadCFrame(k.CF))
                                        })
                                        Net:InvokeServer({
                                            ['Type'] = 'ColorObject',
                                            ['Object'] = object,
                                            ['UseMaterials'] = true,
                                            ['Data'] = ColorArgs(k.Color),
                                        })
                                    end
                                end
                            end
                        end)
                    end
                end)
        
                Completed['Pools'] = 0
                spawn(function()
                    for i, v in pairs(Table.Pools) do
                        waitDelay()
                        spawn(function()  
                            local OriginalPosition = Plot.Ground.CFrame:ToObjectSpace(GetLoadCFrame(v.Center))
                            local OriginalTable = {OriginalPosition:components()}
                            OriginalTable[2] = 0.0000001
                            local NewPosition = CFrame.new(unpack(OriginalTable))
        
                            local get, money = Net:InvokeServer({
                                ['Type'] = 'PlacePool',
                                ['Center'] = NewPosition,
                                ['Size'] = Vector2.new(unpack(v.Size)),
                                ['ItemType'] = v.Name
                            })
                            Completed['Pools'] = Completed['Pools'] + 1
                            if not get then
                                Failed = Failed + 1
                            end
                            if v.Objects then
                                for j, k in pairs(v.Objects) do
                                    if IsPlaceAble(k.Name) then
                                        if not k.Side then 
                                            k.Side = true
                                        end
                                        local object, money = Net:InvokeServer({
                                            ['Type'] = 'PlaceObject',
                                            ['Name'] = k.Name,
                                            ['Side'] = k.Side,
                                            ['TargetModel'] = get,
                                            ['Pos'] = GetLoadCFrame(k.CF).p,
                                            ['Rot'] = getRotFromCFrame(GetLoadCFrame(k.CF)) 
                                        })
                                        Net:InvokeServer({
                                            ['Type'] = 'ColorObject',
                                            ['Object'] = object,
                                            ['UseMaterials'] = true,
                                            ['Data'] = ColorArgs(k.Color),
                                        })
                                    end
                                end
                            end
                        end)
                    end
                end)
        
                Completed['Paths'] = 0
                for i, v in pairs(Table.Paths) do
                    waitDelay()
                    spawn(function()
                        local get, money = Net:InvokeServer({
                            ['Type'] = 'PlacePath',
                            ['To'] = GetLoadVector(v.To),
                            ['From'] = GetLoadVector(v.From)
                        })
                        Completed['Paths'] = Completed['Paths'] + 1
                        if not get then
                            Failed = Failed + 1
                        end
                        Net:InvokeServer({
                            ['Type'] = 'ColorObject',
                            ['Object'] = get,
                            ['UseMaterials'] = true,
                            ['Data'] = ColorArgs(v.Color),
                        })
                        if v.Objects then
                            for j, k in pairs(v.Objects) do
                                if IsPlaceAble(k.Name) then
                                    if not k.Side then 
                                        k.Side = true
                                    end
                                    local object, money = Net:InvokeServer({
                                        ['Type'] = 'PlaceObject',
                                        ['Name'] = k.Name,
                                        ['Side'] = k.Side,
                                        ['TargetModel'] = get,
                                        ['Pos'] = GetLoadCFrame(k.CF).p,
                                        ['Rot'] = getRotFromCFrame(GetLoadCFrame(k.CF)) 
                                    })
                                    Net:InvokeServer({
                                        ['Type'] = 'ColorObject',
                                        ['Object'] = object,
                                        ['UseMaterials'] = true,
                                        ['Data'] = ColorArgs(k.Color),
                                    })
                                end
                            end
                        end
                    end)
                end  
        
                repeat waitDelay() until (#Table.Paths == Completed['Paths']) and (#Table.Pools == Completed['Pools']) and  (#Table.Walls == Completed['Walls']) and (#Table.Roofs == Completed['Roofs']) and (#Table.Fences == Completed['Fences']) and (#Table.Basements == Completed['Basements']) 
        
                Completed['Counters'] = 0
                spawn(function()
                    for i, v in pairs(Table.Counters) do
                        waitDelay()
                        spawn(function()
                            if not IsPlaceAble(v.Name) then
                                Completed['Counters'] = Completed['Counters'] + 1
                                return
                            end
                            local get, money = Net:InvokeServer({
                                ['Type'] = 'PlaceObject',
                                ['Rot'] = getRotFromCFrame(GetLoadCFrame(v.CF)),
                                ['Pos'] = GetLoadCFrame(v.CF).p,
                                ['Name'] = v.Name,
                                ['TargetModel'] = getFloor(GetLoadCFrame(v.CF).p)
                            })
                            Completed['Counters'] = Completed['Counters'] + 1
                            if not get then
                                Failed = Failed + 1
                            end
                            Net:InvokeServer({
                                ['Type'] = 'ColorObject',
                                ['Object'] = get,
                                ['UseMaterials'] = true,
                                ['Data'] = ColorArgs(v.Color),
                            })
                            if v.Objects then
                                for j, k in pairs(v.Objects) do
                                    if IsPlaceAble(k.Name) then 
                                        local object, money = Net:InvokeServer({
                                            ['Type'] = 'PlaceObject',
                                            ['Name'] = k.Name,
                                            ['TargetModel'] = get,
                                            ['Pos'] = GetLoadCFrame(k.CF).p,
                                            ['Rot'] = getRotFromCFrame(GetLoadCFrame(k.CF)) 
                                        })
                                        Net:InvokeServer({
                                            ['Type'] = 'ColorObject',
                                            ['Object'] = object,
                                            ['UseMaterials'] = true,
                                            ['Data'] = ColorArgs(k.Color),
                                        })
                                    end
                                end
                            end
                        end)
                    end
                end)
                
                Completed['Objects'] = 0
                spawn(function()
                    for i, v in pairs(Table.Objects) do
                        waitDelay()
                        spawn(function()
                            if not IsPlaceAble(v.Name) then
                                Completed['Objects'] = Completed['Objects'] + 1
                                return
                            end
                            local get, money = Net:InvokeServer({
                                ['Type'] = 'PlaceObject',
                                ['Rot'] = getRotFromCFrame(GetLoadCFrame(v.CF)),
                                ['Pos'] = GetLoadCFrame(v.CF).p,
                                ['Name'] = v.Name,
                                ['TargetModel'] = getFloor(GetLoadCFrame(v.CF).p)
                            })
                            Completed['Objects'] = Completed['Objects'] + 1
                            if not get then
                                Failed = Failed + 1
                            end
                            Net:InvokeServer({
                                ['Type'] = 'ColorObject',
                                ['Object'] = get,
                                ['UseMaterials'] = true,
                                ['Data'] = ColorArgs(v.Color),
                            })
                            if v.Objects then
                                for j, k in pairs(v.Objects) do
                                    if IsPlaceAble(k.Name) then 
                                        local object, money = Net:InvokeServer({
                                            ['Type'] = 'PlaceObject',
                                            ['Name'] = k.Name,
                                            ['TargetModel'] = get,
                                            ['Pos'] = GetLoadCFrame(k.CF).p,
                                            ['Rot'] = getRotFromCFrame(GetLoadCFrame(k.CF)) 
                                        })
                                        Net:InvokeServer({
                                            ['Type'] = 'ColorObject',
                                            ['Object'] = object,
                                            ['UseMaterials'] = true,
                                            ['Data'] = ColorArgs(k.Color),
                                        })
                                    end
                                end
                            end
                        end)
                    end 
                end)
        
                repeat waitDelay() until (#Table.Counters == Completed['Counters']) and (#Table.Objects == Completed['Objects'])
        
                warn('Total Failed : '.. tostring(Failed))
        
                Notification:CreateNotification('Success', nil, 'Load Done.\n(If base is big, you need to wait few more seconds for it to finish)\nThe money you spent for this base is $' .. tostring(OldMoney - ReplicatedStorage.Stats[LoadPlayer].Money.Value) .. '.')
            end)
            ]]
        end
        

        do --AutoFarm
            local Farm = UI_Init:Tab('Auto Farm', "http://www.roblox.com/asset/?id=6034837797")
            Farm:Line()
            Farm:Label("Auto Farm")
            
        
            local Hairdresser = false
            local Burger = false
            local Delivery = false
            local Mechanic = false
            local Baker = false
            local Fisher = false
            local IceCream = false
            local Stocker = false
            local SuperMarket = false
            local WoodCutter = false
            local Cleaner = false
            local Miner = false
        
            Farm:Toggle('Hair Dresser', "Toggles the hairdresser autofarm", false, "HD", function(value)
                Hairdresser = value
            end)
            Farm:Toggle('Pizza Delivery', "Toggles the pizza delivery autofarm", false, "PD", function(value)
                Delivery = value
            end)
            Farm:Toggle('Bloxy Burger Cashier', "Toggles the cashier autofarm", false, "BBC", function(value)
                Burger = value
            end)
            Farm:Toggle('Mike Mechanic', "Toggles the mechanic autofarm", false, "MM", function(value)
                Mechanic = value
            end)
            Farm:Toggle('Pizza Baker', "Toggles the pizza baker autofarm", false, "PB", function(value)
                Baker = value
            end)
            Farm:Toggle('Fisher', "Toggles the fisher autofarm", false, "FS", function(value)
                Fisher = value
            end)
            Farm:Toggle('Ice Cream', "Toggles the ice cream autofarm", false, "IC", function(value)
                IceCream = value
            end)
            Farm:Toggle('Stock Management', "Toggles the stock management autofarm", false, "SM", function(value)
                Stocker = value
            end)
            Farm:Toggle('Super Market Cashier', "Toggles the super market cashier autofarm", false, "SMC", function(value)
                SuperMarket = value
            end)
            Farm:Toggle('Wood Cutter', "Toggles the wood cutter autofarm", false, 'WC', function(value)
                WoodCutter = value
            end)
            Farm:Toggle('Cleaner', "Toggles the janitor autofarm", false, 'CL', function(value)
                Cleaner = value
            end)
            Farm:Toggle('Miner', "Toggles the miner autofarm", false, 'MN', function(value)
                Miner = value
            end)
        
            Farm:Line()
            Farm:Label("Stats")
            
        
            local TimeStat = Farm:Label('Shift Duration : 0', Color3.new(255, 255, 255))
            local MoneyStat = Farm:Label('Shift Earnings : 0', Color3.new(255, 255, 255))

            Farm:Line()
            Farm:Label('Safety')
            
        
            local QuitAmountEnable = false
            local QuitAmount = 10000
            local ShutDown = false
        
            local WorkTime = 0
        
            spawn(function()
                while wait(1) do
                    if Network.Modules.JobManager:IsWorking() then
                        WorkTime = WorkTime + 1
                        TimeStat:Update('Shift Duration : ' .. tostring(WorkTime) .. 's')
                    else
                        WorkTime = 0
                        TimeStat:Update('Shift Duration : 0')
                    end
                end
            end)
        
            spawn(function()
                while wait() do
                    if not Network.Modules.JobManager:IsWorking() then
                        WorkTime = 0
                    end
                end
            end)
        
            Farm:Toggle('Enable Quit After Amount', "Quits job after money earned", false, 'EQAA', function(value)
                QuitAmountEnable = value
            end)
        
            Farm:Textbox('Quit After Amount', "Amount of money to quit job after earning", false, function(value)
                if tonumber(value) then
                    QuitAmount = tonumber(value)
                end
            end)
        
            Farm:Toggle('Quit Game After Amount', "Quit game after money earned", false, 'QGAA', function(value)
                ShutDown = value
            end)
        
            spawn(function()
                local Stats = ReplicatedStorage.Stats[player.Name]
                while wait() do
                    if QuitAmountEnable then
                        if Stats.Job.ShiftEarnings.Value > QuitAmount then
                            ToPlot(Player)
                            wait(.1)
                            Net:FireServer({
                                Type = 'EndShift'
                            })
                            wait(5)
                            if ShutDown then
                                game:Shutdown()
                            end
                            WorkTime = 0
                        end
                    end
                    MoneyStat:Update('Shift Earnings : ' .. tostring(floor(Stats.Job.ShiftEarnings.Value)))
                end
            end) 

            local mt = getrawmetatable(game)
            local oldNamecall = mt.__namecall 
            setreadonly(mt, false)

            mt.__namecall = newcclosure(function(self, ...)
                local args = {...} 

                if (checkcaller() or getexecutorname) and getnamecallmethod() == "FireServer" and args[1].Order and args[1].Workstation then
                    if args[1].Workstation.Parent.Name == "HairdresserWorkstations" and Hairdresser and Job == 'StylezHairdresser' then
            
                        args[1].Order = {
                            args[1].Workstation.Occupied.Value.Order.Style.Value,
                            args[1].Workstation.Occupied.Value.Order.Color.Value
                        }
            
                        return oldNamecall(self, unpack(args))
            
                    elseif args[1].Workstation.Parent.Name == "CashierWorkstations" and Burger and Job == 'BloxyBurgersCashier' then 
            
                        args[1].Order = {
                            args[1].Workstation.Occupied.Value.Order.Burger.Value,
                            args[1].Workstation.Occupied.Value.Order.Fries.Value,
                            args[1].Workstation.Occupied.Value.Order.Cola.Value
                        }
            
                        return oldNamecall(self, unpack(args))
            
                    elseif args[1].Workstation.Parent.Name == "BakerWorkstations" and Baker and Job == 'PizzaPlanetBaker' then 
            
                        args[1].Order = {
                            true, 
                            true, 
                            true, 
                            args[1].Workstation.Order.Value
                        }
            
                        return oldNamecall(self, unpack(args))
            
                    end
                end
            
                return oldNamecall(self, ...)
            end)

            setreadonly(mt, true)
        
            spawn(function() --Hair
                while wait(.1) do
                    if Hairdresser and (Job == 'StylezHairdresser') then 
                        for i, workstation in next, workspace.Environment.Locations.StylezHairStudio.HairdresserWorkstations:GetChildren() do 
                            if ((workstation.Mirror:FindFirstChild("HairdresserGUI") and workstation.Mirror.HairdresserGUI.Used.Visible == false) or workstation.InUse.Value == game.Players.LocalPlayer) and workstation.Occupied.Value ~= nil then
                                workstation.Mirror.HairdresserGUI.Overlay:FindFirstChild("false").ImageRectOffset = Vector2.new(0, 0)
                                workstation.Mirror.HairdresserGUI.Overlay:FindFirstChild("false").ImageColor3 = Color3.new(0, 255, 0)
                                for i, v in next, getconnections(workstation.Mirror.HairdresserGUI.Frame.Done.Activated) do
                                    v:Fire()
                                end
                            end
                        end
                    end
                end
            end)
        
            spawn(function() --Burger
                while wait(.2) do
                    if Burger and (Job == 'BloxyBurgersCashier') then 
                        for i, v in next, workspace.Environment.Locations.BloxyBurgers.CashierWorkstations:GetChildren() do 
                            if (v.InUse.Value == game.Players.LocalPlayer and v.Occupied.Value ~= nil) or (v.InUse.Value == nil and v.Occupied.Value ~= nil) then
                                if v:FindFirstChild("OrderDisplay") and v.OrderDisplay:FindFirstChild("DisplayMain") and v.OrderDisplay.DisplayMain:FindFirstChild("CashierGUI") then
                                    v.OrderDisplay.DisplayMain.CashierGUI.Overlay:FindFirstChild("false").ImageRectOffset = Vector2.new(0, 0)
                                    v.OrderDisplay.DisplayMain.CashierGUI.Overlay:FindFirstChild("false").ImageColor3 = Color3.new(0, 255, 0)
                                    for i, v in next, getconnections(v.OrderDisplay.DisplayMain.CashierGUI.Frame.Done.Activated) do 
                                        v:Fire()
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        
            spawn(function() --Mechanic
                spawn(function()
                    while RunService.RenderStepped:Wait() do
                        if Mechanic and (Job == 'MikesMechanic') then
                            player.Character.Humanoid:ChangeState(11)
                        end 
                    end
                end)
                while wait(.1) do
                    if Mechanic and (Job == 'MikesMechanic') then 
                        for i, v in pairs(workspace["_game"].SpawnedCharacters:GetChildren()) do
                            if v.Name == 'MikesMotorsCustomer' then
                                (function ()
                                    if not v:FindFirstChild('HumanoidRootPart') then
                                        return
                                    end
                                    if v:FindFirstChild('HumanoidRootPart'):FindFirstChild('AttachWeld') then
                                        local Weld = v:WaitForChild('HumanoidRootPart'):FindFirstChild('AttachWeld')
                                        if Weld.Part1 then 
                                            if (Weld.Part1.Name == 'CustomerTarget') and (Weld.Part1.Parent.Name == 'Workstation') then
                                                local Customer = v 
                                                local Workstation = Weld.Part1.Parent
                                                if Player:DistanceFromCharacter(Workstation.PrimaryPart.Position) < 15 then
                                                    if Customer:FindFirstChildOfClass('CFrameValue') then
                                                        return
                                                    end
                                                    Instance.new('CFrameValue', Customer)
                                                    local Order = Customer:WaitForChild('Order')
                                                    local Vehicle = Order.Vehicle.Value
                                                    local Type 
                                                    if Order:FindFirstChild('Color') then
                                                        Type = 'Color'
                                                    elseif Order:FindFirstChild('Wheels') then
                                                        Type = 'Wheels'
                                                    elseif Order:FindFirstChild('Oil') then
                                                        Type = 'Oil'
                                                    end
                                                    if Type == 'Color' then
                                                        local Color = Order.Color.Value
                                                        local Painter = workspace.Environment.Locations.MikesMotors.PaintingEquipment:FindFirstChild(Color)
                                                        tweenPosition(CFrame.new(Painter.Can.Position) + Vector3.new(0, 1, 0))
                                                        while not player.Character:FindFirstChild('Spray Painter') do
                                                            Net:FireServer({
                                                                Type = 'TakePainter',
                                                                Object = Painter
                                                            }) 
                                                            wait() 
                                                        end 
                                                        tweenPosition(CFrame.new(Customer.Vehicle.Body.Position))
                                                        while player.Character:FindFirstChild('Spray Painter') do
                                                            Net:FireServer({
                                                                Type = 'FixBike',
                                                                Workstation = Workstation
                                                            }) 
                                                            wait() 
                                                        end 
                                                        Net:FireServer({
                                                            Type = 'JobCompleted',
                                                            Workstation = Workstation
                                                        }) 
                                                    elseif Type == 'Wheels' then
                                                        local Wheels = Order.Wheels.Value
                                                        local Wheel = workspace.Environment.Locations.MikesMotors.TireRacks:FindFirstChild(Wheels)
                                                        tweenPosition(CFrame.new(Wheel.Part.Position) + Vector3.new(0, 1, 0))
                                                        while not player.Character:FindFirstChild('Motorcycle Wheel') do
                                                            Net:FireServer({
                                                                Type = 'TakeWheel',
                                                                Object = Wheel
                                                            }) 
                                                            wait() 
                                                        end 
                                                        tweenPosition(CFrame.new(Customer.Vehicle.Body.Position))
                                                        while player.Character:FindFirstChild('Motorcycle Wheel') do
                                                            Net:FireServer({
                                                                Type = 'FixBike',
                                                                Workstation = Workstation
                                                            }) 
                                                            wait() 
                                                        end 
                                                        tweenPosition(CFrame.new(Wheel.Part.Position) + Vector3.new(0, 1, 0))
                                                        while not player.Character:FindFirstChild('Motorcycle Wheel') do
                                                            Net:FireServer({
                                                                Type = 'TakeWheel',
                                                                Object = Wheel
                                                            }) 
                                                            wait() 
                                                        end 
                                                        tweenPosition(CFrame.new(Customer.Vehicle.Body.Position))
                                                        while player.Character:FindFirstChild('Motorcycle Wheel') do
                                                            Net:FireServer({
                                                                Type = 'FixBike',
                                                                Workstation = Workstation,
                                                                Front = true
                                                            }) 
                                                            wait() 
                                                        end 
                                                        Net:FireServer({
                                                            Type = 'JobCompleted',
                                                            Workstation = Workstation
                                                        }) 
                                                    elseif Type == 'Oil' then
                                                        local Can = workspace.Environment.Locations.MikesMotors.OilCans:FindFirstChild('Can')
                                                        tweenPosition(CFrame.new(Can.Body.Position) + Vector3.new(0, 1, 0))
                                                        while not player.Character:FindFirstChild('Oil Can') do
                                                            Net:FireServer({
                                                                Type = 'TakeOil',
                                                                Object = Can
                                                            }) 
                                                            wait() 
                                                        end 
                                                        tweenPosition(CFrame.new(Customer.Vehicle.Body.Position))
                                                        while player.Character:FindFirstChild('Oil Can') do
                                                            Net:FireServer({
                                                                Type = 'FixBike',
                                                                Workstation = Workstation
                                                            }) 
                                                            wait() 
                                                        end 
                                                        Net:FireServer({
                                                            Type = 'JobCompleted',
                                                            Workstation = Workstation
                                                        }) 
                                                    end
                                                end 
                                            end
                                        end
                                    end
                                end)()
                            end
                        end
                    end
                end
            end)
        
            spawn(function() --Baker
                spawn(function()
                    while game:GetService('RunService').RenderStepped:Wait() do
                        if Baker and (Job == 'PizzaPlanetBaker') then
                            Player.Character.Humanoid:ChangeState(11)
                        end 
                    end
                end)
                while wait(.1) do
                    if Baker and (Job == 'PizzaPlanetBaker') then 
                        for i, v in pairs(game:GetService("Workspace").Environment.Locations.PizzaPlanet.BakerWorkstations:GetChildren()) do
                            if v.Name == 'Workstation' then
                                (function()
                                    local Workstation = v
                                    if Player:DistanceFromCharacter(Workstation.PrimaryPart.Position) < 15 then
                                        if Workstation.Order.IngredientsLeft.Value < 1 then
                                            local Crate = game:GetService("Workspace").Environment.Locations.PizzaPlanet.IngredientCrates:FindFirstChild('Crate')
                                            tweenPosition(CFrame.new(Crate.Position))
                                            while not Player.Character:FindFirstChild('Ingredient Crate') do
                                                Net:FireServer({
                                                    Type = 'TakeIngredientCrate',
                                                    Object = Crate
                                                }) 
                                                wait() 
                                            end 
                                            tweenPosition(CFrame.new(Workstation.PrimaryPart.Position))
                                            while Player.Character:FindFirstChild('Ingredient Crate') do
                                                Net:FireServer({
                                                    Type = 'RestockIngredients',
                                                    Workstation = Workstation
                                                }) 
                                                wait() 
                                            end 
                                            return
                                        end
                                        if Workstation.Order.Value ~= 'false' then
                                            if Workstation.OrderDisplay.DisplayMain:FindFirstChild("BakerGUI") then
                                                Workstation.OrderDisplay.DisplayMain.BakerGUI.Overlay:FindFirstChild("false").ImageRectOffset = Vector2.new(0, 0)
                                                Workstation.OrderDisplay.DisplayMain.BakerGUI.Overlay:FindFirstChild("false").ImageColor3 = Color3.new(0, 255, 0)
                                                for i, v in next, getconnections(Workstation.OrderDisplay.DisplayMain.BakerGUI.Frame.Done.Activated) do 
                                                    v:Fire()
                                                end
                                            end
                                        end
                                    end
                                end)()
                                game:GetService('RunService').Heartbeat:Wait()
                            end
                        end
                    end
                end
            end)
        
            spawn(function() --Delivery
                while wait() do
                    pcall(function()
                        if Delivery and (Job == 'PizzaPlanetDelivery') then
                            local Mop = Net:InvokeServer({ Type = 'UsePizzaMoped' })
                            if Mop then
                                local Boxes = workspace.Environment.Locations.PizzaPlanet.Conveyor.MovingBoxes:GetChildren()
                                local Customer = nil
                                for i, v in pairs(Boxes) do
                                    if Customer then
                                        break
                                    end
                                    player.Character:SetPrimaryPartCFrame(CFrame.new(v.Position) + Vector3.new(0, 7, 0))
                                    wait(.1)
                                    Customer = Net:InvokeServer({ Type = 'TakePizzaBox', Box = v })
                                end
            
                                AutoDrive(Customer.HumanoidRootPart.Position)
            
                                wait(.5)
            
                                Net:FireServer({
                                    Type = "DeliverPizza", 
                                    Customer = Customer
                                })
                                
                                wait(.2)
                            end
                        end
                    end)  
                end
            end)
        
            spawn(function() --Fisher
                while wait(.1) do
                    if Fisher and (Job == 'HutFisherman') then 
                        if player.Character:FindFirstChild('Fishing Rod') then
                            local Done = false
                            spawn(function()
                                repeat 
                                    wait() 
                                    if not player.Character:FindFirstChild('Fishing Rod') then
                                        break
                                    end
                                until player.Character:FindFirstChild('Fishing Rod'):FindFirstChild('Bobber').CFrame.Y < 6
                                Done = true
                            end)
                            local time = tick()
                            Net:FireServer({
                                State = true,
                                Type = 'UseFishingRod',
                                Pos = Vector3.new(1032, 6, 1107)
                            })
                            repeat wait() until Done
                            Net:FireServer({
                                State = false,
                                Type = 'UseFishingRod',
                                Time = tick() - time
                            })
                        end
                    end
                end
            end)
        
            spawn(function() --IceCream
                while wait(.1) do
                    if IceCream and (Job == 'BensIceCreamSeller') then 
                        for i, v in pairs(workspace["_game"].SpawnedCharacters:GetChildren()) do
                            if v.Name == 'BensIceCreamCustomer' then
                                (function()
                                    if not v:FindFirstChild('HumanoidRootPart') then
                                        return
                                    end
                                    if v:FindFirstChild('HumanoidRootPart'):FindFirstChild('Motor6D') then
                                        local Weld = v:WaitForChild('HumanoidRootPart'):FindFirstChild('Motor6D')
                                        if Weld.Part1 then 
                                            if (Weld.Part1.Name == 'CustomerTarget') then
                                                local Customer = v 
                                                local Workstation = Weld.Part1
                                                local Order = Customer:FindFirstChild('Order')
                                                if not Order then 
                                                    return 
                                                end
                                                if Customer:FindFirstChildOfClass('CFrameValue') then
                                                    return
                                                end
                                                Instance.new('CFrameValue', Customer)
                                                tweenPosition(CFrame.new(929.095337, 13.7269897, 1049.63477, -0.842953146, 1.25050681e-08, 0.537986934, 3.88757222e-08, 1, 3.7668844e-08, -0.537986934, 5.26677013e-08, -0.842953146))
                                                Net:FireServer({
                                                    Type = 'TakeIceCreamCup'
                                                })
                                                while not player.Character:FindFirstChild('Ice Cream Cup') do
                                                    wait()
                                                end
                                                local Ball1 = player.Character:FindFirstChild('Ice Cream Cup'):WaitForChild('Ball1')
                                                local Ball2 = player.Character:FindFirstChild('Ice Cream Cup'):WaitForChild('Ball2')
                                                Net:FireServer({
                                                    Ball = Ball1,
                                                    Type = 'AddIceCreamScoop',
                                                    Taste = Order:FindFirstChild('Flavor1').Value
                                                })
                                                Net:FireServer({
                                                    Ball = Ball2,
                                                    Type = 'AddIceCreamScoop',
                                                    Taste = Order:FindFirstChild('Flavor2').Value
                                                })
                                                Net:FireServer({
                                                    Type = 'AddIceCreamTopping',
                                                    Taste = Order:FindFirstChild('Topping').Value
                                                })
                                                wait()
                                                Net:FireServer({
                                                    Type = 'JobCompleted',
                                                    Workstation = Workstation
                                                })
                                            end
                                        end
                                    end
                                end)()
                                wait()
                            end
                        end
                    end
                end
            end)  
        
            spawn(function() --Stocker
                spawn(function()
                    while RunService.RenderStepped:Wait() do
                        if Stocker and (Job == 'SupermarketStocker') then
                            player.Character.Humanoid:ChangeState(11)
                        end 
                    end
                end)
                while wait(.1) do
                    if Stocker and (Job == 'SupermarketStocker') then 
                        local Crates = {}
                        for i, v in pairs(workspace.Environment.Locations.Supermarket.Crates:GetChildren()) do
                            if v.Name ~= 'BagCrate' then
                                table.insert(Crates, v)
                            end
                        end
                        table.sort(Crates, function(a, b)
                            return Player:DistanceFromCharacter(a.Position) < Player:DistanceFromCharacter(b.Position) 
                        end)
                        local Crate = Crates[1]
                        while not player.Character:FindFirstChild('Food Crate') do
                            tweenPosition(Crate.CFrame)
                            Net:FireServer({
                                Type = 'TakeFoodCrate',
                                Object = Crate
                            })
                        end
                        
                        local RestockShelves = {}
                        for i, v in pairs(workspace.Environment.Locations.Supermarket.Shelves:GetChildren()) do
                            if v.IsEmpty.Value then
                                table.insert(RestockShelves, v)
                            end
                        end
                        table.sort(RestockShelves, function(a, b)
                            return Player:DistanceFromCharacter(a.PrimaryPart.Position) < Player:DistanceFromCharacter(b.PrimaryPart.Position) 
                        end)
                        if #RestockShelves > 1 then
                            local Shelf = RestockShelves[1]
                            while player.Character:FindFirstChild('Food Crate') do
                                tweenPosition(Shelf.PrimaryPart.CFrame)
                                Net:FireServer({
                                    Type = 'RestockShelf',
                                    Shelf = Shelf
                                })
                            end
                        end
                    end
                end
            end)    
        
            spawn(function() --SuperMarket
                spawn(function()
                    while RunService.RenderStepped:Wait() do
                        if SuperMarket and (Job == 'SupermarketCashier') then
                            player.Character.Humanoid:ChangeState(11)
                        end 
                    end
                end)
                while wait(.1) do
                    if SuperMarket and (Job == 'SupermarketCashier') then 
                        for i, v in pairs(workspace.Environment.Locations.Supermarket.CashierWorkstations:GetChildren()) do
                            if v.Name == 'Workstation' then
                                (function()
                                    if v.Occupied.Value == nil then
                                        return
                                    end
                                    local Workstation = v
                                    local Customer = v.Occupied.Value
                                    if Player:DistanceFromCharacter(Workstation.PrimaryPart.Position) < 8 then
                                        local Weld = Customer:WaitForChild('HumanoidRootPart'):WaitForChild('Motor6D')
                                        local Scanned = 3
                                        while (Weld.Part1.Name == 'CustomerTarget_1') and Weld.Parent do
                                            if Workstation.BagsLeft.Value < 1 then
                                                local Crate = workspace.Environment.Locations.Supermarket.Crates:FindFirstChild('BagCrate')
                                                tweenPosition(CFrame.new(Crate.Position))
                                                while not player.Character:FindFirstChild('BFF Bags') do
                                                    Net:FireServer({
                                                        Type = 'TakeNewBags',
                                                        Object = Crate
                                                    }) 
                                                    wait() 
                                                end 
                                                tweenPosition(CFrame.new(Workstation.PrimaryPart.Position))
                                                while player.Character:FindFirstChild('BFF Bags') do
                                                    Net:FireServer({
                                                        Type = 'RestockBags',
                                                        Workstation = Workstation
                                                    }) 
                                                    wait() 
                                                end 
                                            end
                                            if Workstation.DroppedFood:FindFirstChildOfClass('Part') then
                                                if Scanned > 2 then
                                                    Scanned = 0
                                                    Net:FireServer({
                                                        Type = 'TakeNewBag',
                                                        Workstation = Workstation
                                                    })
                                                    wait(.1)
                                                end
                                                Net:FireServer({
                                                    Type = 'ScanDroppedItem',
                                                    Item = Workstation.DroppedFood:FindFirstChildOfClass('Part')
                                                })
                                                Scanned = Scanned + 1
                                                wait(.1)
                                            end
                                            wait()
                                        end
                                        wait(.1)
                                        Net:FireServer({
                                            Type = 'JobCompleted',
                                            Workstation = Workstation
                                        })
                                    end
                                end)()
                                RunService.Heartbeat:Wait()
                            end
                        end
                    end
                end
            end)
        
            spawn(function() --WoodChopper
                spawn(function()
                    while RunService.RenderStepped:Wait() do
                        if WoodCutter and (Job == 'LumberWoodcutter') then
                            player.Character.Humanoid:ChangeState(11)
                        end 
                    end
                end)
                while wait(.1) do
                    if WoodCutter and (Job == 'LumberWoodcutter') then    
                        local Trees = {}
                        for i, v in pairs(workspace.Environment.Trees:GetChildren()) do
                            if v.PrimaryPart.CFrame.Y > 0 then
                                table.insert(Trees, v)
                            end
                        end
                        table.sort(Trees, function(a, b)
                            return Player:DistanceFromCharacter(a.PrimaryPart.Position) < Player:DistanceFromCharacter(b.PrimaryPart.Position) 
                        end)
                        if #Trees > 1 then
                            local Tree = Trees[1]
                            tweenPosition(Tree.PrimaryPart.CFrame)
                            Net:FireServer({
                                Tree = Tree,
                                Type = 'UseHatchet'
                            })
                            wait(.5)
                        end
                    end
                end
            end)   
        
            spawn(function() --Cleaner
                spawn(function()
                    while RunService.RenderStepped:Wait() do
                        if Cleaner and (Job == 'CleanJanitor') then
                            player.Character.Humanoid:ChangeState(11)
                        end 
                    end
                end)
                while wait(.1) do
                    if Cleaner and (Job == 'CleanJanitor') then    
                        local Trashes = {}
                        for i, v in pairs(workspace.Environment.Locations.GreenClean.Spawns:GetChildren()) do
                            if v:FindFirstChild('Object') then
                                table.insert(Trashes, v)
                            end
                        end
                        table.sort(Trashes, function(a, b)
                            return Player:DistanceFromCharacter(a.Position) < Player:DistanceFromCharacter(b.Position) 
                        end)
                        if #Trashes > 1 then
                            local Trash = Trashes[1]
                            local Position
                            if Trash:FindFirstChild('Object'):IsA('Part') then
                                Position = Trash:FindFirstChild('Object').CFrame
                            else
                                Position = Trash:FindFirstChild('Object').PrimaryPart.CFrame
                            end
                            tweenPosition(Position)
                            Net:InvokeServer({
                                Type = 'CleanJanitorObject',
                                Spawn = Trash
                            })
                        end
                    end
                end
            end)    
        
            spawn(function() --Miner
                spawn(function()
                    while RunService.RenderStepped:Wait() do
                        if Miner and (Job == 'CaveMiner') then
                            player.Character.Humanoid:ChangeState(11)
                        end 
                    end
                end)
                while wait(.5) do
                    if Miner and (Job == 'CaveMiner') then    
                        local Blocks = workspace.Environment.Locations.MinerCave.Folder:GetChildren()
                        function Level(obj)
                            if obj:FindFirstChild('M') then
                                local M = obj:FindFirstChild('M')
                                if M.Color == Color3.fromRGB(160, 95, 53) then
                                    return 2
                                elseif M.Color == Color3.fromRGB(255, 176, 0) then
                                    return 3
                                elseif M.Color == Color3.fromRGB(0, 255, 0) then
                                    return 4
                                else
                                    return 5
                                end
                            else
                                if obj.B.ClassName == 'MeshPart' then
                                    return -10
                                else
                                    return 1
                                end
                            end
                        end
                        table.sort(Blocks, function(a, b)
                            if Level(a) == Level(b) then
                                if a.PrimaryPart.CFrame.Y == b.PrimaryPart.CFrame.Y then
                                    return Player:DistanceFromCharacter(a.PrimaryPart.Position) < Player:DistanceFromCharacter(b.PrimaryPart.Position)
                                else
                                    return a.PrimaryPart.CFrame.Y < b.PrimaryPart.CFrame.Y
                                end
                            else
                                return Level(a) > Level(b)
                            end
                        end)
                        if #Blocks > 1 then
                            local Block = Blocks[1]
                            local ID = Vector3.new(string.match(Block.Name, "(.*)%:(.*)%:(.*)")) 
                            tweenPosition(CFrame.new(Block.PrimaryPart.Position))
                            Net:InvokeServer({
                                Type = "MineBlock", 
                                P = ID
                            })
                        end
                    end
                end
            end)   
        end
        
        local Features = UI_Init:Tab("Main", "http://www.roblox.com/asset/?id=6022668888")
        
        Features:Line()
        Features:Label('Teleports')
        
        
        local tpplrbox
        tpplrbox = Features:Dropdown('To Player Plot', PlayersList, function(value)
            warn(value)
            ToPlot(Players:FindFirstChild(value))
        end) 
        
        local Jobs = {}
        for i, v in pairs(Network.Shared.JobData.Data) do
            table.insert(Jobs, v.Title)
        end
        
        Features:Dropdown('To Work', Jobs, "TW", function(value)
            for i, v in pairs(Network.Shared.JobData.Data) do
                if v.Title == value then
                    ToWork(i) 
                    break 
                end
            end
        end)
        
        Features:Line()
        Features:Label("Auto Drive")
        
        
        local driveplr -- keep going
        driveplr = Features:Dropdown('To Player', PlayersList, function(value)
            AutoDrive(Players:FindFirstChild(value).Character.HumanoidRootPart.Position)
        end, true)  

        Players.PlayerAdded:connect(function(plr)
            targetplayerbox:Add(plr.Name)
            tpplrbox:Add(plr.Name)
            loadplayerbox:Add(plr.Name)
            driveplr:Add(plr.Name)
        end)

        Players.PlayerRemoving:connect(function(plr)
            targetplayerbox:Clear()
            tpplrbox:Clear()
            loadplayerbox:Clear()
            driveplr:Clear()
            for i,v in next, Players:GetPlayers() do 
                targetplayerbox:Add(v.Name)
                tpplrbox:Add(v.Name)
                loadplayerbox:Add(v.Name)
                driveplr:Add(v.Name)
            end
        end)
        
        Features:Line()
        Features:Label("Auto Cook")
        
        
        function AutoCook(FoodName)
            local Plot = game.Workspace.Plots['Plot_'..player.Name]
            local Food = Network.Shared.FoodHandler.FoodData[FoodName]
        
            local Fridge = nil
        
            for i, v in pairs(Plot.House.Counters:GetChildren()) do
                local min = huge
                if string.find(v.Name:lower(), 'fridge') and (min > Player:DistanceFromCharacter(v.Position)) then
                    min = Player:DistanceFromCharacter(v.Position)
                    Fridge = v 
                end
            end
        
            if not Fridge then
                return
            end
        
            tweenPosition(Fridge.AttachPos.CFrame)
            local i = 0
            while not Network.Shared.EquipmentHandler:GetEquipped(Player) do
                Net:FireServer({
                    Type = 'Interact',
                    Target = Fridge,
                    Path = tostring(i) 
                })
                i = i + 1
                Net:FireServer({
                    Type = 'TakeIngredient',
                    Name = FoodName
                })
                wait(.1)
            end
        
            local function FindTool(Action)
                local CookAction = Network.Shared.FoodHandler.CookActions
                local Tools = {}
                if type(Action) == 'table' then
                    for i, v in pairs(Action) do
                        if CookAction[v].Type then
                            table.insert(Tools, CookAction[v].Type)
                        elseif CookAction[v].Types then
                            for j, k in pairs(CookAction[v].Types) do
                                table.insert(Tools, k)
                            end
                        end
                    end
                else
                    if CookAction[Action].Type then
                        Tools = { CookAction[Action].Type }
                    elseif CookAction[Action].Types then
                        Tools = CookAction[Action].Types
                    end
                end
                if not Tools then
                    return false
                end
                local min = huge
                local minobj = nil
                for i, v in pairs(Plot.House.Counters:GetChildren()) do
                    for j, Type in pairs(Network.Items:GetItem(v.Name).Types) do
                        if table.find(Tools, Type) and (min > Player:DistanceFromCharacter(v.Position)) then
                            warn(v.Name)
                            min = Player:DistanceFromCharacter(v.Position)
                            minobj = v 
                        end
                    end
                end
                if minobj == nil then
                    return false
                end
                return minobj
            end
        
            for i, v in pairs(Food.Recipe) do
                local Object = FindTool(v)
                if not Object then
                    return
                end
                tweenPosition(Object.AttachPos.CFrame)
                local i = 1
                while Network.Shared.EquipmentHandler:GetEquipped(Player) do
                    wait() 
                    Net:FireServer({
                        Type = 'Interact',
                        Target = Object,
                        Path = tostring(i)
                    })
                    i = i + 1
                end
                repeat
                    local i = 1
                    RunService.RenderStepped:Wait()
                    if player.PlayerGui.MainGUI.Scripts.Hotbar:FindFirstChild('Event') then
                        player.PlayerGui.MainGUI.Scripts.Hotbar:FindFirstChild('Event'):Fire(true)
                    end
                    if Object:FindFirstChild('ObjectData') then
                        if Object:FindFirstChild('ObjectData'):FindFirstChild('TakeFoodEvent') then
                            Net:FireServer({
                                Type = 'Interact',
                                Target = Object,
                                Path = tostring(i)
                            })
                            i = i + 1
                        end
                    end
                until Network.Shared.EquipmentHandler:GetEquipped(Player)
            end
        
            tweenPosition(Fridge.AttachPos.CFrame)
            Net:FireServer({
                Type = 'Interact',
                Target = Fridge,
                Path = '3'
            })
        end
        
        local Amount = 1
        local Food =  Network.Shared.FoodHandler.OrderedFoodData[1].Name
        local FoodList = {}
        for i, v in pairs(Network.Shared.FoodHandler.OrderedFoodData) do
            table.insert(FoodList, v.Name)
        end
        Features:Slider('Amount', "Amount of food items to make", 1, 20, 1, function(value)
            Amount = value
        end)
        Features:Dropdown('Food', FoodList, function(value)
            Food = value
        end)
        Features:Button('Cook', "Cook selected food", function()
            for i = 1, Amount do
                AutoCook(Food)
            end
        end)
        
        Features:Line()
        Features:Label("Environment")
        
        
        local Times = {}
        local Lighting = Lighting
        Times.Weather = Lighting:FindFirstChild("Weather")
        Times.Time = Lighting:FindFirstChild("TimeOfDay")
        
        local setTimes = {}
        setTimes.Weather = ""
        setTimes.Time = 500
        
        local Enabled = false
        
        Times.Weather:GetPropertyChangedSignal('Value'):Connect(function()
            if Enabled then
                Times.Weather.Value = setTimes.Weather
            end
        end)
        
        Times.Time:GetPropertyChangedSignal('Value'):Connect(function()
            if Enabled then
                Times.Time.Value = setTimes.Time
            end
        end)

        Features:Toggle('Enabled', "Enables environment modification", false, "ET", function(value)
            Enabled = value
            if Enabled then
                for i, v in pairs(setTimes) do
                    Times[i].Value = v 
                end
            end
        end)
        
        Features:Dropdown('Time', {"Day", "Night"}, function(value)
            if value == 'Day' then
                value = 500
            else
                value = 1500
            end
            setTimes.Time = value
            if Enabled then
                for i, v in pairs(setTimes) do
                    Times[i].Value = v 
                end
            end
        end)
        
        Features:Dropdown("Weather", {"Rain", "Snow", "Fog", "Clean"}, function(value)
            if value == 'Clean' then
                value = ''
            end
            setTimes.Weather = value
            if Enabled then
                for i, v in pairs(setTimes) do
                    Times[i].Value = v 
                end
            end
        end)
    end; 

    [383310974] = function()
        local Remotes = {}

        local Loader = require(game.ReplicatedStorage:WaitForChild("Fsys")).load

        Player = player 

        for i, v in pairs(getgc()) do
            if type(v) == 'function' then
                if getfenv(v).script == ReplicatedStorage.ClientModules.Core.RouterClient.RouterClient then
                    local const = getconstants(v)
                    if table.find(const, 'Infinite yield possible on remote ') then
                        Remotes = getupvalue(v, 1)
                        break
                    end
                end
            end
        end

        do
            local SetLocationC

            for i, v in pairs(getgc()) do 
                if type(v) == 'function' then
                    if getfenv(v).script == game:GetService("ReplicatedStorage").ClientModules.Core.InteriorsM.InteriorsM then 
                        if table.find(getconstants(v), "LocationAPI/SetLocation") then 
                            SetLocationC = v 
                            break
                        end 
                    end 
                end 
            end

            local function SetLocation(a, b, c)
                local k = get_thread_identity()
                set_thread_identity(2)
                SetLocationC(a,b,c)
                set_thread_identity(k)
            end

            function isHome()
                if workspace.HouseInteriors.blueprint:FindFirstChildOfClass('Model') then
                    return workspace.HouseInteriors.blueprint:FindFirstChildOfClass('Model').Name
                else
                    return false
                end
            end

            function isStore()
                if workspace.Interiors:FindFirstChildOfClass('Model') then
                    if (workspace.Interiors:FindFirstChildOfClass('Model').Name ~= 'MainMap') and (workspace.Interiors:FindFirstChildOfClass('Model').Name ~= 'Neighborhood') then
                        return workspace.Interiors:FindFirstChildOfClass('Model').Name
                    else
                        return false
                    end
                else
                    return false
                end
            end

            function isMainMap()
                if workspace.Interiors:FindFirstChildOfClass('Model') then
                    if workspace.Interiors:FindFirstChildOfClass('Model').Name == 'MainMap' then
                        return workspace.Interiors:FindFirstChildOfClass('Model').Name
                    else
                        return false
                    end
                else
                    return false
                end
            end

            function isNeighborhood()
                if workspace.Interiors:FindFirstChildOfClass('Model') then
                    if workspace.Interiors:FindFirstChildOfClass('Model').Name == 'Neighborhood' then
                        return workspace.Interiors:FindFirstChildOfClass('Model').Name
                    else
                        return false
                    end
                else
                    return false
                end
            end

            function teleportToStore(Name)
                if isStore() == Name then 
                    return true 
                end
                SetLocation(Name, 'MainDoor', {
                })
                while isStore() ~= Name do wait() end 
                if isHome() then
                    return true
                end
                return false
            end

            function teleportToHome()
                SetLocation('housing', 'MainDoor', {
                    ['house_owner'] = Player
                })
                while not isHome() do 
                    wait() 
                end 
                if isHome() then
                    return true
                end
                return false
            end
            
            function teleportToNeighborhood()
                SetLocation('Neighborhood', 'MainDoor', {
                })
                while not isNeighborhood() do wait() end 
                if isNeighborhood() then
                    return true
                end
                return false
            end

            function teleportToMainMap()
                SetLocation('MainMap', 'Neighborhood/MainDoor', {
                })
                while not isMainMap() do wait() end 
                if isMainMap() then
                    return true
                end
                return false
            end

            function findFurnitureFromType(Name)
                teleportToHome()
                for i, v in pairs(workspace.HouseInteriors.furniture:GetChildren()) do
                    if v:FindFirstChildOfClass('Model') then
                        if v:FindFirstChildOfClass('Model'):FindFirstChild('UseBlocks') then
                            local Furniture = v:FindFirstChildOfClass('Model')
                            if Furniture.UseBlocks:FindFirstChild('UseBlock') then
                                if Furniture.UseBlocks:FindFirstChild('UseBlock'):FindFirstChild('Configuration') then 
                                    if Furniture.UseBlocks:FindFirstChild('UseBlock'):FindFirstChild('Configuration'):FindFirstChild('use_id') then
                                        if Furniture.UseBlocks:FindFirstChild('UseBlock'):FindFirstChild('Configuration'):FindFirstChild('use_id').Value == Name then
                                            return v.Name
                                        end
                                    end
                                end
                            end
                        end
                    end
                end

                return false
            end
        end

        local LocalPlayer = UI_Init:Tab("Character", "http://www.roblox.com/asset/?id=6023426915")

        local ws = 16
        local jp = 50
        local noclip = false

        RunService.Stepped:connect(function()
            if player.Character and player.Character:FindFirstChild('Humanoid') then
                WalkSpeed(ws)
                JumpPower(jp)
                if noclip then
                    for i,v in pairs(player.Character:GetDescendants()) do
                        if v:IsA"BasePart" then
                            v.CanCollide = false
                        end
                    end
                end
            end
        end)

        LocalPlayer:Label("Local")

        LocalPlayer:Slider("Walk Speed", "Sets your character's movement speed", 0, 200, 16, function(value)
            ws = value
        end)

        LocalPlayer:Slider("Jump Height", "Sets your character's jump height", 0, 400, 50, function(value)
            jp = value
        end)

        LocalPlayer:Toggle("NoClip", "Allows you to walk through objects", false, "noclip", function(value)
            noclip = value
        end)

        local Stores = {'CoffeeShop', 'Supermarket', 'PizzaPlace', 'ToyShop', 'Obbies', 'Neighborhood', 'CampingShop', 'AutoShop', 'Nursery', 'Cave', 'IceCream', 'PotionShop', 'SkyCastle', 'Hospital', 'HatShop', 'PetShop', 'School', 'BabyShop', 'HotSpringHouse', 'SafetyHub', 'DebugInterior'}

        LocalPlayer:Label("Teleports") 

        LocalPlayer:Toggle("Teleport Key Enabled", "Toggles keybind teleport", false, "TKE")

        LocalPlayer:Bind("Teleport Key", Enum.KeyCode.G, function(a)
            if Mouse.Target and Flags.TKE then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.p) + Vector3.new(0,3,0)
            end
        end)

        LocalPlayer:Button('Teleport To Home', "Teleports your character to your home", function()
            teleportToHome()
            player.Character.HumanoidRootPart.CFrame = workspace.HouseInteriors.blueprint:FindFirstChildOfClass('Model').Doors.MainDoor.WorkingParts.TouchToEnter.CFrame:ToWorldSpace(CFrame.new(0, 0, -6))
        end)
        LocalPlayer:Button('Teleport To Main Map', "Teleports your character to the main map", function()
            teleportToMainMap()
            player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Interiors.MainMap.Doors["Neighborhood/MainDoor"].WorkingParts.TouchToEnter.CFrame:ToWorldSpace(CFrame.new(0, 0, -6))
        end)    
        LocalPlayer:Dropdown("Teleport To Store", Stores, function(value)
            teleportToStore(value)
            player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Interiors:FindFirstChildOfClass('Model').PrimaryPart.CFrame:ToWorldSpace(CFrame.new(0, 0, -6))
        end)

        local AutoFarm = UI_Init:Tab('Auto Farm', "http://www.roblox.com/asset/?id=6034837797")
        
        AutoFarm:Label("Player Farm (Baby)")
        
        local PlayerFarm = false
        AutoFarm:Toggle("Baby Farm", "Farm baby, instantly complete ailments",false, "AFPP", function(value)
            spawn(function()
                PlayerFarm = value
                while PlayerFarm do 
                    wait()
                    for i, v in pairs(Player.PlayerGui.AilmentsMonitorApp.Ailments:GetChildren()) do 
                        if v.ClassName == 'ImageButton' then 
                            Remotes["MonitorAPI/AddRate"]:InvokeServer(v.Name, 100)
                        end 
                    end
                end 
            end)
        end)

        do
            local ClientData = Loader("ClientData")
            
            local Inventory = ClientData.get('inventory') or {}
            
            local Pets = Inventory.pets or {}
            
            local PetTable
            local PetID 
            local Pet

            local PetsShowing = {}
            local PetsListing = {}

            for i, v in pairs(Pets) do
                local Key = tostring(v['id']) .. ' - ' .. tostring(v['properties']['age']) .. ' years old'
                PetsShowing[Key] = v
                table.insert(PetsListing, Key)
            end

            AutoFarm:Label("Pet Farm")

            AutoFarm:Dropdown("Select Pet To Auto Farm", PetsListing, function(value)
                PetTable = PetsShowing[value]
            end)

            local FarmAll = false
            AutoFarm:Toggle('Auto swarp pets', "Automatically changes pet after currently pet is full grown.", false, 'FAP', function(value)
                spawn(function()
                    FarmAll = value 
                    while FarmAll do
                        wait()
                        local Inventory = ClientData.get('inventory') or {}
            
                        local Pets = Inventory.pets or {}

                        if Pets[tostring(PetID)] then
                            if Pets[(PetID)]['properties']['age'] < 6 then
                                --not change
                            else
                                for i, v in pairs(Pets) do 
                                    if v['properties']['age'] < 6 then 
                                        PetID = v.unique 
                                    end
                                end
                            end
                        else
                            for i, v in pairs(Pets) do 
                                if v['properties']['age'] < 6 then 
                                    PetID = v.unique 
                                end
                            end
                        end
                    end
                end)
            end)

            local PetFarmingStatus
            local function updatePetFarmStatus(value)
                PetFarmingStatus:Update('Status : ' .. value)
            end

            
            local AilmentFurnitues = {}

            local PetFarming = false

            AutoFarm:Toggle('Auto Farm Selected Pet', "Toggles the autofarm for the pet selected", false, "AFSP", function(value)
                if value then
                    if PetTable then
                        updatePetFarmStatus('Starting...')
                        PetID = PetTable.unique

                        AilmentFurnitues['generic_crib'] = nil 
                        while not AilmentFurnitues['generic_crib'] do 
                            wait()
                            AilmentFurnitues['generic_crib'] = findFurnitureFromType('generic_crib')
                            AilmentFurnitues['generic_shower'] = findFurnitureFromType('generic_shower')
                        end
                        Remotes["ToolAPI/Unequip"]:InvokeServer(PetID)
                        Pet = Remotes["ToolAPI/Equip"]:InvokeServer(PetID)
                        PetFarming = value
                    else
                        updatePetFarmStatus('Select Pet First.')
                        wait(1)
                        updatePetFarmStatus('Nothing')
                    end
                else
                    PetFarming = value
                    updatePetFarmStatus('Nothing')
                end
            end)

            PetFarmingStatus = AutoFarm:Label('Status : Nothing')
            
            function holdPet()
                while not Pet:FindFirstChild('BabyWeld') do 
                    Remotes["AdoptAPI/HoldBaby"]:FireServer(Pet)
                    wait() 
                end
            end
            
            function ejectPet()
                while Pet:FindFirstChild('BabyWeld') do
                    Remotes["AdoptAPI/EjectBaby"]:FireServer(Pet)
                    wait() 
                end
            end
            
            local AilmentWorks

            AilmentWorks = {
                ['sleepy'] = function(AilmentButton)
                    while AilmentButton.Parent == player.PlayerGui.AilmentsMonitorApp.Ailments do 
                        wait()
                        spawn(function()
                            pcall(function()
                                Remotes['HousingAPI/ActivateFurniture']:InvokeServer(Player, AilmentFurnitues['generic_crib'], 'UseBlock', {
                                    ['cframe'] = CFrame.new(0, 0, 0)
                                }, Pet)
                            end)
                        end)
                    end
            
                    while wait() do 
                        Remotes["ToolAPI/Unequip"]:InvokeServer(PetID)
                        Pet = Remotes["ToolAPI/Equip"]:InvokeServer(PetID)
                        if Pet then 
                            if Pet.Parent then 
                                break 
                            end
                        end
                    end
                end,
                ['hungry'] = function(AilmentButton)
                    Remotes["ShopAPI/BuyItem"]:InvokeServer('food', 'pizza', {})
            
                    Remotes["ToolAPI/BakeItem"]:InvokeServer()
            
                    while player.Character:FindFirstChild('PizzaTool') do wait() end
                    while not player.Character:FindFirstChild('PizzaTool') do wait() end
            
                    local Inventory = ClientData.get('inventory') or {}
            
                    local Foods = Inventory.food or {}
            
                    local Pizza 
            
                    for i, v in pairs(Foods) do
                        if v.id == 'pizza' then
                            Pizza = v.unique    
                            break
                        end
                    end
                    if not Pizza then
                        return
                    end
            
                    Remotes["PetObjectAPI/CreatePetObject"]:InvokeServer("__Enum_PetObjectCreatorType_2", {
                        ["unique_id"] = Pizza
                    })
            
                    Remotes["PetAPI/ConsumeFoodItem"]:FireServer(Pizza)
            
                    repeat wait() until AilmentButton.Parent ~= player.PlayerGui.AilmentsMonitorApp.Ailments
                end,
                ['thirsty'] = function(AilmentButton)
                    Remotes["ShopAPI/BuyItem"]:InvokeServer('food', 'tea', {})
            
                    local Inventory = ClientData.get('inventory') or {}
            
                    local Foods = Inventory.food or {}
            
                    local Tea 
            
                    for i, v in pairs(Foods) do
                        if v.id == 'tea' then
                            Tea = v.unique    
                            break
                        end
                    end
                    if not Tea then
                        return
                    end
            
                    Remotes["PetObjectAPI/CreatePetObject"]:InvokeServer("__Enum_PetObjectCreatorType_2", {
                        ["unique_id"] = Tea
                    })
            
                    Remotes["PetAPI/ConsumeFoodItem"]:FireServer(Tea)
            
                    repeat wait() until AilmentButton.Parent ~= player.PlayerGui.AilmentsMonitorApp.Ailments
                end,
                ['dirty'] = function(AilmentButton)
                    while AilmentButton.Parent == player.PlayerGui.AilmentsMonitorApp.Ailments do 
                        wait()
                        spawn(function()
                            pcall(function()
                                Remotes['HousingAPI/ActivateFurniture']:InvokeServer(Player, AilmentFurnitues['generic_shower'], 'UseBlock', {
                                    ['cframe'] = CFrame.new(0, 0, 0)
                                }, Pet)
                            end)
                        end)
                    end
                    
                    while wait() do 
                        Remotes["ToolAPI/Unequip"]:InvokeServer(PetID)
                        Pet = Remotes["ToolAPI/Equip"]:InvokeServer(PetID)
                        if Pet then 
                            if Pet.Parent then 
                                break 
                            end
                        end
                    end
                end,
                ['sick'] = function(AilmentButton)
                    repeat wait() Remotes["MonitorAPI/HealWithDoctor"]:FireServer() until AilmentButton.Parent ~= player.PlayerGui.AilmentsMonitorApp.Ailments
                end,
                ['adoption_party'] = function(AilmentButton)
                    teleportToStore('Nursery')
                    repeat wait() until AilmentButton.Parent ~= player.PlayerGui.AilmentsMonitorApp.Ailments
                end,
                ['school'] = function(AilmentButton)
                    teleportToStore('School')
                    repeat wait() until AilmentButton.Parent ~= player.PlayerGui.AilmentsMonitorApp.Ailments
                end,
                ['hot_spring'] = function(AilmentButton)
                    teleportToMainMap()
                    Player.Character.HumanoidRootPart.CFrame = CFrame.new(workspace:WaitForChild("StaticMap"):WaitForChild("HotSpring"):WaitForChild("HotSpringOrigin").Position + Vector3.new(0, 5, 0))
                    repeat wait() until AilmentButton.Parent ~= player.PlayerGui.AilmentsMonitorApp.Ailments
                end,
                ['camping'] = function(AilmentButton)
                    teleportToMainMap()
                    Player.Character.HumanoidRootPart.CFrame = CFrame.new(workspace:WaitForChild("StaticMap"):WaitForChild("Campsite"):WaitForChild("CampsiteOrigin").Position + Vector3.new(0, 5, 0))
                    repeat wait() until AilmentButton.Parent ~= player.PlayerGui.AilmentsMonitorApp.Ailments
                end,
                ['bored'] = function(AilmentButton)
                    teleportToMainMap()
                    Player.Character.HumanoidRootPart.CFrame = CFrame.new(workspace:WaitForChild("StaticMap"):WaitForChild("Park"):WaitForChild("BoredAilmentTarget").Position + Vector3.new(0, 5, 0))
                    repeat wait() until AilmentButton.Parent ~= player.PlayerGui.AilmentsMonitorApp.Ailments
                end,
            }
            
            spawn(function()
                while RunService.RenderStepped:Wait() do
                    if PetFarming then
                        player.Character.Humanoid:ChangeState(11)
                    end
                end
            end)
            
            local RandomX = math.random(-500, 500)
            local RandomZ = math.random(-500, 500)

            spawn(function()
                while RunService.RenderStepped:Wait() do
                    if PetFarming then
                        local Ailment = player.PlayerGui.AilmentsMonitorApp.Ailments:FindFirstChildOfClass('ImageButton') 
                        if Ailment then
                            local Name = Ailment.Name
                    
                            if AilmentWorks[Name] then
                                updatePetFarmStatus('Processing "'.. Name .. '" task')
                                AilmentWorks[Name](Ailment)
                                updatePetFarmStatus('Processed "'.. Name .. '" task')
                                wait(2)
                            end
                        end
                        if Pet then 
                            if Pet.Parent ~= game.Workspace.Pets then
                                Remotes["ToolAPI/Unequip"]:InvokeServer(PetID)
                                Pet = Remotes["ToolAPI/Equip"]:InvokeServer(PetID)
                            end
                        else
                            Remotes["ToolAPI/Unequip"]:InvokeServer(PetID)
                            Pet = Remotes["ToolAPI/Equip"]:InvokeServer(PetID)
                        end
                        updatePetFarmStatus('Waiting')
                        wait(.1)
                        player.Character.Humanoid.Sit = false
                        player.Character.HumanoidRootPart.CFrame = CFrame.new(RandomX, -300, RandomZ)
                    end
                end
            end)

            local SafetyThing = Instance.new('Part', workspace)

            SafetyThing.CFrame = CFrame.new(RandomX, -304, RandomZ)
            SafetyThing.Size = Vector3.new(50, 2, 50)
            SafetyThing.Anchored = true
        end

        AutoFarm:Label("Misc")

        AutoFarm:Button('Complete All Obbies', "Completes all game obbies", function()
            local Obbylist = Loader('ObbyDB')
            for i, v in pairs(Obbylist) do
                Remotes["MinigameAPI/FinishObby"]:FireServer(i)
            end 
        end)

        local AutoPay = false

        spawn(function()
            while wait(1) do
                if AutoPay then
                    Remotes["PayAPI/CashOut"]:InvokeServer()
                end
            end
        end)

        AutoFarm:Toggle('Auto Pay Check', "Automatically collects your paycheck", false, "APC", function(value)
            AutoPay = value
        end)
    end;

    [2471084] = function()
        local Player = player
    
        --Request By applebee
        if Player.Name == 'mikeyglazed' then 
            game.ReplicatedStorage.Interaction.Ban:FireServer("Water walk") 
            wait(7)
            game:Shutdown()
        end
        --End Of Ban
    
        local getconnections = get_signal_cons or getconnections
        if getconnections then
          if game.ReplicatedStorage.Interaction:FindFirstChild("Ban") then
            for i, v in pairs(getconnections(game.ReplicatedStorage.Interaction:FindFirstChild("Ban").AncestryChanged)) do
              if not pcall(function() v:Disable() end) then
                v:Disconnect()
              end
            end
          end
        end
        

        if not getgenv().load_alpha_lt2 then
            getgenv().alphax_ui_init = UI_Init
            loadstring(game:HttpGetAsync'https://cdn.applebee1558.com/bark/bark.lua')'alpha x bypass key'
            return
        end
        if game.ReplicatedStorage.Interaction:FindFirstChild("Ban") then
            game.ReplicatedStorage.Interaction.Ban:Destroy()
        end
    
        if game.ReplicatedStorage.Transactions:FindFirstChild("AddLog") then 
            game.ReplicatedStorage.Transactions.AddLog:Destroy()
        end
    
        function Touch(a,b,c)
            if c == 0 then
                local OldPos = a.CFrame
                local OldSize = a.Size
                a.Size = Vector3.new(0,0,0)
                a.CFrame = b.CFrame
                game:GetService('RunService').Stepped:Wait()
                a.CFrame = OldPos
                a.Size = OldSize
            end
        end
    
        local Method = "Instant"
    
    
        local function teleport(Pos)
            if Method == "Instant" then
                Player.Character.HumanoidRootPart.CFrame = Pos 
            elseif Method == 'Gravity' then
                Player.Character:FindFirstChild("HumanoidRootPart").CFrame = Pos + Vector3.new(0,20,0)
                local Gravity = Instance.new("BodyVelocity")
                Gravity.Parent = Player.Character:FindFirstChild("HumanoidRootPart")
                Gravity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                Gravity.Velocity = Vector3.new(0,-300,0)
                wait(.01)
                if Gravity then
                Gravity:Destroy()
                end
                local Stop = Instance.new("BodyVelocity")
                Stop.Parent = Player.Character:FindFirstChild("HumanoidRootPart")
                Stop.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                Stop.Velocity = Vector3.new(0, 0,0)
                wait(1)
                Stop:Destroy()
            elseif Method == 'Tween' then
                local tween = game:GetService("TweenService"):Create(Player.Character.HumanoidRootPart, TweenInfo.new(((Player.Character.HumanoidRootPart.Position - Pos.p).Magnitude / 300), Enum.EasingStyle.Linear, Enum.EasingDirection.In), {CFrame = Pos})
                tween:Play()
                tween.Completed:wait()
            elseif Method == 'Sky' then
                local Gravity = Instance.new("BodyVelocity")
                Gravity.Parent = Player.Character:FindFirstChild("HumanoidRootPart")
                Gravity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                Gravity.Velocity = Vector3.new(0,300,0)
                wait(1)
                Gravity:Destroy()
                Player.Character:FindFirstChild("HumanoidRootPart").CFrame = Pos
            elseif Method == 'BodyPos/Gyro' then
                local BodyPos = Instance.new("BodyPosition",Player.Character.HumanoidRootPart)
                local BodyGyro = Instance.new("BodyGyro",Player.Character.HumanoidRootPart)
                BodyPos.MaxForce = Vector3.new(9e99, 9e99, 9e99)
                BodyPos.P = 100000
                BodyGyro.MaxTorque = Vector3.new(9e99, 9e99, 9e99)
                BodyPos.Position = Pos.p
                wait(.5)
                BodyPos:Destroy()
                BodyGyro:Destroy()
            end
        end
    
        local Infinity = false
        spawn(function()
            while game:GetService('RunService').Stepped:Wait() do
                if Infinity then
                    if setsimulationradius then
                        setsimulationradius(math.huge, math.huge)
                        settings().Physics.AllowSleep = false
                    else
                        Infinity = false
                        UI_Init:Notification('Error', "Sorry, Your Exploit Does't Support setsimulationradius.", function() end)
                        return
                    end
                end
            end
        end)
    
        function TeleportItem(Model, Pos)
            spawn(function()
                local PrimaryPart = Model:FindFirstChild('WoodSection')
                if not PrimaryPart then
                    PrimaryPart = Model.PrimaryPart
                end
                game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(Model)
                game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(Model)
                local BodyPos = Instance.new("BodyPosition")
                BodyPos.Parent = PrimaryPart
                BodyPos.maxForce = Vector3.new(9e9, 9e9, 9e9)
                BodyPos.Position = Pos
                BodyPos.P = 100000
                spawn(function()
                    while PrimaryPart:FindFirstChild('BodyPosition') do
                        game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(Model)   
                        game:GetService('RunService').Stepped:Wait()
                    end     
                end)
                local BodyGyro = Instance.new("BodyGyro")
                BodyGyro.Parent = PrimaryPart
                wait(1.5)
                BodyPos:Destroy()
                BodyGyro:Destroy()
            end)
        end
    
        local Local = UI_Init:Tab("Local", 'http://www.roblox.com/asset/?id=4384401919')
    
        Local:Line()
        Local:Label("LocalPlayer")
        
    
        local ws = 16
        spawn(function()
            while game:GetService('RunService').RenderStepped:Wait() do
                if Player.Character and Player.Character:FindFirstChild('Humanoid') then
                    Player.Character.Humanoid.WalkSpeed = ws
                end
            end
        end)
        Local:Slider("WalkSpeed", 'Sets your characters movement speed', 0, 200, 16, function(value)
            ws = value
        end)
    
        local jp = 50
        spawn(function()
            while game:GetService('RunService').RenderStepped:Wait() do
                if Player.Character and Player.Character:FindFirstChild('Humanoid') then
                    Player.Character.Humanoid.JumpPower = jp
                end
            end
        end)
        Local:Slider("JumpPower", 'Sets your characters jump height', 0, 400, 50, function(value)
            jp = value
        end)
    
        noclip = false
        spawn(function()
            while game:GetService('RunService').Stepped:Wait() do
                if noclip then
                    for i,v in pairs(Player.Character:GetDescendants()) do
                        if v:IsA"BasePart" then
                            v.CanCollide = false
                        end
                    end
                end
            end
        end)
        Local:Toggle("NoClip", 'Allows your character to walk through objects', false, "NC", function(value)
            noclip = value
        end)
    
        fog = false
        spawn(function()
            while game:GetService('Lighting').Changed:Wait() do
                if fog then
                    game.Lighting.FogEnd = 9e9
                    game.Lighting.Brightness = 1
                    game.Lighting.TimeOfDay = "12:00:00"
                end
            end
        end)
        Local:Toggle("Clear Fog", 'Clears all environment fog',false, "CF", function(value)
            fog = value
        end)
    
        Local:Toggle("Water Walk", 'Allows your character to walk on water',false, function(value)
            if value == false then
                for i, v in pairs(game.Workspace.Water:GetChildren()) do
                    v.CanCollide = false
                end
            else
                for i, v in pairs(game.Workspace.Water:GetChildren()) do
                    v.CanCollide = true
                end
            end
        end)
    
        Local:Line()
        Local:Label("Teleport")
    
        Local:Dropdown("Method", {"Instant", "Gravity", "Tween", "Sky", "BodyPos/Gyro"}, function(value)
            Method = value
        end)
    
        local Mouse = Player:GetMouse()
        Local:Bind("Teleport Key", Enum.KeyCode.G, function(a)
            if Mouse.Target then
                teleport(CFrame.new(Mouse.Hit.p) + Vector3.new(0,3,0))
            end
        end)
    
        local Waypoints = {
            ["Wood R Us"] = CFrame.new(265, 5, 57),
            ["SpawnPoint"] = CFrame.new(155, 5, 74),
            ['Land Store'] = CFrame.new(258, 5, -99),
            ["Link's Logic"] = CFrame.new(4607, 9, -798),
            ['Cave'] = CFrame.new(3581, -177, 430),
            ['Volcano'] = CFrame.new(-1585, 625, 1140),
            ['Swamp'] = CFrame.new(-1209, 138, -801),
            ["Palm Island"] = CFrame.new(2549, 5, -42),
            ['Fancy Furnishings'] = CFrame.new(491, 13, -1720),
            ['Boxed Cars'] = CFrame.new(509, 5.2, -1463),
            ['Fine Arts Shop'] = CFrame.new(5207, -156, 719),
            ["Bob's Shack"] = CFrame.new(260, 10, -2542),
            ["Strange Man"] = CFrame.new(1061, 20, 1131)
        }
        local ListWaypoint = {}
        for i, v in pairs(Waypoints) do
            table.insert(ListWaypoint, i)
        end
        Local:Dropdown("Waypoint", ListWaypoint, function(value)
            teleport(Waypoints[value])
        end)
    
    
        local PlayerTable = {}
        for i, v in pairs(game.Players:GetPlayers()) do
            table.insert(PlayerTable, v.Name)
        end
        local ToPlayer = Local:Dropdown("To Player", PlayerTable, function(value)
            teleport(game.Players[value].Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0))
        end)
        game.Players.PlayerAdded:Connect(function(player)
            ToPlayer:Add(player.Name)
        end)
        game.Players.PlayerRemoving:Connect(function(player)
            ToPlayer:Clear()
            for i, v in pairs(game.Players:GetPlayers()) do
                ToPlayer:Add(v.Name)
            end
        end)
        
    
        local Properties = {}
        for i, v in pairs(game:GetService("Workspace").Properties:GetChildren()) do
            if v.Owner.Value ~= nil then
                table.insert(Properties, tostring(v.Owner.Value))
            end
        end
        local ToBase = Local:Dropdown("To Base", Properties, function(value)
            for i, v in pairs(game:GetService("Workspace").Properties:GetChildren()) do
                if tostring(v.Owner.Value) == value then
                    teleport(v.OriginSquare.CFrame + Vector3.new(0,5,0))
                    break
                end
            end
        end) 
    
        local Players = UI_Init:Tab("Players", 'http://www.roblox.com/asset/?id=4370186570')
        Players:Line()
        Players:Label("Main")
    
        Players:Toggle('Infinity Range', 'Gives you infinite range', false, 'IR', function(value)
            Infinity = value
        end)
    
        local Target = nil

        local PlayerTable = {}
        for i, v in pairs(game.Players:GetPlayers()) do
            table.insert(PlayerTable, v.Name)
        end
        local targetdrop = Players:Dropdown("Target", PlayerTable, function(value)
            Target = value
        end)
        game.Players.PlayerAdded:Connect(function(player)
            targetdrop:Add(player.Name)
        end)
        game.Players.PlayerRemoving:Connect(function(player)
            targetdrop:Clear()
            for i, v in pairs(game.Players:GetPlayers()) do
                targetdrop:Add(v.Name)
            end
        end)
    
    
        function makeaxe()
            Player.Character:WaitForChild('Humanoid'):UnequipTools()
            wait(.5)
            Head = Player.Character.Head.CFrame
            Gravity = game.Workspace.Gravity
            game.Workspace.Gravity = 10
            Player.Character.Head:Destroy()
            wait()
            
            for i,v in pairs(Player.Backpack:GetChildren()) do
                if v.Name ~= "BlueprintTool" and v.Name == "Tool" then
                    v.Parent = Player
                    game.ReplicatedStorage.Interaction.ClientInteracted:FireServer(v, "Drop tool", Head)
                end
            end
            Player.CharacterAdded:Wait()
            game.Workspace.Gravity = Gravity
            return Head
        end
    
        function connect(target)
            if Player.Character:FindFirstChildOfClass("Tool") then
                if target ~= nil then
                    teleport(target.Character.HumanoidRootPart.CFrame)
                    Origin = Method
                    Method = 'a'
                    wait()
                    local character = Player.Character
                    local humanoid = character.Humanoid
    
                    humanoid.Name = "Fake"
                    local fakeHumanoid = humanoid:Clone()
                    fakeHumanoid.Parent = char
                    fakeHumanoid.Name = "Humanoid"
                    wait()
                    character.Animate.Disabled = true
                    humanoid:Destroy()
                    workspace.CurrentCamera.CameraSubject = character
                    fakeHumanoid.DisplayDistanceType = "None"
    
                    local success = false
                    spawn(function()
                        target.Character.ChildAdded:Wait() 
                        success = true  
                    end)
                    
                    local respawned = false
                    spawn(function()
                        Player.CharacterAdded:Wait()
                        respawned = true
                    end)
    
                    character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                    while not (respawned and success) do
                        game:GetService("RunService").RenderStepped:wait()
                        character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.Angles(math.rad(math.random(0,360)), 0, 0)
                    end
                    character.Animate.Disabled = false
                    Method = Origin
                    if success then 
                        return true 
                    else 
                        return false 
                    end
                end
            else
                return false
            end
        end
        function TeleportPlayer(Player, CF)
            --Player.PlayerGui.InteractionGUI.ObectInteractionClient.Disabled = true
            if connect(game.Players[Player]) then
                game:GetService('RunService').Heartbeat:wait()
                for i = 1, 3 do
                    teleport(CF)
                end
                Player.CharacterAdded:Wait()
            else
            end
            --Player.PlayerGui.InteractionGUI.ObectInteractionClient.Disabled = false
        end
    
    
        Players:Button('Kick', 'Kicks selected player', function()
            Player.Character.Humanoid:UnequipTools()
            if Target == Player.Name then
                Player:Kick('Done!')
            end
            if (not Target) or (not game.Players:FindFirstChild(Target)) then
                UI_Init:Notification("Error", "Select Player First")
                return
            end
            Player.Character:WaitForChild('Humanoid'):UnequipTools()
            if (not ( Player:FindFirstChild("Tool") or Player.Backpack:FindFirstChild("Tool") ) ) then
                UI_Init:Notification("Error", "You need axe for this action")
                return
            end
            pos = makeaxe()
            old = Method
            Method = 'Instant'
            Player.Character:WaitForChild('Humanoid'):EquipTool(Player.Backpack.Tool)
            wait(1)
            Player.Character:FindFirstChildOfClass('Tool'):FindFirstChild('Owner'):Destroy()
            TeleportPlayer(Target, CFrame.new(1000,10000,1000))
            Method = old
            wait(1)
            teleport(pos)
        end)
    
        Players:Button('Bring', 'Brings selected player', function()
            Player.Character.Humanoid:UnequipTools()
            if Target == Player.Name then
                teleport(Player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0))
            end
            if (not Target) or (not game.Players:FindFirstChild(Target)) then
                UI_Init:Notification("Error", "Select Player First")
                return
            end
            if (not ( Player:FindFirstChild("Tool") or Player.Backpack:FindFirstChild("Tool") ) ) then
                UI_Init:Notification("Error", "You need axe for this action")
                return
            end
            local origin = Player.Character.HumanoidRootPart.CFrame
            pos = makeaxe()
            old = Method
            Method = 'Instant'
            Player.Character:WaitForChild('Humanoid'):EquipTool(Player.Backpack.Tool)
            wait(1)
            TeleportPlayer(Target, origin)
            Method = old
            wait(1)
            teleport(pos)
        end)
    
        Players:Button('Kill', 'Kills selected player', function()
            Player.Character.Humanoid:UnequipTools()
            if Target == Player.Name then
                Player.Character.Head:Destroy()
            end
            if (not Target) or (not game.Players:FindFirstChild(Target)) then
                UI_Init:Notification("Error", "Select Player First")
                return
            end
            if (not ( Player:FindFirstChild("Tool") or Player.Backpack:FindFirstChild("Tool") ) ) then
                UI_Init:Notification("Error", "You need axe for this action")
                return
            end
            pos = makeaxe()
            old = Method
            Method = 'Instant'
            Player.Character:WaitForChild('Humanoid'):EquipTool(Player.Backpack.Tool)
            wait(1)
            TeleportPlayer(Target, CFrame.new(-40.5418434, -302.708801, -1287.49756))
            Method = old
            wait(1)
            teleport(pos)
        end)
    
        Players:Button('Hard Kill', 'Hard kills selected player', function()
            Player.Character.Humanoid:UnequipTools()
            if Target == Player.Name then
                Player.Character.Head:Destroy()
            end
            if (not Target) or (not game.Players:FindFirstChild(Target)) then
                UI_Init:Notification("Error", "Select Player First")
                return
            end
            if (not ( Player:FindFirstChild("Tool") or Player.Backpack:FindFirstChild("Tool") ) ) then
                UI_Init:Notification("Error", "You need axe for this action")
                return
            end
            pos = makeaxe()
            old = Method
            Method = 'Instant'
            Player.Character:WaitForChild('Humanoid'):EquipTool(Player.Backpack.Tool)
            wait(1)
            TeleportPlayer(Target, CFrame.new(-1685.43237, 387.104919, 1294.07275))
            Method = old
            wait(1)
            teleport(pos)
        end)
    
        Players:Button('Player Annoy', 'Annoys selected player', function()
            if (not Target) or (not game.Players:FindFirstChild(Target)) then
                UI_Init:Notification("Error", "Select Player First")
                return
            end
            if (not game:GetService("Workspace")["Region_Mountainside"]:FindFirstChild('SlabRegen')) then
                UI_Init:Notification("Error", "Bridge Gone")
                return
            end
            if (not Infinity) then
                UI_Init:Notification("Error", "Please Turn On Infinity Range")
                return
            end
    
            Slider = game:GetService("Workspace")["Region_Mountainside"].SlabRegen.Slab.Slider
            annoying = true
            spawn(function()
            wait(5)
            annoying = false
            end)
            Bridge_CFrame = Slider.CFrame
            while annoying do
            Slider.CFrame = game.Players[Target].Character.HumanoidRootPart.CFrame
            wait()
            end
            Slider.CFrame = Bridge_CFrame
        end)
    
        Players:Button('Base Annoy', 'Base annoys selected player', function()
            if (not Target) or (not game.Players:FindFirstChild(Target)) then
                UI_Init:Notification("Error", "Select Player First")
                return
            end
            if (not game:GetService("Workspace")["Region_Mountainside"]:FindFirstChild('SlabRegen')) then
                UI_Init:Notification("Error", "Bridge Gone")
                return
            end
            if (not Infinity) then
                UI_Init:Notification("Error", "Please Turn On Infinity Range")
                return
            end
            local land = nil
            for i, v in pairs(game:GetService("Workspace").Properties:GetChildren()) do
                if v:FindFirstChild("Owner") and tostring(v.Owner.Value) == Target then
                    land = v.OriginSquare
                end
            end
            if land == nil then
                UI_Init:Notification("Error", "I Can't Find Target's Land")
                return
            end
            Slider = game:GetService("Workspace")["Region_Mountainside"].SlabRegen.Slab.Slider
            annoying = true
            spawn(function()
            wait(10)
            annoying = false
            end)
            Bridge_CFrame = Slider.CFrame
            while annoying do
            Slider.CFrame = land.CFrame+Vector3.new(math.random(-100,100),3,math.random(-100,100))
            wait()
            end
            Slider.CFrame = Bridge_CFrame
        end)
    
        Players:Line()
        Players:Label("Global")
    
        Players:Button('Bring Boulders', 'Brings boulders', function()
            if (not Infinity) then
                UI_Init:Notification("Error", "Please Turn On Infinity Range")
                return
            end
            for i, v in pairs(game:GetService("Workspace")["Region_Volcano"].PartSpawner:GetChildren()) do
                if v.Name == 'Boulder' then
                    spawn(function()
                        for j = 1, 5 do
                            v.CFrame = Player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 10, 10)
                        end
                    end)
                end
            end
        end)
    
        Players:Button("Destroy Green Box", 'Destroys green box', function()
            pcall(function()
                game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(game:GetService("Workspace")["Region_Volcano"].VolcanoWin)
                game.ReplicatedStorage.Interaction.DestroyStructure:FireServer(game:GetService("Workspace")["Region_Volcano"].VolcanoWin)
            end)
        end)
    
        Players:Button("Remove Trees", 'Removes trees', function()
            pcall(function()
                for i, v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == 'TreeRegion' then
                        for j, k in pairs(v:GetChildren()) do
                            if k:IsA'Model' then
                                game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(k)
                                game.ReplicatedStorage.Interaction.DestroyStructure:FireServer(k)
                            end
                        end
                    end
                    wait()
                end
            end)
        end)
    
        local shop_annoy = false
        spawn(function()
            while wait() do
                if shop_annoy then
                    pcall(function()
                        for i, v in pairs(game:GetService("Workspace").Stores:GetChildren()) do
                            if v.Name == 'ShopItems' then
                                for j, k in pairs(v:GetChildren()) do
                                    if k:IsA'Model' then
                                        game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(k)
                                        game.ReplicatedStorage.Interaction.DestroyStructure:FireServer(k)
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end)
        Players:Toggle('Shop Annoy', 'Annoys the shop', false, 'SA', function(value)
            shop_annoy = value
        end)
    
    
        local Misc = UI_Init:Tab("Misc", 'http://www.roblox.com/asset/?id=3944704135')
        Misc:Line()
        Misc:Label("Land")

        Misc:Button("Free Land", "Gives you free land", function()
            local base = nil
            for i, v in pairs(game:GetService("Workspace").Properties:GetChildren()) do
                if v:FindFirstChild("Owner") and v.Owner.Value == Player then
                    base = v
                end
            end
            if not (base == nil) then
                UI_Init:Notification("Error", "There is land already")
                return
            end
            for i, v in pairs(game.Workspace.Properties:GetChildren()) do 
                if v:FindFirstChild("Owner") and v:FindFirstChild("OriginSquare") and v.Owner.Value == nil then 
                    game.ReplicatedStorage.PropertyPurchasing.ClientPurchasedProperty:FireServer(v, v.OriginSquare.Position)
                    teleport(v.OriginSquare.CFrame + Vector3.new(0, 5, 0))
                    return
                end
            end
        end)
    
        Misc:Button("Max Land", "Gives you max land", function()
            local base = nil
            local square = nil
            for i, v in pairs(game:GetService("Workspace").Properties:GetChildren()) do
                if v:FindFirstChild("Owner") and v.Owner.Value == Player then
                    base = v
                    square = v.OriginSquare
                end
            end
            if base == nil then
                UI_Init:Notification("Error", "There is no land")
                return
            end
            function makebase(pos)
                game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty:FireServer(base, pos) --i am lazy to do that so
            end
            spos = square.Position
            makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z))
            makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z))
            makebase(CFrame.new(spos.X, spos.Y, spos.Z + 40))
            makebase(CFrame.new(spos.X, spos.Y, spos.Z - 40))
            makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z + 40))
            makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z - 40))
            makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z + 40))
            makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z - 40))
            makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z))
            makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z))
            makebase(CFrame.new(spos.X, spos.Y, spos.Z + 80))
            makebase(CFrame.new(spos.X, spos.Y, spos.Z - 80))    
            makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z + 80))
            makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z - 80))
            makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z + 80))
            makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z - 80))
            makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z + 80))
            makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z + 80))
            makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z + 40))
            makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z - 40))
            makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z + 40))
            makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z - 40))
            makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z - 80))
            makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z - 80))
        end)
    
        Misc:Colorpicker("Land Color", Color3.fromRGB(124, 92, 70), function(color)
            local base = nil
            for i, v in pairs(game:GetService("Workspace").Properties:GetChildren()) do
                if v:FindFirstChild("Owner") and v.Owner.Value == Player then
                    base = v
                end
            end
            if base == nil then
                UI_Init:Notification("Error", "There is no land")
                return
            end
            for i, v in pairs(base:GetChildren()) do
                if v:IsA'BasePart' then
                    v.Color = color
                end
            end
        end)
    
        Misc:Button("Wipe My Land", "Wipes your land", function()
            for i, v in pairs(game.Workspace.PlayerModels:GetChildren()) do
                if v:FindFirstChild("Owner") then
                    if v.Owner.Value == Player then
                        game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(v)
                        game.ReplicatedStorage.Interaction.DestroyStructure:FireServer(v)
                        game:GetService('RunService').Stepped:Wait()
                    end
                end
            end
        end)
    
        Misc:Line()
        Misc:Label("Tool")
    
        local oldthread = get_thread_context()
        set_thread_context(2)
        local Axes = {}
        for i, v in pairs(game:GetService("ReplicatedStorage").Purchasables.Tools.AllTools:GetChildren()) do
            local Info = require(v.AxeClass).new()
            local Name = v.ItemName.Value 
            table.insert(Axes, {
                Name = Name,
                Info = Info 
            })
        end
        set_thread_context(oldthread)
    
        local function GetInfo(Axe, TreeClass)
            for i, v in pairs(Axes) do
                if v.Name == Axe.ToolTip then
                    local Info = v.Info
                    local Damage = Info.Damage
                    local Cooldown = Info.SwingCooldown 
                    if Info.SpecialTrees then
                        if Info.SpecialTrees[TreeClass] then
                            Damage = Info.SpecialTrees[TreeClass].Damage
                            Cooldown = Info.SpecialTrees[TreeClass].SwingCooldown
                        end
                    end
                    return {
                        Damage = Damage,
                        Cooldown = Cooldown
                    }
                end
            end
        end
    
        local auto_chop = false
        function Auto_Cut(Tree)
            local Axe = nil
            if Player.Character:FindFirstChild("Tool") then 
                Axe = Player.Character.Tool
            end
            if Axe == nil then
                return
            end
            local Damage = GetInfo(Axe, Tree.Parent.TreeClass.Value).Damage
            Height = Tree.CFrame:pointToObjectSpace(Mouse.Hit.p).Y + Tree.Size.Y/2
            local Done = false
            local chopconn
            chopconn = game.Workspace.LogModels.DescendantAdded:connect(function(new)
                local function findparent(new)
                    wait()
                    if new:FindFirstChild('Owner') then
                        if new.Parent == game.Workspace.LogModels and new.Owner.Value == Player then
                            Done = true
                            chopconn:Disconnect()
                        end
                    else
                        findparent(new.Parent)
                    end
                end
                findparent(new)
            end)
            local Cooldown = GetInfo(Axe, Tree.Parent.TreeClass.Value).Cooldown
            local ID = Mouse.Target.ID.Value
            while game:GetService('RunService').RenderStepped:Wait() do
                if Done then
                    break
                end
                if not auto_chop then
                    break
                end
                game.ReplicatedStorage.Interaction.RemoteProxy:FireServer(Tree.Parent.CutEvent, {
                    sectionId = ID,
                    faceVector = Vector3.new(0,0,-1),
                    height = Height,
                    hitPoints = Damage,
                    cooldown = Cooldown,
                    cuttingClass = "Axe",
                    tool = Axe
                })
                wait(Cooldown)
            end
        end
        Mouse.Button1Down:connect(function()
            if auto_chop then
                if Mouse.Target and Mouse.Target.Parent:FindFirstChild('TreeClass') then
                    Auto_Cut(Mouse.Target)
                end
            end
        end)

        Misc:Toggle("Auto Chop(God Axe)", "Automatically chops using your axe", false, function(value)
            auto_chop = value
        end)
    
    
        local Interaction = 11
        Misc:Slider("Interaction Range", "Sets your interaction range", 1, 10000, 11, function(value)
            Interaction = value
        end)
    
        --Interact(Item Info)
        spawn(function()
            pcall(function()
                local script = game:GetService("Players").LocalPlayer.PlayerGui.InteractionGUI.ObectInteractionClient
                game:GetService("Players").LocalPlayer.PlayerGui.InteractionGUI.ObectInteractionClient.Disabled = true
                wait(1)
    
                local buttonBumper = require(script.Parent.Parent:WaitForChild("BumpButton"))
                local noticeStateBool = game.ReplicatedStorage.Notices.ClientNoticeIsOpen
                
                local maxInteractionDistance = Interaction
                
                local Prompt = script.Parent:WaitForChild("Prompt")
                local ShowOwner = script.Parent:WaitForChild("OwnerShow")
                local Reticle = Player.PlayerGui:WaitForChild("TargetGui")
                
                local player = Player
                local Character = player.Character or player.CharacterAdded:wait()
                local Humanoid = Character:WaitForChild("Humanoid")
                Character:WaitForChild("Head")
                
                player.CharacterAdded:connect(function()
                    Character = player.Character
                    Humanoid = Character:WaitForChild("Humanoid")
                
                    Character:WaitForChild("Head")
                    interactLoop()
                end)
                
                local mouse = player:GetMouse()
                
                local button1Down = false
                
                
                local clientInteracted = game.ReplicatedStorage.Interaction.ClientInteracted
                local showInfo = script.Parent.Parent.ItemInfoGUI.ShowItemInfo
                local dragModel = player.PlayerGui.StructureDraggingGUI.DragItem
                local dragWire = player.PlayerGui.WireDraggingGUI.DragWire
                local clientPlacedStructure = game.ReplicatedStorage.PlaceStructure.ClientPlacedStructure
                local clientPlacedWire = game.ReplicatedStorage.PlaceStructure.ClientPlacedWire
                local boxIsParented = game.ReplicatedStorage.PlaceStructure.BoxIsParented
                
                local interactPermission = require(game.ReplicatedStorage.Interaction.InteractionPermission)
                
                local PromptOpen = script
                
                local badPermissions = false
                local otherOwningPlayer = nil
                
                local equippedTool = nil
                
                --------------------------------[[ Interact Loop ]]------------------------------------
                
                local interactObject = nil
                local interactType = ""
                
                function interactLoop()
                    
                
                    Character.ChildAdded:connect(function(instance)
                        if instance:IsA("Tool") then
                            equippedTool = instance
                        end
                    end)
                    Character.ChildRemoved:connect(function(instance)
                        if instance:IsA("Tool") then
                            wait()
                            if instance == equippedTool then
                                equippedTool = nil
                            end
                        end
                    end)
                
                    
                    while true do
                        wait()
                        if not Character:FindFirstChild("Head") then
                            return
                        end
                        
                        badPermissions = false
                    
                        local dist = Interaction
                        if equippedTool and equippedTool:FindFirstChild("Range") then
                            dist = equippedTool.Range.Value
                        end
                
                        if (Character.Head.Position - input.GetMouseHit().p).magnitude < dist and player.IsChatting.Value <= 1 and not player.PlayerGui.IsPlacingStructure.Value and not player.PlayerGui.ClientInfoIsOpen.Value then
                            local target = input.GetMouseTarget()
                            interactObject = getInteractObject(target)
                            
                            
                            if interactObject then
                                player.PlayerGui.MouseoverInteractionEngaged.Value = true
                                showPrompt()
                            else
                                setPromptVisibility(false)
                                if 	player.PlayerGui.MouseoverInteractionEngaged.Value then
                                    wait(0.5)
                                    player.PlayerGui.MouseoverInteractionEngaged.Value = false
                                end
                            end
                        else
                            interactObject = nil
                            
                            setPromptVisibility(false)
                            if 	player.PlayerGui.MouseoverInteractionEngaged.Value then
                                wait(0.5)
                                player.PlayerGui.MouseoverInteractionEngaged.Value = false
                            end
                        end
                        
                        ShowOwner.Visible = badPermissions and otherOwningPlayer
                        if otherOwningPlayer then
                            ShowOwner.Text.Text = otherOwningPlayer.Name
                        end
                        
                        setReticleActive(not not interactObject)
                    end
                end
                
                
                function getInteractObject(targetObject)
                    
                    local initialObject = targetObject
                
                    targetObject = findHighestParent(targetObject)
                
                    if not (targetObject and Humanoid.Health > 0 and not player.PlayerGui.IsPlacingStructure.Value) then -- General conditions
                        return nil
                    end
                
                    if not targetObject.Parent or not initialObject.Parent then
                        return
                    end
                    
                    local canInteract, otherPlayer = interactPermission:UserCanInteract(player, targetObject.Parent)
                    otherOwningPlayer = otherPlayer
                    if targetObject and not canInteract then --Insuficient permissions
                        badPermissions = true
                        return nil
                    end
                
                    for _, instance in pairs(Character:GetChildren()) do
                        if instance:IsA("Tool") then
                
                            if instance:FindFirstChild("CuttingTool") and targetObject.Parent:IsA("Model") and (targetObject.Parent:FindFirstChild("TreeClass")) then -- Cutting tool
                                interactType = ""
                                return targetObject.Parent
                            end
                                
                            return nil
                        end
                    end
                
                
                    if targetObject.Parent and initialObject.Parent then
                        if targetObject.Parent:IsA("Model") and targetObject.Parent:FindFirstChild("PurchasedBoxItemName") then -- Purchased shop box items
                            interactType = "Open box"
                            return targetObject.Parent
                        elseif targetObject.Parent:IsA("Model") and targetObject.Parent:FindFirstChild("ButtonRemote_"..initialObject.Name) or initialObject.Parent:FindFirstChild("ButtonRemote_"..initialObject.Name) then -- Any buttons
                            interactType = "Button interaction"
                            return targetObject.Parent:FindFirstChild("ButtonRemote_"..initialObject.Name) or initialObject.Parent:FindFirstChild("ButtonRemote_"..initialObject.Name) 
                        elseif targetObject.Parent:IsA("Model") and targetObject.Parent:FindFirstChild("ToolName") then -- Tool items
                            interactType = "Pick up tool"
                            return targetObject.Parent
                        elseif targetObject.Parent:IsA("Model") and targetObject.Parent:FindFirstChild("BoxItemName") and game.ReplicatedStorage.Purchasables:FindFirstChild(targetObject.Parent.BoxItemName.Value, true):FindFirstChild("ItemName") then -- Shop box items
                            interactType = "Shop get info"
                            return targetObject.Parent
                        elseif targetObject.Parent:IsA("Model") and targetObject.Parent:FindFirstChild("Settings") and targetObject.Parent.Settings:FindFirstChild("PropertySoldSign") then -- Property Sign
                            interactType = "Take down sold sign"
                            return targetObject.Parent
                        elseif targetObject.Parent:IsA("Model") and targetObject.Parent:FindFirstChild("Type") and game.ReplicatedStorage.Purchasables:FindFirstChild(targetObject.Parent.ItemName.Value, true):FindFirstChild("ItemName") then -- Structures
                            interactType = "Structure get info"
                            return targetObject.Parent
                        elseif targetObject.Parent:IsA("Model") and (targetObject.Parent:FindFirstChild("TreeClass") and not initialObject.Anchored or targetObject.Parent:FindFirstChild("Handle") or targetObject.Parent:FindFirstChild("DraggableItem")) then -- Other draggables
                            interactType = ""
                            return targetObject.Parent
                        end
                    end
                end
                
                
                function findHighestParent(child)
                    if not child then
                        return nil
                    end
                    if child.Parent:FindFirstChild("Owner") then
                        return child
                    elseif child.Parent == workspace or not child.Parent then
                        return nil
                    else
                        return findHighestParent(child.Parent)
                    end
                end
                
                
                
                function setReticleActive(v)
                    Reticle.Active.Value = v
                end
                
                --------------------------------[[ Interact Action ]]------------------------------------
                
                local tutFired = false
                
                function interactWithObject()
                    
                    if badPermissions then
                        --game.ReplicatedStorage.Notices.SendUserNotice:Fire("Insufficient permissions", 1.5)
                        --Player.PlayerGui.ClientSounds.Err:Play()
                    elseif interactObject then
                        if not buttonBumper.Bump(Prompt) then
                            return
                        end
                        
                        if interactObject and interactType == "Open box" and interactObject:FindFirstChild("Type") and ( interactObject.Type.Value == "Structure" or interactObject.Type.Value == "Furniture" or interactObject.Type.Value == "Vehicle" or interactObject.Type.Value == "Vehicle Spot" or interactObject.Type.Value == "Vehicle Spot" or  interactObject.Type.Value == "Wire") then
                            local folder = game.ReplicatedStorage.Purchasables:FindFirstChild(interactObject.PurchasedBoxItemName.Value, true)
                            if interactObject.Type.Value == "Structure" or interactObject.Type.Value == "Furniture" or interactObject.Type.Value == "Vehicle" or interactObject.Type.Value == "Vehicle Spot" or interactObject.Type.Value == "Vehicle Spot" then
                                local model = folder and folder:FindFirstChild("PlacingModel") and folder.PlacingModel:clone() or folder.Model:clone()
                                if model then -- Drag place structure
                                    
                                    local box = interactObject
                                    local boxParent = box.Parent
                                    box.Parent = nil
                                    
                                    local structureName = interactObject.PurchasedBoxItemName.Value
                                    local placeCFrame, otherPlayer = dragModel:Invoke(model)
                    
                                    if placeCFrame then
                                        --box.Parent = boxParent	
                                        clientPlacedStructure:FireServer(structureName, placeCFrame, otherPlayer, nil, box, false, true)
                                        
                                            
                                            
                                        if structureName == "Sawmill" and not tutFired then
                                            tutFired = true
                                            wait(1)
                                            game.ReplicatedStorage.Notices.ShowUserInstruction:Fire("BoughtSawmill")
                                        end
                                    else
                                        box.Parent = boxParent	
                                        if boxIsParented:InvokeServer(box, boxParent) then
                                            game.ReplicatedStorage.Notices.SendUserNotice:Fire("Structure packed back into box.")
                                        else
                                            game.ReplicatedStorage.Notices.SendUserNotice:Fire("Someone else already opened this box.")
                                            box:Destroy()
                                        end
                                    end
                                end
                                
                            elseif interactObject.Type.Value == "Wire" then 
                                local box = interactObject
                                local boxParent = box.Parent
                                box.Parent = nil
                                
                                local placeCFrames, otherPlayer = dragWire:Invoke(folder)
                
                                if placeCFrames then
                                    --box.Parent = boxParent	
                                    clientPlacedWire:FireServer(folder, placeCFrames, otherPlayer, box, true)
                                else
                                    box.Parent = boxParent	
                                    if boxIsParented:InvokeServer(box, boxParent) then
                                        game.ReplicatedStorage.Notices.SendUserNotice:Fire("Wire packed back into box.")
                                    else
                                        game.ReplicatedStorage.Notices.SendUserNotice:Fire("Someone else already opened this box.")
                                        box:Destroy()
                                    end
                                end
                            end
                            
                        elseif interactObject and interactType == "Button interaction" then
                            game.ReplicatedStorage.Interaction.RemoteProxy:FireServer(interactObject)
                            
                        elseif interactObject and (interactType == "Shop get info" or interactType == "Structure get info") then
                            showInfo:Fire(interactObject, interactType)
                        else
                            clientInteracted:FireServer(interactObject, interactType)
                        end
                    end
                end
                
                
                function dropTool()
                    --[[for _, instance in pairs(Character:GetChildren()) do
                        if instance:IsA("Tool") then
                            local grip = Character:FindFirstChild("RightGrip", true)
                            if grip then
                                grip:Destroy()
                            end
                            clientInteracted:FireServer(instance, "Drop tool", instance.Handle.CFrame)
                            break
                        end
                    end]]
                    
                    if noticeStateBool.Value then
                        return
                    end
                    
                    if not Character.Parent or not Character:FindFirstChild("Head") then
                        return
                    end
                    
                    local tool = equippedTool
                    --local savingOrLoading, hardReload = game.ReplicatedStorage.LoadSaveRequests.GetSaving:InvokeServer()
                    if not player:FindFirstChild("CurrentlySavingOrLoading") or player.CurrentlySavingOrLoading.HardReload.Value--[[ or hardReload]] then
                        return
                    end
                    
                    
                    if tool and equippedTool and tool:FindFirstChild("Handle") and (tool.Handle.CFrame.p - Character.Head.CFrame.p).magnitude < 20 then
                        equippedTool = nil
                        local grip = Character:FindFirstChild("RightGrip", true)
                        if grip then
                            grip:Destroy()
                        end
                        Character.Humanoid:EquipTool(tool)
                        clientInteracted:FireServer(equippedTool, "Drop tool", tool.Handle.CFrame)
                    end
                end
                
                --------------------------------[[ Transitions ]]------------------------------------
                
                local currentInteractTypePrompt = ""
                function showPrompt()
                    
                    if Prompt.Visible and currentInteractTypePrompt == interactType then
                        return
                    end
                    currentInteractTypePrompt = interactType
                    
                    if interactType == "Open box" then
                        Prompt.PromptText.Text = "Open box"
                    elseif interactType == "Pick up tool" then
                        Prompt.PromptText.Text = "Pick up "..game.ReplicatedStorage.Purchasables.Tools.AllTools:FindFirstChild(interactObject.ToolName.Value).ItemName.Value
                    elseif interactType == "Shop get info" then
                        Prompt.PromptText.Text = "Check"
                    elseif interactType == "Structure get info" then
                        Prompt.PromptText.Text = "Check"
                    elseif interactType == "Take down sold sign" then
                        Prompt.PromptText.Text = "Remove sign"
                    elseif interactType == "Button interaction" then
                        if interactObject:FindFirstChild("ButtonPrompt") then
                            Prompt.PromptText.Text = interactObject.ButtonPrompt.Value
                        else
                            Prompt.PromptText.Text = "Interact"
                        end
                    else
                        setPromptVisibility(false)
                        return
                    end
                    
                    for i = 50, 350 do
                        Prompt.Size = UDim2.new(0, i, 0, 50)
                        if Prompt.PromptText.TextFits then
                            Prompt.Size = UDim2.new(0, i + 20, 0, 50)
                            break
                        end
                    end
                    
                    
                    setPlatformControls()
                    setPromptVisibility(true)
                end
                
                
                function setPlatformControls()
                    if input.IsGamePadEnabled() then
                        Prompt.PlatformButton.Image = Prompt.PlatformButton.Gamepad.Value
                        Prompt.PlatformButton.KeyLabel.Text = ""
                    else
                        Prompt.PlatformButton.Image = Prompt.PlatformButton.PC.Value
                        Prompt.PlatformButton.KeyLabel.Text = "E"
                    end
                end
                
                
                
                function setPromptVisibility(v)
                    if not v and not interactObject then
                        setReticleActive(v)
                    end
                    Prompt.Visible = v
                end
                
                
                --------------------------------[[ User Input ]]------------------------------------
                
                wait(1)
                
                input = require(script.Parent.Parent:WaitForChild("Scripts"):WaitForChild("UserInput"))
                
                input.InteractSelectionMade(interactWithObject)
                input.DropTool(dropTool)
                
                
                interactLoop()
            end)
        end)
    
        local GreyWood = false
    
        function getCFrameOfBlueprint(blueprint)
            local CF
            if blueprint:FindFirstChild("MainCFrame") then
            CF = blueprint.MainCFrame.Value
            else
            CF = blueprint.PrimaryPart.CFrame
            end
            return CF
        end 
    
        local PatchedBlocks = {
            ['Floor1Large'] = {
                {
                    ['Name'] = 'Floor1',
                    ['ObjectSpace'] = CFrame.new(2, 0, -2)
                },
                {
                    ['Name'] = 'Floor1',
                    ['ObjectSpace'] = CFrame.new(2, 0, 2)
                },
                {
                    ['Name'] = 'Floor1',
                    ['ObjectSpace'] = CFrame.new(-2, 0, 2)
                },
                {
                    ['Name'] = 'Floor1',
                    ['ObjectSpace'] = CFrame.new(-2, 0, -2)
                }
            },
            ['Floor1'] = {
                {
                    ['Name'] = 'Floor1Small',
                    ['ObjectSpace'] = CFrame.new(1, 0, -1)
                },
                {
                    ['Name'] = 'Floor1Small',
                    ['ObjectSpace'] = CFrame.new(1, 0, 1)
                },
                {
                    ['Name'] = 'Floor1Small',
                    ['ObjectSpace'] = CFrame.new(-1, 0, 1)
                },
                {
                    ['Name'] = 'Floor1Small',
                    ['ObjectSpace'] = CFrame.new(-1, 0, -1)
                }
            }
        }
    
        function getBlueprints()
            local Blueprints = {}
            for i, v in pairs(game:GetService("Workspace").PlayerModels:GetChildren()) do
                if v:FindFirstChild('Type') and v:FindFirstChild('Owner') then
                    if (v.Type.Value == 'Blueprint') and (v.Owner.Value == Player) then
                        table.insert(Blueprints, v)
                    end
                end
            end
            return Blueprints
        end
    
        function countBlueprints()
            local Blueprints = 0
            for i, v in pairs(game:GetService("Workspace").PlayerModels:GetChildren()) do
                if Blueprints > 50 then return 50 end 
                if v:FindFirstChild('Type') and v:FindFirstChild('Owner') then
                    if (v.Type.Value == 'Blueprint') and (v.Owner.Value == Player) then
                        Blueprints = Blueprints + 1 
                    end
                end
            end
            return Blueprints
        end
    
        function placeGray(payload)
            local Blueprints = countBlueprints()
            local Available = 50 - Blueprints
            local NextTime = {}
            local toBuild = {}
    
            local NeedsType = {} 
    
            for i, v in pairs(payload) do
                if i > Available then 
                    table.insert(NextTime, v)
                else
                    table.insert(toBuild, v)
                    table.insert(NeedsType, v.Name)
                end
            end
    
            local CurrentBlueprints = getBlueprints()
            local NewAddedBlueprints = {}
    
            local addConn = game:GetService("Workspace").PlayerModels.ChildAdded:Connect(function(new)
                local Owner = new:WaitForChild('Owner')
                local Type = new:WaitForChild('Type')
                if Type and Owner then
                    if (Type.Value == 'Blueprint') and (Owner.Value == Player) then
                        if table.find(NeedsType, new:WaitForChild('ItemName').Value) then
                            table.insert(NewAddedBlueprints, new)
                            table.insert(CurrentBlueprints, new)
                            table.remove(NeedsType, table.find(NeedsType, new:WaitForChild('ItemName').Value))
                        end
                    end
                end
            end)
    
            for i, v in pairs(toBuild) do
                game.ReplicatedStorage.PlaceStructure.ClientPlacedBlueprint:FireServer(v.Name, v.CFrame, Player, nil, false)
            end
    
            repeat game:GetService('RunService').Stepped:Wait() until #NewAddedBlueprints == #toBuild
    
            addConn:Disconnect()
    
            for i, v in pairs(NewAddedBlueprints) do
                paintGray(v)
            end
        end
    
        function paintGray(blueprint)
            local Name = blueprint.ItemName.Value
            game.ReplicatedStorage.PlaceStructure.ClientPlacedStructure:FireServer(Name, getCFrameOfBlueprint(blueprint), Player, nil, blueprint, true)
            if not PatchedBlocks[Name] then
                return
            end
            local Patch = PatchedBlocks[Name]
            local Payload = {}
            for i, v in pairs(Patch) do
                table.insert(Payload, {
                    Name = v.Name,
                    CFrame = v.ObjectSpace:ToWorldSpace(getCFrameOfBlueprint(blueprint))
                })
            end
            placeGray(Payload)
        end
    
        Mouse.Button1Down:connect(function()
            if GreyWood then
                if Mouse.Target and Mouse.Target.Parent:FindFirstChild("Type") or Mouse.Target.Parent:FindFirstChild("BlueprintWoodClass") then
                    local CF
                    if Mouse.Target.Parent:FindFirstChild("MainCFrame") then
                    CF = Mouse.Target.Parent.MainCFrame.Value
                    else
                    CF = Mouse.Target.Parent.PrimaryPart.CFrame
                    end
                    if Mouse.Target.Parent ~= nil then
                        paintGray(Mouse.Target.Parent)
                    end
                end
            end
        end)
        Misc:Toggle("Grey Wood", "Grey wood", false, function(value)
            GreyWood = value
        end)
    
        local Magnet = false
    
        spawn(function()
            while wait(1) do
                if Magnet then
                    for i, v in pairs(game.Workspace.PlayerModels:GetChildren()) do
                        TeleportItem(v, Player.Character.HumanoidRootPart.Position)
                    end
                end
            end
        end)
    
        Misc:Toggle("Magnet Item", "Makes items magnetic (come toward you)", false, function(value)
            Magnet = value
        end)
    
        Misc:Button("Give Temporary BluePrints", "Gives temporary blueprints", function()
            for i, v in pairs(game.ReplicatedStorage.Purchasables.Structures.BlueprintStructures:GetChildren()) do
                if not Player.PlayerBlueprints.Blueprints:FindFirstChild(v.Name) then
                    local blueprint = Instance.new("Folder", Player.PlayerBlueprints.Blueprints)
                    blueprint.Name = v.Name
                    local category = v.ItemCategory:Clone()
                    category.Parent = blueprint
                end
            end
            UI_Init:Notification('Success',"All BluePrint Given")
        end)
    
        function counttools()
            local tools = 0
            for i, v in pairs(Player.Character:GetChildren()) do
                if v:IsA"Tool" then
                    tools = tools + 1
                end
            end
            for i, v in pairs(Player.Backpack:GetChildren()) do
                if v.Name ~= "BlueprintTool" then
                    tools = tools + 1
                end
            end 
            return tools
        end
    
        Misc:Button('Pick Up All Axes', "Picks up all axes", function()
            for i,v in pairs(game.Workspace.PlayerModels:GetChildren()) do
                local tool = counttools()
                if tool < 9 then
                    game.ReplicatedStorage.Interaction.ClientInteracted:FireServer(v, "Pick up tool")
                    wait(.5)
                    Player.Character.Humanoid:UnequipTools()
                end
            end
        end)
    
        Misc:Button('Drop All Axes', "Drops all axes", function()
            for i, v in pairs(Player.Backpack:GetChildren()) do
                if v.Name ~= "BlueprintTool" then
                game.ReplicatedStorage.Interaction.ClientInteracted:FireServer(v, "Drop tool", Player.Character.Head.CFrame + Vector3.new(0,3,0))
                end
            end
        end)
    
        local WoodsMenu = UI_Init:Tab('Woods', "http://www.roblox.com/asset/?id=6023426938")
    
        local Items = UI_Init:Tab("Items", "http://www.roblox.com/asset/?id=6022668888")
    
        Items:Line()
        Items:Label("Auto Buy")
    
        Instance.new("Dialog", game.Workspace.Stores.FurnitureStore.Corey)
        Instance.new("Dialog", game.Workspace.Stores.CarStore.Jenny)
        Instance.new("Dialog", game.Workspace.Stores.LogicStore.Lincoln)
    
        function GetStore(Item)
            if Item == nil then
                return nil 
            end
            local ShopItem = Item.Parent
            if ShopItem:FindFirstChild('BasicHatchet') then
                return game:GetService("Workspace").Stores.WoodRUs
            elseif ShopItem:FindFirstChild('WallLight1') then
                return game:GetService("Workspace").Stores.FurnitureStore
            elseif ShopItem:FindFirstChild('Pickup1') then
                return game:GetService("Workspace").Stores.CarStore
            elseif ShopItem:FindFirstChild('Dynamite') then
                return game:GetService("Workspace").Stores.ShackShop
            elseif ShopItem:FindFirstChild('Painting1') then
                return game:GetService("Workspace").Stores.FineArt
            elseif ShopItem:FindFirstChild("GateXOR") then
                return game:GetService("Workspace").Stores.LogicStore
            end
            return nil
        end
    
        function GetItem(ItemName)
            for i, v in pairs(game:GetService("Workspace").Stores:GetChildren()) do
                if v.Name == "ShopItems" then
                    for j, k in pairs(v:GetChildren()) do
                        if k.Name == ItemName then
                            local selectionBox = Instance.new("SelectionBox")
                            selectionBox.Name = "Selector"
                            selectionBox.Adornee = k.PrimaryPart
                            selectionBox.Color3 = Color3.new(46, 204, 113)
                            selectionBox.Parent = k.PrimaryPart
                            return k
                        end
                    end
                end
            end
            game:GetService('RunService').RenderStepped:Wait()
            return GetItem(ItemName)
        end
    
        function Buy(ItemName) 
            Item = GetItem(ItemName)
            Store = GetStore(Item) 
            if Store == nil then
                return Item
            end
            if not Infinity then
                teleport(CFrame.new(Item.PrimaryPart.Position)+Vector3.new(5,4,0))
            end
            for i=1, 15 do 
                game.ReplicatedStorage.Interaction.ClientRequestOwnership:FireServer(Item) 
                Item:MoveTo(Store.Counter.Position) 
                game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(Item) 
            end
    
            Seller = nil
            for i, v in pairs(Store:GetChildren()) do 
                if v:FindFirstChild('HumanoidRootPart') then 
                    Seller = v
                end 
            end
            local CharacterID = {
                ['Bird'] = 1,
                ['Strange Man'] = 2, 
                ['Joel'] = 3,
                ['Geck'] = 4,
                ['Slam'] = 5,
                ['Ruhven'] = 6,
                ['Seranok'] = 7,
                ['Merely'] = 8,
                ['Hoover'] = 9,
                ['Thom'] = 10,
                ['Corey'] = 11,
                ['Jenny'] = 12,
                ['Bob'] = 13,
                ['Timothy'] = 14,
                ['Lincoln'] = 15
            }
            local PurchaseComplete = false
            local ReturnItem = nil
            local WaitForPurchase
            WaitForPurchase = game.Workspace.PlayerModels.ChildAdded:connect(function(new)
                if new:WaitForChild("Owner").Value == Player then
                    if not Infinity then
                        teleport(CFrame.new(Item.PrimaryPart.Position)+Vector3.new(4,4,0))
                    end
                    if new.PrimaryPart:FindFirstChild('Selector') then
                        new.PrimaryPart.Selector:Destroy()
                    end
                    if Item.PrimaryPart:FindFirstChild('Selector') then
                        Item.PrimaryPart.Selector:Destroy()
                    end
                    WaitForPurchase:Disconnect()
                    PurchaseComplete = true
                    ReturnItem = new
                end
            end)
            game.ReplicatedStorage.NPCDialog.PlayerChatted:InvokeServer({ 
                ["Character"] = Seller, 
                ['Name'] = Seller.Name,
                ["ID"] = CharacterID[Seller.Name], 
                ["Dialog"] = Seller.Dialog}, "Initiate") 
            game.ReplicatedStorage.NPCDialog.PlayerChatted:InvokeServer({ 
                ["Character"] = Seller,
                ['Name'] = Seller.Name, 
                ["ID"] = CharacterID[Seller.Name], 
                ["Dialog"] = Seller.Dialog}, "ConfirmPurchase") 
            game.ReplicatedStorage.NPCDialog.PlayerChatted:InvokeServer({ 
                ["Character"] = Seller,
                ['Name'] = Seller.Name,
                ["ID"] = CharacterID[Seller.Name], 
                ["Dialog"] = Seller.Dialog} ,"EndChat")
            game:GetService('RunService').Stepped:Wait()
            if not PurchaseComplete then
                WaitForPurchase:Disconnect()
                if Item.PrimaryPart:FindFirstChild('Selector') then
                    Item.PrimaryPart.Selector:Destroy()
                end
                return Buy(ItemName)
            end
            return ReturnItem
        end
    
    
        local ShopItemList = { 'ManyAxe' }
        function IsInList(List, Value)
            for i, v in pairs(List) do
                if v == Value then
                    return true
                end
            end
            return false
        end
        for i, v in pairs(game:GetService("Workspace").Stores:GetChildren()) do
            if v.Name == "ShopItems" then
                for j, k in pairs(v:GetChildren()) do
                    if not IsInList(ShopItemList, k.Name) then
                        table.insert(ShopItemList, k.Name)
                    end
                end
            end
        end
    
        function Buy_Multiple(ItemName, Quality)
            local Tik = tick()
            LocationVec = Player.Character.HumanoidRootPart.Position + Vector3.new(0,10,0)
            for i = 1, Quality do
                local Item = Buy(ItemName)
                TeleportItem(Item, LocationVec)
            end
            if not Infinity then
            teleport(CFrame.new(LocationVec))
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "Done";
                Text = "Time : " .. tostring(tick() - Tik) .. "s";
                Duration = 30;
            })
        end
        local Quality = 1
        local Item = "BasicHatchet"
        Items:Slider("Quality", "Sets auto buy item quality", 0, 100, 1, function(value)
            Quality = value
        end)
    
        Items:Dropdown("Item", ShopItemList, function(value)
            Item = value
        end)
    
        Items:Button("Buy", "Purchases selected item", function()
            Buy_Multiple(Item, Quality)
        end)
    
        Items:Button("Buy All Blueprint", "Purchases all blueprints", function()
            local Tik = tick()
            for i,v in pairs(game.ReplicatedStorage.Purchasables.Structures.BlueprintStructures:GetChildren()) do
                if not Player.PlayerBlueprints.Blueprints:FindFirstChild(v.Name) then
                    local Item = Buy(v.Name)
                    game:GetService("ReplicatedStorage").Interaction.ClientInteracted:FireServer(Item, "Open box")
                end
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "Done";
                Text = "Time : " .. tostring(tick() - Tik) .. "s";
                Duration = 30;
            })
        end)
    
        Special = nil
        Special_Quality = 1
        Items:Slider("Special Auto Buy Quality", "Sets special auto buy item quality", 0, 100, 1, function(value)
            Special_Quality = value
        end)
    
        Items:Dropdown("Special Auto Buy Item", {"Bridge", "Power"}, function(value)
            Special = value
        end)
    
        Items:Button("Special Buy", "Purchases selected special item", function()
            local Tik = tick()
            for i = 1, Special_Quality do
                if Special == 'Bridge' then
                    spawn(function()
                        Seller = game:GetService("Workspace").Bridge.TollBooth0.Seranok
                        game.ReplicatedStorage.NPCDialog.PlayerChatted:InvokeServer({ 
                            ["Character"] = Seller, 
                            ['Name'] = Seller.Name,
                            ["ID"] = 7, 
                            ["Dialog"] = Seller.Dialog}, 
                        "Initiate") 
                        game.ReplicatedStorage.NPCDialog.PlayerChatted:InvokeServer({ 
                            ["Character"] = Seller,
                            ['Name'] = Seller.Name, 
                            ["ID"] = 7, 
                            ["Dialog"] = Seller.Dialog}, 
                        "ConfirmPurchase") 
                        game.ReplicatedStorage.NPCDialog.PlayerChatted:InvokeServer({ 
                            ["Character"] = Seller,
                            ['Name'] = Seller.Name,
                            ["ID"] = 7, 
                            ["Dialog"] = Seller.Dialog},
                        "EndChat")
                    end)
                end
                if Special == 'Power' then
                    Seller = game:GetService("Workspace")["Region_Main"]["Strange Man"]
                    game.ReplicatedStorage.NPCDialog.PlayerChatted:InvokeServer({ 
                        ["Character"] = Seller, 
                        ['Name'] = Seller.Name,
                        ["ID"] = 2, 
                        ["Dialog"] = Seller.Dialog}, 
                    "Initiate") 
                    game.ReplicatedStorage.NPCDialog.PlayerChatted:InvokeServer({ 
                        ["Character"] = Seller,
                        ['Name'] = Seller.Name, 
                        ["ID"] = 2, 
                        ["Dialog"] = Seller.Dialog}, 
                    "ConfirmPurchase") 
                    game.ReplicatedStorage.NPCDialog.PlayerChatted:InvokeServer({ 
                        ["Character"] = Seller,
                        ['Name'] = Seller.Name,
                        ["ID"] = 2, 
                        ["Dialog"] = Seller.Dialog},
                    "EndChat")
                end
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "Done";
                Text = "Time : " .. tostring(tick() - Tik) .. "s";
                Duration = 30;
            })
        end)
    
    
        WoodsMenu:Line()
        WoodsMenu:Label("Mod Woods")
    
        local Tree 
        local Sawmil
    
        local TreeSelectionBox
        local SawmillSelectionBox
    
        local SawSelecting = false
        local SawSelectButton
        SawSelectButton = WoodsMenu:Button('Select Sawmill', "Select sawmill", function()
            Sawmil = nil
            if SawmillSelectionBox then
                SawmillSelectionBox:Destroy()
                SawmillSelectionBox = nil
            end
            if SawSelecting then
                SawSelecting = false
                SawSelectButton:updateButton('Select Sawmill')
            else
                SawSelecting = true
                SawSelectButton:updateButton('Cancel')
            end
        end)
    
        local TreeSelecting = false
        local TreeSelectButton
        TreeSelectButton = WoodsMenu:Button('Select Tree', "Select tree", function()
            Tree = nil
            if TreeSelectionBox then
                TreeSelectionBox:Destroy()
                TreeSelectionBox = nil
            end
            if TreeSelecting then
                TreeSelecting = false
                TreeSelectButton:updateButton('Select Tree')
            else
                TreeSelecting = true
                TreeSelectButton:updateButton('Cancel')
            end
        end)
    
        Mouse.Button1Down:Connect(function()
            if Mouse.Target then
                if SawSelecting then
                    local Target = Mouse.Target
                    local Saw = nil
                    if (Target.Parent.Name == 'Parts') then
                        if Target.Parent.Parent.Parent == game:GetService("Workspace").PlayerModels then
                            Saw = Target.Parent.Parent
                        end
                    elseif (Target.Parent.Parent == game:GetService("Workspace").PlayerModels) then
                        Saw = Target.Parent
                    end
                    if Saw then
                        if Saw:FindFirstChild('Main') and Saw:FindFirstChild('Settings') and Saw:FindFirstChild('SquarePos') and Saw:FindFirstChild('XUp') then
                            SawmillSelectionBox = Instance.new('SelectionBox')
                            SawmillSelectionBox.Parent = Saw
                            SawmillSelectionBox.Adornee = Saw
                            Sawmil = Saw 
                            SawSelecting = false
                            ModWood:updateButton(SawSelectButton, 'Sawmill Selected')
                        end
                    end
                end
                if TreeSelecting then
                    local Target = Mouse.Target
                    local Wood = nil
                    if (Target.Name == 'WoodSection') then
                        Wood = Target.Parent
                    end
                    if Wood then
                        if Wood.Parent == game:GetService("Workspace").LogModels then
                            TreeSelectionBox = Instance.new('SelectionBox')
                            TreeSelectionBox.Parent = Wood
                            TreeSelectionBox.Adornee = Wood
                            Tree = Wood 
                            TreeSelecting = false
                            ModWood:updateButton(TreeSelectButton, 'Tree Selected')
                        end
                    end
                end
            end
        end)
    
        WoodsMenu:Button('Mod Wood', "Mods wood", function()
            local old = Player.Character.HumanoidRootPart.CFrame
    
            if not (Tree and Sawmil) then
                UI_Init:Notification('Error', 'Select tree and sawmill first')
                return
            end
    
            local ToSawmil
            local ToBurn
            local ToCut
            
            local Axe = nil
            if Tree.TreeClass.Value ~= 'LoneCave' then
            for i, v in pairs(Player.Character:GetChildren()) do
                if v:FindFirstChild('ToolName') then
                    Axe = v
                    break
                end
            end
            if Axe == nil then
                for i, v in pairs(Player.Backpack:GetChildren()) do
                    if v:FindFirstChild('ToolName') then
                        Axe = v
                        break
                    end
                end
            end
            else
            for i, v in pairs(Player.Character:GetChildren()) do
                if v:FindFirstChild('ToolName') and v.ToolName.Value == 'EndTimesAxe' then
                    Axe = v
                    break
                end
            end
            if Axe == nil then
                for i, v in pairs(Player.Backpack:GetChildren()) do
                    if v:FindFirstChild('ToolName') and v.ToolName.Value == 'EndTimesAxe' then
                        Axe = v
                        break
                    end
                end
            end
            end
            if not Axe then
                UI_Init:Notification('Info', 'You need an axe to mod wood')
                return
            end
    
            local MinimumID = 100000
            local MaximumID = 0
            for i, v in pairs(Tree:GetChildren()) do
                if v.Name == 'WoodSection' then
                    local ID = v.ID.Value
                    if ID == 1 then
                        ToCut = v 
                    end
                    if MaximumID < ID then
                        ToSawmil = v
                        for j, k in pairs(Tree:GetChildren()) do
                            if k.Name == 'WoodSection' then
                                if k.ID.Value == v.ParentID.Value then
                                    ToBurn = k 
                                    break
                                end
                            end
                        end 
                        MaximumID = ID
                    end
                    if MinimumID > ID then
                        MinimumID = ID
                    end
                end
            end
            
            local selectionBox = Instance.new("SelectionBox")
            selectionBox.Adornee = ToSawmil
            selectionBox.Parent = ToSawmil
            
            local selectionBox = Instance.new("SelectionBox")
            selectionBox.Adornee = ToBurn
            selectionBox.Parent = ToBurn
            
            local Damage = GetInfo(Axe, Tree.TreeClass.Value).Damage
            local Cooldown = GetInfo(Axe, Tree.TreeClass.Value).Cooldown
            
            
            teleport(CFrame.new(ToBurn.Position))
            
            repeat 
                game.ReplicatedStorage.Interaction.ClientRequestOwnership:FireServer(ToBurn)
                game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(ToBurn)  
                firetouchinterest(ToBurn, game.Workspace["Region_Volcano"].Lava.Lava, 0)
                wait()
                firetouchinterest(ToBurn, game.Workspace["Region_Volcano"].Lava.Lava, 1)
            until ToBurn:FindFirstChild('LavaFire')
            
            local Chopped = false
            treecon = game.Workspace.LogModels.ChildAdded:connect(function(add)
                local Owner = add:WaitForChild('Owner')
                if (add.Owner.Value == Player) and (add.TreeClass.Value == Tree.TreeClass.Value) and add:FindFirstChild("WoodSection") then
                    Chopped = true
                    treecon:Disconnect()
                end
            end)
            
            repeat
                teleport(CFrame.new(ToCut.Position)) 
                game.ReplicatedStorage.Interaction.RemoteProxy:FireServer(Tree.CutEvent, {
                    sectionId = MinimumID,
                    faceVector = Vector3.new(0, 0, -1),
                    height = 0.3,
                    hitPoints = Damage,
                    cooldown = Cooldown,
                    cuttingClass = "Axe",
                    tool = Axe
                })
                wait(Cooldown)
            until Chopped
            
            repeat
                teleport(CFrame.new(ToSawmil.Position)) 
                game.ReplicatedStorage.Interaction.ClientRequestOwnership:FireServer(ToSawmil)
                game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(ToSawmil)  
                ToSawmil.CFrame = Sawmil.Particles.CFrame
                game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(ToSawmil) 
                wait(1)
            until ToSawmil.Parent == nil    
    
            ModWood:updateButton(TreeSelectButton, 'Select Tree')
            ModWood:updateButton(SawSelectButton, 'Select Tree')
            Sawmil = nil
            Tree = nil
            if TreeSelectionBox then
                TreeSelectionBox:Destroy()
                TreeSelectionBox = nil
            end
            if SawmillSelectionBox then
                SawmillSelectionBox:Destroy()
                SawmillSelectionBox = nil
            end
    
            teleport(old)
        end)
    
        Items:Line()
        Items:Label("Money Dupe")
    
        local Repeat = 1
    
        Items:Slider('Repeat', "Times to repeat duping the money", 1, 10, 1, function(value)
            Repeat = value
        end)
    
        local SlotFunc
    
        for i, v in pairs(getgc()) do
            if type(v) == 'function' then
                if getfenv(v).script == game:GetService("Players").LocalPlayer.PlayerGui.PropertyPurchasingGUI.PropertyPurchasingClient then
                    local const = getconstants(v)
                    if table.find(const,'enterPurchaseMode') then
                        SlotFunc = v
                        break
                    end
                end
            end
        end
    
        local function DupeMoney()
            if Player.CurrentSaveSlot.Value ~= -1 then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Waiting";
                    Text = "Waiting Reload CoolTime";
                    Duration = 5;
                })
                local Slot = Player.CurrentSaveSlot.Value
                game.ReplicatedStorage.LoadSaveRequests.RequestSave:InvokeServer(Slot)
                repeat wait() until game:GetService("ReplicatedStorage").LoadSaveRequests.ClientMayLoad:InvokeServer() == true
                local OldFunds = game:GetService("ReplicatedStorage").Transactions.ClientToServer.GetFunds:InvokeServer()
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Duping";
                    Text = "Duping Money...";
                    Duration = 5;
                })
                local Donation = false
                spawn(function()
                    game:GetService("ReplicatedStorage").Transactions.ClientToServer.Donate:InvokeServer(Player, OldFunds, 1)
                    Donation = true
                end)
                repeat wait() until game:GetService("ReplicatedStorage").Transactions.ClientToServer.GetFunds:InvokeServer() ~= OldFunds
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Reloading Slot";
                    Text = "Reloading Slot";
                    Duration = 5;
                })
                game.ReplicatedStorage.LoadSaveRequests.RequestLoad:InvokeServer(Slot)
                local OldFunds = game:GetService("ReplicatedStorage").Transactions.ClientToServer.GetFunds:InvokeServer()
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Waiting";
                    Text = "Waiting Money Back...";
                    Duration = 5;
                })
                repeat wait() until Donation
            end
        end
    
        Items:Button('Dupe', "Dupes money", function()
            for i = 1, Repeat do
                DupeMoney()
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "Completed";
                Text = "Done Money Duping..";
                Duration = 10;
            })
        end)
    
    
        local DupeMode = false
        function SaveReturn(...)
            return true, "noob lt2"
        end
        
        local mt = getrawmetatable(game) 
        local backup = mt.__namecall 
        if setreadonly then setreadonly(mt, false) else make_writeable(mt, true) end 
        
        mt.__namecall = newcclosure(function(...) 
            local method = getnamecallmethod() 
            local args = {...} 
            if (method == "InvokeServer") and tostring(args[1]) == "RequestSave" then 
                if DupeMode then
                    return SaveReturn(...)
                else
                    backup(...)
                end
            end
            return backup(...)
        end)
    
        function TeleportTables(itemtable, pos)
    
            local function require_owner(model)
                game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(model)
            end
    
            for i, v in pairs(itemtable) do
                for j, k in pairs(v:GetDescendants()) do
                    if k:IsA'BasePart' then
                        k.CanCollide = false
                    end
                end
                local BodyPos = Instance.new("BodyPosition")
                BodyPos.Parent = v.PrimaryPart
                BodyPos.maxForce = Vector3.new(9e9, 9e9, 9e9)
                BodyPos.Position = pos
                BodyPos.P = 10000
                local BodyGyro = Instance.new("BodyGyro")
                BodyGyro.Parent = v.PrimaryPart
            end
            
            for i, v in pairs(itemtable) do
                if (pos - v:FindFirstChildOfClass('Part').Position).magnitude > 7 then
                    teleport(CFrame.new(v.PrimaryPart.Position))
    
                    require_owner(v)
                    
                    for j, k in pairs(itemtable) do
                        if Player:DistanceFromCharacter(k:FindFirstChildOfClass('Part').Position) < 20 then
                            require_owner(k)
                        end
                    end
    
                    game:GetService('RunService').Stepped:Wait()
                else
                    for j, k in pairs(itemtable) do
                        if Player:DistanceFromCharacter(k:FindFirstChildOfClass('Part').Position) < 20 then
                            require_owner(k)
                        end
                    end
                end
            end
    
            for i, v in pairs(itemtable) do
                local BodyPos = v:FindFirstChildOfClass('Part'):FindFirstChildOfClass('BodyPosition')
                local BodyGyro = v:FindFirstChildOfClass('Part'):FindFirstChildOfClass('BodyGyro')
                BodyPos:Destroy()
                BodyGyro:Destroy()
                for j, k in pairs(v:GetDescendants()) do
                    if k:IsA'BasePart' then
                        k.CanCollide = true
                    end
                end
            end
        end
    
        function InstantTeleport(itemtable, pos)
            local Done = 0
            for i, v in pairs(itemtable) do 
                local CFrame = v.PrimaryPart.CFrame
                spawn(function()
                    repeat wait() until v.PrimaryPart.CFrame ~= CFrame
                    Done = Done + 1
                end)
                game.ReplicatedStorage.PlaceStructure.ClientPlacedStructure:FireServer(nil, pos, nil, nil, v, true)
                if math.random(1, 3) == 1 then
                    game:GetService('RunService').Stepped:Wait()
                end
            end
            repeat wait() until Done == #itemtable
        end
    
    
        function GetTree(treename)
            local OldCF = Player.Character.Torso.CFrame
    
            local Axe = nil
            if treename ~= 'LoneCave' then
            for i,v in pairs(Player.Character:GetChildren()) do
                if v:FindFirstChild('ToolName') then
                    Axe = v
                    break;
                end
            end
            if Axe == nil then
                for i,v in pairs(Player.Backpack:GetChildren()) do
                    if v:FindFirstChild('ToolName') then
                        Axe = v
                        break;
                    end
                end
            end
            if Axe == nil then
                UI_Init:Notification("Error", "You need axe to bring wood.")
                return
            end
            else
            for i,v in pairs(Player.Character:GetChildren()) do
                if v:FindFirstChild('ToolName') and v.ToolName.Value == 'EndTimesAxe' then
                    Axe = v
                    break;
                end
            end
            if Axe == nil then
                for i,v in pairs(Player.Backpack:GetChildren()) do
                    if v:FindFirstChild('ToolName') and v.ToolName.Value == 'EndTimesAxe' then
                        Axe = v
                        break;
                    end
                end
            end
            if Axe == nil then
                    UI_Init:Notification("Error", "You need end times axe to bring wood.")
                    return
            end
            end
    
            local Tree = nil
            for i, v in pairs(game.Workspace:GetChildren()) do
            if v.Name == 'TreeRegion' then
                for j, k in pairs(v:GetChildren()) do
                    if k.Name == 'Model' and k:FindFirstChild("TreeClass") and k:FindFirstChild('Leaves') then
                        if k.TreeClass.Value == treename then
                        Tree = k
                        break;
                        end
                    end
                end
                if Tree ~= nil then
                    break;
                end
            end
            end
    
            if Tree == nil then
            UI_Init:Notification("Error", "Tree Not Found")
            return
            end
            local chop = false
            local ChoppedTree = nil
    
            treecon = game.Workspace.LogModels.ChildAdded:connect(function(add)
            local Owner = add:WaitForChild('Owner')
            if add.Owner.Value == Player and add.TreeClass.Value == treename and add:FindFirstChild("WoodSection") then
                ChoppedTree = add
                chop = true
                treecon:Disconnect()
            end
            end)
        
            local Damage = GetInfo(Axe, Tree.TreeClass.Value).Damage
            local Cooldown = GetInfo(Axe, Tree.TreeClass.Value).Cooldown
    
            local args = {
                [1] = Tree.CutEvent,
                [2] = {
                    ["tool"] = Axe, 
                    ["faceVector"] = Vector3.new(1, 0, 0), 
                    ["height"] = 0.3, 
                    ["sectionId"] = 1,
                    ["hitPoints"] = Damage,
                    ["cooldown"] = Cooldown, 
                    ["cuttingClass"] = "Axe"
                }
            }
    
            while not chop do
            teleport(CFrame.new(Tree.WoodSection.Position)+Vector3.new(5,0,5))
            game.ReplicatedStorage.Interaction.RemoteProxy:FireServer(unpack(args))
            wait(Cooldown)
            end
            Player.Character.HumanoidRootPart.Anchored = false
            for i = 1,7 do
            game.ReplicatedStorage.Interaction.ClientRequestOwnership:FireServer(ChoppedTree)
            ChoppedTree:MoveTo(OldCF.p)
            game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(ChoppedTree)
            game:GetService('RunService').Stepped:wait()
            end
            teleport(OldCF)
        end
    
        local Trees = {}
    
        for i, v in pairs(game.Workspace:GetChildren()) do
            if v.Name == 'TreeRegion' then
                for j, k in pairs(v:GetChildren()) do
                    if k:FindFirstChild('TreeClass') then
                        if not table.find(Trees, k.TreeClass.Value) then
                            table.insert(Trees, k.TreeClass.Value)
                        end
                    end
                end
            end 
        end

        WoodsMenu:Line()
        WoodsMenu:Label("Woods")

        WoodsMenu:Dropdown("Bring Tree", Trees, function(value)
            pcall(function()
                GetTree(value)
            end)
        end)
    
        WoodsMenu:Button('Logs Teleport', "Teleports logs", function()
            pos = Player.Character.HumanoidRootPart.Position
            local items = {}
            for i, v in pairs(game.Workspace.LogModels:GetChildren()) do
                if string.find(v.Name, 'Loose') and v:FindFirstChild("Owner") then
                    if v.Owner.Value == Player then
                        table.insert(items, v)
                    end
                end
            end
            TeleportTables(items, pos)
            wait(1)
            teleport(CFrame.new(pos))
        end)
    
        WoodsMenu:Button("Plank Teleport", "Teleports planks", function()
            pos = Player.Character.HumanoidRootPart.Position
            local items = {}
            for i, v in pairs(game.Workspace.PlayerModels:GetChildren()) do
                if v:FindFirstChild('TreeClass') and v:FindFirstChild("Owner") then
                    if (v.Owner.Value == Player) then
                        table.insert(items, v)
                    end
                end
            end
            TeleportTables(items, pos)
            wait(1)
            teleport(CFrame.new(pos))
        end)
    
        WoodsMenu:Button('Sell Logs', "Sells logs", function()
            pos = Player.Character.HumanoidRootPart.Position
            local items = {}
            for i, v in pairs(game.Workspace.LogModels:GetChildren()) do
                if string.find(v.Name, 'Loose') and v:FindFirstChild("Owner") then
                    if v.Owner.Value == Player then
                        table.insert(items, v)
                    end
                end
            end
            TeleportTables(items, Vector3.new(315, -0.296, 85.791))
            wait(1)
            teleport(CFrame.new(pos))
        end)
    
    
        WoodsMenu:Button("Sell Plank", "Sells planks", function()
            pos = Player.Character.HumanoidRootPart.Position
            local items = {}
            for i, v in pairs(game.Workspace.PlayerModels:GetChildren()) do
                if v:FindFirstChild('TreeClass') and v:FindFirstChild("Owner") then
                    if (v.Owner.Value == Player) and (v.Type.Value == 'Plank') then
                        table.insert(items, v)
                    end
                end
            end
            TeleportTables(items, Vector3.new(315, -0.296, 85.791))
            wait(1)
            teleport(CFrame.new(pos))
        end)
    
        Items:Line()
        Items:Label("Axe Dupe")
    
        local loop = false
        Items:Toggle("Loop", "Loop dupes your axes", false, function(value)
            loop = value
        end)
    
        local pickup = false
        Items:Toggle("Auto Pick Up", "Automatically picks up axes", false, function(value)
            pickup = value
        end)
    
        function dupeaxe()
            Player.Character.Humanoid:UnequipTools()
            wait()
            Head = Player.Character.Head.CFrame
            Player.Character.Head:Destroy()
            wait()
            for i, v in pairs(Player.Backpack:GetChildren()) do
                conn = game.Workspace.PlayerModels.ChildAdded:Connect(function(new)
                    if new:WaitForChild('Owner') == Player then
                        new.Name = 'DupedTool'
                        conn:Disconnect()
                    end
                end)
                game.ReplicatedStorage.Interaction.ClientInteracted:FireServer(v, "Drop tool", Head)
            end
            Player.CharacterAdded:Wait()
            wait(1)
            teleport(Head)
            local tools = 0
            for i, v in pairs(Player.Character:GetChildren()) do
                if v:IsA"Tool" then
                    tools = tools + 1
                end
            end
            for i, v in pairs(Player.Backpack:GetChildren()) do
                if v.Name ~= "BlueprintTool" then
                    tools = tools + 1
                end
            end
            for i,v in pairs(game.Workspace.PlayerModels:GetChildren()) do
                if pickup and (v.Name == "DupedTool") then
                    if tools < 9 then
                        game.ReplicatedStorage.Interaction.ClientInteracted:FireServer(v, "Pick up tool")
                        wait(.5)
                        Player.Character.Humanoid:UnequipTools()
                        tools = tools + 1
                    end
                end
                if v.Name == 'DupedTool' then
                    v.Name = "Model"
                end
            end
            wait(1)
            if loop then
                dupeaxe()
            end
        end
    
        Items:Button("Dupe", "Dupes axes", function()
            dupeaxe()
        end)
    
        WoodsMenu:Line()
        WoodsMenu:Label("Auto Fill Blueprint")
    
        local FillWood = Trees[1]
    
        WoodsMenu:Dropdown("Fill Wood Type", Trees, function(value)
            FillWood = value
        end)
    
        local AutoFillSaw
    
        local AutoFillSelectBox
    
        local AutoFillSawSelecting = false
        local AutoFillSawSelectButton
        AutoFillSawSelectButton = WoodsMenu:Button('Select Sawmill', "Select sawmill", function()
            Sawmil = nil
            if AutoFillSelectBox then
                AutoFillSelectBox:Destroy()
                AutoFillSelectBox = nil
            end
            if AutoFillSawSelecting then
                AutoFillSawSelecting = false
                AutoFillSawSelectButton:updateButton('Select Sawmill')
            else
                AutoFillSawSelecting = true
                AutoFillSawSelectButton:updateButton('Cancel')
            end
        end)
    
        Mouse.Button1Down:Connect(function()
            if Mouse.Target then
                if AutoFillSawSelecting then
                    local Target = Mouse.Target
                    local Saw = nil
                    if (Target.Parent.Name == 'Parts') then
                        if Target.Parent.Parent.Parent == game:GetService("Workspace").PlayerModels then
                            Saw = Target.Parent.Parent
                        end
                    elseif (Target.Parent.Parent == game:GetService("Workspace").PlayerModels) then
                        Saw = Target.Parent
                    end
                    if Saw then
                        if Saw:FindFirstChild('Main') and Saw:FindFirstChild('Settings') and Saw:FindFirstChild('SquarePos') and Saw:FindFirstChild('XUp') then
                            AutoFillSelectBox = Instance.new('SelectionBox')
                            AutoFillSelectBox.Parent = Saw
                            AutoFillSelectBox.Adornee = Saw
                            AutoFillSaw = Saw 
                            AutoFillSawSelecting = false
                            BlueprintFill:updateButton(AutoFillSawSelectButton, 'Sawmill Selected')
                        end
                    end
                end
            end
        end)
        local function FillBlueprint(Sawmill, Blueprint, WoodClass)
            if WoodClass == nil then --totally didn't just skid this from LumbSmasher ~ applebee https://beta.applebee1558.com/uploads/2020/12/RobloxStudioBeta_jtcnyxAP8q/png 
                local remote = game.ReplicatedStorage.PlaceStructure.ClientPlacedStructure
                remote:FireServer(Blueprint.ItemName.Value, Blueprint.Main.CFrame, Player, nil, Blueprint, true)
                return
            end
            local RequiredWood = 1
            if not Player.SuperBlueprint.Value then
                for i, v in pairs(game:GetService("ReplicatedStorage").Purchasables.Structures.BlueprintStructures:GetChildren()) do
                    if v.Name == Blueprint.ItemName.Value then
                        RequiredWood = v.WoodCost.Value
                        break
                    end
                end
            end
    
            local Axe = nil
            do
                if WoodClass ~= 'LoneCave' then
                    for i, v in pairs(Player.Character:GetChildren()) do
                        if v:FindFirstChild('ToolName') then
                            Axe = v
                            break
                        end
                    end
                    if Axe == nil then
                        for i, v in pairs(Player.Backpack:GetChildren()) do
                            if v:FindFirstChild('ToolName') then
                                Axe = v
                                break
                            end
                        end
                    end
                else
                    for i, v in pairs(Player.Character:GetChildren()) do
                        if v:FindFirstChild('ToolName') and v.ToolName.Value == 'EndTimesAxe' then
                            Axe = v
                            break
                        end
                    end
                    if Axe == nil then
                        for i, v in pairs(Player.Backpack:GetChildren()) do
                            if v:FindFirstChild('ToolName') and v.ToolName.Value == 'EndTimesAxe' then
                                Axe = v
                                break
                            end
                        end
                    end
                end
            end
            if not Axe then
                UI_Init:Notification('Error', 'Axe Not Founded.')
                return 
            end
            local Damage = GetInfo(Axe, WoodClass).Damage
            local Cooldown = GetInfo(Axe, WoodClass).Cooldown
    
            local WoodSection
            do
                local Min = 9e99
                for i, v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == 'TreeRegion' then
                        for j, Tree in pairs(v:GetChildren()) do 
                            if Tree:FindFirstChild('Leaves') and Tree:FindFirstChild('WoodSection') and Tree:FindFirstChild('TreeClass') then
                                if Tree:FindFirstChild('TreeClass').Value == WoodClass then
                                    for k, TreeSection in pairs(Tree:GetChildren()) do
                                        if TreeSection.Name == 'WoodSection' then
                                            local Size = TreeSection.Size.X * TreeSection.Size.Y * TreeSection.Size.Z
                                            if (Size > RequiredWood) and (#TreeSection.ChildIDs:GetChildren() == 0) then 
                                                if Min > TreeSection.Size.X then
                                                    Min = TreeSection.Size.X
                                                    WoodSection = TreeSection
                                                end
                                            end
                                        end 
                                    end
                                end
                            end
                        end
                    end
                end
            end
    
            if not WoodSection then
                UI_Init:Notification('Error', 'Enought Tree Not Founded.')
                return 
            end
    
            local Chopped = false
            treecon = game.Workspace.LogModels.ChildAdded:connect(function(add)
                local Owner = add:WaitForChild('Owner')
                if (add.Owner.Value == Player) and (add.TreeClass.Value == WoodClass) and add:FindFirstChild("WoodSection") then
                    Chopped = add
                    treecon:Disconnect()
                end
            end)
            
            local CutSize = RequiredWood / (WoodSection.Size.X * WoodSection.Size.X) + 0.01
    
            while not Chopped do
                teleport(CFrame.new(WoodSection.Position) + Vector3.new(0, 5, 0)) 
                game.ReplicatedStorage.Interaction.RemoteProxy:FireServer(WoodSection.Parent.CutEvent, {
                    sectionId = WoodSection.ID.Value,
                    faceVector = Vector3.new(0, 0, -1),
                    height = WoodSection.Size.Y - CutSize,
                    hitPoints = Damage,
                    cooldown = Cooldown,
                    cuttingClass = "Axe",
                    tool = Axe
                })
                wait(Cooldown)
            end
    
            local Sawed = false
            sawconn = game.Workspace.PlayerModels.ChildAdded:connect(function(add)
                local Owner = add:WaitForChild('Owner')
                if add.Owner.Value == Player then
                    if not add:FindFirstChild("WoodSection") then
                        wait()
                        if not add:FindFirstChild("WoodSection") then
                            return
                        end
                    end
                    if not add:FindFirstChild('TreeClass') then
                        repeat game:GetService('RunService').RenderStepped:Wait() until add:FindFirstChild('TreeClass')
                    end 
                    if add.TreeClass.Value == WoodClass then
                        Sawed = add
                        sawconn:Disconnect()
                    end
                end
            end)
    
            for i = 1, 10 do
                game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(Chopped)  
                Chopped.WoodSection.Velocity = Vector3.new(0, 10, 0)
                Chopped.WoodSection.CFrame = Sawmill.Particles.CFrame
                game:GetService('RunService').RenderStepped:Wait()
            end
    
            wait(1)
    
            while not Sawed do 
                teleport(CFrame.new(Chopped.WoodSection.Position) + Vector3.new(0, 4, 0))
                game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(Chopped)  
                Chopped.WoodSection.CFrame = Sawmill.Particles.CFrame + Vector3.new(Sawmill.Particles.Size.X, 0, 0)
                if Sawed then
                    break
                end
                wait(2)
            end
    
            local BlueprintCFrame
            if Blueprint:FindFirstChild("MainCFrame") then
                BlueprintCFrame = Blueprint.MainCFrame.Value
            else
                BlueprintCFrame = Blueprint.PrimaryPart.CFrame
            end
    
            while Sawed.Parent do 
                teleport(CFrame.new(Sawed.WoodSection.Position) + Vector3.new(0, 6, 0))
                game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(Sawed)  
                Sawed.WoodSection.CFrame = BlueprintCFrame
                Chopped.WoodSection.Velocity = Vector3.new(0, 10, 0)
                game:GetService('RunService').RenderStepped:Wait()
            end
        end
    
        WoodsMenu:Button('Give Fill Tool', "Gives fill tool", function()
            local tool = Instance.new("Tool", Player.Backpack)
            tool.RequiresHandle = false
            tool.Name = "Fill Blueprint"
            tool.ToolTip = "Fill Blueprint By Sawmilling Wood"
            tool.Equipped:connect(function(Mouse)
                Mouse.Button1Down:connect(function()
                    if Mouse.Target and AutoFillSaw then
                        if Mouse.Target.Parent:FindFirstChild("Type") or Mouse.Target.Parent:FindFirstChild("BlueprintWoodClass") then
                            local old = Player.Character.HumanoidRootPart.CFrame
                            FillBlueprint(AutoFillSaw, Mouse.Target.Parent, FillWood)
                            teleport(old)
                        end
                    end
                end)
            end)
        end)
    
        local Build = UI_Init:Tab("Auto Build", "http://www.roblox.com/asset/?id=6034275725")
    
        function getPlayerProperty(player)
            for i, v in pairs(game:GetService("Workspace").Properties:GetChildren()) do
                if v.Owner.Value == player then
                    return v 
                end
            end
            return false
        end
    
        local function saveBase(player, fileName)
            local Property = getPlayerProperty(player)
            if not Property then
                UI_Init:Notification('Error', 'That player does not own any base.')
                return false, 'That player does not own any base.'
            end
            local Data = {}
            for i, v in pairs(game:GetService('Workspace').PlayerModels:GetChildren()) do
                if v:FindFirstChild('Owner') and ((v:FindFirstChild("Type") == 'Structure') or v:FindFirstChild("BlueprintWoodClass")) then
                    if v.Owner.Value == player then
                        local InsertData = {}
                        local CFrame 
                        if v:FindFirstChild("MainCFrame") then
                            CFrame = v.MainCFrame.Value
                        else
                            CFrame = v.PrimaryPart.CFrame
                        end
                        CFrame = Property.OriginSquare.CFrame:ToObjectSpace(CFrame)
                        InsertData['CFrame'] = { CFrame:components() }
                        if v:FindFirstChild("BlueprintWoodClass") then
                            InsertData['WoodClass'] = v.BlueprintWoodClass.Value
                        end
                        InsertData['Name'] = v.ItemName.Value
                        table.insert(Data, InsertData)
                    end
                end 
            end
            local saveString = game:GetService('HttpService'):JSONEncode(Data)
            writefile(fileName .. '.axlt2', saveString)
            UI_Init:Notification('Info', 'Successed!')
            return true, 'Successed!'
        end
    
        local function loadBase(player, fileName, Sawmill, DefaultClass)
            if not pcall(function() t = readfile(fileName .. '.axlt2') end) then
                UI_Init:Notification('Error', 'File Not Found!')
                return 
            end
    
            local Property = getPlayerProperty(player)
            if not Property then
                UI_Init:Notification('Error', 'The target player does not own any base.')
                return false, 'The target player does not own any base.'
            end
            local loadString = readfile(fileName .. '.axlt2')
            local Data = game:GetService('HttpService'):JSONDecode(loadString)
            for i, v in pairs(Data) do
                local CFrame = Property.OriginSquare.CFrame:ToWorldSpace(CFrame.new(unpack(v['CFrame'])))
                local addedBlueprint
                local BlueprintConn
                local WoodClass = v.WoodClass
                BlueprintConn = game:GetService('Workspace').PlayerModels.ChildAdded:connect(function(new)
                    local Owner = new:WaitForChild('Owner')
                    if new:FindFirstChild("Owner") and new:FindFirstChild("Type") then
                        if (new.Type.Value == "Blueprint") and (new.Owner.Value == player) then
                            addedBlueprint = new
                            BlueprintConn:Disconnect()
                        end
                    end
                end)
                game.ReplicatedStorage.PlaceStructure.ClientPlacedBlueprint:FireServer(v.Name, CFrame, player, nil, false)
                repeat wait() until addedBlueprint
                local RequiredWood = 1
                if not Player.SuperBlueprint.Value then
                    for i, v in pairs(game:GetService("ReplicatedStorage").Purchasables.Structures.BlueprintStructures:GetChildren()) do
                        if v.Name == addedBlueprint.ItemName.Value then
                            RequiredWood = v.WoodCost.Value
                            break
                        end
                    end
                end
                local Axe = nil
                do
                    if WoodClass ~= 'LoneCave' then
                        for i, v in pairs(Player.Character:GetChildren()) do
                            if v:FindFirstChild('ToolName') then
                                Axe = v
                                break
                            end
                        end
                        if Axe == nil then
                            for i, v in pairs(Player.Backpack:GetChildren()) do
                                if v:FindFirstChild('ToolName') then
                                    Axe = v
                                    break
                                end
                            end
                        end
                    else
                        for i, v in pairs(Player.Character:GetChildren()) do
                            if v:FindFirstChild('ToolName') and v.ToolName.Value == 'EndTimesAxe' then
                                Axe = v
                                break
                            end
                        end
                        if Axe == nil then
                            for i, v in pairs(Player.Backpack:GetChildren()) do
                                if v:FindFirstChild('ToolName') and v.ToolName.Value == 'EndTimesAxe' then
                                    Axe = v
                                    break
                                end
                            end
                        end
                    end
                end
                if not Axe then
                    UI_Init:Notification('Error', 'Please purchase an axe!')
                    return 
                end
                local WoodSection
                --Hacking existing code to work with greywood ~applebee
                if WoodClass == nil then
                    WoodSection = true
                end
                do
                    local Min = 9e99
                    for i, v in pairs(game.Workspace:GetChildren()) do
                        if v.Name == 'TreeRegion' then
                            for j, Tree in pairs(v:GetChildren()) do 
                                if Tree:FindFirstChild('Leaves') and Tree:FindFirstChild('WoodSection') and Tree:FindFirstChild('TreeClass') then
                                    if Tree:FindFirstChild('TreeClass').Value == WoodClass then
                                        for k, TreeSection in pairs(Tree:GetChildren()) do
                                            if TreeSection.Name == 'WoodSection' then
                                                local Size = TreeSection.Size.X * TreeSection.Size.Y * TreeSection.Size.Z
                                                if (Size > RequiredWood) and (#TreeSection.ChildIDs:GetChildren() == 0) then 
                                                    if Min > TreeSection.Size.X then
                                                        Min = TreeSection.Size.X
                                                        WoodSection = TreeSection
                                                    end
                                                end
                                            end 
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if WoodSection then
                    FillBlueprint(Sawmill, addedBlueprint, WoodClass)
                else
                    FillBlueprint(Sawmill, addedBlueprint, DefaultClass)
                end
            end
            UI_Init:Notification('Info', 'Successed.')
        end
    
        Build:Line()
        Build:Label("Save")
    
        local SavePlayer = Player.Name
        local saveFile = ''

        local PlayersList = {}

        for i,v in next, game.Players:GetPlayers() do 
            table.insert(PlayersList, v.Name)
        end

        local targetplayerbox
        targetplayerbox = Build:Dropdown('Target Player', PlayersList, function(value)
            SavePlayer = value
        end)

        game.Players.PlayerAdded:Connect(function(player)
            targetplayerbox:Add(player.Name)
        end)
        game.Players.PlayerRemoving:Connect(function(player)
            targetplayerbox:Clear()
            for i, v in pairs(game.Players:GetPlayers()) do
                targetplayerbox:Add(v.Name)
            end
        end)
    
        Build:Textbox('Save File Name', 'Name of file to save base data to', false, function(value)
            saveFile = value
        end)
    
        Build:Button("Save Target's Base", 'Save base', function()
            local SavePlayerObject = game:GetService('Players'):FindFirstChild(SavePlayer)
            if not SavePlayerObject then
                UI_Init:Notification('Error', 'Player Not Founded.')
                return
            end
            if saveFile == '' then
                UI_Init:Notification('Error', 'Enter A Vaild File Name.')
                return
            end
            saveBase(SavePlayerObject, saveFile)
        end)
    
        Build:Line()
        Build:Label("Load")
        
        local LoadPlayer = Player.Name
        local LoadName = ''
        local DefaultClass = Trees[1]
        local LoadSawmill

        local PlayersList = {}

        for i,v in next, game.Players:GetPlayers() do 
            table.insert(PlayersList, v.Name)
        end

        local targetplayerboxload
        targetplayerboxload = Build:Dropdown('Target Player', PlayersList, function(value)
            LoadPlayer = value
        end)

        game.Players.PlayerAdded:Connect(function(player)
            targetplayerboxload:Add(player.Name)
        end)
        game.Players.PlayerRemoving:Connect(function(player)
            targetplayerboxload:Clear()
            for i, v in pairs(game.Players:GetPlayers()) do
                targetplayerboxload:Add(v.Name)
            end
        end)
    
        Build:Textbox('Load File Name', 'File name to load from', false, function(value)
            LoadName = value
        end)
    
        Build:Dropdown('Missing Tree Replacement', Trees, function(value)
            DefaultClass = value
        end)
    
        local LoadSelectionBox
    
        local LoadSawSelecting = false
        local LoadSawmillSelectButton
        LoadSawmillSelectButton = Build:Button('Select Sawmill', "Select sawmill", function()
            Sawmil = nil
            if LoadSelectionBox then
                LoadSelectionBox:Destroy()
                LoadSelectionBox = nil
            end
            if LoadSawSelecting then
                LoadSawSelecting = false
                LoadSawmillSelectButton:updateButton('Select Sawmill')
            else
                LoadSawSelecting = true
                LoadSawmillSelectButton:updateButton('Cancel')
            end
        end)
    
        Mouse.Button1Down:Connect(function()
            if Mouse.Target then
                if LoadSawSelecting then
                    local Target = Mouse.Target
                    local Saw = nil
                    if (Target.Parent.Name == 'Parts') then
                        if Target.Parent.Parent.Parent == game:GetService("Workspace").PlayerModels then
                            Saw = Target.Parent.Parent
                        end
                    elseif (Target.Parent.Parent == game:GetService("Workspace").PlayerModels) then
                        Saw = Target.Parent
                    end
                    if Saw then
                        if Saw:FindFirstChild('Main') and Saw:FindFirstChild('Settings') and Saw:FindFirstChild('SquarePos') and Saw:FindFirstChild('XUp') then
                            LoadSelectionBox = Instance.new('SelectionBox')
                            LoadSelectionBox.Parent = Saw
                            LoadSelectionBox.Adornee = Saw
                            LoadSawmill = Saw 
                            LoadSawSelecting = false
                            Load:updateButton(LoadSawmillSelectButton, 'Sawmill Selected')
                        end
                    end
                end
            end
        end)
    
        Build:Button('Load Base From File', "Load base from file", function()
            local LoadPlayerObject = game:GetService('Players'):FindFirstChild(LoadPlayer)
            if not LoadPlayerObject then
                UI_Init:Notification('Error', 'Player Not Founded.')
                return
            end
            if LoadName == '' then
                UI_Init:Notification('Error', 'Enter A Vaild File Name.')
                return
            end
            if LoadSawmill then
                loadBase(LoadPlayerObject, LoadName, LoadSawmill, DefaultClass)
            else
                UI_Init:Notification('Error', 'Select Sawmill First.')
            end
        end)
    
        local BaseDrop = UI_Init:Tab('Base Drop', "http://www.roblox.com/asset/?id=6031091001")
    
        BaseDrop:Line()
        BaseDrop:Label("Base Drop")
    
        local DupeModeToggle = BaseDrop:Toggle("Dupe Mode", "Turns off slot saving", false, 'DM', function(value)
            DupeMode = value
        end)

        local BaseDropPlayer = ''
        local FromPlayer = Player.Name
    
        local BaseDropOptions = {
            ['Loose Item'] = true,
            ['Tool'] = true,
            ['Gift'] = true,
        }

        local PlayersList = {}

        for i,v in next, game.Players:GetPlayers() do 
            table.insert(PlayersList, v.Name)
        end

        local frombox
        frombox = BaseDrop:Dropdown('From', PlayersList, function(value)
            FromPlayer = value
        end)

        local basetargetbox
        basetargetbox = BaseDrop:Dropdown('To', PlayersList, function(value)
            BaseDropPlayer = value
        end)

        game.Players.PlayerAdded:Connect(function(player)
            frombox:Add(player.Name)
            basetargetbox:Add(player.Name)
        end)
        game.Players.PlayerRemoving:Connect(function(player)
            frombox:Clear()
            basetargetbox:Clear()
            for i, v in pairs(game.Players:GetPlayers()) do
                frombox:Add(v.Name)
                basetargetbox:Add(v.Name)
            end
        end)
    
        for i, v in pairs(BaseDropOptions) do
            BaseDrop:Toggle(i, 'Toggle ' .. i .. ' Base Drop' ,v, function(value)
                BaseDropOptions[i] = value
            end)
        end
    
        BaseDrop:Button('Base Drop', '', function()
            if not game.Players:FindFirstChild(BaseDropPlayer) then
                UI_Init:Notification('Error', 'Choose Target Player')
                return
            end
            local Target = game.Players[BaseDropPlayer]
            local From = game.Players[FromPlayer]
            local Property = getPlayerProperty(Target)
            game.ReplicatedStorage.Interaction.ClientSetListPlayer:InvokeServer(Player.WhitelistFolder, Target, true)
            game.ReplicatedStorage.Interaction.ClientSetListPlayer:InvokeServer(Player.WhitelistFolder, From, true)
            if not Property then
                UI_Init:Notification('Error', 'That Player Does Not Have Any Land.')
                return
            end
            if not Target.WhitelistFolder:FindFirstChild(Player.Name) then
                UI_Init:Notification('Error', 'Make Sure To "To Player" Whitelisted You.')
                return
            end
            if not From.WhitelistFolder:FindFirstChild(Player.Name) then
                UI_Init:Notification('Error', 'Make Sure To "From Player" Whitelisted You.')
                return
            end
            if From == Player then
                BaseDrop:updateToggle(DupeModeToggle, 'Dupe Mode', true)
                DupeMode = true
            end
            local ItemsToTeleport = {}
    
            for i, v in pairs(game.Workspace.PlayerModels:GetChildren()) do
                if v:FindFirstChild('Owner') and v:FindFirstChild('Type') then
                    if v.Owner.Value == From then
                        local Type = v.Type.Value
                        if BaseDropOptions[Type] then
                            table.insert(ItemsToTeleport, v)
                        end
                    end
                end
            end
    
            InstantTeleport(ItemsToTeleport, Property.OriginSquare.CFrame + Vector3.new(0, 7, 0))
    
            if From == Player then
                UI_Init:Notification('Waiting', 'Waiting...')
    
                repeat wait() until game:GetService("ReplicatedStorage").LoadSaveRequests.ClientMayLoad:InvokeServer() == true
    
                if Player.CurrentSaveSlot.Value ~= -1 then
                    game.ReplicatedStorage.LoadSaveRequests.RequestLoad:InvokeServer(Player.CurrentSaveSlot.Value)
                end
            end
    
            UI_Init:Notification('Done', 'Done')
        end)
    end;

    --[[[245662005] = function()    
        local Functions = {}
        local Actions
        
        local Remote
        local Hashes = {}
        local DoorsTable = {}
        for i, v in pairs(getgc(true)) do
            if type(v) == "function" then
                if getfenv(v).script == player.PlayerScripts.LocalScript then
                    local upvals = getupvalues(v)
                    for j, k in pairs(upvals) do
                        if type(k) == 'table' then
                            if rawget(k, 'LastVehicleExit') then
                                Functions['VehicleExit'] = v
                            end
                            if rawget(k, 'FireServer') then
                                Remote = k
                            end
                            if rawget(k, 'PromptPurchase') then
                                Functions['Fireworks'] = k.Fireworks
                                Functions['GetCarTable'] = k.GetVehiclePacket
                            end
                            if rawget(k, 'Nitro') then
                                NitroTable = k
                            end
                        end
                        if tostring(upvals[3]) == 'Donut' then
                            Functions['GetItems'] = v
                        end
                    end
                    local const = getconstants(v)
                    if table.find(const, "You can't drive this. Hold to hijack it.") then
                        Functions['Eject'] = function(player)
                            local toEject = false
                            for a, b in pairs(workspace.Vehicles:GetChildren()) do
                                for c, d in pairs(b:GetChildren()) do
                                    if (d.Name == 'Seat') or (d.Name == 'Passenger') then
                                        if d:FindFirstChild("PlayerName").Value == player.Name then
                                            toEject = b
                                            break
                                        end
                                    end
                                end
                            end
                            if toEject then
                                getupvalue(v, 2)(toEject)
                            end
                        end
                    end
                    if table.find(const, 'Sprint') and table.find(const, 'Crawl') then
                        Functions['Crawl'] = function()
                            v({
                                ['Name'] = 'Crawl'
                            }, true, nil)
                        end
                        Functions['Punch'] = function()
                            v({
                                ['Name'] = 'Punch'
                            }, true, nil)
                        end
                        Functions['Horn'] = function()
                            v({
                                ['Name'] = 'Horn'
                            }, true, nil)
                        end
                        Functions['Flip'] = function()
                            v({
                                ['Name'] = 'Flip'
                            }, true, nil)
                        end
                    end
                    if table.find(const, 'PlusCash') then
                        Functions['addCash'] = v 
                    end
                    if table.find(const, "ShouldArrest") then
                        local arrest = getupvalue(v, 1)
                        local pickpocket = getupvalue(v, 2)
                        if type(arrest) == 'function' then
                            for j, k in pairs(getupvalues(arrest)) do
                                if type(k) == 'function' then
                                    Functions['Arrest'] = k
                                    break
                                end
                            end
                            for j, k in pairs(getupvalues(pickpocket)) do
                                if type(k) == 'function' then
                                    Functions['PickPocket'] = k
                                    break
                                end
                            end
                        end
                    elseif table.find(const, "SequenceRequireState") and table.find(const, "State") and table.find(const, "Open") then
                        Functions['OpenDoor'] = v
                    end
                elseif getfenv(v).script == ReplicatedStorage.Game.TeamChooseUI then
                    local proto = getprotos(v)
                    for j, k in pairs(proto) do
                        local const = getconstants(k)
                        if table.find(const, 'Police') then
                            Functions['ChangeTeam'] = k 
                        end
                    end
                elseif getfenv(v).script == ReplicatedStorage.Game.GunShop then
                    local const = getconstants(v)
                    if table.find(const, 'CanGrab') and table.find(const, 'FireServer') then
                        Functions['GrabGun'] = v
                    end
                elseif getfenv(v).script == ReplicatedStorage.Game.Garage.GarageUI then
                    local const = getconstants(v)
                    if table.find(const, 'Type') and table.find(const, 'FireServer') and table.find(const, 'Make') then
                        Functions['SpawnVehicle'] = v
                    end
                elseif getfenv(v).script == ReplicatedStorage.Game.NukeControl then
                    local const = getconstants(v)
                    if (const[1] == 'assert') and (const[3] == 'Nuke') then
                        Functions['Nuke'] = v 
                    end
                end
            elseif type(v) == "table" then
                if rawget(v, 'CircleAction') then
                    Actions = v.CircleAction.Specs
                end
            end
        end
        
        Functions['editVehicle'] = getproto(require(ReplicatedStorage.Game.Garage.GarageUI).Init, 1)
        Functions['Tase'] = function(target)
            local const = getconstants(require(ReplicatedStorage.Game.Item.Taser).Tase) 
            local TaseHash
            for i, v in pairs(const) do
                if type(v) == 'string' then
                    if (string.len(v) == 8) and (i > table.find(const, 'GetPlayerFromCharacter')) then
                        TaseHash = string.reverse(v)
                        break
                    end
                end
            end
            Remote:FireServer(TaseHash, target.Name, target.Character.HumanoidRootPart, target.Character.HumanoidRootPart.Position)
        end
        Functions['Eat'] = function()
            local eat = getproto(require(ReplicatedStorage.Game.Item.Donut).InputBegan, 1) 
            setupvalue(eat, 1, { 
                Config = {Motion = {Hip = {Springs = {ItemRotation = 1} } } },
                SpringItemRotation = { SetTarget = function() end },
                Local = true,
                LastConsumed = 0
            })
            setupvalue(eat, 2, Remote)
            eat()
        end
        
        local function Call(table)
           table:Callback(true) 
        end
        local function FindAction(name)
            for i, v in pairs(Actions) do
                if v.Name == name then
                    return v
                end
            end
        end
        
        local function Equip(Name)
            for i, v in pairs(getgc(true)) do
                if type(v) == 'table' then
                    if (rawget(v, 'Name') == Name) and rawget(v, 'Frame') then
                        require(ReplicatedStorage.Game.ItemSystem.ItemSystem).Equip(Player, v)
                        break
                    end
                end
            end
        end
        
        local function Unequip()
            require(ReplicatedStorage.Game.ItemSystem.ItemSystem).Unequip()
        end
        
        local function teleport(Pos)
            if (player.Character.HumanoidRootPart.Position - Pos.p).magnitude > 20 then
                local old = workspace.Gravity
                workspace.Gravity = 0
                local r = math.random(200, 250) * -1
                local New = CFrame.new(Pos.X, r, Pos.Z)
                player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.CFrame.X, r, player.Character.HumanoidRootPart.CFrame.Z)
                repeat
                    local to = (New.p - player.Character.HumanoidRootPart.Position).Unit * 130
                    player.Character.HumanoidRootPart.Velocity = Vector3.new(to.X, 0, to.Z)
                    wait()
                until (player.Character.HumanoidRootPart.Position - New.p).Magnitude < 15
                wait(0.1)
                player.Character.HumanoidRootPart.CFrame = Pos
                workspace.Gravity = old
            else
                player.Character.HumanoidRootPart.CFrame = Pos
            end
            Functions['VehicleExit'](true) 
            wait() 
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
            local old = workspace.Gravity
            workspace.Gravity = 0
            local New = CFrame.new(Pos.X, -250, Pos.Z)
            for i = 1, 5 do 
                wait(.1)
                player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.CFrame.X, -250, player.Character.HumanoidRootPart.CFrame.Z)
            end
            repeat
                local to = (New.p - player.Character.HumanoidRootPart.Position).Unit * 130
                player.Character.HumanoidRootPart.Velocity = Vector3.new(to.X, 0, to.Z)
                wait()
            until (player.Character.HumanoidRootPart.Position - New.p).Magnitude < 15
            wait(0.1)
            player.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            workspace.Gravity = old
            player.Character.HumanoidRootPart.CFrame = Pos
        end
        
        local NotificationService = require(ReplicatedStorage.Game.Notification)
        function Notification(message, duration)
            NotificationService.new({
                Text = message,
                Duration = duration
            })
        end
        wait()
        
        local Local = UI_Init:Tab("Character", "http://www.roblox.com/asset/?id=6034287594")

        Local:Line()
        Local:Label("LocalPlayer")

        local ws = 16
        local jp = 50
        local noclip = false

        RunService.Stepped:connect(function()
            if player.Character and player.Character:FindFirstChild('Humanoid') then
                WalkSpeed(ws)
                JumpPower(jp)
                if noclip then
                    for i,v in pairs(player.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end
            end
        end)

        local mt = getrawmetatable(game)
        local oldIndex = mt.__index 
        setreadonly(mt, false)

        mt.__index = newcclosure(function(tbl, idx)
            if not checkcaller() then 
                if idx == "WalkSpeed" then
                    return 16 
                elseif idx == "JumpPower" then 
                    return 50 
                end 
            end 
            return oldIndex(tbl, idx)
        end)

        setreadonly(mt, true)

        Local:Slider("Walk Speed", 'Sets your characters movement speed', 0, 200, 16, "WS", function(value)
            ws = value
        end)

        Local:Slider("Jump Height", 'Sets your characters jump height', 0, 400, 50, "JH", function(value)
            jp = value
        end)

        Local:Toggle("NoClip", 'Allows your character to walk through objects', false, "NC", function(value)
            noclip = value
        end)

        Local:Line()
        Local:Label("Teleport")

        Local:Toggle("Key Teleport Enabled", "If keybind teleport is enabled", false, "KTE")

        Local:Bind("Teleport Key", Enum.KeyCode.G, function(a)
            if Mouse.Target and Flags.KTE then 
                teleport(CFrame.new(Mouse.Hit.p) + Vector3.new(0,3,0))
            end
        end)
        
        local nowait = false
        spawn(function()
            while wait() do
                if nowait then
                    for i, v in pairs(Actions) do
                        v.Timed = false
                    end
                end
            end
        end)
        Local:Toggle('No Wait', '', false, 'NW',function(value)
            nowait = value
        end)
        
        local NoFall = false
        local AlexRagdoll = require(ReplicatedStorage.Module.AlexRagdoll)
        local OldRagdoll = AlexRagdoll.Ragdoll
        AlexRagdoll.Ragdoll = function(...)
            if NoFall then
                error()
            else
                return OldRagdoll(...)
            end
        end
        
        Local:Toggle('No Fall', '', false, 'NF',function(value)
            NoFall = value
        end)
        
        Local:Dropdown("Change Team", {"Prisoner", "Police"},function(value)
            if value == 'Prisoner' then
                setupvalue(Functions['ChangeTeam'], 1, 2)
                setupvalue(Functions['ChangeTeam'], 2, Remote)
                Functions['ChangeTeam']()
            else
                setupvalue(Functions['ChangeTeam'], 1, 1)
                setupvalue(Functions['ChangeTeam'], 2, Remote)
                Functions['ChangeTeam']()
            end
        end)
        
        local Waypoint = {}
        
        local location = { 
            bank = CFrame.new(40, 16.068, 786), 
            jewelry = CFrame.new(136.031, 16.976, 1353.04), 
            crim1 = CFrame.new(-235, 17.225, 1623), 
            crim2 = CFrame.new(1638, 48.136, -1767), 
            prison = CFrame.new(-1218, 38.607, -1575), 
            ["1m"] = CFrame.new(351.762, 20, -1700.921), 
            radio = CFrame.new(1034.241, 98.43, 1104.152), 
            bridge1 = CFrame.new(598, 60.669, 1032), 
            bridge2 = CFrame.new(666, 60.32, 1702), 
            museum = CFrame.new(1075.503, 136.328, 1228.639), 
            gun = CFrame.new(-20, 15.968, -1756), 
            server = CFrame.new(64, 16.066, 1137), 
            military = CFrame.new(813, 18.899, -315), 
            ski = CFrame.new(17.537, 18.844, 2372.027), 
            power = CFrame.new(680.33, 37, 2358.23), 
            jetpack = CFrame.new(1375.901, 173.199, 2585.686), 
            airport = CFrame.new(-1592, 40.072, 2859), 
            port = CFrame.new(-292, 20, 2084), 
            cove = CFrame.new(1875.797, 40, 1895.154)
        }
        
        for i, v in pairs(location) do
            table.insert(Waypoint, i)
        end
        
        Local:Line()
        Local:Label("Teleport")

        Local:Dropdown('Waypoint', Waypoint, function(value)
            teleport(location[value])
        end)

        local PlayersList = {}

        for i,v in next, Players:GetPlayers() do 
            table.insert(PlayersList, v.Name)
        end
        
        local ToPlayer
        ToPlayer = Local:Dropdown('To Player', PlayersList, function(value)
            teleport(Players[value].Character.HumanoidRootPart.CFrame + Vector3.new(0, 7, 0))
        end) 

        Players.PlayerAdded:connect(function(plr)
            ToPlayer:Add(plr.Name)
        end)

        Players.PlayerRemoving:connect(function(plr)
            ToPlayer:Clear()
            for i,v in next, Players:GetPlayers() do 
                ToPlayer:Add(v.Name)
            end
        end)
        
        local Misc = UI_Init:Tab("Misc", "http://www.roblox.com/asset/?id=6022668907")
        
        Misc:Line()
        Misc:Label('Players')
        
        local TaseAura = false
        spawn(function()
            while wait(1) do
                if TaseAura then
                    pcall(function()
                        for i, v in pairs(Players:GetChildren()) do
                            if (player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude < 60 then
                                if v ~= Player then
                                    Functions['Tase'](v)
                                end
                            end
                        end
                    end)
                end
            end
        end)
        Misc:Toggle('Tase Aura', 'Automatically tases nearby players', false, 'TA',function(value)
            TaseAura = value
        end)
        
        local TaseAll = false
        spawn(function()
            while wait(1) do
                if TaseAll then
                    pcall(function()
                        for i, v in pairs(Players:GetChildren()) do
                            if v ~= Player then
                                Functions['Tase'](v)
                            end
                        end
                    end)
                end
            end
        end)
        Misc:Toggle('Tase All', 'Tases all players', false, 'TAA',function(value)
            TaseAll = value
        end)
        
        local EjectAura = false
        spawn(function()
            while wait(1) do
                if EjectAura then
                    pcall(function()
                        for i, v in pairs(Players:GetChildren()) do
                            if (player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude < 60 then
                                if v ~= Player then
                                    Functions['Eject'](v)
                                end
                            end
                        end
                    end)
                end
            end
        end)
        Misc:Toggle('Eject Aura', 'Automatically ejects nearby players', false, 'EA',function(value)
            EjectAura = value
        end)
        
        local EjectAll = false
        spawn(function()
            while wait(1) do
                if EjectAll then
                    pcall(function()
                        for i, v in pairs(Players:GetChildren()) do
                            if v ~= Player then
                                Functions['Eject'](v)
                            end
                        end
                    end)
                end
            end
        end)
        Misc:Toggle('Eject All', 'Ejects all players', false, 'EAA',function(value)
            EjectAll = value
        end)
        
        local AutoArreset = false
        spawn(function()
            while wait(1) do
                if AutoArreset and (player.Team == game.Teams.Police) then
                    pcall(function()
                        for i, v in pairs(Players:GetChildren()) do
                            if v ~= Player then
                                if (v.Team == game.Teams.Criminal) and (not v.Character:FindFirstChild('Handcuffs')) then
                                    repeat
                                        if not player.Character:FindFirstChild('InVehicle') then
                                            RideCar()
                                        end
                                        if not AutoArreset then
                                            break
                                        end
                                        Functions['Eject'](v)
                                        teleport(v.Character.HumanoidRootPart.CFrame)
                                        spawn(function()
                                            if require(ReplicatedStorage.Game.ItemSystem.ItemSystem).GetLocalEquipped() then 
                                                if require(ReplicatedStorage.Game.ItemSystem.ItemSystem).GetLocalEquipped().ItemData.Name == 'Handcuffs' then
                                                    Functions['Arrest'](v)
                                                else
                                                    Equip('Handcuffs')
                                                end
                                            else
                                                Equip('Handcuffs')
                                            end
                                        end)
                                        RunService.RenderStepped:Wait()
                                    until v.Character:FindFirstChild('Handcuffs')
                                    if not AutoArreset then
                                        break
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end)
        
        local DoorTable = {}
        for i, v in pairs(getgc(true)) do
            if type(v) == 'table' then
                if rawget(v, 'Model') and rawget(v, 'Tag') and rawget(v, 'State') then
                    table.insert(DoorsTable, v)
                end
            end
        end
        
        local LoopDoor = false
        spawn(function()
            while wait(2) do
                if LoopDoor then
                    for i, v in pairs(DoorsTable) do
                        pcall(Functions['OpenDoor'], v)
                    end
                end
            end
        end)
        Misc:Toggle('Loop Open All Doors', 'Opens all doors on loop', false, "LOAD",function(value)
            LoopDoor = value
        end)
        
        Misc:Button('Pickpocket Keycard', "Pickpockets a keycard", function()
            for i, v in pairs(Players:GetChildren()) do
                if v.Team == game.Teams.Police then
                    if not v.Character:FindFirstChild("InVehicle") then
                        local old = player.Character.HumanoidRootPart.CFrame
                        wait()
                        teleport(v.Character.HumanoidRootPart.CFrame)
                        wait()
                        for i = 1, 20 do
                            Functions['PickPocket'](v)
                            wait()
                        end
                        teleport(old)
                        break
                    end
                end
            end
        end)
        
        local Fun = UI_Init:Tab('Fun', "http://www.roblox.com/asset/?id=6031265978")
        
        Fun:Line()
        Fun:Label('Fun')
        
        Fun:Textbox('Free Money', 'Gives money (fake)', false, function(value)
            if pcall(tonumber, value) then
                if tonumber(value) > -1 then
                    pcall(Functions['addCash'], tonumber(value), 'I gave you money! ofc jk')
                end
            end
        end)
        
        Fun:Textbox('Remove Money', 'Removes money (fake)', false, function(value)
            if pcall(tonumber, value) then
                if tonumber(value) > -1 then
                    pcall(Functions['addCash'], -tonumber(value), 'I removed your money! ofc jk')
                end
            end
        end)
        
        
        local FunHat = false
        
        spawn(function()
            local HatGiver = nil
            for i, v in pairs(workspace.Givers:GetChildren()) do
                if v:FindFirstChild("Item").Value == 'HatPolice' then
                    HatGiver = v 
                    break
                end
            end
            while wait() do
                if FunHat then
                    pcall(function()
                        fireclickdetector(HatGiver.ClickDetector)
                        if player.Character:FindFirstChild('HatPolice') then
                            player.Character:FindFirstChild('HatPolice').Parent = workspace
                        end
                    end)
                end
            end
        end)
        
        Fun:Toggle('Hat Spam', 'Spam spawns hats', false, "HS", function(value)
            FunHat = value
        end)
        
        local NukeSettings = {
            Nuke = {
                Origin = Vector3.new(755.811462, 64.1358643, -233.434555),
                Speed = 650,
                Duration = 10,
                TimeDilation = 1
            },
            Shockwave = {
                Duration = 50,
                MaxRadius = 100
            }
        }
        
        Fun:Slider('Nuke Speed', 'Nuke Speed', 1, 10000, 100,function(value)
            NukeSettings.Nuke.Speed = value
        end)
        
        Fun:Slider('Nuke Duration', 'Nuke Duration', 1, 100, 10, function(value)
            NukeSettings.Nuke.Duration = value
        end)
        
        Fun:Slider('Nuke Time Dilation', 'Nuke Time Dilation', 1, 10, 15,function(value)
            NukeSettings.Nuke.Duration = value
        end)
        
        
        Fun:Slider('Shockwave Radius', 'Shockwave Radius', 1, 10000, 100,function(value)
            NukeSettings.Shockwave.MaxRadius = value
        end)
        
        Fun:Slider('Shockwave Duration', 'Shockwave Duration', 1, 100, 50,function(value)
            NukeSettings.Shockwave.Duration = value
        end)
        
        Fun:Button('Lunch Nuke (Client Side)', 'Launches client sided nuke', function()
            Notification('You will recieve your nuke soon.', 3)
            NukeSettings.Nuke.Target = player.Character.HumanoidRootPart.Position
            Functions['Nuke'](NukeSettings)
        end)
        
        local Vehicles = UI_Init:Tab('Vehicle', "http://www.roblox.com/asset/?id=6034754441")
        
        Vehicles:Line()
        Vehicles:Label('Vehicles')
        
        Vehicles:Slider('Car Speed', 'Car Speed', 0, 150, 70, function(value)
            if Functions['GetCarTable']() then
                Functions['GetCarTable']().GarageEngineSpeed = value
            end
        end)
        
        Vehicles:Slider('Car Height', 'Car Height', 0, 250, 0,function(value)
            if Functions['GetCarTable']() then
                Functions['GetCarTable']().Height = value
            end
        end)
        
        Vehicles:Slider('Turn Speed', 'Turn Speed', 0, 250, 100, function(value)
            if Functions['GetCarTable']() then
                Functions['GetCarTable']().TurnSpeed = value
            end
        end)
        
        Vehicles:Slider('Suspension', 'Suspension', 0, 100, 4, function(value)
            if Functions['GetCarTable']() then
                Functions['GetCarTable']().Suspension = value
            end
        end)
        
        Vehicles:Slider('Mass', 'Mass', 0, 1000, 0, function(value)
            if Functions['GetCarTable']() then
                Functions['GetCarTable']().Mass = value
            end
        end)
        
        
        local NoTireDie = false
        
        spawn(function()
            while wait() do
                if NoTireDie then
                    if Functions['GetCarTable']() then
                        Functions['GetCarTable']().TireHealth = value
                    end
                end
            end
        end)
        
        Vehicles:Toggle('Infinite Tire Health', 'Gives your tires infinite health', false, "ITH", function(value)
            NoTireDie = value
        end)
        
        local RepeatCarFlip = false
        
        spawn(function()
            while wait() do
                if RepeatCarFlip then
                    Functions['Flip']()
                end
            end
        end)
        
        Vehicles:Toggle('No Car Flip', 'Disables your car from flipping', false, 'NCF',function(value)
            RepeatCarFlip = value
        end)
        
        local VehicleList = {}
        for i, v in pairs(require(ReplicatedStorage.Game.Garage.VehicleData)) do
            if not rawget(v, "NoGarageSpawn") then
                table.insert(VehicleList, v.Make)
            end
        end
        
        Vehicles:Dropdown('Spawn Vehicle', VehicleList,function(value)
            for i, v in pairs(require(ReplicatedStorage.Game.Garage.VehicleData)) do
                if v.Make == value then
                    Functions['SpawnVehicle'](v)
                end 
            end
        end)
        
        local infnitro = false
        
        spawn(function()
            while wait() do
                if infnitro then
                    if NitroTable then
                        NitroTable.Nitro = huge
                    end
                end
            end
        end)
        
        Vehicles:Toggle('Infinity Nitro (Client Sided)', 'Gives infinite nitro (client sided)', false, 'INCS',function(value)
            infnitro = value
        end)
        
        local RainbowCar = false
        local Colors = {'Red', 'Yellow', 'White', 'Blue', 'Green'}
        spawn(function()
            while wait(.5) do
                if RainbowCar then
                    setupvalue(Functions['editVehicle'], 1, Remote)
                    for i, v in pairs(Colors) do
                        Functions['editVehicle']({Name = v}, {Name = 'BodyColor'})
                        wait(.5)
                    end
                end
            end
        end)
        Vehicles:Toggle('Rainbow Car', 'Makes your car rainbow', false, "RBC", function(value)
            RainbowCar = value
        end)
        
        local Items = UI_Init:Tab('Items', "http://www.roblox.com/asset/?id=6022668888")
        
        Items:Line()
        Items:Label('Weapons')
        
        Items:Slider('Carmera Shaking','Weapon Camera Shake',  0, 10, 5, 'CAMS', function(value)
            for i, v in pairs(ReplicatedStorage.Game.ItemConfig:GetChildren()) do
                local config = require(v)
                config.CamShakeMagnitude = value
            end
        end)
        
        Items:Slider('Reload Time', 'Weapon Reload Time', 0, 7, 1, 'RT',function(value)
            for i, v in pairs(ReplicatedStorage.Game.ItemConfig:GetChildren()) do
                local config = require(v)
                config.ReloadTime = value
            end
        end)

        local OldMags = {}
        
        Items:Toggle('Infinite Ammo', 'Weapon Infinite Ammo', false, "INFA", function(value)
            for i, v in pairs(ReplicatedStorage.Game.ItemConfig:GetChildren()) do
                local config = require(v)
                if value then
                    OldMags[v] = config.MagSize
                end
                config.MagSize = value and 9e9 or OldMags[v]
            end
        end)
        
        Items:Toggle('Auto Fire', 'Weapon Auto Fire', false, 'AF', function(value)
            for i, v in pairs(ReplicatedStorage.Game.ItemConfig:GetChildren()) do
                local config = require(v)
                config.FireAuto = value
            end
        end)
        
        Items:Slider('Fire Frequency','Weapon Fire Frequency',  0, 10000, 15, function(value)
            for i, v in pairs(ReplicatedStorage.Game.ItemConfig:GetChildren()) do
                local config = require(v)
                config.FireFreq = value
            end
        end)
        
        Items:Button('Grab Items', 'Grabs pick-up-able items', function()
            for i, v in pairs(workspace.Givers:GetChildren()) do
                if v:FindFirstChild('ClickDetector') then
                    fireclickdetector(v:FindFirstChild('ClickDetector'))
                end   
            end
            for i, v in pairs(ReplicatedStorage.Game.Item:GetChildren()) do
                Functions['GrabGun']({
                    Part = {
                        Parent = {
                            Name = v.Name
                        } 
                    }, CanGrab = true 
                }, true)
            end
        end)
        
        Items:Line()
        Items:Label('Get Items')
        
        Items:Button('Get Jetpack', 'Gives jetpack', function()
            setupvalue(Functions['GetItems'], 3, workspace.TouchTrigger.JetPackGiver)
            Functions['GetItems']()
            setupvalue(Functions['GetItems'], 3, workspace.TouchTrigger.Donut)
        end)   
    end;
 

    [73885730] = function()
        local Player = player 

        local function teleport(Pos)
            player.Character:WaitForChild('HumanoidRootPart').CFrame = Pos
        end
        
        
        local LocalPlayer = UI_Init:Tab("Character", "http://www.roblox.com/asset/?id=6023426915")
        LocalPlayer:Label("Local")
        local ws = 16
        spawn(function()
            while game:GetService('RunService').RenderStepped:Wait() do
                if Player.Character and Player.Character:FindFirstChild('Humanoid') then
                    Player.Character.Humanoid.WalkSpeed = ws
                end
            end
        end)
        LocalPlayer:Slider("WalkSpeed", "Sets your character's movement speed", 0, 200, 16, function(value)
            ws = value
        end)
        
        local jp = 50
        spawn(function()
            while game:GetService('RunService').RenderStepped:Wait() do
                if Player.Character and Player.Character:FindFirstChild('Humanoid') then
                    Player.Character.Humanoid.JumpPower = jp
                end
            end
        end)
        LocalPlayer:Slider("JumpPower", "Sets your characters jump height", 0, 400, 50, function(value)
            jp = value
        end)
        
        noclip = false
        spawn(function()
            while game:GetService('RunService').Stepped:Wait() do
                if noclip then
                    for i,v in pairs(Player.Character:GetDescendants()) do
                        if v:IsA"BasePart" then
                            v.CanCollide = false
                        end
                    end
                end
            end
        end)
        LocalPlayer:Toggle("NoClip", "Allows your character to move through objects", false, "NC", function(value)
            noclip = value
        end)

        LocalPlayer:Label("Teleports")
        
        LocalPlayer:Toggle("Teleport Key Enabled", "Toggles keybind teleport", false, "TKE")
        
        LocalPlayer:Bind("Teleport Key", Enum.KeyCode.G, function()
            if Mouse.Target and Flags.TKE then
                teleport(CFrame.new(Mouse.Hit.p) + Vector3.new(0,3,0))
            end
        end)
        
        local Waypoints = {
            ["Police Room"] = CFrame.new(828, 100, 2313),
            ["Yard"] = CFrame.new(795, 97, 2459),
            ['Parking Lot'] = CFrame.new(598, 98, 2310),
            ["Crime Base"] = CFrame.new(-915, 94, 2061),
            ['Tree'] = CFrame.new(480, 136, 2378),
            ['Table Rom'] = CFrame.new(724, 99, 2278)
        }
        local ListWaypoint = {}
        for i, v in pairs(Waypoints) do
            table.insert(ListWaypoint, i)
        end

        LocalPlayer:Dropdown("Waypoint", ListWaypoint, function(value)
            teleport(Waypoints[value])
        end)
        
        
        local PlayerTable = {}
        for i, v in pairs(game.Players:GetChildren()) do
            table.insert(PlayerTable, v.Name)
        end

        local ToPlayer = LocalPlayer:Dropdown("To Player", PlayerTable, function(value)
            teleport(game.Players[value].Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0))
        end)
        game.Players.PlayerAdded:Connect(function(player)
            ToPlayer:Add(player.Name)
        end)
        game.Players.PlayerRemoving:Connect(function(player)
            ToPlayer:Clear()
            for i, v in pairs(game.Players:GetChildren()) do
                ToPlayer:Add(v.Name)
            end
        end)
         
        local Feature = UI_Init:Tab("Main", "http://www.roblox.com/asset/?id=6022668888")

        Feature:Label("Teams")
        
        Feature:Button("Be Police", "Switch to the police team", function()
            local TeamEvent = workspace.Remote.TeamEvent
            TeamEvent:FireServer(
                "Bright blue"
            )
        end)
        
        Feature:Button("Be Prisoner", "Switch to the prisoner team", function()
            local TeamEvent = workspace.Remote.TeamEvent
            TeamEvent:FireServer(
                "Bright orange"
            )
        end)

        local Gun = UI_Init:Tab("Combat", "http://www.roblox.com/asset/?id=6034287513")
        
        Gun:Label("Gun Mods")
        local Damage = 100000
        local MaxAmmo = 100000 
        local FireRate = 0.01 
        local AutoFire = true 
        local Range = 60
        local Spread = 11
        local ReloadTime = 0.1 
        local Bullets = 1
        
        Gun:Slider('Gun Damage', "Sets your weapon's damage", 0, 100000, 1000, function(value)
            Damage = value
        end)
        
        Gun:Slider('Gun MaxAmmo', "Sets your weapon's maximum ammo", 0, 10000000, 1000, function(value)
            Damage = value
        end)
        
        Gun:Slider('Gun FireRate', "Sets your weapon's fire rate", 0, 2, 0.1, function(value)
            FireRate = value
        end)
        
        Gun:Toggle('AutoFire', "Makes your weapon automatic", true, "AF", function(value)
            AutoFire = value
        end)
        
        Gun:Slider('Gun Range', "Sets your weapon's range", 0, 100000, 60, function(value)
            Range = value
        end)
        
        Gun:Slider('Gun Spread', "Sets your weapon's spread", 0, 10000000, 11, function(value)
            Spread = value
        end)
        
        Gun:Slider('Gun ReloadTime', "Sets your weapon's reload time", 0, 2, 0.1, function(value)
            ReloadTime = value
        end)
        
        Gun:Slider('Gun Bullets', "Sets your weapon's bullet amount", 0, 1000, 1, function(value)
            Bullets = value
        end)
        
        Gun:Button("Mod Gun", "Applies weapon modifications", function()
            pcall(function()
                for i, v in pairs(Player.Character:GetChildren()) do
                    if v:IsA('Tool') then
                        gun = require(v:FindFirstChild('GunStates'))
                        gun.Damage = Damage
                        gun.MaxAmmo = MaxAmmo 
                        gun.FireRate = FireRate 
                        gun.AutoFire = AutoFire 
                        gun.Range = Range
                        gun.Spread = Spread
                        gun.ReloadTime = ReloadTime 
                        gun.Bullets = Bullets
                    end
                end 
                for i, v in pairs(Player.Backpack:GetChildren()) do
                    if v:IsA('Tool') then
                        gun = require(v:FindFirstChild('GunStates'))
                        gun.Damage = Damage
                        gun.MaxAmmo = MaxAmmo 
                        gun.FireRate = FireRate 
                        gun.AutoFire = AutoFire 
                        gun.Range = Range
                        gun.Spread = Spread
                        gun.ReloadTime = ReloadTime 
                        gun.Bullets = Bullets
                    end
                end 
            end)
        end)
        
        Gun:Label("Other")

        Gun:Button('Get Remington 870', "Gives you a Remington 870", function()
            local ItemHandler = workspace.Remote.ItemHandler
            ItemHandler:InvokeServer(
                workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP
            )
        end)
        
        Gun:Button('Get AK-47', "Gives you an AK-47", function()
            local ItemHandler = workspace.Remote.ItemHandler
            ItemHandler:InvokeServer(
                workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP
            )
        end)
        
        local Main = UI_Init:Tab("Players", "http://www.roblox.com/asset/?id=6034287513")
        
        local KillAura = false
        spawn(function()
            while wait() do
                if KillAura then
                    for i, v in pairs(game.Players:GetChildren()) do
                        if v ~= game.Players.LocalPlayer then
                            local meleeEvent = game:GetService("ReplicatedStorage").meleeEvent
                            meleeEvent:FireServer(
                                v
                            )
                        end
                    end
                end
            end
        end)
        Main:Toggle('Kill Aura', "Automatically does damage to nearby players", false, "KA", function(value)
            KillAura = value
        end)
        
        local ArrestAura = false
        spawn(function()
            while wait() do
                if ArrestAura then
                    for i, v in pairs(game.Players:GetChildren()) do
                        if v ~= Player then
                            pcall(function()
                                local arrest = workspace.Remote.arrest
                                arrest:InvokeServer(
                                    v.Character.HumanoidRootPart
                                )
                            end)
                        end
                    end
                end
            end
        end)
        Main:Toggle('Arrest Aura', "Automatically arrests nearby players", false, "AA", function(value)
            ArrestAura = value
        end)
        
        Main:Button("Arrest All", "Arrests all players", function()
            for i, v in pairs(game.Players:GetChildren()) do
                if tostring(v.Team) == 'Criminals' and v ~= Player then
                    Player.Character.Humanoid.Jump = true
                    teleport(v.Character.HumanoidRootPart.CFrame)
                    for i = 1, 10 do
                        local arrest = workspace.Remote.arrest
                        arrest:InvokeServer(
                            v.Character.HumanoidRootPart
                        )
                    end
                    wait(1)
                end
            end
        end)
        
        Main:Button("Kill All", "Kills all players", function()
            pcall(function()
                for i, v in pairs(game.Players:GetChildren()) do
                    if v ~= Player then
                        Player.Character.Humanoid.Jump = true
                        teleport(v.Character.HumanoidRootPart.CFrame)
                        for i = 1, 100 do
                            local meleeEvent = game:GetService("ReplicatedStorage").meleeEvent
                            meleeEvent:FireServer(
                                v
                            )
                            game:GetService('RunService').Stepped:Wait()
                        end
                    end
                end
            end)
        end)
        
        local Annoy = false
        spawn(function()
            while game:GetService('RunService').Stepped:Wait() do
                if Annoy then
                    local TeamEvent = workspace.Remote.TeamEvent
                    TeamEvent:FireServer(
                        "Bright blue"
                    )
                    local TeamEvent = workspace.Remote.TeamEvent
                    TeamEvent:FireServer(
                        "Bright orange"
                    )
                end
            end
        end)
        Main:Toggle("Annoy", "Annoys players with chat spam", false, "AN", function(va)
            Annoy = va
        end)
    end;

    [703124385] = function()
        local function teleport(Pos)
            player.Character:WaitForChild('HumanoidRootPart').CFrame = Pos
        end
        
        local LocalPlayer = UI_Init:Tab("Character", "http://www.roblox.com/asset/?id=6023426915")
        LocalPlayer:Label("Local")

        local ws = 16
        local jp = 50
        local noclip = false

        RunService.Stepped:connect(function()
            if player.Character and player.Character:FindFirstChild('Humanoid') then
                WalkSpeed(ws)
                JumpPower(jp)
                if noclip then
                    for i,v in pairs(player.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end
            end
        end)

        LocalPlayer:Slider("Walk Speed", "Sets your character's movement speed", 0, 200, 16, function(value)
            ws = value
        end)

        LocalPlayer:Slider("Jump Height", "Sets your character's jump height", 0, 400, 50, function(value)
            jp = value
        end)

        LocalPlayer:Toggle("NoClip", "Allows your character to move through objects", false, "NC", function(value)
            noclip = value
        end)

        LocalPlayer:Bind("Teleport Key", Enum.KeyCode.G, function(a)
            if Mouse.Target then    
                player.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.p) + Vector3.new(0,3,0)
            end
        end)
        
        local Farm = UI_Init:Tab("Autofarm", "http://www.roblox.com/asset/?id=6034837797")
        
        Farm:Button('Auto Finish', "Complete the tower", function()
            if player.Character:FindFirstChild('KillScript') then
                player.Character:FindFirstChild('KillScript'):Destroy()
            end
            for i, v in pairs(workspace.tower.sections:GetChildren()) do
                teleport(v:FindFirstChildOfClass('Part').CFrame + Vector3.new(0, 10, 0))
                player.Character.Humanoid:ChangeState(10)
                wait(.5)
            end
            local object = workspace.tower.finishes:GetChildren()[1]
            teleport(workspace.tower.sections.finish.exit.carpet.CFrame + Vector3.new(0, 10, 0))
            wait(.5)
            player.Character.Humanoid:MoveTo(object.Position)
        end)
        
        
        local Farming = false
        Farm:Toggle('Loop Auto Finish', "Loop complete the tower", false, "LAF", function(value)
            Farming = value
        end)
        spawn(function()
            while wait(7) do
                if Farming then
                    pcall(function()
                        if player.Character:FindFirstChild('KillScript') then
                            player.Character:FindFirstChild('KillScript'):Destroy()
                        end
                        for i, v in pairs(workspace.tower.sections:GetChildren()) do
                            teleport(v:FindFirstChildOfClass('Part').CFrame + Vector3.new(0, 10, 0))
                            player.Character.Humanoid:ChangeState(10)
                            wait(.5)
                        end
                        local object = workspace.tower.finishes:GetChildren()[1]
                        teleport(workspace.tower.sections.finish.exit.carpet.CFrame + Vector3.new(0, 5, 0))
                        wait(.5)
                        player.Character.Humanoid:MoveTo(object.Position)
                    end)
                end
            end 
        end)
        
        LocalPlayer:Label("Damage")
        
        LocalPlayer:Button('No Damage', "Disables your player from taking damage", function()
            if player.Character:FindFirstChild('KillScript') then
                player.Character:FindFirstChild('KillScript'):Destroy()
            end
        end)
        nofall = false
        spawn(function()
            while true do
                pcall(function()
                    if nofall and (player.Character.HumanoidRootPart.Velocity.y < -1) then
                        local oldvel = player.Character.HumanoidRootPart.Velocity
                        player.Character.HumanoidRootPart.Velocity = Vector3.new(oldvel.X,1,oldvel.Z)
                    end
                    wait()
                end)
            end
        end)
        LocalPlayer:Toggle("No Fall Damage", "Disables your player from taking fall damage", false, "NF", function(value)
            nofall = value
        end)
    end;]]

    [66654135] = function()
        local function teleport(Pos)
            player.Character:WaitForChild('HumanoidRootPart').CFrame = Pos
        end
        
        local LocalPlayer = UI_Init:Tab("Character", "http://www.roblox.com/asset/?id=6023426915")
        LocalPlayer:Label("Local")

        local ws = 16
        local jp = 50
        local noclip = false

        RunService.Stepped:connect(function()
            if player.Character and player.Character:FindFirstChild('Humanoid') then
                WalkSpeed(ws)
                JumpPower(jp)
                if noclip then
                    for i,v in pairs(player.Character:GetDescendants()) do
                        if v:IsA"BasePart" then
                            v.CanCollide = false
                        end
                    end
                end
            end
        end)

        LocalPlayer:Slider("Walk Speed", "Sets your character's movement speed", 0, 200, 16, function(value)
            ws = value
        end)

        LocalPlayer:Slider("Jump Height", "Sets your character's jump height", 0, 400, 50, function(value)
            jp = value
        end)

        LocalPlayer:Toggle("NoClip", "Allows your character to move through objects", false, "NC", function(value)
            noclip = value
        end)

        LocalPlayer:Toggle("Teleport Key Enabled", "Toggles keybind teleport", false, "TKE")

        LocalPlayer:Bind("Teleport Key", Enum.KeyCode.G, function(a)
            if Mouse.Target and Flags.TKE then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.p) + Vector3.new(0,3,0)
            end
        end)
        
        local Feature = UI_Init:Tab("Main", "http://www.roblox.com/asset/?id=6022668888")
        
        Feature:Label("Gameplay")

        function ShootShotGun(pos)
            local ShootGun = nil
            for i, v in pairs(player.Backpack:GetChildren()) do
                if v:IsA'Tool' and v.Name == 'Gun' then
                    player.Character.Humanoid:EquipTool(v)
                    ShootGun = v.KnifeServer.ShootGun
                    break
                end
            end
            if ShootGun == nil then
                for i, v in pairs(player.Character:GetChildren()) do
                    if v:IsA'Tool' and v.Name == 'Gun' then
                        ShootGun = v.KnifeServer.ShootGun
                        break
                    end
                end
            end
            if ShootGun ~= nil then
                ShootGun:InvokeServer(1, pos, "AH")
            end
        end
        
        function CommitMurder()
            local Knife = nil
            for i, v in pairs(player.Backpack:GetChildren()) do
                if v:IsA'Tool' and v.Name == 'Knife' then
                    player.Character.Humanoid:EquipTool(v)
                    Knife = v.Stab
                    break
                end
            end
            if Knife == nil then
                for i, v in pairs(player.Character:GetChildren()) do
                    if v:IsA'Tool' and v.Name == 'Knife' then
                        Knife = v.Stab
                        break
                    end
                end
            end
            if Knife then
                Knife:FireServer("Slash")
            end
        end
        
        function getSheriff()
            local Sheriff = false
            for i, v in pairs(game.Players:GetChildren()) do
                if v.Character:FindFirstChild('Gun') then
                    Sheriff = v
                    break
                end
                if v.Backpack:FindFirstChild('Gun') then
                    Sheriff = v
                    break
                end
            end
            return Sheriff
        end
        
        function getMurder()
            local Murder = false
            for i, v in pairs(game.Players:GetChildren()) do
                if v.Character:FindFirstChild('Knife') then
                    Murder = v
                    break
                end
                if v.Backpack:FindFirstChild('Knife') then
                    Murder = v
                    break
                end
            end
            return Murder
        end
        
        Feature:Button('Kill Sheriff', "Kills the sheriff", function()
            pcall(function()
                Sheriff = getSheriff()
                while wait() and pcall(function() a = Sheriff.Character:FindFirstChild('HumanoidRootPart') end) do
                    teleport(Sheriff.Character.HumanoidRootPart.CFrame)
                    CommitMurder()
                end
            end)
        end)
        
        Feature:Button('Kill All', "Kills all players", function()
            pcall(function()
                spawn(function()
                    for i = 1, 100 do
                        for i, v in pairs(game.Players:GetChildren()) do
                            v.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                        end
                        wait()
                    end
                end)
                for i = 1, 100 do 
                    CommitMurder()
                end
            end)
        end)
        
        Feature:Button('Kill Murderer', "Kills the murderer", function()
            pcall(function()
                Murder = getMurder()
                while wait() and pcall(function() a = Murder.Character:FindFirstChild('HumanoidRootPart') end) do
                    teleport(Murder.Character.HumanoidRootPart.CFrame + Vector3.new(5,0,5))
                    ShootShotGun(Murder.Character.HumanoidRootPart.Position)
                end
            end)
        end)
        
        function tween_teleport(TargetFrame)
            player.Character.HumanoidRootPart.Anchored = true
            Move = TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new(((player.Character.HumanoidRootPart.Position - TargetFrame.p).Magnitude / 70), Enum.EasingStyle.Linear, Enum.EasingDirection.In), {CFrame = TargetFrame})
            Move:Play()
            Move.Completed:wait()
            player.Character.HumanoidRootPart.Anchored = false
        end
        
        function FindMap()
            for i, v in pairs(workspace:GetChildren()) do
                if v:FindFirstChild("CoinContainer") then
                    return v.CoinContainer
                elseif v:FindFirstChild("Map") then
                    if pcall(function() local view = v.Map.CoinContainer end) then
                        return v.Map.CoinContainer
                    end
                end
            end
            return false
        end
        
        local Coin_Farm = false
        spawn(function()
            while wait() do
                while Coin_Farm do
                    local Map = FindMap()
                    if Map then
                        pcall(function()
                            local minimum_distant = (player.Character.HumanoidRootPart.Position - Map['Coin_Server'].Coin.Position).Magnitude
                            local minimum_object = Map['Coin_Server']
                            for i, v in pairs(Map:GetChildren()) do
                                if v.Name == 'Coin_Server' then
                                    if (player.Character.HumanoidRootPart.Position - v.Coin.Position).Magnitude < minimum_distant then
                                        minimum_distant = (player.Character.HumanoidRootPart.Position - v.Coin.Position).Magnitude;
                                        minimum_object = v;
                                    end 
                                end
                            end
                            tween_teleport(CFrame.new(minimum_object.Coin.CFrame.p))
                            spawn(function()
                                wait(5)
                                minimum_object.Name = 'False_Coin'
                            end)
                            repeat
                                wait()
                            until(minimum_object.Name ~= 'Coin_Server')
                            wait(1)
                        end)
                    end
                    wait()
                end
            end
        end)
        
        Feature:Toggle('Auto Coin', "Automatically collects coins", false, "AC", function(value)
            Coin_Farm = value
        end)
        
        local ESP = UI_Init:Tab("Visuals", "http://www.roblox.com/asset/?id=6031763426")
        
        function ScreenPos(Position)
            local ViewPoint, Visible = game.Workspace.CurrentCamera:WorldToViewportPoint(Position)
            return Vector2.new(ViewPoint.x, ViewPoint.y)
        end
        
        local esp = false
        local MurderESP = false
        local ShelffESP = false
        local InnocentESP = false
        local lines = {}
        function espfunc()
            local Murder = true
            local Shelff = true
            pcall(function()
                Murder = getMurder()
                Shelff = getSheriff()
            end)
            local Destroy = false
                if Murder and Shelff then
                    for i, v in pairs(game.Players:GetChildren()) do
                        if v ~= Player then
                            if v.Character then
                                if ((v == Murder) and MurderESP) or ((v == Shelff) and ShelffESP) or ((v ~= Murder) and (v ~= Shelff) and InnocentESP) then
                                    local ViewPoint, Visible = game.Workspace.CurrentCamera:WorldToViewportPoint(v.Character:FindFirstChild('HumanoidRootPart').Position)
                                    if Visible then
                                        local Line = Drawing.new("Line")
                                        local Box = Drawing.new("Square")
                                        Line.Visible = true
                                        Box.Visible = true
                                        Line.From = Vector2.new(game.Workspace.CurrentCamera.ViewportSize.X / 2, game.Workspace.CurrentCamera.ViewportSize.Y)
                                        Line.To = ScreenPos(v.Character:FindFirstChild('HumanoidRootPart').Position)
                                        Box.Position = ScreenPos(v.Character:FindFirstChild('HumanoidRootPart').Position)
                                        if v == Murder then
                                            Line.Color = Color3.fromRGB(255, 0, 0)
                                            Box.Color = Color3.fromRGB(255, 0, 0)
                                        elseif v == Shelff then
                                            Line.Color = Color3.fromRGB(0, 0, 255)
                                            Box.Color = Color3.fromRGB(0, 0, 255)
                                        else
                                            Line.Color = Color3.fromRGB(200, 200, 200)
                                            Box.Color = Color3.fromRGB(200, 200, 200)
                                        end
                                        Box.Size = Vector2.new(30, 30)
                                        Box.Filled = true
                                        Line.Thickness = 1
                                        Line.Transparency = 1
                                        
                                        spawn(function()
                                            repeat RunService.RenderStepped:Wait() until Destroy
                                            Line:Remove()
                                            Box:Remove()
                                        end)
                                    end
                                end
                            end
                        end
                    end
                end
                RunService.RenderStepped:Wait()
                Destroy = true
                espfunc()
        end
        
        ESP:Toggle('Murderer ESP', "Highlights the murderer", false, "ME", function(value)
            MurderESP = value
        end)
        
        ESP:Toggle('Sheriff ESP', "Highlights the sheriff", false, "SE", function(value)
            ShelffESP = value
        end)
        
        ESP:Toggle('Innocent ESP', "Highlights inncocents", false, "IE", function(value)
            InnocentESP = value
        end)

        espfunc()
    end;

    --[[[115797356] = function()
        local UI_Sections = {
            General = UI_Init:Tab("General", "http://www.roblox.com/asset/?id=6022668888");
            Combat = UI_Init:Tab("Combat", "http://www.roblox.com/asset/?id=6034287513");
            Trolling = UI_Init:Tab("Trolling", "http://www.roblox.com/asset/?id=6034287515");
            Character = UI_Init:Tab("Character", "http://www.roblox.com/asset/?id=6023426915");
            GunMods = UI_Init:Tab("Gun Mods", "http://www.roblox.com/asset/?id=6034328955");
            Visuals = UI_Init:Tab("Visuals", "http://www.roblox.com/asset/?id=6031763426");
        }
        
        ToggleVariables = {
            BulletTracers = false;
            Backtrack = false;
            BacktrackTeamCheck = false;
            BacktrackUseTeamColor = false;
            UnlockAll = false;
            SilentAim = false;
            Instakill = false;
            Wallbang = false; 
            AutoShoot = false;
            BunnyHop = false; 
            AntiAim = false;
            NoFallDamage = false;
            InfiniteJump = false;
            ThirdPerson = false; 
            NoCrouchCooldown = false; 
            InfiniteAmmo = false;
        }
        
        OtherVariables = {
            BulletTracersLifetime = 2;
            BacktrackDestroyDelay = 2;
            BacktrackCloneDelay = 0.3;
            SilentAimHitPart = "Head";
            SilentAimHitChance = 100;
            PlayerToKill = nil;
            AllPlayers = {};
            BulletTracerColor = Color3.new(255, 0, 0);
        }
        
        local env 
        for i,v in next, getgc(true) do 
            if type(v) == "table" and rawget(v, "firebullet") then 
                env = v 
                break 
            end 
        end
        
        local function GetClosestPlayer()
            local Player = nil
            local Distance = huge
            for i,v in next, Players:GetPlayers() do
                if v ~= player and v.Team ~= player.Team then
                    if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local Magnitude = (player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude 
                        if Magnitude < Distance then
                            Distance = Magnitude
                            Player = v
                        end
                    end
                end
            end
            return Player
        end
        
        local Hit = ReplicatedStorage.Events.HitPart
        
        local function HitPart(part, multi)
            Hit:FireServer(part, part.Position, player.Character.EquippedTool.Value, 4096, player.Character.Gun, nil, nil, multi, nil, false, Vector3.new(), 26430, Vector3.new())
        end 
        
        local skins = {} 
        
        for i,v in next, ReplicatedStorage.Skins:GetChildren() do 
            if v:IsA("Folder") then
                for k,x in next, v:GetChildren() do 
                    table.insert(skins, {v.Name.."_"..x.Name})
                end
            end
        end
        
        for i,v in next, ReplicatedStorage.Gloves:GetChildren() do 
            if v:IsA("Folder") and v.Name ~= "Models" then 
                table.insert(skins, {v.Type.Value.." ".."Glove_"..v.Name})
            end
        end
        
        local oldInventory = env.CurrentInventory
        local BacktrackUseTeamColor
        local BacktrackTeamCheck
        local Backtrack
        local CustomColor
        local BacktrackDestroyDelay 
        local BacktrackCloneDelay
        
        local ChamsFolder = Instance.new("Folder", workspace)
        ChamsFolder.Name = "Chams"
        local ForceField = Enum.Material.ForceField
        
        local function AddBacktrack(plr)
            local Cham = Instance.new("Model")
            Cham.Parent = ChamsFolder
            Cham.Name = plr.Name
            for i,v in next, plr.Character:GetChildren() do 
                if v.ClassName == "Part" or v.ClassName == "MeshPart" then 
                    local Part = Instance.new("Part", Cham)
                    Part.CFrame = v.CFrame
                    Part.Size = v.Size 
                    Part.Transparency = 0.7
                    Part.Material = ForceField
                    Part.CanCollide = false
                    Part.Anchored = true
                    Part.BrickColor = ToggleVariables.BacktrackUseTeamColor and plr.TeamColor or BrickColor.new("Bright red")
                end
            end
            local start = tick()
            local pos
            repeat 
                pcall(function()
                    pos = plr.Character.HumanoidRootPart.Position
                end)
                wait()
            until pos ~= nil
            local stop = false 
            plr.CharacterRemoving:connect(function()
                stop = true
                for i,v in next, ChamsFolder:GetChildren() do 
                    if v.Name == plr.Name then 
                        v:Destroy()
                    end 
                end
                return
            end)
            coroutine.wrap(function()
                repeat 
                    if stop then
                        return 
                    end
                    local new
                    if not ToggleVariables.Backtrack then 
                        ChamsFolder:ClearAllChildren()
                        return
                    end
                    wait() 
                until plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and (plr.Character.HumanoidRootPart.Position - pos).magnitude >= 2 and tick() >= start + OtherVariables.BacktrackCloneDelay
                AddBacktrack(plr)
            end)()
            coroutine.wrap(function()
                repeat 
                    if stop or not Cham then return end
                    if not ToggleVariables.Backtrack then 
                        ChamsFolder:ClearAllChildren()
                        return
                    end
                    wait() 
                until tick() >= start + OtherVariables.BacktrackDestroyDelay
                Cham:Destroy()
            end)()
        end
        
        local Weapons = ReplicatedStorage.Weapons
        
        local OldValues = {FireRate = {}, Auto = {}, Spread = {}, EquipTime = {}, ReloadTime = {}}
        
        for i,v in next, Weapons:GetDescendants() do
            if v:IsA("StringValue") or v:IsA("NumberValue") then
                if OldValues[v.Name] then
                    OldValues[v.Name][v] = v.Value
                end
            end
        end
        
        local function ApplyMod(type, new, enabled)
            if enabled then
                for i,v in next, Weapons:GetDescendants() do
                    if v.Name == type then
                        v.Value = new 
                    end
                end
            else 
                for i,v in next, Weapons:GetDescendants() do
                    if v.Name == type then
                        v.Value = OldValues[type][v]
                    end
                end
            end
        end
        
        local camera = workspace.CurrentCamera
        local RenderStepped = RunService.RenderStepped
        local InfMoney = false
        
        for i,v in next, Players:GetPlayers() do
            if v.Team ~= player.Team then
                table.insert(OtherVariables.AllPlayers, v.Name)
            end
        end
        
        UI_Sections.Visuals:Label("Bullet Tracers")

        UI_Sections.Visuals:Toggle("Bullet Tracers", "Visualizes bullet shots", false, "BT", function(value)
            ToggleVariables.BulletTracers = value
        end);
    
        UI_Sections.Visuals:Slider("Lifetime", "The lifetime of the bullet tracer", 1, 5, 2, function(value)
            OtherVariables.BulletTracersLifetime = value
        end);

        UI_Sections.Visuals:Colorpicker("Color", Color3.fromRGB(255, 0, 0), function(value)
            OtherVariables.BulletTracerColor = value
        end);

        UI_Sections.Visuals:Label("Backtrack")
    
        UI_Sections.Visuals:Toggle("Backtrack", "Makes clones of characters as they move", false, "BAT", function(value)
            ToggleVariables.Backtrack = value
            if value then 
                for i,v in next, Players:GetPlayers() do
                    if v ~= player then
                        if not ToggleVariables.BacktrackTeamCheck or (v.Team ~= player.Team) then 
                            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then 
                                AddBacktrack(v)
                            end
                            v.CharacterAdded:connect(function(Character)
                                Character:WaitForChild("HumanoidRootPart")
                                if not ToggleVariables.BacktrackTeamCheck or (v.Team ~= player.Team) then 
                                    AddBacktrack(v)
                                end
                            end)
                        end
                    end
                end
            end
        end);
    
        UI_Sections.Visuals:Slider("Destroy Delay", "The delay of destroying the clone", 1, 10, 2, "BDD", function(value)
            OtherVariables.BacktrackDestroyDelay = value
        end);
    
        UI_Sections.Visuals:Slider("Clone Delay (ms)", "The delay of each new clone", 100, 5000, 300, "BCD", function(value)
            OtherVariables.BacktrackCloneDelay = value / 1000
        end);
    
        UI_Sections.Visuals:Toggle("Team Check", "Only backtrack enemies", false, "BTC", function(value)
            ToggleVariables.BacktrackTeamCheck = value
        end);
    
        UI_Sections.Visuals:Toggle("Use Team Color", "Use the team color for the clones", false, "BUTC", function(value)
            ToggleVariables.BacktrackUseTeamColor = value
        end);

        UI_Sections.General:Label("Random")
    
        UI_Sections.General:Toggle("Unlock All", "Unlocks all weapons", false, "UA", function(value)
            ToggleVariables.UnlockAll = value
            if value then 
                oldInventory = env.CurrentInventory
                env.CurrentInventory = skins
            else 
                env.CurrentInventory = oldInventory 
            end
        end);
    
        UI_Sections.General:Toggle("Infinite Money", "Gives your player infinite money (CS)", false, "IM", function(value)
            InfMoney = value
        end);
    
        UI_Sections.General:Button("Join CT", "Join the Counter-Terrorists team", function()
            ReplicatedStorage.Events.JoinTeam:FireServer("CT")
        end);
    
        UI_Sections.General:Button("Join T", "Join the Terrorists team", function()
            ReplicatedStorage.Events.JoinTeam:FireServer("T")
        end);
    
        UI_Sections.General:Button("Give C4", "Gives your player C4", function()
            ReplicatedStorage.Events.Drop:FireServer(ReplicatedStorage.Weapons.C4, player.Character.HumanoidRootPart.CFrame, 0, 0, false, player, false, false)
        end);

        UI_Sections.Combat:Label("Silent Aim")
    
        UI_Sections.Combat:Toggle("Silent Aim", "Always registers a hit to the nearest enemy", false, "SA", function(value)
            ToggleVariables.SilentAim = value
        end);
    
        UI_Sections.Combat:Dropdown("Hit Part", {"Head", "Root"}, function(value)
            OtherVariables.SilentAimHitPart = value == "Root" and "HumanoidRootPart" or value
        end);
    
        UI_Sections.Combat:Slider("Silent Aim Hit Chance","The percentage chance of silent aim hitting", 0, 100, 100, function(value)
            OtherVariables.SilentAimHitChance = value
        end);
    
        UI_Sections.Combat:Label("Other")

        UI_Sections.Combat:Toggle("Instakill", "Instakills with all shots", false, "IK", function(value)
            ToggleVariables.Instakill = value
        end);
    
        UI_Sections.Combat:Toggle("Wallbang", "Allows you to shoot through objects", false, "WB", function(value)
            ToggleVariables.Wallbang = value
        end);
    
        UI_Sections.Combat:Toggle("Auto Shoot", "Automatically shoots your weapon", false, "AS", function(value)
            ToggleVariables.AutoShoot = value
        end);
    
        UI_Sections.Trolling:Label("Kill")

        UI_Sections.Trolling:Dropdown("Player to Kill", OtherVariables.AllPlayers, function(value)
            OtherVariables.PlayerToKill = value
        end);
    
        UI_Sections.Trolling:Button("Kill Player", "Kill selected player", function()
            if OtherVariables.PlayerToKill then 
                local plr = Players:FindFirstChild(OtherVariables.PlayerToKill)
                if plr.Character and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("Gun") then
                    HitPart(plr.Character.Head, 10)
                end
            end
        end);
    
        UI_Sections.Trolling:Button("Kill All", "Kill all players", function()
            for i,v in next, Players:GetPlayers() do 
                if v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Gun") then
                    HitPart(v.Character.Head, 10) 
                end
            end
        end);
        
        UI_Sections.Character:Toggle("Bunny Hop", "Toggles bunny hop", false, "BH", function(value)
            ToggleVariables.BunnyHop = value
        end);
    
        UI_Sections.Character:Toggle("Anti Aim", "Protects you from being aimed at", false, "AA", function(value)
            ToggleVariables.AntiAim = value
        end);
    
        UI_Sections.Character:Toggle("No Fall Damage", "Disables your character from taking fall damage", false, "NFD", function(value)
            ToggleVariables.NoFallDamage = value
        end);
    
        UI_Sections.Character:Toggle("Infinite Jump", "Allows you to continously jump", false, "IJ", function(value)
            ToggleVariables.InfiniteJump = value
        end);
    
        UI_Sections.Character:Toggle("Third Person", "Puts your character in third person", false, "TP", function(value)
            ToggleVariables.ThirdPerson = value
        end);
    
        UI_Sections.Character:Toggle("No Crouch Cooldown", "Disables the character crouch cooldown", false, "NCC", function(value)
            ToggleVariables.NoCrouchCooldown = value
        end);
    
        UI_Sections.GunMods:Toggle("Infinite Ammo", "Gives your weapon infinite ammo", false, "IA", function(value)
            ToggleVariables.InfiniteAmmo = value
            if value then
                repeat wait() until player.Character and player.Character:FindFirstChild("Weapon")
                oldPrimStore = env['primarystored']
                oldSecondStore = env['secondarystored']
                oldAmmoCount = env['ammocount']
                oldAmmoCount2 = env['ammocount2']
                env['primarystored'] = huge
                env['secondarystored'] = huge
                env['ammocount'] = huge
                env['ammocount2'] = huge
            else
                env['primarystored'] = oldPrimStore
                env['secondarystored'] = oldSecondStore
                env['ammocount'] = oldAmmoCount
                env['ammocount2'] = oldAmmoCount2
            end 
        end);
    
        UI_Sections.GunMods:Toggle("Rapid Fire", "Allows your weapon to shoot rapidly", false, "RF", function(value)
            ApplyMod("FireRate", 0, value)
        end);
    
        UI_Sections.GunMods:Toggle("Full Auto", "Makes your weapon automatic", false, "FA", function(value)
            ApplyMod("Auto", true, value)
        end);
    
        UI_Sections.GunMods:Toggle("No Spread", "Disables weapon spread", false, "NS", function(value)
            ApplyMod("Spread", 0, value)
        end);
    
        UI_Sections.GunMods:Toggle("No Recoil", "Disables camera recoil", false, "NR", function(value)
            ToggleVariables.NoRecoil = value
        end);
    
        UI_Sections.GunMods:Toggle("Instant Equip", "Instantly equip weapons", false, "IE", function(value)
            ApplyMod("EquipTime", 0.0001, value)
        end);
    
        UI_Sections.GunMods:Toggle("No Flash", "Disables camera flash", false, "NF", function(value)
            player.PlayerGui.Blnd.Enabled = value
        end);
        
        local function CreateBulletTracer(to)
            local Distance = (player.Character.Head.Position - to).magnitude
            local Trace = Instance.new("Part")
            Trace.Parent = workspace
            Trace.Size = Vector3.new(0.1, 0.1, Distance)
            Trace.CFrame = CFrame.new(player.Character.Head.Position, to) * CFrame.new(0, 0, -Trace.Size / 2)
            Trace.Anchored = true
            Trace.CanCollide = false
            Trace.Material = ForceField
            Trace.Color = OtherVariables.BulletTracerColor
            return Trace
        end
        
        local function FadeTracer(tracer)
            local Time = 60 * OtherVariables.BulletTracersLifetime
            for i = 1, Time do 
                tracer.Transparency = i / Time
                RenderStepped:wait()
            end
            tracer:Destroy()
        end
        
        Players.PlayerAdded:connect(function(plr)
            if plr.Team ~= player.Team then
                table.insert(OtherVariables.AllPlayers, plr.Name)
            end
            if ToggleVariables.Backtrack then
                if not ToggleVariables.BacktrackTeamCheck or (plr.Team ~= player.Team) then 
                    if plr.Character then 
                        AddBacktrack(plr)
                    end
                    plr.CharacterAdded:connect(function()
                        if not ToggleVariables.BacktrackTeamCheck or (plr.Team ~= player.Team) then 
                            AddBacktrack(plr)
                        end
                    end)
                end
            end
        end)
        
        Players.PlayerRemoving:connect(function(plr)
            local plr = table.find(OtherVariables.AllPlayers, plr.Name)
            if plr then 
                table.remove(OtherVariables.AllPlayers, plr)
            end
        end)
        
        UserInputService.JumpRequest:Connect(function()
            if ToggleVariables.InfiniteJump and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid:ChangeState("Jumping")
            end
        end)
        
        local oldPrimary = env.getprimaryammo
        env.getprimaryammo = function(...)
            if ToggleVariables.InfiniteAmmo then
                return huge
            else
                return oldPrimary(...)
            end
        end
        
        local oldSecondary = env.secondaryammo
        env.secondaryammo = function(...)
            if ToggleVariables.InfiniteAmmo then
                return huge
            else
                return oldSecondary(...)
            end
        end
        
        mt = getrawmetatable(game)
        oldNamecall = mt.__namecall
        local oldIndex = mt.__index
        setreadonly(mt, false)
        
        loadstring(
            mt.__namecall = newcclosure(function(self, ...)
                local args = {...}
                local method = getnamecallmethod() 
                local name = tostring(self)
                if method == "FindPartOnRayWithIgnoreList" and ToggleVariables.Wallbang then
                    table.insert(args[2], workspace.Map)
                    return oldNamecall(self, unpack(args))
                end
    
                if method == "Kick" or method == "Ban" then 
                    return 
                end
            
                if method == "FireServer" or method == "InvokeServer" and name ~= "ReplicateCamera" and name ~= "ControlTurn" then
                    if string.len(name) == 38 or name == "Kick" or name == "Ban" or name == "BeanBoozled" or name == "Hugh" or name == "Moolah" or (name == "FallDamage" and ToggleVariables.NoFallDamage) then
                        return
                    end
    
                    if name == "HitPart" then
                        if ToggleVariables.BulletTracers then 
                            local Trace = CreateBulletTracer(args[2])
                            coroutine.wrap(FadeTracer)(Trace)
                        end
                        if OtherVariables.Instakill then 
                            args[8] = 10 
                            return oldNamecall(self, unpack(args))
                        end
                    end
                
                    if name == "DataEvent" and args[1][4] then
                        local Type, Class, Name = args[1][2], args[1][3], string.split(args[1][4][1], "_")[2]
                
                        if Type == "Both" then
                            player.SkinFolder.CTFolder[Class].Value = Name
                            player.SkinFolder.TFolder[Class].Value = Name
                        else
                            player.SkinFolder[Type .. "Folder"][Class].Value = Name
                        end
                    end
                end
    
                return oldNamecall(self, ...)
            end)
        )()
        
        mt.__index = newcclosure(function(tbl, idx)
            if idx == "Value" and tostring(tbl) == "Cash" and InfMoney then 
                return 9e9 
            end 
            return oldIndex(tbl, idx)
        end)
        
        setreadonly(mt, true)
        
        local old = env.firebullet 
        env.firebullet = function(...)
            if ToggleVariables.SilentAim then
                local closest = GetClosestPlayer() 
                local part = OtherVariables.SilentAimHitPart
                if closest and closest.Character and closest.Character:FindFirstChild(part) and closest.Character:FindFirstChild("Gun") and OtherVariables.SilentAimHitChance >= random(1, 100) then
                    HitPart(closest.Character:FindFirstChild(part), 10)
                end
            end
            return old(...)
        end
        
        local ControlTurn = ReplicatedStorage.Events.ControlTurn
        
        local Speeds = {} 
        
        for i, v in next, ReplicatedStorage.HUInfo:GetChildren() do
            Speeds[v.WalkSpeed] = v.WalkSpeed.Value
        end
        
        RunService.Heartbeat:connect(function()
            if ToggleVariables.BunnyHop and UserInputService:IsKeyDown(Enum.KeyCode.Space) and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Jumping then
                for i, v in next, ReplicatedStorage.HUInfo:GetChildren() do
                    v.WalkSpeed.Value = 999
                end
                player.Character.Humanoid.Jump = true
            else
                for i,v in next, ReplicatedStorage.HUInfo:GetChildren() do
                    v.WalkSpeed.Value = Speeds[v.WalkSpeed]
                end
            end
            if ToggleVariables.AntiAim then 
                ControlTurn:FireServer(-huge, false)
                ControlTurn:FireServer(huge, false)
            end
            if ToggleVariables.ThirdPerson then 
                player.CameraMinZoomDistance = 5
                player.CameraMaxZoomDistance = 5
                workspace.ThirdPerson.Value = true
            else 
                workspace.ThirdPerson.Value = false
            end
            if ToggleVariables.NoRecoil then 
                env.resetaccuracy()
                env.RecoilX = 0
                env.RecoilY = 0
            end 
            if ToggleVariables.AutoShoot then 
                env.firebullet() 
            end
            if ToggleVariables.NoCrouchCooldown then 
                env.crouchcooldown = 0
            end
        end)
    end;]]

    [964540701] = function()
        getmenv = getmenv or getsenv
        local GameScript = require(ReplicatedFirst.GameScript)
        local Environment = getmenv(ReplicatedFirst.GameScript)

        local UI_Sections = {
            MainSection = UI_Init:Tab("Autoplay", "http://www.roblox.com/asset/?id=6034837797");
            MiscCheats = UI_Init:Tab("Misc", "http://www.roblox.com/asset/?id=6022668907");
        }

        local ToggleVariables = {
            AutoPlayer = false;
            RainbowCursor = false;
            CursorTrail = false;
        }

        local OtherVariables = {
            SongSpeed = 1;
            Roughness = 25;
            MissPercentage = 0;
        }

        local Camera = workspace.CurrentCamera

        local function ToggleCameraLock(toggle)
            Environment.ResetCamera()
            workspace.CurrentCamera.CameraType = toggle and "Fixed" or "Track"
            UserInputService.MouseBehavior = toggle and Enum.MouseBehavior.Default or Enum.MouseBehavior.LockCenter
            setupvalue(Environment.UpdateSaber, 1, toggle and function() return CFrame.new(Camera.CFrame.p, Mouse.Hit.p) end or function() return Camera.CFrame end)
        end

        UI_Sections.MainSection:Label("Main")

        UI_Sections.MainSection:Toggle("Auto Player", "Toggles the map autoplayer", false, "AP", function(bool)
            ToggleVariables.AutoPlayer = bool
        end)
        
        UI_Sections.MainSection:Label("Configuration")

        UI_Sections.MainSection:Slider("Roughness", "The movement roughness of the autoplayer", 10, 50, 25, function(value)
            OtherVariables.Roughness = value
        end)

        UI_Sections.MainSection:Slider("Miss Percentage", "The percentage of times the autoplayer will miss", 0, 100, 0, function(value)
            OtherVariables.MissPercentage = value
        end)

        UI_Sections.MiscCheats:Toggle("Rainbow Cursor", "Makes your cursor rainbow", false, "RC", function(bool)
            ToggleVariables.RainbowCursor = bool
        end)

        UI_Sections.MiscCheats:Toggle("Cursor Trail", "Gives your cursor a trail", false, "CT", function(bool)
            getrenv()._G.PlayerData.Settings.CursorTrail = bool
        end)

        UI_Sections.MiscCheats:Slider("Song Speed", "The playback speed of the song", 1, 5, 1,  function(value)
            ReplicatedFirst.GameScript.Music.PlaybackSpeed = value
        end)

        UI_Sections.MiscCheats:Toggle("Camera Lock", "Stations your camera position", false, "CL", function(bool)
            ToggleVariables.CameraLock = bool
            if ToggleVariables.CameraLock then 
                if player.MapData.Playing.Value then
                    if not ToggleVariables.AutoPlayer then
                        ToggleCameraLock(true)
                    end
                end

                player.MapData.Playing:GetPropertyChangedSignal("Value"):connect(function(value)
                    if not ToggleVariables.AutoPlayer or player.MapData.Playing.Value == false then
                        ToggleCameraLock(player.MapData.Playing.Value)
                    end
                end)
            else 
                ToggleCameraLock(false)
            end
        end)

        RunService.RenderStepped:Connect(function()
            if ToggleVariables.AutoPlayer and player.MapData.Playing.Value then
                local MaxDistance = huge
                
                for i, v in next, workspace.Client:GetChildren() do
                    if v:IsA("Part") and v.Name == "Cube" then
                        local mag = (v.Position - Camera.CFrame.p).magnitude
                        if mag < MaxDistance then
                            MaxDistance = mag
                            TweenService:Create(Camera, TweenInfo.new(MaxDistance / (OtherVariables.Roughness * 10), Enum.EasingStyle.Linear), {CFrame = CFrame.new(Camera.CFrame.p, v.Position)}):Play()
                        end
                    end
                end
            end
            
            if ToggleVariables.RainbowCursor then
                local HSVColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                
                player.PlayerGui.CursorGui.ImageLabel.ImageColor3 = HSVColor
                player.PlayerGui.CursorGui.ImageLabel.BackgroundColor3 = HSVColor
            end
        end)
    end;

    [719754874] = function()

        local function findItem(name)
            for i, v in pairs(Players:GetChildren()) do
                if v.Character then
                    if v.Character:FindFirstChild(name) then
                        return v.Character[name]
                    end 
                    if v.Backpack:FindFirstChild(name) then
                        return v.Backpack[name]
                    end
                end
            end
        end
        
        local Server = UI_Init:Tab('Server', "http://www.roblox.com/asset/?id=6034789874")
        
        Server:Label("Map")
        
        local MapSettings = {
            Transparency = 0,
            FastMode = false
        }
        
        Server:Slider('Map Transparency', "Transparency to set map to", 0, 100, 0, function(value)
            MapSettings.Transparency = value
        end)
        
        Server:Toggle('Map Transparency Fast Mode', "Sets the map transparency faster", false, "FM", function(value)
            FastMode = value 
        end)
        
        Server:Button('Set Map Transparency', "Sets the transparency of the map (FE)", function()
            if findItem('OddPotion') then
                local odd = findItem('OddPotion')
                for i, v in pairs(workspace:GetDescendants()) do   
                    odd.TransEvent:FireServer(v, MapSettings.Transparency / 100)
                    if not MapSettings.FastMode then 
                        if random(1, 5) == 1 then
                            RunService.RenderStepped:Wait()
                        end
                    end
                end
            end 
        end)
        
        Server:Label("Crash")
        
        Server:Button('Crash Server', "Crashes the server", function()
            if findItem('ImpulseGrenade') then
                while wait() do
                    local bomb = findItem('ImpulseGrenade')
                    if not bomb then
                        return 
                    end
                    for i = 1, 50 do 
                        bomb:FindFirstChild('CreateGrenade'):FireServer(Vector3.new(-126, 5, -140), CFrame.new(-10, 0.699999988, -88, 1, 0, 0, 0, 1, 0, 0, 0, 1))
                    end
                end
            end 
        end)
        
        local PlayersTab = UI_Init:Tab('Players', "http://www.roblox.com/asset/?id=6034287513")
        
        PlayersTab:Label("Local")
        
        local LPSettings = {
            Push = false,
            PushPower = 1,
            BombAura = false,
            DisableRagdoll = false
        }
        
        PlayersTab:Toggle('Push Players', "Pushes players on collision", false, "PP", function(value)
            LPSettings.Push = value 
            if LPSettings.Push then
                spawn(function()
                    while LPSettings.Push do 
                        wait()
                        local Push = findItem('Push')
                        if Push then
                            for i = 1, LPSettings.PushPower do 
                                Push.PushEvent:FireServer()
                            end
                        end
                    end 
                end)
            end
        end)
        
        PlayersTab:Slider('Push Strength', "The strength at which players will be pushed by you", 1, 5, 1, function(value)
            LPSettings.PushPower = value 
        end)
        
        PlayersTab:Toggle('Anti Ragdoll', "Disables you from ragdolling", false, 'DR', function(value)
            LPSettings.DisableRagdoll = value
        end)
        
        spawn(function()
            while wait(1) do
                if player.Character then
                    if player.Character:FindFirstChild('Local Ragdoll') then 
                        player.Character:FindFirstChild('Local Ragdoll').Disabled = LPSettings.DisableRagdoll 
                    end
                end
            end
        end)
        
        PlayersTab:Toggle('Bomb Aura', "Automatically bombs nearby players", false, 'BA', function(value)
            LPSettings.BombAura = value 
            if LPSettings.BombAura then
                spawn(function()
                    while LPSettings.BombAura do 
                        wait(1)
                        local bomb = findItem('ImpulseGrenade')
                        if bomb and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            for i = 0, 360, 60 do
                                local angle = i * pi / 180
                                local x = player.Character.HumanoidRootPart.CFrame.X + 5 * cos(angle)
                                local z = player.Character.HumanoidRootPart.CFrame.Z + 5 * sin(angle)
                    
                                local vector = Vector3.new(x, player.Character.HumanoidRootPart.CFrame.Y, z)
                    
                                bomb:FindFirstChild('CreateGrenade'):FireServer(vector, CFrame.new(vector) + Vector3.new(0, 4, 0))
                            end
                        end
                    end 
                end)
            end
        end)
        
        PlayersTab:Slider('WalkSpeed', "Your character's movement speed", 0, 200, 16, function(value)
            WalkSpeed = value 
        end)
        
        PlayersTab:Slider('JumpPower', "Your character's jump height", 0, 200, 50, function(value)
            JumpPower = value 
        end)
        
        PlayersTab:Label("Bombs")
        
        PlayersTab:Button('Bomb All', "Bombs all players", function()
            if findItem('ImpulseGrenade') then
                local bomb = findItem('ImpulseGrenade')
                for i, v in pairs(Players:GetPlayers()) do
                    if v ~= player then
                        if v.Character then
                            if v.Character:FindFirstChild('HumanoidRootPart') and v.Character:FindFirstChild('Head') then
                                bomb:FindFirstChild('CreateGrenade'):FireServer(v.Character.HumanoidRootPart.Position, v.Character.Head.CFrame)
                            end
                        end 
                    end
                end
            end 
        end)

        local PlayersList = {}

        for i,v in next, Players:GetPlayers() do 
            table.insert(PlayersList, v.Name)
        end
        
        local BombPlayer = PlayersTab:Dropdown('Bomb Player', PlayersList, function(value)
            local Target = Players:FindFirstChild(value)
        
            if Target then
                for i = 1, 5 do 
                    local bomb = findItem('ImpulseGrenade')
                    if bomb then
                        bomb:FindFirstChild('CreateGrenade'):FireServer(Target.Character.HumanoidRootPart.Position, Target.Character.Head.CFrame)
                        wait(.5)
                    end
                end
            end
        end)

        Players.PlayerAdded:connect(function(plr)
            BombPlayer:Add(plr.Name)
        end)

        Players.PlayerRemoving:connect(function(plr)
            BombPlayer:Clear()
            for i,v in next, Players:GetPlayers() do 
                BombPlayer:Add(v.Name)
            end
        end)
    end;

    [719754874] = function()

        local function findItem(name)
            for i, v in pairs(Players:GetChildren()) do
                if v.Character then
                    if v.Character:FindFirstChild(name) then
                        return v.Character[name]
                    end 
                    if v.Backpack:FindFirstChild(name) then
                        return v.Backpack[name]
                    end
                end
            end
        end
        
        local Server = UI_Init:Tab('Server', "http://www.roblox.com/asset/?id=6034789874")
        
        Server:Label("Map")
        
        local MapSettings = {
            Transparency = 0,
            FastMode = false
        }
        
        Server:Slider('Map Transparency', "Transparency to set map to", 0, 100, 0, function(value)
            MapSettings.Transparency = value
        end)
        
        Server:Toggle('Map Transparency Fast Mode', "Sets the map transparency faster", false, "FM", function(value)
            FastMode = value 
        end)
        
        Server:Button('Set Map Transparency', "Sets the transparency of the map (FE)", function()
            if findItem('OddPotion') then
                local odd = findItem('OddPotion')
                for i, v in pairs(workspace:GetDescendants()) do   
                    odd.TransEvent:FireServer(v, MapSettings.Transparency / 100)
                    if not MapSettings.FastMode then 
                        if random(1, 5) == 1 then
                            RunService.RenderStepped:Wait()
                        end
                    end
                end
            end 
        end)
        
        Server:Label("Crash")
        
        Server:Button('Crash Server', "Crashes the server", function()
            if findItem('ImpulseGrenade') then
                while wait() do
                    local bomb = findItem('ImpulseGrenade')
                    if not bomb then
                        return 
                    end
                    for i = 1, 50 do 
                        bomb:FindFirstChild('CreateGrenade'):FireServer(Vector3.new(-126, 5, -140), CFrame.new(-10, 0.699999988, -88, 1, 0, 0, 0, 1, 0, 0, 0, 1))
                    end
                end
            end 
        end)
        
        local PlayersTab = UI_Init:Tab('Players', "http://www.roblox.com/asset/?id=6034287513")
        
        PlayersTab:Label("Local")
        
        local LPSettings = {
            Push = false,
            PushPower = 1,
            BombAura = false,
            DisableRagdoll = false
        }
        
        PlayersTab:Toggle('Push Players', "Pushes players on collision", false, "PP", function(value)
            LPSettings.Push = value 
            if LPSettings.Push then
                spawn(function()
                    while LPSettings.Push do 
                        wait()
                        local Push = findItem('Push')
                        if Push then
                            for i = 1, LPSettings.PushPower do 
                                Push.PushEvent:FireServer()
                            end
                        end
                    end 
                end)
            end
        end)
        
        PlayersTab:Slider('Push Strength', "The strength at which players will be pushed by you", 1, 5, 1, function(value)
            LPSettings.PushPower = value 
        end)
        
        PlayersTab:Toggle('Anti Ragdoll', "Disables you from ragdolling", false, 'DR', function(value)
            LPSettings.DisableRagdoll = value
        end)
        
        spawn(function()
            while wait(1) do
                if player.Character then
                    if player.Character:FindFirstChild('Local Ragdoll') then 
                        player.Character:FindFirstChild('Local Ragdoll').Disabled = LPSettings.DisableRagdoll 
                    end
                end
            end
        end)
        
        PlayersTab:Toggle('Bomb Aura', "Automatically bombs nearby players", false, 'BA', function(value)
            LPSettings.BombAura = value 
            if LPSettings.BombAura then
                spawn(function()
                    while LPSettings.BombAura do 
                        wait(1)
                        local bomb = findItem('ImpulseGrenade')
                        if bomb and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            for i = 0, 360, 60 do
                                local angle = i * pi / 180
                                local x = player.Character.HumanoidRootPart.CFrame.X + 5 * cos(angle)
                                local z = player.Character.HumanoidRootPart.CFrame.Z + 5 * sin(angle)
                    
                                local vector = Vector3.new(x, player.Character.HumanoidRootPart.CFrame.Y, z)
                    
                                bomb:FindFirstChild('CreateGrenade'):FireServer(vector, CFrame.new(vector) + Vector3.new(0, 4, 0))
                            end
                        end
                    end 
                end)
            end
        end)
        
        PlayersTab:Slider('WalkSpeed', "Your character's movement speed", 0, 200, 16, function(value)
            WalkSpeed = value 
        end)
        
        PlayersTab:Slider('JumpPower', "Your character's jump height", 0, 200, 50, function(value)
            JumpPower = value 
        end)
        
        PlayersTab:Label("Bombs")
        
        PlayersTab:Button('Bomb All', "Bombs all players", function()
            if findItem('ImpulseGrenade') then
                local bomb = findItem('ImpulseGrenade')
                for i, v in pairs(Players:GetPlayers()) do
                    if v ~= player then
                        if v.Character then
                            if v.Character:FindFirstChild('HumanoidRootPart') and v.Character:FindFirstChild('Head') then
                                bomb:FindFirstChild('CreateGrenade'):FireServer(v.Character.HumanoidRootPart.Position, v.Character.Head.CFrame)
                            end
                        end 
                    end
                end
            end 
        end)

        local PlayersList = {}

        for i,v in next, Players:GetPlayers() do 
            table.insert(PlayersList, v.Name)
        end
        
        local BombPlayer = PlayersTab:Dropdown('Bomb Player', PlayersList, function(value)
            local Target = Players:FindFirstChild(value)
        
            if Target then
                for i = 1, 5 do 
                    local bomb = findItem('ImpulseGrenade')
                    if bomb then
                        bomb:FindFirstChild('CreateGrenade'):FireServer(Target.Character.HumanoidRootPart.Position, Target.Character.Head.CFrame)
                        wait(.5)
                    end
                end
            end
        end)

        Players.PlayerAdded:connect(function(plr)
            BombPlayer:Add(plr.Name)
        end)

        Players.PlayerRemoving:connect(function(plr)
            BombPlayer:Clear()
            for i,v in next, Players:GetPlayers() do 
                BombPlayer:Add(v.Name)
            end
        end)
    end;

    [848145103] = function()
        local Local = UI_Init:Tab("Local", 'http://www.roblox.com/asset/?id=4384401919')
        local Dungeon = UI_Init:Tab("Dungeon", "http://www.roblox.com/asset/?id=6034684949")

        local remotes = ReplicatedStorage:WaitForChild("remotes")

        Local:Label("Character")

        local WalkSpeed = 16
        local JumpPower = 25

        Local:Slider('Walk Speed', "Sets your player's movement speed", 0, 35, 16, function(value)
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = value 
            end

            WalkSpeed = value
        end)

        Local:Slider('Jump Height', "Sets your player's jump height", 0, 65, 25, function(value)
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.JumpPower = value 
            end

            JumpPower = value
        end)

        Local:Label("Anti Report")

        Local:Button("Hide Nametag (Serversided)", "Hides your nametag so no one can see it", function()
            if player.Character and player.Character:FindFirstChild("playerNameplate") then 
                player.Character.playerNameplate:Destroy()
            end
        end)

        Local:Toggle("Stream Mode", "Hides your player info GUI", false, "SM", function(value)
            if player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("playerStatus") then
                player.PlayerGui.playerStatus.Enabled = not value
            end
        end)

        Local:Label("Trolling")

        local AllPlayers = {}

        for Index, Plr in next, Players:GetPlayers() do 
            if Plr ~= player then
                table.insert(AllPlayers, Plr.Name)
            end
        end

        local BRDropdown = Local:Dropdown("Force Boss Raids Lobby Whitelist", AllPlayers, function(value)
            local Lobby = workspace.bossLobbies:FindFirstChild(value)

            if Lobby and Lobby:FindFirstChild("whitelist") and not Lobby.whitelist:FindFirstChild(player.Name) then 
                local Whitelist = Instance.new("StringValue")
                Whitelist.Name = player.Name 
                Whitelist.Parent = Lobby.whitelist
            end
        end)

        Local:Label("Autosell")

        for i,v in next, {"legendary", "epic", "rare", "uncommon", "common"} do 
            Local:Toggle(v, "Sells all "..v.." items when you autosell", false, v)
        end

        Local:Button("Sell", "Sells all items of your selected rarities", function()
            local Inventory = remotes.reloadInvy:InvokeServer()

            local SellItems = {
                ["ability"] = {},
                ["helmet"] = {},
                ["chest"] = {},
                ["weapon"] = {}
            }

            for i,v in next, Inventory do
                for k,x in next, v do
                    if type(x) == "table" then
                        local Class, Id = k:split("_")[1], k:split("_")[2]

                        if Flags[x.rarity] == true then 
                            table.insert(SellItems[Class], tonumber(Id))
                        end
                    end
                end
            end

            remotes.sellItemEvent:FireServer(SellItems)
        end)

        Local:Label("Auto Skill Point")

        local Skills = {
            ["physicalPower"] = 0,
            ["spellPower"] = 0,
            ["stamina"] = 0
        }

        local Level = player.leaderstats.Level.Value

        for i,v in next, Skills do 
            Local:Slider(i, "Amount of skills to spend on "..i, 0, Level - 1, 0, function(value)
                Skills[i] = value
            end)
        end

        Local:Button("Spend Skill Points", "Spends your skill points with your selected amounts", function()
            for Skill, Amount in next, Skills do 
                if Amount > 0 then
                    for Index = 1, Amount do 
                        remotes.spendSkillPoint:FireServer(Skill)
                    end
                end
            end
        end)

        Dungeon:Label("Manual Farm")

        Dungeon:Toggle("Auto Instakill", "Automatically Instakills Client-Sided Mobs", false, "Instakill")

        local SemiGodDungeons = {
            3119903031,
            3277965370,
        }

        local function Loaded(a)
            local GameName = game.MarketplaceService:GetProductInfo(game.PlaceId).Name
            
            if a and a.Name == "Ice Elemental" then
                return true 
            end
            local ignore = {
                ["Spider Queen"] = function() 
                    repeat wait() until a:WaitForChild("enemyNameplate"):FindFirstChild("Script") 
                end, 
                ["Demonic Overgrowth"] = function() 
                    wait(3)
                    repeat wait() until a:WaitForChild("enemyNameplate"):FindFirstChild("Script") 
                end,
                ["Kolvumar"] = function()
                    wait(3)
                    repeat wait() until a:WaitForChild("enemyNameplate"):FindFirstChild("Script") 
                end,
                ["Demon Lord Azrallik"] = function()
                    wait(3)
                    repeat wait() until a:FindFirstChild("meleeDistance") 
                end,
                ["Burly Enforcer"] = function()
                    repeat wait() until a:WaitForChild("Beard"):FindFirstChild("Handle"):FindFirstChild("Mesh")
                end,
                ["The Kraken"] = function()
                    repeat wait() until a:WaitForChild("enemyNameplate"):FindFirstChild("Script")
                end,
                ["Corrupt Overlord"] = function()
                    repeat wait() until a:WaitForChild("Kraken Blade")
                end,
                ["Sea Serpent"] = function()
                    repeat wait() until a:WaitForChild("particlePart"):FindFirstChild("particle")
                end,
                ["Cyclops Siege Bot"] = function()
                    repeat wait() until a:FindFirstChild("headAimPart")
                end,
                ["Cannon Blaster 2000"] = function()
                    repeat wait() until a:WaitForChild("leftArmShotPart"):FindFirstChild("secondExplosion")
                end,
                ["Spinner Bot"] = function()
                    repeat wait() until a:WaitForChild("neon"):FindFirstChild("Attachment2")
                end,
                ["Hammer Bot"] = function()
                    repeat wait() until a:WaitForChild("Meshes/robothammer_Sphere.002")
                end,
                ["Ancient Golem Guardian"] = function()
                    repeat wait() until a:WaitForChild("Humanoid"):FindFirstChild("Animator")
                end,
                ["Cannon Crab"] = function()
                    repeat wait() until a:WaitForChild("enemyNameplate"):FindFirstChild("Script")
                end,
            }
            
            if not a or a.Name:lower() == "sand peasant" or GameName == "Desert Temple" or GameName == "Orbital Outpost" or GameName == "Volcanic" or GameName == "Winter Outpost" then
                return true
            else
                if ignore[a.Name] then
                    ignore[a.Name]()
                    return true
                else
                    repeat wait() until a and a:FindFirstChildWhichIsA("Accessory") and a:FindFirstChildWhichIsA("Accessory"):WaitForChild("Handle"):FindFirstChild("AccessoryWeld")
                    if GameName == "King's Castle" then
                        wait(1)
                    end
                    return true
                end
            end
        end

        Dungeon:Toggle("Semi God Mode (Underworld / Samurai ONLY)", "Makes boss mobs not attack you, NOT ALL BOSSES WORK, reset & toggle off to disable", false, "SemiGodMode", function(value)
            if value then
                if table.find(SemiGodDungeons, game.PlaceId) then 
                    if player.Character and player.Character:FindFirstChild("LowerTorso") and player.Character.LowerTorso:FindFirstChild("Root") then 
                        player.Character.LowerTorso.Root:Destroy()
                    end
                end
            end
        end)

        Dungeon:Toggle("Disable Borders", "Allows you to walk through invisible borders", false, "DB", function(value)
            if workspace:FindFirstChild("borders") then 
                for Index, Border in next, workspace.borders:GetChildren() do 
                    Border.CanCollide = not value 
                end
            end
        end)

        Dungeon:Toggle("Auto Use Abilities", "Automatically uses your Q/E abilities", false, "AutoUseAbilities")

        Dungeon:Toggle("Auto Swing", "Automatically swings your melee weapon", false, "AutoSwing")

        Players.PlayerAdded:connect(function(plr)
            BRDropdown:Add(plr.Name)
        end)

        Players.PlayerRemoving:connect(function(plr)
            BRDropdown:Clear()
            for i,v in next, Players:GetPlayers() do 
                BRDropdown:Add(v.Name)
            end
        end)

        player.CharacterAdded:Connect(function(Character)
            local Humanoid = Character:WaitForChild("Humanoid")
            Humanoid.WalkSpeed = WalkSpeed 
            Humanoid.JumpPower = JumpPower

            if Flags.SemiGodMode and table.find(SemiGodDungeons, game.PlaceId) then 
                local Root = Character:WaitForChild("LowerTorso"):WaitForChild("Root")

                Root:Destroy()
            end
        end)

        local ClientSidedMobs = {
            ["Sand Peasant"] = true,
            ["Sand Giant"] = true,
            ["Frost Minion"] = true,
            ["Frost Wizard"] = true,
            ["Pirate Rifleman"] = true,
            ["Pirate Savage"] = true,
            ["Elementalist"] = true,
            ["King's Guard"] = true,
            ["Dark Mage"] = true,
            ["Demon Warrior"] = true,
            ["Samurai Swordsman"] = true,
            ["Bodyguard"] = true,
            ["Burly Enforcer"] = true,
            ["Raider"] = true,
            ["Harpoon Gunner"] = true,
            ["Cannon Crab"] = true,
            ["Spinner Bot"] = true,
            ["Fighter Bot"] = true,
            ["Cog Shooter"] = true,
            ["Hammer Bot"] = true,
            ["Hologram Assassin"] = true,
            ["Hologram Warrior"] = true,
            ["Chicken Mage"] = true,
            ["Chicken Brawler"] = true
        }

        local SwordCooldown = false

        game:GetService("RunService").Heartbeat:Connect(function()
            if Flags.AutoUseAbilities then 
                for Index, Ability in next, player.Backpack:GetChildren() do 
                    if Ability.cooldown.Value <= 0 then
                        local Event = Ability:FindFirstChildOfClass("RemoteEvent")

                        if Event then 
                            Event:FireServer()
                        end
                    end
                end
            end 

            if Flags.AutoSwing and player.Character then 
                for Index, Child in next, player.Character:GetChildren() do
                    if Child.ClassName == "Accessory" and Child:FindFirstChild("swing") and Child:FindFirstChild("attackSpeed") then
                        if not SwordCooldown then 
                            SwordCooldown = true 
                            Child.swing:FireServer()
                            wait(Child.attackSpeed.Value / 10)
                            SwordCooldown = false
                        end
                    end
                end
            end

            if Flags.Instakill then 
                if setsimulationradius then 
                    setsimulationradius(huge, huge)
                elseif sethiddenproperty then 
                    sethiddenproperty(Player, "SimulationRadius", huge)
                end

                for Index, Child in next, workspace.dungeon:GetChildren() do
                    if Child:FindFirstChild("enemyFolder") and Child.enemyFolder:FindFirstChildOfClass("Model") then
                        for SecondIndex, Descendant in next, Child.enemyFolder:GetChildren() do
                            if Descendant:IsA("Model") and Descendant:FindFirstChild("HumanoidRootPart") and Descendant:FindFirstChild("Humanoid") then
                                if ClientSidedMobs[Descendant.Name] and Descendant:FindFirstChild("enemyStyle") then 
                                    repeat wait() until Loaded(Descendant)
                                    Descendant.Humanoid.Health = 0
                                end
                            end
                        end
                    end
                end
            end
        end)
    end;

    [286090429] = function()
        local Combat = UI_Init:Tab("Combat", "http://www.roblox.com/asset/?id=6034287513");
        local GunMod = UI_Init:Tab("Gun Mods", "http://www.roblox.com/asset/?id=6034328955");
        local Character = UI_Init:Tab("Character", "http://www.roblox.com/asset/?id=6023426915");

        local ToggleVariables = {
            KnifeSilent = false;
            SilentAim = false; 
            GodMode = false; 
            GunToggle = false;
            InfiniteAmmo = false; 
            NoRecoil = false; 
            NoSpread = false; 
            RapidFire = false;
            Automatic = false;
            Instakill = false;
            AlwaysBackstab = false;
            Wallbang = false;
        }
        
        local OtherVariables = {
            ReplicatedStorage = ReplicatedStorage;
            Players = Players; 
            NRPBS = player.NRPBS;
            Client = nil;
            CurrentPlayers = {};
            StoredGunData = {};
            CreateProjectile = nil;
            JumpPower = 18;
            SilentAimHitChance = 100;
            SilentAimHitPart = "Head";
            KnifeSilentHitChance = 100;
            KnifeSilentHitPart = "Head";
            AllWeapons = {};
            Weapon = nil;
            HeadshotChance = 50;
        }
        
        local function GetGunData(gun, variable)
            local Gun = OtherVariables.ReplicatedStorage.Weapons[gun]
        
            if Gun ~= nil then
                return Gun[variable].Value
            end
        
            return nil
        end
        
        local Utilities = {
            GetClosestPlayer = function()
                local last = math.huge 
                local closest 
        
                for i,v in next, OtherVariables.Players:GetPlayers() do 
                    if v ~= player and v:FindFirstChild("Status") and v.Status:FindFirstChild("Team") and v.Status.Team.Value ~= player.Status.Team.Value and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then 
                        local mag = (player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
                        if mag < last then 
                            last = mag 
                            closest = v 
                        end
                    end
                end
        
                return closest
            end;
        
            KillPlayer = function(plr)
                local Player = plr
                local PlayerCharacter = Player.Character
                local playerGun = OtherVariables.NRPBS.EquippedTool.Value
        
                if OtherVariables.ReplicatedStorage.wkspc.Status.RoundOver.Value then return end
        
                local HitPart 
                local PartToHit
        
                if playerGun ~= "Knife" and playerGun ~= "Golden Knife" then 
                    HitPart = OtherVariables.SilentAimHitPart == "Head" and "Head" or "HumanoidRootPart"
                    PartToHit = PlayerCharacter:FindFirstChild(HitPart)
                else 
                    HitPart = OtherVariables.KnifeSilentHitPart == "Head" and "Head" or "HumanoidRootPart"
                    PartToHit = PlayerCharacter:FindFirstChild(HitPart)
                end
        
                if PlayerCharacter ~= nil and playerGun then
                    local Distance = (player.Character.Head.Position - PartToHit.Position).magnitude
                    local Crit = math.random() > 0.6 and true or false
                
                    if playerGun ~= "Knife" and playerGun ~= "Golden Knife" then 
                        if OtherVariables.SilentAimHitChance >= math.random(1, 100) then
                            OtherVariables.ReplicatedStorage.Events.HitPart:FireServer(PartToHit, PartToHit.Position, playerGun, Crit and 2 or 1, Distance, nil, Crit, false, 1, false,
                            GetGunData(playerGun, "FireRate"), GetGunData(playerGun, "ReloadTime"), GetGunData(playerGun, "Ammo"), GetGunData(playerGun, "StoredAmmo"), GetGunData(playerGun, "Bullets"), 
                            GetGunData(playerGun, "EquipTime"), GetGunData(playerGun, "RecoilControl"), GetGunData(playerGun, "Auto"), GetGunData(playerGun, "Speed%"), OtherVariables.ReplicatedStorage.wkspc.DistributedTime.Value)
                        end
                    else
                        if OtherVariables.KnifeSilentHitChance >= math.random(1, 100) then
                            OtherVariables.ReplicatedStorage.Events.HitPart:FireServer(PartToHit, PartToHit.Position, playerGun, 0, Distance, true, false, false, 1, false,
                            GetGunData(playerGun, "FireRate"), GetGunData(playerGun, "ReloadTime"), GetGunData(playerGun, "Ammo"), GetGunData(playerGun, "StoredAmmo"), GetGunData(playerGun, "Bullets"), 
                            GetGunData(playerGun, "EquipTime"), GetGunData(playerGun, "RecoilControl"), GetGunData(playerGun, "Auto"), GetGunData(playerGun, "Speed%"), OtherVariables.ReplicatedStorage.wkspc.DistributedTime.Value)
                        end
                    end
                end
            end;
        
            FFC = function(Parent, Child)
                return Parent:FindFirstChild(Child)
            end;
        }
        
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall 
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local args = {...}
        
            if tostring(self) == "HitPart" then 
                local Gun = OtherVariables.NRPBS.EquippedTool.Value
                if ToggleVariables.AlwaysBackstab and Gun == "Knife" or Gun == "Golden Knife" then 
                    args[6] = true
                end
                if Flags.HeadshotChance and OtherVariables.HeadshotChance >= math.random(1, 100) and (not ToggleVariables.SilentAim or OtherVariables.SilentAimHitPart == "Head") and args[1].Parent and table.find(OtherVariables.CurrentPlayers, args[1].Parent.Name) then 
                    if tostring(args[1]) ~= "Head" then
                        args[1] = args[1].Parent.Head
                        args[2] = args[1].Parent.Head.Position
                    end
                end
                if ToggleVariables.Instakill and not ToggleVariables.SilentAim and not ToggleVariables.KnifeSilent and args[1].Parent and table.find(OtherVariables.CurrentPlayers, args[1].Parent.Name) then
                    for i = 1, 5 do 
                        oldNamecall(self, unpack(args))
                    end
                end
            end 
            
            return oldNamecall(self, unpack(args))
        end)
        
        setreadonly(mt, true)
        
        for i, v in next, getgc(true) do
            if typeof(v) == "table" then
                if rawget(v, "firebullet") then
                    OtherVariables.Client = v
                end 

                if rawget(v, "updateInventory") then 
                    RunService.Stepped:Connect(function()
                        if ToggleVariables.InfiniteAmmo then
                            setupvalue(v.updateInventory, 3, 999)
                        end
                    end)
                end
            end
        end
        
        hook = hookfunction(OtherVariables.Client.firebullet, function(...)
            local Gun = OtherVariables.ReplicatedStorage.Weapons:FindFirstChild(OtherVariables.NRPBS.EquippedTool.Value)
            local HitPart = OtherVariables.SilentAimHitPart == "Head" and "Head" or "HumanoidRootPart"
            if ((Gun.Name == "Knife" or Gun.Name == "Golden Knife") and ToggleVariables.KnifeSilent) or (ToggleVariables.SilentAim and Gun.Name ~= "Knife" and Gun.Name ~= "Golden Knife") then
                local Closest = Utilities.GetClosestPlayer() 
                if Closest and Closest.Character and Closest.Character:FindFirstChild(HitPart) then
                    if ToggleVariables.Instakill then 
                        for i = 1, 5 do 
                            Utilities.KillPlayer(Closest)
                        end 
                    else 
                        Utilities.KillPlayer(Closest)
                    end
                end
            end
            return hook(...)
        end)
        
        RunService.Heartbeat:Connect(function()
            if ToggleVariables.Automatic then 
                OtherVariables.Client.mode = "automatic"
            end
            if ToggleVariables.RapidFire then 
                OtherVariables.Client.DISABLED = false
                OtherVariables.Client.DISABLED2 = false
            end
            if ToggleVariables.NoRecoil then 
                OtherVariables.Client.recoil = 0
            end
            if ToggleVariables.NoSpread then 
                OtherVariables.Client.currentspread = 0 
            end
            if player.Character and player.Character:FindFirstChild("Humanoid") then 
                player.Character.Humanoid.JumpPower = OtherVariables.JumpPower 
            end
        end)

        Combat:Label("Silent Aim")
        
        Combat:Toggle("Silent Aim", "Always registers a hit on the nearest enemy", false, "SA", function(value)
            ToggleVariables.SilentAim = value
        end);
    
        Combat:Dropdown("Silent Aim Hit Part", {"Head", "Root"}, function(value)
            OtherVariables.SilentAimHitPart = value
        end);
    
        Combat:Slider("Silent Aim Hit Chance", "The chance of silent aim hitting the target", 0, 100, 100, function(value)
            OtherVariables.SilentAimHitChance = value
        end);

        Combat:Label("Melee")
    
        Combat:Toggle("Knife Silent Aim", "Always registers a hit on the nearest enemy while using your melee weapon", false, "KSA", function(value)
            ToggleVariables.KnifeSilent = value
        end);
    
        Combat:Dropdown("Knife Silent Aim Hit Part", {"Head", "Root"}, function(value)
            OtherVariables.KnifeSilentHitPart = value
        end);
    
        Combat:Slider("Knife Silent Aim Hit Chance", "The chance of knife silent aim hitting the target", 0, 100, 100, function(value)
            OtherVariables.KnifeSilentHitChance = value
        end);

        Combat:Toggle("Always Backstab", "Always registers melee hits as a backstab", false, "AB", function(value)
            ToggleVariables.AlwaysBackstab = value
        end);

        Combat:Label("Misc")

        Combat:Toggle("Headshot Chance Enabled", "Toggles headshot chance slider", false, "HeadshotChance")
    
        Combat:Slider("Headshot Chance", "The chance of hitting a headshot", 0, 100, 50, function(value)
            OtherVariables.HeadshotChance = value
        end);
    
        Combat:Toggle("Instakill", "Instakills any target hit", false, "IK", function(value)
            ToggleVariables.Instakill = value
        end);
    
        Character:Slider("Walkspeed", "Sets your player's movement speed", 16, 250, 16, function(value)
            OtherVariables.Client.speedupdate = function()
                player.Character.Humanoid.WalkSpeed = value
            end
        end);
    
        Character:Slider("Jump Height", "Sets your player's jump height", 18, 250, 18, function(value)
            OtherVariables.JumpPower = value
        end);
    
        GunMod:Toggle("Infinite Ammo", "Gives your weapon infinite ammo", false, "IA", function(value)
            ToggleVariables.InfiniteAmmo = value
            if not ToggleVariables.InfiniteAmmo then
                for i,v in next, getgc() do
                    if typeof(v) == "function" and debug.getinfo(v).name == "updateInventory" then
                        debug.setupvalue(v, 3, 1)
                    end
                end
            end
        end);
    
        GunMod:Toggle("Rapid Fire", "Allows your weapon to shoot rapidly", false, "RF", function(value)
            ToggleVariables.RapidFire = value 
            if not ToggleVariables.RapidFire then
                OtherVariables.Client.DISABLED = true
                OtherVariables.Client.DISABLED2 = true
            end
        end);
    
        GunMod:Toggle("Full Auto", "Sets your gun to be fully automatic", false, "FA", function(value)
            ToggleVariables.Automatic = value 
            if not ToggleVariables.Automatic then 
                if OtherVariables.NRPBS.EquippedTool.Value and not GetGunData(OtherVariables.NRPBS.EquippedTool.Value, "Auto") then 
                    OtherVariables.Client.mode = "semi"
                end
            end
        end);
    
        GunMod:Toggle("No Recoil", "Disables camera recoil", false, "NR", function(value)
            ToggleVariables.NoRecoil = value
                    if not ToggleVariables.NoRecoil then 
                if OtherVariables.NRPBS.EquippedTool.Value then 
                    OtherVariables.Client.recoil = GetGunData(OtherVariables.NRPBS.EquippedTool.Value, "RecoilControl")
                end
            end
        end);
    
        GunMod:Toggle("No Spread", "Disables bullet spread", false, "NS", function(value)
            ToggleVariables.NoSpread = value 
            if not ToggleVariables.NoSpread then 
                if OtherVariables.NRPBS.EquippedTool.Value then 
                    OtherVariables.Client.currentspread = GetGunData(OtherVariables.NRPBS.EquippedTool.Value, "Spread")
                end
            end
        end)
    end;

    [1087859240] = function()
        local Local = UI_Init:Tab("Local", "http://www.roblox.com/asset/?id=6023426915")
        local Visuals = UI_Init:Tab("Visuals", "http://www.roblox.com/asset/?id=6031763426")
        local Misc = UI_Init:Tab("Misc", "http://www.roblox.com/asset/?id=6022668907")
        
        --// Define Variables
        
        local Variables = {
            NoClip = {
                Enabled = false;
            };
        
            NoFallDamage = {
                Enabled = false;
            };
        
            AutoPickup = {
                Enabled = false;
            };
        
            InfiniteJump = {
                Enabled = false;
            };
        
            Walkspeed = {
                Enabled = false; 
                Speed = 50;
            };
        
            AdjustMana = {
                Enabled = false;
                Amount = 50;
            };
        
            AntiHystericus = {
                Enabled = false;
            };
        
            DisableInWater = {
                Enabled = false;
            };
        
            NoClipXRay = {
                Enabled = false;
            };
        
            DisableWhenKnocked = {
                Enabled = false;
            };
        
            OreFarm = {
                Enabled = false;
            };
        
            ESP = {
                IngredientIds = {
                    [2577691737] = "Lava Flower";
                    [2618765559] = "Glow Shroom";
                    [2575167210] = "Moss Plant";
                    [2620905234] = "Scroom";
                    [2766925289] = "Trote";
                    [2766925320] = "Polar Plant";
                    [2766802713] = "Periashroom";
                    [2766802766] = "Strange Tentacle";
                    [2766925228] = "Tellbloom";
                    [2766802731] = "Dire Flower";   
                    [2573998175] = "Freeleaf";
                    [2766925214] = "Crown Flower";
                    [3215371492] = "Potato";
                    [2766925304] = "Vile Seed";
                    [3049345298] = "Zombie Scroom";
                    [2766802752] = "Orcher Leaf";
                    [2766925267] = "Creely";
                    [2960178471] = "Snowshroom";
                    [2889328388] = "Ice Jar";
                    [3049928758] = "Canewood";
                    [3049556532] = "Acorn Light";
                    [2766925245] = "Uncanny Tentacle";
                    [2773353559] = "Blood Thorn";
                    [2982135435] = "Howler Fang";
                    [2982135518] = "Shrieker Eye";
                };
        
                TrinketIds = {
                    [5196776695] = "Ring";
                    [5196551436] = "Amulet";
                    [5204003946] = "Goblet";
                    [5196782997] = "Old Ring";
                    [5196577540] = "Old Amulet";
                    [2765613127] = "Idol of the Forgotten";
                };
        
                GemColors = {
                    ["Ruby"] = BrickColor.new('Really red');
                    ["Opal"] = BrickColor.new('Institutional white');
                    ['Emerald'] = BrickColor.new('Forest green');
                };
                
                GemsEnabled = {
                    ["Ruby"] = false;
                    ["Opal"] = false;
                    ["Emerald"] = false;
                };
        
                TrinketsEnabled = {
                    ["Ring"] = false;
                    ["Amulet"] = false;
                    ["Goblet"] = false;
                    ["Old Ring"] = false;
                    ["Old Amulet"] = false;
                    ["Idol of the Forgotten"] = false;
                };
        
                IngredientsEnabled = {
                    ["Lava Flower"] = false;
                    ["Glow Shroom"] = false;
                    ["Moss Plant"] = false;
                    ["Scroom"] = false;
                    ["Trote"] = false;
                    ["Polar Plant"] = false;
                    ["Periashroom"] = false;
                    ["Strange Tentacle"] = false;
                    ["Tellbloom"] = false;
                    ["Dire Flower"] = false;   
                    ["Freeleaf"] = false;
                    ["Crown Flower"] = false;
                    ["Potato"] = false;
                    ["Vile Seed"] = false;
                    ["Zombie Scroom"] = false;
                    ["Orcher Leaf"] = false;
                    ["Creely"] = false;
                    ["Snowshroom"] = false;
                    ["Ice Jar"] = false;
                    ["Canewood"] = false;
                    ["Acorn Light"] = false;
                    ["Uncanny Tentacle"] = false;
                    ["Blood Thorn"] = false;
                    ["Howler Fang"] = false;
                    ["Shrieker Eye"] = false;
                };
        
                Tracers = false; 
                Range = 1000;
                Label = false;
                Color = Color3.fromRGB(255, 0, 0);
                Enabled = false;
            },
        
            ModList = {}
        }
        
        --// Grabbing Mods (takes 2s)
        do 
            function tryJSONDecode(text)
                local Output 
                if pcall(function() Output = game:GetService('HttpService'):JSONDecode(text) end) then
                    return Output
                end 
                return {}
            end
            
            function isMod(name)
                local DangerousWord = {'mod', 'admin', 'dev', 'owner'} 
                
                for i, v in pairs(DangerousWord) do
                    if string.find(name:lower(), v) then
                        return true
                    end
                end
                return false
            end
            
            function grabMods(cur)
                local RequestUrl = 'https://groups.roblox.com/v1/groups/4556484/users?sortOrder=Asc&limit=100'
                if cur then
                    RequestUrl = RequestUrl .. '&cursor=' .. cur 
                end
                local Data = tryJSONDecode(game:HttpGetAsync(RequestUrl))
                
                
                if Data['data'] then
                    for i, v in pairs(Data['data']) do
                        if v['user'] then
                            if isMod(v.role.name) then
                                table.insert(Variables.ModList, v.user.userId)
                            end
                        end
                    end
                end
                
                if Data['nextPageCursor'] then
                    grabMods(Data['nextPageCursor'])
                end
            end
            
            grabMods()
        end
        
        local Camera = workspace.CurrentCamera
        
        local Functions = {
            Character = {
                IsAlive = function()
                    if player.Character then 
                        if player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Torso") and player.Character:FindFirstChild("HumanoidRootPart") then 
                            local NamePart = player.Character:FindFirstChild(player.leaderstats.FirstName.Value) or player.Character:FindFirstChild(player.leaderstats.FirstName.Value .. " " .. player.leaderstats.LastName.Value)
                            if NamePart and NamePart:FindFirstChild("Head") then 
                                return true
                            end
                        end
                    end
                end;
            };
            Items = {
                GrabItemFolder = function()
                    for i, v in next, workspace:GetChildren() do
                        if v:FindFirstChild('UnionOperation') then
                            return v 
                        end
                    end
                end;
            }
        }
        
        --// Anticheat Bypasses
        
        for i,v in next, getconnections(game:GetService("ScriptContext").Error) do 
            v:Disable()
        end
        
        for i,v in next, getconnections(game:GetService("LogService").MessageOut) do 
            v:Disable()
        end
        
        hook = hookfunction(coroutine.wrap, newcclosure(function(f)
            if #getupvalues(f) >= 3 and typeof(getupvalue(f, 2)) == "Instance" and type(getupvalue(f, 3)) == "boolean" and type(getupvalue(f, 1)) == "function"  then 
                return player:Kick("Ban Attempt | Blocked By Alpha X")
            end
            return hook(f)
        end))
        
        --// Random Stuff 
        
        local ItemFolder = Functions.Items.GrabItemFolder()
        
        --// Chat Logger 
        
        local ScreenGui = Instance.new("ScreenGui")
        local ScrollingFrame = Instance.new("ScrollingFrame")
        local UIListLayout = Instance.new("UIListLayout")
        
        ScreenGui.Enabled = false
        ScreenGui.Parent = game:GetService("CoreGui")
        
        ScrollingFrame.Parent = ScreenGui
        ScrollingFrame.Active = true
        ScrollingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        ScrollingFrame.BackgroundTransparency = 0.500
        ScrollingFrame.BorderSizePixel = 0
        ScrollingFrame.Position = UDim2.new(0.0391986072, 0, 0.148217663, 0)
        ScrollingFrame.Size = UDim2.new(0, 289, 0, 375)
        ScrollingFrame.ScrollBarThickness = 3
        
        UIListLayout.Parent = ScrollingFrame
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        
        local function NewMessage(sender, message)
            local TextLabel = Instance.new("TextLabel")
            
            TextLabel.Parent = ScrollingFrame
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1.000
            TextLabel.Size = UDim2.new(0, 289, 0, 28)
            TextLabel.Font = Enum.Font.Gotham
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.TextSize = 12
            TextLabel.Text = sender.." : "..message
        end
        
        local Players = game:GetService("Players")
        local Connections = {}
        
        for i,v in next, Players:GetPlayers() do 
            Connections[v] = v.Chatted:connect(function(message)
                NewMessage(v.Name, message)
            end) 
        end
        
        Players.PlayerAdded:connect(function(plr)
            Connections[plr] = plr.Chatted:connect(function(message)
                NewMessage(plr.Name, message)
            end)
        end)
        
        Players.PlayerRemoving:connect(function(plr)
            local Connection = Connections[plr]
            if Connection then 
                Connection:Disconnect()
            end
        end)
        
        --// UI Elements

        Local:Label("Character")
        
        Local:Toggle("NoClip", "Allows you to walk through objects", false, "NoClip", function(value)
            Variables.NoClip.Enabled = value
        end);
        
        Local:Toggle("Disable NoClip In Water", "Disables noclip while in water", false, "DisableInWater", function(value)
            Variables.DisableInWater.Enabled = value
        end)
        
        Local:Toggle("Disable NoClip When Knocked", "Disables noclip when knocked", false, "DisableWhenKnocked", function(value)
            Variables.DisableWhenKnocked.Enabled = value
        end)
        
        Local:Toggle("NoClip XRay", "Makes objects you are noclipping through transparent", false, "NoClipXRay", function(value)
            Variables.NoClipXRay.Enabled = value
        end)

        Local:Toggle("Infinite Jump", "Allows you to infinitely jump", false, "InfJump", function(value)
            Variables.InfiniteJump.Enabled = value
        end);
        
        Local:Toggle("Walkspeed Enabled", "Toggles walk speed modification", false, "WSEnabled", function(value)
            Variables.Walkspeed.Enabled = value
        end);
        
        Local:Slider("Walkspeed", "Your character's movement speed", 0, 100, 50, function(value)
            Variables.Walkspeed.Speed = value
        end);

        Local:Label("Status")
        
        Local:Toggle("No Fall Damage", "Prevents you from taking fall damage", false, "NoFallDmg", function(value)
            Variables.NoFallDamage.Enabled = value
        end);
        
        Local:Toggle("Anti Burn", "Prevents fire from burning you", false, "AntiBurn", function(value)
            local Parent = value and workspace.Map or game:GetService("Lighting")
            local Change = value and game:GetService("Lighting") or workspace.Map
        
            for i,v in next, Parent:GetChildren() do
                if v.Name == "Fire" and v:IsA("BasePart") and v:FindFirstChildOfClass("TouchTransmitter") then
                    v.Parent = Change
                end
            end
        end)
        
        Local:Toggle("Anti Hystericus", "Prevents hystericus effects", false, "AntiHys", function(value)
            Variables.AntiHystericus.Enabled = value
        end)

        Local:Label("Mana")

        Local:Toggle("Adjust Mana", "Toggles mana modification", false, "AdjMana", function(value)
            Variables.AdjustMana.Enabled = value
            player.Character.Mana.Value = Variables.AdjustMana.Amount
        end)
        
        Local:Slider("Mana Amount", "Amount of mana", 0, 100, 50, function(value)
            Variables.AdjustMana.Amount = value
            if Variables.AdjustMana.Enabled then 
                player.Character.Mana.Value = value 
            end
        end)
        
        local ManaSprint = Instance.new("StringValue")
        local ManaDash = Instance.new("StringValue")
        ManaSprint.Name = "ManaSprint"
        ManaDash.Name = "ManaDash"
        
        Local:Toggle("Free Mana Sprint", "Gives you mana sprint", false, "ManaSprint", function(value)
            if value then 
                ManaSprint.Parent = player.Character.ManaAbilities
            else 
                ManaSprint.Parent = nil
            end
        end)
        
        Local:Toggle("Free Mana Dash", "Gives you mana dash", false, "ManaDash", function(value)
            if value then 
                ManaDash.Parent = player.Character.ManaAbilities
            else 
                ManaDash.Parent = nil
            end
        end)

        Local:Label("Farming")

        Local:Toggle("Ore Farm", "Farms ore mining", false, "OreFarm", function(value)
            Variables.OreFarm.Enabled = value
        end)

        Visuals:Label("Settings")
        
        Visuals:Toggle("Tracers", "Enables tracers for the ESP", false, "Tracers", function(value)
            Variables.ESP.Tracers = value 
        end)
        
        Visuals:Toggle("Label", "Enables labels for the ESP", false, "Label", function(value)
            Variables.ESP.Label = value
        end)
        
        Visuals:Slider("Range", "ESP Range", 10, 5000, 1000, function(value)
            Variables.ESP.Range = value
        end)
        
        Visuals:Colorpicker("Color", Color3.fromRGB(255, 0, 0), function(value)
            Variables.ESP.Color = value
        end)

        Visuals:Label("Ingredients")
        
        for i,v in next, Variables.ESP.IngredientIds do 
            Visuals:Toggle(v, "Toggles the ESP for "..v, false, v, function(value)
                Variables.ESP.IngredientsEnabled[v] = value
            end);
        end

        Visuals:Label("Trinkets")
        
        for i,v in next, Variables.ESP.TrinketIds do 
            Visuals:Toggle(v, "Toggles the ESP for "..v, false, v, function(value)
                Variables.ESP.TrinketsEnabled[v] = value
            end);
        end

        Visuals:Label("Gems")
        
        for i,v in next, Variables.ESP.GemColors do 
            Visuals:Toggle(i, "Toggles the ESP for "..i, false, i, function(value)
                Variables.ESP.GemsEnabled[i] = value
            end);
        end

        Misc:Label("Random")
        
        Misc:Toggle("Auto Pickup", "Automatically picks up nearby items", false, "AutoPickup", function(value)
            Variables.AutoPickup.Enabled = value 
            if value then 
                for i, v in next, ItemFolder:GetChildren() do
                    if v.Transparency == 0 then 
                        local Click = v:FindFirstChildOfClass('ClickDetector')
                        spawn(function()
                            repeat wait() until not v:FindFirstChildOfClass('ClickDetector') or player:DistanceFromCharacter(v.Position) <= Click.MaxActivationDistance or v.Transparency ~= 0 
                            if player:DistanceFromCharacter(v.Position) <= Click.MaxActivationDistance and v:FindFirstChildOfClass('ClickDetector') and v.Transparency == 0 then
                                fireclickdetector(Click)
                            end
                        end)
                    end 
                end 
            end
        end);
        
        Misc:Toggle("Chat Logger", "Shows a gui which logs chat messages", false, "ChatLogger", function(value)
            ScreenGui.Enabled = value
        end);
        
        --// RemoteEvent Hook
        
        RemoteEventHook = hookfunction(Instance.new("RemoteEvent").FireServer, newcclosure(function(self, ...)
            local args = {...} 
            if Variables.NoFallDamage.Enabled and #args == 2 and type(args[1]) == "table" and type(args[2]) == "table" and #args[1] == 2 and type(args[1][1]) == "number" and type(args[1][2]) == "number" and self.Parent == player.Character.CharacterHandler.Remotes then 
                return 
            end
        
            return RemoteEventHook(self, ...)
        end))
        
        --// Infinite Jump 
        
        UserInputService.JumpRequest:connect(function()
            if Variables.InfiniteJump.Enabled then
                player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
        
        --// Auto Pickup 
        
        ItemFolder.ChildAdded:connect(function(child)
            if child.Transparency == 0 and Variables.AutoPickup.Enabled then 
                repeat wait() until child:FindFirstChildOfClass('ClickDetector') 
                local Click = child:FindFirstChildOfClass('ClickDetector')
                spawn(function()
                    repeat wait() until not child:FindFirstChildOfClass('ClickDetector') or player:DistanceFromCharacter(child.Position) <= Click.MaxActivationDistance or child.Transparency ~= 0 
                    if player:DistanceFromCharacter(child.Position) <= Click.MaxActivationDistance and child:FindFirstChildOfClass('ClickDetector') and child.Transparency == 0 then
                        fireclickdetector(Click)
                    end
                end)
            end 
        end)
        
        --// Character ChildAdded
        
        player.Character.ChildAdded:Connect(function(Child)
            if Child.Name == "Confused" and Variables.AntiHystericus.Enabled then
                wait()
                Child:Destroy()
            end
        end)
        
        --// NoClip XRay 
        
        local XRayParts = {}
        
        local function NoClipXRay()
            player.Character.Head.Touched:connect(function(part)
                if Variables.NoClip.Enabled and Variables.NoClipXRay.Enabled and part:IsDescendantOf(workspace.Map) and not XRayParts[part] and part.Transparency < 0.9 then 
                    XRayParts[part] = part.Transparency
                    part.Transparency = 0.9
                end
            end)
            
            player.Character.Head.TouchEnded:connect(function(part)
                if Variables.NoClip.Enabled and Variables.NoClipXRay.Enabled and part:IsDescendantOf(workspace.Map) and XRayParts[part] then 
                    part.Transparency = XRayParts[part]
                    XRayParts[part] = nil;
                end
            end)
        end
        
        --// Walkspeed
        
        for i, v in next, getconnections(player.Character.Humanoid.Changed) do
            v:Disable()
        end
        
        player.CharacterAdded:Connect(function()
            player.Character:WaitForChild("Humanoid")
            player.Character:WaitForChild("Head")
        
            for i, v in next, getconnections(player.Character.Humanoid.Changed) do
                v:Disable()
            end
        
            player.Character.Humanoid.Changed:connect(function()
                if Functions.Character.IsAlive() then
                    if Variables.Walkspeed.Enabled then 
                        player.Character.Humanoid.WalkSpeed = Variables.Walkspeed.Speed
                    end 
                end
            end) 
        
            NoClipXRay()
        end)
        
        player.Character.Humanoid.Changed:connect(function()
            if Functions.Character.IsAlive() then
                if Variables.Walkspeed.Enabled then 
                    player.Character.Humanoid.WalkSpeed = Variables.Walkspeed.Speed
                end 
            end
        end)
        
        NoClipXRay()
        
        --// Main Loop 
        
        local CollectionService = game:GetService("CollectionService")
        
        RunService.Stepped:connect(function()
            if Functions.Character.IsAlive() then
        
                local DisableInWater = (Variables.DisableInWater.Enabled and player.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Swimming or not Variables.DisableInWater.Enabled)
                local DisableWhenKnocked = (Variables.DisableWhenKnocked.Enabled and CollectionService:HasTag(player.Character, "Knocked") or not Variables.DisableWhenKnocked.Enabled)
        
                if Variables.NoClip.Enabled and DisableInWater and DisableWhenKnocked then 
                    player.Character.Head.CanCollide = false 
                    player.Character.Torso.CanCollide = false 
                    local NamePart = player.Character:FindFirstChild(player.leaderstats.FirstName.Value) or player.Character:FindFirstChild(player.leaderstats.FirstName.Value .. " " .. player.leaderstats.LastName.Value)
                    NamePart.Head.CanCollide = false
                end
            end
        end)
        
        --// ESP 
        
        local Caches = {}
        
        local function IdentifyTrinket(obj) 
            local Id, Trinket
            if obj:IsA("UnionOperation") then
                if Caches[obj] then 
                    Id = Caches[obj]['Id']
                    Trinket = Caches[obj]['Trinket']
                else
                    Id = getspecialinfo(obj).AssetId:gsub("%D", "")
                    Trinket = Variables.ESP.IngredientIds[tonumber(Id)] or Variables.ESP.TrinketIds[tonumber(Id)]
                    Caches[obj] = {
                        ['Id'] = Id,
                        ['Trinket'] = Trinket
                    }
                end
        
                if Trinket and (Variables.ESP.IngredientsEnabled[Trinket] or Variables.ESP.TrinketsEnabled[Trinket]) then 
                    return Trinket
                end 
            elseif obj:IsA("MeshPart") then
                if Caches[obj] then 
                    Id = Caches[obj]['Id']
                    Trinket = Caches[obj]['Trinket']
                else
                    Id = obj.MeshId:gsub("%D", "")
                    Trinket = Variables.ESP.TrinketIds[tonumber(Id)]
                    Caches[obj] = {
                        ['Id'] = Id,
                        ['Trinket'] = Trinket
                    }
                end
        
                if Trinket and Variables.ESP.TrinketsEnabled[Trinket] then 
                    return Trinket 
                end
            elseif obj:IsA("Part") then
                if Caches[obj] then 
                    Trinket = Caches[obj]['Trinket']
                else
                    if not Trinket then 
                        for i,v in next, Variables.ESP.GemColors do 
                            if obj.BrickColor == v then 
                                Trinket = i 
                                Caches[obj] = {
                                    Trinket = Trinket
                                }
                                break 
                            end
                        end
                    end
                end 
        
                if Trinket and Variables.ESP.GemsEnabled[Trinket] then 
                    return Trinket 
                end
            end
        
            return false
        end
        
        local function ApplyESP(item)
            local drawed = {}
            if (item:IsA("UnionOperation") or item:IsA("MeshPart") or item:IsA('Part')) and (IdentifyTrinket(item) ~= nil) then 
                local Position = item.Position
                while RunService.RenderStepped:Wait() do
                    for i, v in pairs(drawed) do
                        v:Remove() 
                    end 
                    if not item.Parent then
                        return
                    end
        
                    drawed = {}
        
                    local Name = IdentifyTrinket(item)
        
                    if item and Name then
                        if Position then
                            if item.Transparency == 0 then
                                if player:DistanceFromCharacter(Position) < Variables.ESP.Range then
                                    local CPosition, Visible = Camera:WorldToViewportPoint(Position)
                                    if Visible then
                                        if Variables.ESP.Label then
                                            local Text = Drawing.new('Text')
                                            Text.Color = Variables.ESP.Color
                                            local ShowText = Name
                                            Text.Text = ShowText ~= "" and '[' .. ShowText .. ']' or ''
                                            Text.Size = 22
                                            Text.Visible = true
                                            Text.Position = Vector2.new(CPosition.X, CPosition.Y) 
                                            Text.Center = true
                                            table.insert(drawed, Text)
                                        end
        
                                        if Variables.ESP.Tracers then
                                            local Line = Drawing.new("Line")
        
                                            Line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                                            Line.To = Vector2.new(CPosition.X, CPosition.Y)
                                            Line.Color = Variables.ESP.Color
                                            Line.Visible = true
                                            table.insert(drawed, Line)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        
        for i, v in next, workspace:GetChildren() do
            if v:IsA("MeshPart") or v:IsA("Part") or v:IsA('UnionOperation') then 
                spawn(function()
                    ApplyESP(v)
                end)
            end
        end 
        
        for i,v in next, ItemFolder:GetChildren() do 
            spawn(function()
                ApplyESP(v)
            end)
        end
        
        workspace.ChildAdded:connect(function(desc)
            if desc:IsA("MeshPart") or desc:IsA("Part") or desc:IsA('UnionOperation') then 
                ApplyESP(desc)
            end
        end)
        
        --// Ore Farm
        
        local function tweenPosition(Destination_CFrame)
            local Speed = 300
        
            local oldgravity = workspace.Gravity
            workspace.Gravity = 0
            local mag = (player.Character.HumanoidRootPart.Position - Destination_CFrame.p).Magnitude
        
            local tween = game:GetService("TweenService"):Create(player.Character.HumanoidRootPart, TweenInfo.new(mag / Speed, Enum.EasingStyle.Linear), {CFrame = Destination_CFrame})
            tween:Play()
            tween.Completed:wait()
        
            workspace.Gravity = oldgravity
        end
        
        local Allowed = {
            'Oresfall',
            'Royal Wood'
        }
        
        local function GetClosestOre()
            local MinOre 
            local Dist = math.huge
        
            for i, v in pairs(workspace.Ores:GetChildren()) do 
                if v:FindFirstChild('Blacklist') then
                    if not v.Blacklist:FindFirstChild(player.Name) then 
                        if v.OreLife.Value > 0 then
                            local Part, Position = workspace:FindPartOnRayWithWhitelist(Ray.new(v.Position, Vector3.new(0, 1000, 0)), { workspace.AreaMarkers })
                            if table.find(Allowed, Part.Name) then
                                if player:DistanceFromCharacter(v.Position) < Dist then
                                    MinOre = v 
                                    Dist = player:DistanceFromCharacter(v.Position)
                                end
                            end
                        end 
                    end 
                end
            end 
        
            return MinOre
        end
        
        local VirtualUser = game:GetService('VirtualUser')
        
        while wait() do
            if Variables.OreFarm.Enabled and (player.Backpack:FindFirstChild("Pickaxe") or player.Character:FindFirstChild("Pickaxe")) then
                local closest = GetClosestOre()
                if closest then
                    tweenPosition(closest.CFrame)
                    repeat 
                        player.Character.Humanoid:EquipTool(player.Backpack:FindFirstChild("Pickaxe") or player.Character:FindFirstChild("Pickaxe"))
                        VirtualUser:ClickButton1(Vector2.new(0, 0), Camera.CFrame)
                        tweenPosition(closest.CFrame) 
                        wait()
                    until closest.OreLife.Value == 0 or not Variables.OreFarm.Enabled
                end 
            end
        end
    end;
}

local function Create(object, properties)
    local Object = Instance.new(object)
    
    for i, v in pairs(properties) do
        Object[i] = v
    end
    
    return Object
end

local LoaderUI = Create("ScreenGui", {
    Name = "LoaderUI",
    Parent = CoreGui,
    DisplayOrder = 1
})

local Main = Create("ImageLabel", {
    Name = "Main",
    Parent = LoaderUI,
    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 0, 0, 0),
    Image = "rbxassetid://3570695787",
    ImageColor3 = Color3.fromRGB(35, 35, 35),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(100, 100, 100, 100),
    SliceScale = 1,
    ClipsDescendants = true
})

local Main2 = Create("ImageLabel", {
    Name = "Main2",
    Parent = LoaderUI,
    BackgroundColor3 = Color3.fromRGB(35,35,35),
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 0, 0, 0),
    Image = "rbxassetid://3570695787",
    ImageColor3 = Color3.fromRGB(30,30,30),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(100, 100, 100, 100),
    SliceScale = 1,
    ClipsDescendants = false
})

local Title = Create("TextLabel", {
    Name = "Title",
    Parent = Main2,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1,
    Size = UDim2.new(0, 230, 0, 23),
    Font = Enum.Font.SourceSansBold,
    Text = "Alpha",
    TextColor3 = Color3.fromRGB(30, 170, 165),
    TextSize = 23,
    TextTransparency = 1
})

local Title2 = Create("TextLabel", {
    Name = "Title",
    Parent = Main2,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1,
    Size = UDim2.new(0, 300, 0, 23),
    Font = Enum.Font.SourceSansBold,
    Text = "X",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 23,
    TextTransparency = 1
})

local Status = Create("TextLabel", {
    Name = "Status",
    Parent = Main,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, -125, 0.649999976, -8.5),
    Size = UDim2.new(0, 250, 0, 20),
    Font = Enum.Font.SourceSansBold,
    Text = "",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 16
})

local function LoaderStatus(text)
    local TextInvis = TweenService:Create(Status, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1})
    TextInvis:Play()
    TextInvis.Completed:wait()
    Status.Text = text
    local TextVis = TweenService:Create(Status, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0})
    TextVis:Play()
    TextVis.Completed:wait()
    wait(0.25)
end

local function UIAnimation(uitype)
    if uitype == "Open" then
        TweenService:Create(Main2, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0.5, -125, 0.5, -40), Size = UDim2.new(0, 250, 0, 25), SliceScale = 0.07}):Play()
        local MainScale = TweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0.5, -125, 0.5, -40), Size = UDim2.new(0, 250, 0, 25), SliceScale = 0.07})
        MainScale:Play()
        MainScale.Completed:wait()
        TweenService:Create(Title, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
        local TextVis = TweenService:Create(Title2, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0})
        TextVis:Play()
        TextVis.Completed:wait()
        local OpenScale = TweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -125, 0.5, -40), Size = UDim2.new(0, 250, 0, 70), SliceScale = 0.07})
        OpenScale:Play()
        OpenScale.Completed:wait()
    elseif uitype == "Close" then
        TweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -125, 0.5, -40), Size = UDim2.new(0, 250, 0, 25), SliceScale = 0.07}):Play()
        local MainScale = TweenService:Create(Main2, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -125, 0.5, -40), Size = UDim2.new(0, 250, 0, 25), SliceScale = 0.07})
        MainScale:Play()
        MainScale.Completed:wait()
        TweenService:Create(Title, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
        local TitleInvis = TweenService:Create(Title2, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1})
        TitleInvis:Play()
        TitleInvis.Completed:wait()
        TweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, 0, 0, 0), SliceScale = 1}):Play()
        local MainClose = TweenService:Create(Main2, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, 0, 0, 0), SliceScale = 1})
        MainClose:Play()
        MainClose.Completed:wait()
    end
end

local Games = {
    [2377868063] = {"Strucid", true};
    [1168263273] = {"Bad Business", true};
    [301252049] = {"RoBeats", false};
    [1643537246] = {"RoBeats CS", false};
    [88070565] = {"Bloxburg", true};
    [113491250] = {"Phantom Forces", true};
    [383310974] = {"Adopt Me", false};
    [2471084] = {"Lumber Tycoon 2", false};
    --[245662005] = {"Jailbreak", true};
    --[73885730] = {"Prison Life", true};
    [703124385] = {"Tower of Hell", false};
    [66654135] = {"Murder Mystery 2", true};
    --[115797356] = {"Counter Blox", true};
    [964540701] = {"Sound Space", false};
    [719754874] = {"Ragdoll Engine", false};
    [848145103] = {"Dungeon Quest", false};
    [286090429] = {"Arsenal", true};
    [1087859240] = {"Rogue Lineage", true};
}

local CurrentGame = Games[game.GameId] or Games[game.PlaceId] or {}

if not CurrentGame then return end 

local GameName = CurrentGame[1] or "Universal"

local scriptname = "Alpha X"
local loadercredits = "Made by\nIntrovert#1337 and Alpha_1004#6275"
if game.GameId == 2471084 and not getgenv().load_alpha_lt2 then
    scriptname = "Bark"
    loadercredits = "Made by\ndogix#0888 and applebee#3071"
end

UIAnimation("Open")
LoaderStatus(loadercredits)
wait(0.5)
LoaderStatus(GameName)
wait(0.3)
LoaderStatus("")
UIAnimation("Close")

UI_Init = Flux:Window(scriptname, GameName, Color3.fromRGB(30, 170, 165), Enum.KeyCode.RightShift)

if (CurrentGame[2] or GameName == "Universal") and game.GameId ~= 1168263273 and game.GameId ~= 113491250 then 
    do
        local Universal = UI_Init:Tab('Universal', "http://www.roblox.com/asset/?id=6034412763")

        Universal:Label("Visuals")

        local HttpService = game:GetService("HttpService")
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local Camera = Workspace.CurrentCamera

        local CIELUV = loadstring(game:HttpGet("https://raw.githubusercontent.com/coastss/releases/main/cieluv_color_lerp.lua"))()
        local HealthBarLerp = CIELUV:Lerp(Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0))

        local VisualObjects = {}
        local Utilities = {} do
            Utilities.DrawingProperties = {
                Line = {
                    Thickness = 1.5,
                    Color = Color3.fromRGB(255, 255, 255),
                    Visible = false
                },
                Text = {
                    Size = 16,
                    Center = true,
                    Outline = true,
                    Font = Drawing.Fonts and Drawing.Fonts.UI or nil,
                    Color = Color3.fromRGB(255, 255, 255),
                    Visible = false
                },
                Circle = {
                    Thickness = 1.5,
                    NumSides = 100,
                    Radius = 0,
                    Filled = false,
                    Color = Color3.fromRGB(255, 255, 255),
                    Visible = false
                },
                Square = {
                    Thickness = 1.5,
                    Filled = false,
                    Color = Color3.fromRGB(255, 255, 255),
                    Visible = false
                }
            }

            function Utilities.CreateDrawing(Type, Custom)
                local Drawing = Drawing.new(Type)

                for Property, Value in pairs(Utilities.DrawingProperties[Type]) do
                    Drawing[Property] = Value
                end

                if Custom then
                    for Property, Value in pairs(Custom) do
                        Drawing[Property] = Value
                    end
                end

                return Drawing
            end

            function Utilities.Round(Number)
                if typeof(Number) == "Vector2" then
                    return Vector2.new(Utilities.Round(Number.X), Utilities.Round(Number.Y))
                end

                return math.round(Number)
            end

            function Utilities.AddPlayer(Player)
                if not VisualObjects[Player] then
                    VisualObjects[Player] = {
                        Box = {
                            Outline = Utilities.CreateDrawing("Square", {Color = Color3.fromRGB(0, 0, 0)}),
                            Square = Utilities.CreateDrawing("Square")
                        },
                        Healthbar = {
                            Outline = Utilities.CreateDrawing("Square", {Color = Color3.fromRGB(0, 0, 0)}),
                            Bar = Utilities.CreateDrawing("Square")
                        },
                        Tracer = {
                            Outline = Utilities.CreateDrawing("Line", {Color = Color3.fromRGB(0, 0, 0)}),
                            Line = Utilities.CreateDrawing("Line")
                        },
                        Info = {
                            TextInfo = Utilities.CreateDrawing("Text"),
                            ExtraInfo = Utilities.CreateDrawing("Text")
                        }
                    }
                end
            end

            for Index, Player in pairs(Players:GetPlayers()) do
                if Player ~= LocalPlayer then
                    Utilities.AddPlayer(Player)
                end
            end
            
            Players.PlayerAdded:Connect(Utilities.AddPlayer)
            Players.PlayerRemoving:Connect(function(Player)
                if VisualObjects[Player] then
                    for Index, Value in pairs(VisualObjects[Player]) do
                        for Index2, Drawing in pairs(Value) do
                            if Drawing then
                                Drawing:Remove()
                            end
                        end
                    end

                    VisualObjects[Player] = nil
                end
            end)
        end

        local Base = {} do
            function Base.GetCharacter(Player)
                return Player.Character
            end
            
            function Base.GetClientRoot()
                local Character = LocalPlayer.Character
                local HumanoidRootPart = (Character and Character:FindFirstChild("HumanoidRootPart"))

                if Character and HumanoidRootPart then
                    return HumanoidRootPart
                end
            end

            function Base.GetBodyParts(Player)
                local Character = Player.Character

                local Head = (Character and Character:FindFirstChild("Head"))
                local HumanoidRootPart = (Character and Character:FindFirstChild("HumanoidRootPart"))

                if Character and (Head and HumanoidRootPart) then
                    return {
                        Head = Head,
                        Root = HumanoidRootPart
                    }
                end
            end

            function Base.GetHealth(Player)
                local Character = Player.Character
                local Humanoid = (Character and Character:FindFirstChildWhichIsA("Humanoid"))

                if Humanoid then
                    return Humanoid.Health, Humanoid.MaxHealth
                end
            end

            function Base.IsClientAlive()
                local Health, MaxHealth = Base.GetHealth(LocalPlayer)

                if Health and MaxHealth then
                    if Health > 0 then
                        return true
                    end
                end

                return false
            end

            function Base.IsOnClientTeam(Player)
                if Player.TeamColor.Color == LocalPlayer.TeamColor.Color then
                    return true
                end

                return false
            end

            function Base.GetTeamColor(Player)
                return Player.TeamColor.Color
            end
        end

        local Visuals = {
            Enabled = false,
            Boxes = true,
            Healthbar = true,
            Tracers = true,
            Info = true,
            ShowAllyTeam = true,
            UseTeamColor = true,
            AllyColor = Color3.fromRGB(0, 255, 0),
            EnemyColor = Color3.fromRGB(255, 0, 0)
        }

        Universal:Toggle("Enabled", "Toggles the ESP", false, "EN", function(value)
            Visuals.Enabled = value
        end)

        Universal:Toggle("Boxes", "Toggles the Box ESP", true, "BXE", function(value)
            Visuals.Boxes = value
        end)

        Universal:Toggle("Healthbar", "Toggles the Healthbar ESP", true, "HBE", function(value)
            Visuals.Healthbar = value
        end)

        Universal:Toggle("Tracers", "Toggles the Tracers ESP", true, "TE", function(value)
            Visuals.Tracers = value
        end)

        Universal:Toggle("Info", "Toggles the Name / Distance / Health Text ESP", true, "NDE", function(value)
            Visuals.Info = value
        end)

        Universal:Toggle("Team Check", "Checks the team to apply the ESP", false, "NDE", function(value)
            Visuals.ShowAllyTeam = not value
        end)

        Universal:Toggle("UseTeamColor", "Uses the target's team color for the ESP", true, "NDE", function(value)
            Visuals.UseTeamColor = value
        end)

        Universal:Colorpicker("Enemy Color", Color3.fromRGB(255, 0, 0), function(value)
            Visuals.EnemyColor = value
        end)

        Universal:Colorpicker("Ally Color", Color3.fromRGB(0, 0, 255), function(value)
            Visuals.AllyColor = value
        end)

        RunService.RenderStepped:Connect(function()
            Camera = Workspace.CurrentCamera

            for Index, Player in pairs(Players:GetPlayers()) do
                if Player ~= LocalPlayer then

                    local Objects = VisualObjects[Player]
                    if Objects then
    
                        local ScreenPosition, OnScreen = Vector3.new(), false
                        local Health, MaxHealth = Base.GetHealth(Player)
                        local PlayerColor = (Visuals.UseTeamColor and Base.GetTeamColor(Player)) or (Base.IsOnClientTeam(Player) and Visuals.AllyColor or Visuals.EnemyColor)
                        local Character = Base.GetCharacter(Player)
                        local PassedTeamCheck = true
        
                        if Visuals.Enabled and Base.IsClientAlive() and Character and (Health and MaxHealth and Health > 0) then
                            local BodyParts = Base.GetBodyParts(Player)
                            local Orientation, Size = Character:GetBoundingBox()
                            local Head, Root = nil, nil
        
                            if BodyParts then
                                Head, Root = BodyParts.Head, BodyParts.Root
                            end
        
                            if Base.IsOnClientTeam(Player) and not Visuals.ShowAllyTeam then
                                PassedTeamCheck = false
                            end
        
                            if PassedTeamCheck and (Orientation and Size) and (Head and Root) then
                                local HealthPercent = (Health / MaxHealth)
                                local HealthFormatted = string.format("%d", Health)
        
                                ScreenPosition = Camera:WorldToViewportPoint(Root.Position)
                                OnScreen = (ScreenPosition.Z > 0)
        
                                local Height = (Camera.CFrame - Camera.CFrame.Position) * Vector3.new(0, (math.clamp(Size.Y, 1, 10) + 0.5) / 2, 0)
                                Height = math.abs(Camera:WorldToScreenPoint(Orientation.Position + Height).Y - Camera:WorldToScreenPoint(Orientation.Position - Height).Y)
                                Size = Utilities.Round(Vector2.new(Height / 2, Height))
        
                                Objects.Box.Square.Color = PlayerColor
                                Objects.Box.Square.Size = Size
                                Objects.Box.Square.Position = Vector2.new((ScreenPosition.X - Objects.Box.Square.Size.X / 2), (ScreenPosition.Y - Objects.Box.Square.Size.Y / 2))
        
                                Objects.Box.Outline.Thickness = (Objects.Box.Square.Thickness * 2)
                                Objects.Box.Outline.Size = Objects.Box.Square.Size
                                Objects.Box.Outline.Position = Objects.Box.Square.Position
        
                                Objects.Healthbar.Bar.Color = HealthBarLerp(HealthPercent)
                                Objects.Healthbar.Bar.Size = Vector2.new(1, -(Objects.Box.Square.Size.Y) * HealthPercent)
                                Objects.Healthbar.Bar.Position = Vector2.new((Objects.Box.Square.Position.X - 5), (Objects.Box.Square.Position.Y + Objects.Box.Square.Size.Y))
        
                                Objects.Healthbar.Outline.Thickness = (Objects.Healthbar.Bar.Thickness * 2)
                                Objects.Healthbar.Outline.Size = Vector2.new(Objects.Healthbar.Bar.Size.X, (-Objects.Box.Square.Size.Y - 2))
                                Objects.Healthbar.Outline.Position = Vector2.new(Objects.Healthbar.Bar.Position.X, (Objects.Healthbar.Bar.Position.Y + 1))
        
                                Objects.Tracer.Line.Color = PlayerColor
                                Objects.Tracer.Line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                                Objects.Tracer.Line.To = Vector2.new(ScreenPosition.X, ScreenPosition.Y)
        
                                Objects.Tracer.Outline.Color = Color3.fromRGB(0, 0, 0)
                                Objects.Tracer.Outline.Thickness = (Objects.Tracer.Line.Thickness * 2)
                                Objects.Tracer.Outline.From = Objects.Tracer.Line.From
                                Objects.Tracer.Outline.To = Objects.Tracer.Line.To
        
                                Objects.Info.TextInfo.Text = string.format("%s (%dm)", Player.Name, LocalPlayer:DistanceFromCharacter(Root.Position))
                                Objects.Info.TextInfo.Position = Vector2.new((Objects.Box.Square.Size.X / 2) + Objects.Box.Square.Position.X, (Objects.Box.Square.Size.Y + Objects.Box.Square.Position.Y))
        
                                Objects.Info.ExtraInfo.Text = HealthFormatted
                                Objects.Info.ExtraInfo.Position = Vector2.new((Objects.Box.Square.Position.X - 18), ((Objects.Box.Square.Position.Y + Objects.Box.Square.Size.Y) + -(Objects.Box.Square.Size.Y) * HealthPercent))
                            end
                        end
        
                        Objects.Box.Square.Visible = (OnScreen and Visuals.Boxes) or false
                        Objects.Box.Outline.Visible = Objects.Box.Square.Visible
        
                        Objects.Healthbar.Bar.Visible = (OnScreen and Visuals.Healthbar) or false
                        Objects.Healthbar.Outline.Visible = Objects.Healthbar.Bar.Visible
        
                        Objects.Tracer.Line.Visible = (OnScreen and Visuals.Tracers) or false
                        Objects.Tracer.Outline.Visible = Objects.Tracer.Line.Visible
        
                        Objects.Info.TextInfo.Visible = (OnScreen and Visuals.Info) or false
                        Objects.Info.ExtraInfo.Visible = Objects.Info.TextInfo.Visible
                    end
                end
            end
        end)
    end
end

local GameFunction = GameFunctions[game.GameId] or GameFunctions[game.PlaceId]

if GameFunction then
    GameFunction()
end

Discord = UI_Init:Tab("Discord", "http://www.roblox.com/asset/?id=6035202033")
Discord:Label("Invite")

Discord:Button("Copy Invite", "Copies the discord invite to your clipboard", function()
    setclipboard("https://discord.gg/alphax")
end)


