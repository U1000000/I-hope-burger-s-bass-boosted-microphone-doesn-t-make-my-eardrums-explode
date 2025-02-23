--[[
	
	Gui2Lua Winning! ~ Ch0nky Code:tm:
	
	37 instances
	
	-> shared.gv2.require("main").printChangelogs()
	
]]--

local tbl =
{
	bee_swarm_simulator = Instance.new("LocalScript"),
	components = Instance.new("Folder"),
	taskSystem = Instance.new("ModuleScript"),
	linoria = Instance.new("ModuleScript"),
	save_manager = Instance.new("ModuleScript"),
	theme_manager = Instance.new("ModuleScript"),
	playerMovement = Instance.new("ModuleScript"),
	tween = Instance.new("ModuleScript"),
	signal = Instance.new("ModuleScript"),
	keyPress = Instance.new("ModuleScript"),
	monsterData = Instance.new("ModuleScript"),
	getTokens = Instance.new("ModuleScript"),
	buffComponents = Instance.new("ModuleScript"),
	getPlanters = Instance.new("ModuleScript"),
	getFieldsByColor = Instance.new("ModuleScript"),
	tabs = Instance.new("Folder"),
	planterTab = Instance.new("ModuleScript"),
	toysTab = Instance.new("ModuleScript"),
	questTab = Instance.new("ModuleScript"),
	autofarmTab = Instance.new("ModuleScript"),
	Features = Instance.new("Folder"),
	autofarm = Instance.new("ModuleScript"),
	helpers = Instance.new("ModuleScript"),
	precisePathfind = Instance.new("ModuleScript"),
	autofarmTaskManager = Instance.new("ModuleScript"),
	toys = Instance.new("ModuleScript"),
	convert = Instance.new("ModuleScript"),
	pushrooms = Instance.new("ModuleScript"),
	pushroomTools = Instance.new("ModuleScript"),
	rarities = Instance.new("ModuleScript"),
	mobs = Instance.new("ModuleScript"),
	quest = Instance.new("ModuleScript"),
	Collect_Pollen = Instance.new("ModuleScript"),
	Defeat_Monsters = Instance.new("ModuleScript"),
	Collect_Tokens = Instance.new("ModuleScript"),
	Collect_Goo = Instance.new("ModuleScript"),
	planters = Instance.new("ModuleScript")
}

tbl.bee_swarm_simulator.Name = "bee_swarm_simulator"
tbl.bee_swarm_simulator.Parent = game:GetService("ServerScriptService")

tbl.components.Name = "components"
tbl.components.Parent = tbl.bee_swarm_simulator

tbl.taskSystem.Name = "taskSystem"
tbl.taskSystem.Parent = tbl.components

tbl.linoria.Name = "linoria"
tbl.linoria.Parent = tbl.components

tbl.save_manager.Name = "save_manager"
tbl.save_manager.Parent = tbl.linoria

tbl.theme_manager.Name = "theme_manager"
tbl.theme_manager.Parent = tbl.linoria

tbl.playerMovement.Name = "playerMovement"
tbl.playerMovement.Parent = tbl.components

tbl.tween.Name = "tween"
tbl.tween.Parent = tbl.components

tbl.signal.Name = "signal"
tbl.signal.Parent = tbl.components

tbl.keyPress.Name = "keyPress"
tbl.keyPress.Parent = tbl.components

tbl.monsterData.Name = "monsterData"
tbl.monsterData.Parent = tbl.components

tbl.getTokens.Name = "getTokens"
tbl.getTokens.Parent = tbl.components

tbl.buffComponents.Name = "buffComponents"
tbl.buffComponents.Parent = tbl.components

tbl.getPlanters.Name = "getPlanters"
tbl.getPlanters.Parent = tbl.components

tbl.getFieldsByColor.Name = "getFieldsByColor"
tbl.getFieldsByColor.Parent = tbl.components

tbl.tabs.Name = "tabs"
tbl.tabs.Parent = tbl.bee_swarm_simulator

tbl.planterTab.Name = "planterTab"
tbl.planterTab.Parent = tbl.tabs

tbl.toysTab.Name = "toysTab"
tbl.toysTab.Parent = tbl.tabs

tbl.questTab.Name = "questTab"
tbl.questTab.Parent = tbl.tabs

tbl.autofarmTab.Name = "autofarmTab"
tbl.autofarmTab.Parent = tbl.tabs

tbl.Features.Name = "Features"
tbl.Features.Parent = tbl.bee_swarm_simulator

tbl.autofarm.Name = "autofarm"
tbl.autofarm.Parent = tbl.Features

tbl.helpers.Name = "helpers"
tbl.helpers.Parent = tbl.autofarm

tbl.precisePathfind.Name = "precisePathfind"
tbl.precisePathfind.Parent = tbl.autofarm

tbl.autofarmTaskManager.Name = "autofarmTaskManager"
tbl.autofarmTaskManager.Parent = tbl.autofarm

tbl.toys.Name = "toys"
tbl.toys.Parent = tbl.Features

tbl.convert.Name = "convert"
tbl.convert.Parent = tbl.Features

tbl.pushrooms.Name = "pushrooms"
tbl.pushrooms.Parent = tbl.Features

tbl.pushroomTools.Name = "pushroomTools"
tbl.pushroomTools.Parent = tbl.pushrooms

tbl.rarities.Name = "rarities"
tbl.rarities.Parent = tbl.pushrooms

tbl.mobs.Name = "mobs"
tbl.mobs.Parent = tbl.Features

tbl.quest.Name = "quest"
tbl.quest.Parent = tbl.Features

tbl.Collect_Pollen.Name = "Collect Pollen"
tbl.Collect_Pollen.Parent = tbl.quest

tbl.Defeat_Monsters.Name = "Defeat Monsters"
tbl.Defeat_Monsters.Parent = tbl.quest

tbl.Collect_Tokens.Name = "Collect Tokens"
tbl.Collect_Tokens.Parent = tbl.quest

tbl.Collect_Goo.Name = "Collect Goo"
tbl.Collect_Goo.Parent = tbl.quest

tbl.planters.Name = "planters"
tbl.planters.Parent = tbl.Features

local modules, cache = {}, {}
		
local o_require = require;
local function require(module)
	local real, cached = modules[module], cache[module]
	
	if cached then return cached end
	
	if not real then return o_require(module) end
	
	cache[module] = real()
	
	return cache[module]
end

modules[tbl.taskSystem] = function()
	local script = tbl.taskSystem

	local taskSystem = {}
	taskSystem.__index = taskSystem
	
	local queue = {}
	local runningTask
	
	local playerMovement = require(script.Parent.playerMovement)
	local tween = require(script.Parent.tween)
	
	local dead = false --so umur stfu and i can make stop nigger  needs to suicid elike duck on accident pls
	
	local function getBestTask()
		local bestLevel = 0
		local bestTask
		for _, task in queue do
			if task.priorityLevel > bestLevel and task ~= runningTask then
				bestTask = task
				bestLevel = task.priorityLevel
			end
		end
		return bestTask
	end
	
	local function startTask(self)
		if dead then 
			return
		end
		local oldTask = runningTask
		runningTask = self --prob can remove this cus idk why theres 2 lmao
	
		if oldTask then
			oldTask:stop()
		end
		local queuePos = table.find(queue, self)
		table.remove(queue, queuePos)
		
		runningTask = self
		
		self.mainThread = task.spawn(self.callback)
		self.running = true
	end
	
	local function runTasks()
		local task = getBestTask()
	
		if task then
			if not runningTask or task.priorityLevel > runningTask.priorityLevel then
				startTask(task)
			end
		end
	end
		
	function taskSystem:addToQueue()	
		if table.find(queue, self) or self.running then
			return false
		end
		
		table.insert(queue, self)
	
		runTasks()
	
		return true 
	end
	
	function taskSystem:stop(taskEnded, forceCancel)
	--	task.spawn(function() -- new thread cus of thread identities
			if not self.running then
				return
			end
			setthreadidentity(8)
	
			for _, connection in self.connections do
				connection:Disconnect()
			end
	
			tween.stop()
			playerMovement.stop()
	
			self:killSecondaryThreads()
	
			if forceCancel then
				task.cancel(self.mainThread)
			end
	
			if self.endCallback then
				self.endCallback()
			end
			self.running = false
	
			if taskEnded then --task has finished mark running task as nil and run others in queue
				runningTask = nil
				runTasks()
			else
				if runningTask == self then --bandaid right here i forgot why its here but its important but could be better
					runningTask = nil
				end
				
				task.cancel(self.mainThread)
				self:addToQueue()
			end
	--	end)
	end
	
	function taskSystem:killSecondaryThreads()
		for _, thread in self.secondaryThreads do
			pcall(task.cancel, thread.startThread)
			if thread.endCallback then
				thread.endCallback()
			end
		end
		table.clear(self.secondaryThreads)
		playerMovement.stop()
	end
	
	function taskSystem:addSecondaryThread(func, endfunc)
		table.insert(self.secondaryThreads, {startThread = task.spawn(func), endCallback = endfunc})
	end
	
	function taskSystem.new(name, priority, callback, endCallback)
		local self = setmetatable({}, taskSystem)
		
		self.connections = {}
		self.secondaryThreads = {}
		
		self.priorityLevel = priority
		self.name = name
		self.callback = callback
		self.endCallback = endCallback
	
		return self
	end
	
	function taskSystem.taskSystemDestroy()
		dead = true
		table.clear(queue)
		if runningTask then
			runningTask:stop(true,true)
		end
	end
	
	function taskSystem.restart()
		if runningTask then
			runningTask:stop()
		end
	end
	
	function taskSystem.getRunningTask()
		return runningTask
	end
	
	return taskSystem
end

modules[tbl.linoria] = function()
	local script = tbl.linoria

	local InputService = game:GetService('UserInputService');
	local TextService = game:GetService('TextService');
	local CoreGui = game:GetService('CoreGui');
	local Teams = game:GetService('Teams');
	local Players = game:GetService('Players');
	local RunService = game:GetService('RunService')
	local TweenService = game:GetService('TweenService');
	local RenderStepped = RunService.RenderStepped;
	local LocalPlayer = Players.LocalPlayer;
	local Mouse = cloneref(LocalPlayer:GetMouse());
	
	local ProtectGui = protectgui or (syn and syn.protect_gui) or (function() end);
	
	local ScreenGui = Instance.new('ScreenGui');
	ProtectGui(ScreenGui);
	
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
	ScreenGui.DisplayOrder = math.huge;
	ScreenGui.Parent = CoreGui;
	
	local Toggles = {};
	local Options = {};
	
	getgenv().Toggles = Toggles;
	getgenv().Options = Options;
	
	local Library = {
		Registry = {};
		RegistryMap = {};
	
		HudRegistry = {};
	
		FontColor = Color3.fromRGB(255, 255, 255);
		MainColor = Color3.fromRGB(28, 28, 28);
		BackgroundColor = Color3.fromRGB(20, 20, 20);
		AccentColor = Color3.fromRGB(0, 85, 255);
		OutlineColor = Color3.fromRGB(50, 50, 50);
		RiskColor = Color3.fromRGB(255, 50, 50),
	
		Black = Color3.new(0, 0, 0);
		Font = Enum.Font.Code,
	
		OpenedFrames = {};
		DependencyBoxes = {};
	
		Signals = {};
		ScreenGui = ScreenGui;
	};
	
	local RainbowStep = 0
	local Hue = 0
	
	table.insert(Library.Signals, RenderStepped:Connect(function(Delta)
		RainbowStep = RainbowStep + Delta
	
		if RainbowStep >= (1 / 60) then
			RainbowStep = 0
	
			Hue = Hue + (1 / 400);
	
			if Hue > 1 then
				Hue = 0;
			end;
	
			Library.CurrentRainbowHue = Hue;
			Library.CurrentRainbowColor = Color3.fromHSV(Hue, 0.8, 1);
		end
	end))
	
	local function GetPlayersString()
		local PlayerList = Players:GetPlayers();
	
		for i = 1, #PlayerList do
			PlayerList[i] = PlayerList[i].Name;
		end;
	
		table.sort(PlayerList, function(str1, str2) return str1 < str2 end);
	
		return PlayerList;
	end;
	
	local function GetTeamsString()
		local TeamList = Teams:GetTeams();
	
		for i = 1, #TeamList do
			TeamList[i] = TeamList[i].Name;
		end;
	
		table.sort(TeamList, function(str1, str2) return str1 < str2 end);
	
		return TeamList;
	end;
	
	function Library:SafeCallback(f, ...)
		if (not f) then
			return;
		end;
	
		if not Library.NotifyOnError then
			return f(...);
		end;
	
		local success, event = pcall(f, ...);
	
		if not success then
			local _, i = event:find(":%d+: ");
	
			if not i then
				return Library:Notify(event);
			end;
	
			return Library:Notify(event:sub(i + 1), 3);
		end;
	end;
	
	function Library:AttemptSave()
		if Library.SaveManager then
			Library.SaveManager:Save();
		end;
	end;
	
	function Library:Create(Class, Properties)
		local _Instance = Class;
	
		if type(Class) == 'string' then
			_Instance = Instance.new(Class);
		end;
	
		for Property, Value in next, Properties do
			_Instance[Property] = Value;
		end;
	
		return _Instance;
	end;
	
	function Library:ApplyTextStroke(Inst)
		Inst.TextStrokeTransparency = 1;
	
		Library:Create('UIStroke', {
			Color = Color3.new(0, 0, 0);
			Thickness = 1;
			LineJoinMode = Enum.LineJoinMode.Miter;
			Parent = Inst;
		});
	end;
	
	function Library:CreateLabel(Properties, IsHud)
		local _Instance = Library:Create('TextLabel', {
			BackgroundTransparency = 1;
			Font = Library.Font;
			TextColor3 = Library.FontColor;
			TextSize = 16;
			TextStrokeTransparency = 0;
		});
	
		Library:ApplyTextStroke(_Instance);
	
		Library:AddToRegistry(_Instance, {
			TextColor3 = 'FontColor';
		}, IsHud);
	
		return Library:Create(_Instance, Properties);
	end;
	
	function Library:MakeDraggable(DragPoint, Main)
		pcall(function()
			local Dragging, DragInput, MousePos, FramePos = false
			DragPoint.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Dragging = true
					MousePos = Input.Position
					FramePos = Main.Position
	
					Input.Changed:Connect(function()
						if Input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end)
				end
			end)
			DragPoint.InputChanged:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
					DragInput = Input
				end
			end)
			InputService.InputChanged:Connect(function(Input)
				if Input == DragInput and Dragging then
					local Delta = Input.Position - MousePos
					TweenService:Create(Main, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position  = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)}):Play()
				end
			end)
		end)
	end;
	
	function Library:AddToolTip(InfoStr, HoverInstance)
		local X, Y = Library:GetTextBounds(InfoStr, Library.Font, 14);
		local Tooltip = Library:Create('Frame', {
			BackgroundColor3 = Library.MainColor,
			BorderColor3 = Library.OutlineColor,
	
			Size = UDim2.fromOffset(X + 5, Y + 4),
			ZIndex = 100,
			Parent = Library.ScreenGui,
	
			Visible = false,
		})
	
		local Label = Library:CreateLabel({
			Position = UDim2.fromOffset(3, 1),
			Size = UDim2.fromOffset(X, Y);
			TextSize = 14;
			Text = InfoStr,
			TextColor3 = Library.FontColor,
			TextXAlignment = Enum.TextXAlignment.Left;
			ZIndex = Tooltip.ZIndex + 1,
	
			Parent = Tooltip;
		});
	
		Library:AddToRegistry(Tooltip, {
			BackgroundColor3 = 'MainColor';
			BorderColor3 = 'OutlineColor';
		});
	
		Library:AddToRegistry(Label, {
			TextColor3 = 'FontColor',
		});
	
		local IsHovering = false
	
		HoverInstance.MouseEnter:Connect(function()
			if Library:MouseIsOverOpenedFrame() then
				return
			end
	
			IsHovering = true
	
			Tooltip.Position = UDim2.fromOffset(Mouse.X + 15, Mouse.Y + 12)
			Tooltip.Visible = true
	
			while IsHovering do
				RunService.Heartbeat:Wait()
				Tooltip.Position = UDim2.fromOffset(Mouse.X + 15, Mouse.Y + 12)
			end
		end)
	
		HoverInstance.MouseLeave:Connect(function()
			IsHovering = false
			Tooltip.Visible = false
		end)
	end
	
	function Library:OnHighlight(HighlightInstance, Instance, Properties, PropertiesDefault)
		HighlightInstance.MouseEnter:Connect(function()
			local Reg = Library.RegistryMap[Instance];
	
			for Property, ColorIdx in next, Properties do
				Instance[Property] = Library[ColorIdx] or ColorIdx;
	
				if Reg and Reg.Properties[Property] then
					Reg.Properties[Property] = ColorIdx;
				end;
			end;
		end)
	
		HighlightInstance.MouseLeave:Connect(function()
			local Reg = Library.RegistryMap[Instance];
	
			for Property, ColorIdx in next, PropertiesDefault do
				Instance[Property] = Library[ColorIdx] or ColorIdx;
	
				if Reg and Reg.Properties[Property] then
					Reg.Properties[Property] = ColorIdx;
				end;
			end;
		end)
	end;
	
	function Library:MouseIsOverOpenedFrame()
		for Frame, _ in next, Library.OpenedFrames do
			local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;
	
			if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
				and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then
	
				return true;
			end;
		end;
	end;
	
	function Library:IsMouseOverFrame(Frame)
		local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;
	
		if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
			and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then
	
			return true;
		end;
	end;
	
	function Library:UpdateDependencyBoxes()
		for _, Depbox in next, Library.DependencyBoxes do
			Depbox:Update();
		end;
	end;
	
	function Library:MapValue(Value, MinA, MaxA, MinB, MaxB)
		return (1 - ((Value - MinA) / (MaxA - MinA))) * MinB + ((Value - MinA) / (MaxA - MinA)) * MaxB;
	end;
	
	function Library:GetTextBounds(Text, Font, Size, Resolution)
		local Bounds = TextService:GetTextSize(Text, Size, Font, Resolution or Vector2.new(1920, 1080))
		return Bounds.X, Bounds.Y
	end;
	
	function Library:GetDarkerColor(Color)
		local H, S, V = Color3.toHSV(Color);
		return Color3.fromHSV(H, S, V / 1.5);
	end;
	Library.AccentColorDark = Library:GetDarkerColor(Library.AccentColor);
	
	function Library:AddToRegistry(Instance, Properties, IsHud)
		local Idx = #Library.Registry + 1;
		local Data = {
			Instance = Instance;
			Properties = Properties;
			Idx = Idx;
		};
	
		table.insert(Library.Registry, Data);
		Library.RegistryMap[Instance] = Data;
	
		if IsHud then
			table.insert(Library.HudRegistry, Data);
		end;
	end;
	
	function Library:RemoveFromRegistry(Instance)
		local Data = Library.RegistryMap[Instance];
	
		if Data then
			for Idx = #Library.Registry, 1, -1 do
				if Library.Registry[Idx] == Data then
					table.remove(Library.Registry, Idx);
				end;
			end;
	
			for Idx = #Library.HudRegistry, 1, -1 do
				if Library.HudRegistry[Idx] == Data then
					table.remove(Library.HudRegistry, Idx);
				end;
			end;
	
			Library.RegistryMap[Instance] = nil;
		end;
	end;
	
	function Library:UpdateColorsUsingRegistry()
		-- TODO: Could have an 'active' list of objects
		-- where the active list only contains Visible objects.
	
		-- IMPL: Could setup .Changed events on the AddToRegistry function
		-- that listens for the 'Visible' propert being changed.
		-- Visible: true => Add to active list, and call UpdateColors function
		-- Visible: false => Remove from active list.
	
		-- The above would be especially efficient for a rainbow menu color or live color-changing.
	
		for Idx, Object in next, Library.Registry do
			for Property, ColorIdx in next, Object.Properties do
				if type(ColorIdx) == 'string' then
					Object.Instance[Property] = Library[ColorIdx];
				elseif type(ColorIdx) == 'function' then
					Object.Instance[Property] = ColorIdx()
				end
			end;
		end;
	end;
	
	function Library:GiveSignal(Signal)
		-- Only used for signals not attached to library instances, as those should be cleaned up on object destruction by Roblox
		table.insert(Library.Signals, Signal)
	end
	
	function Library:Unload()
		-- Unload all of the signals
		for Idx = #Library.Signals, 1, -1 do
			local Connection = table.remove(Library.Signals, Idx)
			Connection:Disconnect()
		end
	
		-- Call our unload callback, maybe to undo some hooks etc
		if Library.OnUnload then
			Library.OnUnload()
		end
	
		ScreenGui:Destroy()
	end
	
	function Library:OnUnload(Callback)
		Library.OnUnload = Callback
	end
	
	Library:GiveSignal(ScreenGui.DescendantRemoving:Connect(function(Instance)
		if Library.RegistryMap[Instance] then
			Library:RemoveFromRegistry(Instance);
		end;
	end))
	
	local BaseAddons = {};
	
	do
		local Funcs = {};
	
		function Funcs:AddColorPicker(Idx, Info)
			local ToggleLabel = self.TextLabel;
			-- local Container = self.Container;
	
			assert(Info.Default, 'AddColorPicker: Missing default value.');
	
			local ColorPicker = {
				Value = Info.Default;
				Transparency = Info.Transparency or 0;
				Type = 'ColorPicker';
				Title = type(Info.Title) == 'string' and Info.Title or 'Color picker',
				Callback = Info.Callback or function(Color) end;
			};
	
			function ColorPicker:SetHSVFromRGB(Color)
				local H, S, V = Color3.toHSV(Color);
	
				ColorPicker.Hue = H;
				ColorPicker.Sat = S;
				ColorPicker.Vib = V;
			end;
	
			ColorPicker:SetHSVFromRGB(ColorPicker.Value);
	
			local DisplayFrame = Library:Create('Frame', {
				BackgroundColor3 = ColorPicker.Value;
				BorderColor3 = Library:GetDarkerColor(ColorPicker.Value);
				BorderMode = Enum.BorderMode.Inset;
				Size = UDim2.new(0, 28, 0, 14);
				ZIndex = 6;
				Parent = ToggleLabel;
			});
	
			-- Transparency image taken from https://github.com/matas3535/SplixPrivateDrawingLibrary/blob/main/Library.lua cus i'm lazy
			local CheckerFrame = Library:Create('ImageLabel', {
				BorderSizePixel = 0;
				Size = UDim2.new(0, 27, 0, 13);
				ZIndex = 5;
				Image = 'http://www.roblox.com/asset/?id=12977615774';
				Visible = not not Info.Transparency;
				Parent = DisplayFrame;
			});
	
			-- 1/16/23
			-- Rewrote this to be placed inside the Library ScreenGui
			-- There was some issue which caused RelativeOffset to be way off
			-- Thus the color picker would never show
	
			local PickerFrameOuter = Library:Create('Frame', {
				Name = 'Color';
				BackgroundColor3 = Color3.new(1, 1, 1);
				BorderColor3 = Color3.new(0, 0, 0);
				Position = UDim2.fromOffset(DisplayFrame.AbsolutePosition.X, DisplayFrame.AbsolutePosition.Y + 18),
				Size = UDim2.fromOffset(230, Info.Transparency and 271 or 253);
				Visible = false;
				ZIndex = 15;
				Parent = ScreenGui,
			});
	
			DisplayFrame:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
				PickerFrameOuter.Position = UDim2.fromOffset(DisplayFrame.AbsolutePosition.X, DisplayFrame.AbsolutePosition.Y + 18);
			end)
	
			local PickerFrameInner = Library:Create('Frame', {
				BackgroundColor3 = Library.BackgroundColor;
				BorderColor3 = Library.OutlineColor;
				BorderMode = Enum.BorderMode.Inset;
				Size = UDim2.new(1, 0, 1, 0);
				ZIndex = 16;
				Parent = PickerFrameOuter;
			});
	
			local Highlight = Library:Create('Frame', {
				BackgroundColor3 = Library.AccentColor;
				BorderSizePixel = 0;
				Size = UDim2.new(1, 0, 0, 2);
				ZIndex = 17;
				Parent = PickerFrameInner;
			});
	
			local SatVibMapOuter = Library:Create('Frame', {
				BorderColor3 = Color3.new(0, 0, 0);
				Position = UDim2.new(0, 4, 0, 25);
				Size = UDim2.new(0, 200, 0, 200);
				ZIndex = 17;
				Parent = PickerFrameInner;
			});
	
			local SatVibMapInner = Library:Create('Frame', {
				BackgroundColor3 = Library.BackgroundColor;
				BorderColor3 = Library.OutlineColor;
				BorderMode = Enum.BorderMode.Inset;
				Size = UDim2.new(1, 0, 1, 0);
				ZIndex = 18;
				Parent = SatVibMapOuter;
			});
	
			local SatVibMap = Library:Create('ImageLabel', {
				BorderSizePixel = 0;
				Size = UDim2.new(1, 0, 1, 0);
				ZIndex = 18;
				Image = 'rbxassetid://4155801252';
				Parent = SatVibMapInner;
			});
	
			local CursorOuter = Library:Create('ImageLabel', {
				AnchorPoint = Vector2.new(0.5, 0.5);
				Size = UDim2.new(0, 6, 0, 6);
				BackgroundTransparency = 1;
				Image = 'http://www.roblox.com/asset/?id=9619665977';
				ImageColor3 = Color3.new(0, 0, 0);
				ZIndex = 19;
				Parent = SatVibMap;
			});
	
			local CursorInner = Library:Create('ImageLabel', {
				Size = UDim2.new(0, CursorOuter.Size.X.Offset - 2, 0, CursorOuter.Size.Y.Offset - 2);
				Position = UDim2.new(0, 1, 0, 1);
				BackgroundTransparency = 1;
				Image = 'http://www.roblox.com/asset/?id=9619665977';
				ZIndex = 20;
				Parent = CursorOuter;
			})
	
			local HueSelectorOuter = Library:Create('Frame', {
				BorderColor3 = Color3.new(0, 0, 0);
				Position = UDim2.new(0, 208, 0, 25);
				Size = UDim2.new(0, 15, 0, 200);
				ZIndex = 17;
				Parent = PickerFrameInner;
			});
	
			local HueSelectorInner = Library:Create('Frame', {
				BackgroundColor3 = Color3.new(1, 1, 1);
				BorderSizePixel = 0;
				Size = UDim2.new(1, 0, 1, 0);
				ZIndex = 18;
				Parent = HueSelectorOuter;
			});
	
			local HueCursor = Library:Create('Frame', { 
				BackgroundColor3 = Color3.new(1, 1, 1);
				AnchorPoint = Vector2.new(0, 0.5);
				BorderColor3 = Color3.new(0, 0, 0);
				Size = UDim2.new(1, 0, 0, 1);
				ZIndex = 18;
				Parent = HueSelectorInner;
			});
	
			local HueBoxOuter = Library:Create('Frame', {
				BorderColor3 = Color3.new(0, 0, 0);
				Position = UDim2.fromOffset(4, 228),
				Size = UDim2.new(0.5, -6, 0, 20),
				ZIndex = 18,
				Parent = PickerFrameInner;
			});
	
			local HueBoxInner = Library:Create('Frame', {
				BackgroundColor3 = Library.MainColor;
				BorderColor3 = Library.OutlineColor;
				BorderMode = Enum.BorderMode.Inset;
				Size = UDim2.new(1, 0, 1, 0);
				ZIndex = 18,
				Parent = HueBoxOuter;
			});
	
			Library:Create('UIGradient', {
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
				});
				Rotation = 90;
				Parent = HueBoxInner;
			});
	
			local HueBox = Library:Create('TextBox', {
				BackgroundTransparency = 1;
				Position = UDim2.new(0, 5, 0, 0);
				Size = UDim2.new(1, -5, 1, 0);
				Font = Library.Font;
				PlaceholderColor3 = Color3.fromRGB(190, 190, 190);
				PlaceholderText = 'Hex color',
				Text = '#FFFFFF',
				TextColor3 = Library.FontColor;
				TextSize = 14;
				TextStrokeTransparency = 0;
				TextXAlignment = Enum.TextXAlignment.Left;
				ZIndex = 20,
				Parent = HueBoxInner;
			});
	
			Library:ApplyTextStroke(HueBox);
	
			local RgbBoxBase = Library:Create(HueBoxOuter:Clone(), {
				Position = UDim2.new(0.5, 2, 0, 228),
				Size = UDim2.new(0.5, -6, 0, 20),
				Parent = PickerFrameInner
			});
	
			local RgbBox = Library:Create(RgbBoxBase.Frame:FindFirstChild('TextBox'), {
				Text = '255, 255, 255',
				PlaceholderText = 'RGB color',
				TextColor3 = Library.FontColor
			});
	
			local TransparencyBoxOuter, TransparencyBoxInner, TransparencyCursor;
	
			if Info.Transparency then 
				TransparencyBoxOuter = Library:Create('Frame', {
					BorderColor3 = Color3.new(0, 0, 0);
					Position = UDim2.fromOffset(4, 251);
					Size = UDim2.new(1, -8, 0, 15);
					ZIndex = 19;
					Parent = PickerFrameInner;
				});
	
				TransparencyBoxInner = Library:Create('Frame', {
					BackgroundColor3 = ColorPicker.Value;
					BorderColor3 = Library.OutlineColor;
					BorderMode = Enum.BorderMode.Inset;
					Size = UDim2.new(1, 0, 1, 0);
					ZIndex = 19;
					Parent = TransparencyBoxOuter;
				});
	
				Library:AddToRegistry(TransparencyBoxInner, { BorderColor3 = 'OutlineColor' });
	
				Library:Create('ImageLabel', {
					BackgroundTransparency = 1;
					Size = UDim2.new(1, 0, 1, 0);
					Image = 'http://www.roblox.com/asset/?id=12978095818';
					ZIndex = 20;
					Parent = TransparencyBoxInner;
				});
	
				TransparencyCursor = Library:Create('Frame', { 
					BackgroundColor3 = Color3.new(1, 1, 1);
					AnchorPoint = Vector2.new(0.5, 0);
					BorderColor3 = Color3.new(0, 0, 0);
					Size = UDim2.new(0, 1, 1, 0);
					ZIndex = 21;
					Parent = TransparencyBoxInner;
				});
			end;
	
			local DisplayLabel = Library:CreateLabel({
				Size = UDim2.new(1, 0, 0, 14);
				Position = UDim2.fromOffset(5, 5);
				TextXAlignment = Enum.TextXAlignment.Left;
				TextSize = 14;
				Text = ColorPicker.Title,--Info.Default;
				TextWrapped = false;
				ZIndex = 16;
				Parent = PickerFrameInner;
			});
	
	
			local ContextMenu = {}
			do
				ContextMenu.Options = {}
				ContextMenu.Container = Library:Create('Frame', {
					BorderColor3 = Color3.new(),
					ZIndex = 14,
	
					Visible = false,
					Parent = ScreenGui
				})
	
				ContextMenu.Inner = Library:Create('Frame', {
					BackgroundColor3 = Library.BackgroundColor;
					BorderColor3 = Library.OutlineColor;
					BorderMode = Enum.BorderMode.Inset;
					Size = UDim2.fromScale(1, 1);
					ZIndex = 15;
					Parent = ContextMenu.Container;
				});
	
				Library:Create('UIListLayout', {
					Name = 'Layout',
					FillDirection = Enum.FillDirection.Vertical;
					SortOrder = Enum.SortOrder.LayoutOrder;
					Parent = ContextMenu.Inner;
				});
	
				Library:Create('UIPadding', {
					Name = 'Padding',
					PaddingLeft = UDim.new(0, 4),
					Parent = ContextMenu.Inner,
				});
	
				local function updateMenuPosition()
					ContextMenu.Container.Position = UDim2.fromOffset(
						(DisplayFrame.AbsolutePosition.X + DisplayFrame.AbsoluteSize.X) + 4,
						DisplayFrame.AbsolutePosition.Y + 1
					)
				end
	
				local function updateMenuSize()
					local menuWidth = 60
					for i, label in next, ContextMenu.Inner:GetChildren() do
						if label:IsA('TextLabel') then
							menuWidth = math.max(menuWidth, label.TextBounds.X)
						end
					end
	
					ContextMenu.Container.Size = UDim2.fromOffset(
						menuWidth + 8,
						ContextMenu.Inner.Layout.AbsoluteContentSize.Y + 4
					)
				end
	
				DisplayFrame:GetPropertyChangedSignal('AbsolutePosition'):Connect(updateMenuPosition)
				ContextMenu.Inner.Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(updateMenuSize)
	
				task.spawn(updateMenuPosition)
				task.spawn(updateMenuSize)
	
				Library:AddToRegistry(ContextMenu.Inner, {
					BackgroundColor3 = 'BackgroundColor';
					BorderColor3 = 'OutlineColor';
				});
	
				function ContextMenu:Show()
					self.Container.Visible = true
				end
	
				function ContextMenu:Hide()
					self.Container.Visible = false
				end
	
				function ContextMenu:AddOption(Str, Callback)
					if type(Callback) ~= 'function' then
						Callback = function() end
					end
	
					local Button = Library:CreateLabel({
						Active = false;
						Size = UDim2.new(1, 0, 0, 15);
						TextSize = 13;
						Text = Str;
						ZIndex = 16;
						Parent = self.Inner;
						TextXAlignment = Enum.TextXAlignment.Left,
					});
	
					Library:OnHighlight(Button, Button, 
						{ TextColor3 = 'AccentColor' },
						{ TextColor3 = 'FontColor' }
					);
	
					Button.InputBegan:Connect(function(Input)
						if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch then
							return
						end
						
						
	
						Callback()
					end)
				end
	
				ContextMenu:AddOption('Copy color', function()
					Library.ColorClipboard = ColorPicker.Value
					Library:Notify('Copied color!', 2)
				end)
	
				ContextMenu:AddOption('Paste color', function()
					if not Library.ColorClipboard then
						return Library:Notify('You have not copied a color!', 2)
					end
					ColorPicker:SetValueRGB(Library.ColorClipboard)
				end)
	
	
				ContextMenu:AddOption('Copy HEX', function()
					pcall(setclipboard, ColorPicker.Value:ToHex())
					Library:Notify('Copied hex code to clipboard!', 2)
				end)
	
				ContextMenu:AddOption('Copy RGB', function()
					pcall(setclipboard, table.concat({ math.floor(ColorPicker.Value.R * 255), math.floor(ColorPicker.Value.G * 255), math.floor(ColorPicker.Value.B * 255) }, ', '))
					Library:Notify('Copied RGB values to clipboard!', 2)
				end)
	
			end
	
			Library:AddToRegistry(PickerFrameInner, { BackgroundColor3 = 'BackgroundColor'; BorderColor3 = 'OutlineColor'; });
			Library:AddToRegistry(Highlight, { BackgroundColor3 = 'AccentColor'; });
			Library:AddToRegistry(SatVibMapInner, { BackgroundColor3 = 'BackgroundColor'; BorderColor3 = 'OutlineColor'; });
	
			Library:AddToRegistry(HueBoxInner, { BackgroundColor3 = 'MainColor'; BorderColor3 = 'OutlineColor'; });
			Library:AddToRegistry(RgbBoxBase.Frame, { BackgroundColor3 = 'MainColor'; BorderColor3 = 'OutlineColor'; });
			Library:AddToRegistry(RgbBox, { TextColor3 = 'FontColor', });
			Library:AddToRegistry(HueBox, { TextColor3 = 'FontColor', });
	
			local SequenceTable = {};
	
			for Hue = 0, 1, 0.1 do
				table.insert(SequenceTable, ColorSequenceKeypoint.new(Hue, Color3.fromHSV(Hue, 1, 1)));
			end;
	
			local HueSelectorGradient = Library:Create('UIGradient', {
				Color = ColorSequence.new(SequenceTable);
				Rotation = 90;
				Parent = HueSelectorInner;
			});
	
			HueBox.FocusLost:Connect(function(enter)
				if enter then
					local success, result = pcall(Color3.fromHex, HueBox.Text)
					if success and typeof(result) == 'Color3' then
						ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = Color3.toHSV(result)
					end
				end
	
				ColorPicker:Display()
			end)
	
			RgbBox.FocusLost:Connect(function(enter)
				if enter then
					local r, g, b = RgbBox.Text:match('(%d+),%s*(%d+),%s*(%d+)')
					if r and g and b then
						ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = Color3.toHSV(Color3.fromRGB(r, g, b))
					end
				end
	
				ColorPicker:Display()
			end)
	
			function ColorPicker:Display()
				ColorPicker.Value = Color3.fromHSV(ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib);
				SatVibMap.BackgroundColor3 = Color3.fromHSV(ColorPicker.Hue, 1, 1);
	
				Library:Create(DisplayFrame, {
					BackgroundColor3 = ColorPicker.Value;
					BackgroundTransparency = ColorPicker.Transparency;
					BorderColor3 = Library:GetDarkerColor(ColorPicker.Value);
				});
	
				if TransparencyBoxInner then
					TransparencyBoxInner.BackgroundColor3 = ColorPicker.Value;
					TransparencyCursor.Position = UDim2.new(1 - ColorPicker.Transparency, 0, 0, 0);
				end;
	
				CursorOuter.Position = UDim2.new(ColorPicker.Sat, 0, 1 - ColorPicker.Vib, 0);
				HueCursor.Position = UDim2.new(0, 0, ColorPicker.Hue, 0);
	
				HueBox.Text = '#' .. ColorPicker.Value:ToHex()
				RgbBox.Text = table.concat({ math.floor(ColorPicker.Value.R * 255), math.floor(ColorPicker.Value.G * 255), math.floor(ColorPicker.Value.B * 255) }, ', ')
	
				Library:SafeCallback(ColorPicker.Callback, ColorPicker.Value);
				Library:SafeCallback(ColorPicker.Changed, ColorPicker.Value);
			end;
	
			function ColorPicker:OnChanged(Func)
				ColorPicker.Changed = Func;
				Func(ColorPicker.Value)
			end;
	
			function ColorPicker:Show()
				for Frame, Val in next, Library.OpenedFrames do
					if Frame.Name == 'Color' then
						Frame.Visible = false;
						Library.OpenedFrames[Frame] = nil;
					end;
				end;
	
				PickerFrameOuter.Visible = true;
				Library.OpenedFrames[PickerFrameOuter] = true;
			end;
	
			function ColorPicker:Hide()
				PickerFrameOuter.Visible = false;
				Library.OpenedFrames[PickerFrameOuter] = nil;
			end;
	
			function ColorPicker:SetValue(HSV, Transparency)
				local Color = Color3.fromHSV(HSV[1], HSV[2], HSV[3]);
	
				ColorPicker.Transparency = Transparency or 0;
				ColorPicker:SetHSVFromRGB(Color);
				ColorPicker:Display();
			end;
	
			function ColorPicker:SetValueRGB(Color, Transparency)
				ColorPicker.Transparency = Transparency or 0;
				ColorPicker:SetHSVFromRGB(Color);
				ColorPicker:Display();
			end;
	
			SatVibMap.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
						local MinX = SatVibMap.AbsolutePosition.X;
						local MaxX = MinX + SatVibMap.AbsoluteSize.X;
						local MouseX = math.clamp(Mouse.X, MinX, MaxX);
	
						local MinY = SatVibMap.AbsolutePosition.Y;
						local MaxY = MinY + SatVibMap.AbsoluteSize.Y;
						local MouseY = math.clamp(Mouse.Y, MinY, MaxY);
	
						ColorPicker.Sat = (MouseX - MinX) / (MaxX - MinX);
						ColorPicker.Vib = 1 - ((MouseY - MinY) / (MaxY - MinY));
						ColorPicker:Display();
	
						RenderStepped:Wait();
					end;
	
					Library:AttemptSave();
				end;
			end);
	
			HueSelectorInner.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
						local MinY = HueSelectorInner.AbsolutePosition.Y;
						local MaxY = MinY + HueSelectorInner.AbsoluteSize.Y;
						local MouseY = math.clamp(Mouse.Y, MinY, MaxY);
	
						ColorPicker.Hue = ((MouseY - MinY) / (MaxY - MinY));
						ColorPicker:Display();
	
						RenderStepped:Wait();
					end;
	
					Library:AttemptSave();
				end;
			end);
			DisplayFrame.InputBegan:Connect(function(Input)
				if 		(Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame()) or Input.UserInputType == Enum.UserInputType.Touch and not Library:MouseIsOverOpenedFrame()
	 then
					if PickerFrameOuter.Visible then
						ColorPicker:Hide()
					else
						ContextMenu:Hide()
						ColorPicker:Show()
					end;
				elseif Input.UserInputType == Enum.UserInputType.MouseButton2 and not Library:MouseIsOverOpenedFrame() then
					ContextMenu:Show()
					ColorPicker:Hide()
				end
			end);
	
			if TransparencyBoxInner then
				TransparencyBoxInner.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
							local MinX = TransparencyBoxInner.AbsolutePosition.X;
							local MaxX = MinX + TransparencyBoxInner.AbsoluteSize.X;
							local MouseX = math.clamp(Mouse.X, MinX, MaxX);
	
							ColorPicker.Transparency = 1 - ((MouseX - MinX) / (MaxX - MinX));
	
							ColorPicker:Display();
	
							RenderStepped:Wait();
						end;
	
						Library:AttemptSave();
					end;
				end);
			end;
	
			Library:GiveSignal(InputService.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					local AbsPos, AbsSize = PickerFrameOuter.AbsolutePosition, PickerFrameOuter.AbsoluteSize;
	
					if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
						or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then
	
						ColorPicker:Hide();
					end;
	
					if not Library:IsMouseOverFrame(ContextMenu.Container) then
						ContextMenu:Hide()
					end
				end;
	
				if Input.UserInputType == Enum.UserInputType.MouseButton2 and ContextMenu.Container.Visible then
					if not Library:IsMouseOverFrame(ContextMenu.Container) and not Library:IsMouseOverFrame(DisplayFrame) then
						ContextMenu:Hide()
					end
				end
			end))
	
			ColorPicker:Display();
			ColorPicker.DisplayFrame = DisplayFrame
	
			Options[Idx] = ColorPicker;
	
			return self;
		end;
	
		function Funcs:AddKeyPicker(Idx, Info)
			local ParentObj = self;
			local ToggleLabel = self.TextLabel;
			local Container = self.Container;
	
			assert(Info.Default, 'AddKeyPicker: Missing default value.');
	
			local KeyPicker = {
				Value = Info.Default;
				Toggled = false;
				Mode = Info.Mode or 'Toggle'; -- Always, Toggle, Hold
				Type = 'KeyPicker';
				Callback = Info.Callback or function(Value) end;
				ChangedCallback = Info.ChangedCallback or function(New) end;
	
				SyncToggleState = Info.SyncToggleState or false;
			};
	
			if KeyPicker.SyncToggleState then
				Info.Modes = { 'Toggle' }
				Info.Mode = 'Toggle'
			end
	
			local PickOuter = Library:Create('Frame', {
				BackgroundColor3 = Color3.new(0, 0, 0);
				BorderColor3 = Color3.new(0, 0, 0);
				Size = UDim2.new(0, 28, 0, 15);
				ZIndex = 6;
				Parent = ToggleLabel;
			});
	
			local PickInner = Library:Create('Frame', {
				BackgroundColor3 = Library.BackgroundColor;
				BorderColor3 = Library.OutlineColor;
				BorderMode = Enum.BorderMode.Inset;
				Size = UDim2.new(1, 0, 1, 0);
				ZIndex = 7;
				Parent = PickOuter;
			});
	
			Library:AddToRegistry(PickInner, {
				BackgroundColor3 = 'BackgroundColor';
				BorderColor3 = 'OutlineColor';
			});
	
			local DisplayLabel = Library:CreateLabel({
				Size = UDim2.new(1, 0, 1, 0);
				TextSize = 13;
				Text = Info.Default;
				TextWrapped = true;
				ZIndex = 8;
				Parent = PickInner;
			});
	
			local ModeSelectOuter = Library:Create('Frame', {
				BorderColor3 = Color3.new(0, 0, 0);
				Position = UDim2.fromOffset(ToggleLabel.AbsolutePosition.X + ToggleLabel.AbsoluteSize.X + 4, ToggleLabel.AbsolutePosition.Y + 1);
				Size = UDim2.new(0, 60, 0, 45 + 2);
				Visible = false;
				ZIndex = 14;
				Parent = ScreenGui;
			});
	
			ToggleLabel:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
				ModeSelectOuter.Position = UDim2.fromOffset(ToggleLabel.AbsolutePosition.X + ToggleLabel.AbsoluteSize.X + 4, ToggleLabel.AbsolutePosition.Y + 1);
			end);
	
			local ModeSelectInner = Library:Create('Frame', {
				BackgroundColor3 = Library.BackgroundColor;
				BorderColor3 = Library.OutlineColor;
				BorderMode = Enum.BorderMode.Inset;
				Size = UDim2.new(1, 0, 1, 0);
				ZIndex = 15;
				Parent = ModeSelectOuter;
			});
	
			Library:AddToRegistry(ModeSelectInner, {
				BackgroundColor3 = 'BackgroundColor';
				BorderColor3 = 'OutlineColor';
			});
	
			Library:Create('UIListLayout', {
				FillDirection = Enum.FillDirection.Vertical;
				SortOrder = Enum.SortOrder.LayoutOrder;
				Parent = ModeSelectInner;
			});
	
			local ContainerLabel = Library:CreateLabel({
				TextXAlignment = Enum.TextXAlignment.Left;
				Size = UDim2.new(1, 0, 0, 18);
				TextSize = 13;
				Visible = false;
				ZIndex = 110;
				Parent = Library.KeybindContainer;
			},  true);
	
			local Modes = Info.Modes or { 'Always', 'Toggle', 'Hold' };
			local ModeButtons = {};
	
			for Idx, Mode in next, Modes do
				local ModeButton = {};
	
				local Label = Library:CreateLabel({
					Active = false;
					Size = UDim2.new(1, 0, 0, 15);
					TextSize = 13;
					Text = Mode;
					ZIndex = 16;
					Parent = ModeSelectInner;
				});
	
				function ModeButton:Select()
					for _, Button in next, ModeButtons do
						Button:Deselect();
					end;
	
					KeyPicker.Mode = Mode;
	
					Label.TextColor3 = Library.AccentColor;
					Library.RegistryMap[Label].Properties.TextColor3 = 'AccentColor';
	
					ModeSelectOuter.Visible = false;
				end;
	
				function ModeButton:Deselect()
					KeyPicker.Mode = nil;
	
					Label.TextColor3 = Library.FontColor;
					Library.RegistryMap[Label].Properties.TextColor3 = 'FontColor';
				end;
	
				Label.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						ModeButton:Select();
						Library:AttemptSave();
					end;
				end);
	
				if Mode == KeyPicker.Mode then
					ModeButton:Select();
				end;
	
				ModeButtons[Mode] = ModeButton;
			end;
	
			function KeyPicker:Update()
				if Info.NoUI then
					return;
				end;
	
				local State = KeyPicker:GetState();
	
				ContainerLabel.Text = string.format('[%s] %s (%s)', KeyPicker.Value, Info.Text, KeyPicker.Mode);
	
				ContainerLabel.Visible = true;
				ContainerLabel.TextColor3 = State and Library.AccentColor or Library.FontColor;
	
				Library.RegistryMap[ContainerLabel].Properties.TextColor3 = State and 'AccentColor' or 'FontColor';
	
				local YSize = 0
				local XSize = 0
	
				for _, Label in next, Library.KeybindContainer:GetChildren() do
					if Label:IsA('TextLabel') and Label.Visible then
						YSize = YSize + 18;
						if (Label.TextBounds.X > XSize) then
							XSize = Label.TextBounds.X
						end
					end;
				end;
	
				Library.KeybindFrame.Size = UDim2.new(0, math.max(XSize + 10, 210), 0, YSize + 23)
			end;
	
			function KeyPicker:GetState()
				if KeyPicker.Mode == 'Always' then
					return true;
				elseif KeyPicker.Mode == 'Hold' then
					if KeyPicker.Value == 'None' then
						return false;
					end
	
					local Key = KeyPicker.Value;
	
					if Key == 'MB1' or Key == 'MB2' then
						return Key == 'MB1' and InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
							or Key == 'MB2' and InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2);
					else
						return InputService:IsKeyDown(Enum.KeyCode[KeyPicker.Value]);
					end;
				else
					return KeyPicker.Toggled;
				end;
			end;
	
			function KeyPicker:SetValue(Data)
				local Key, Mode = Data[1], Data[2];
				DisplayLabel.Text = Key;
				KeyPicker.Value = Key;
				ModeButtons[Mode]:Select();
				KeyPicker:Update();
			end;
	
			function KeyPicker:OnClick(Callback)
				KeyPicker.Clicked = Callback
			end
	
			function KeyPicker:OnChanged(Callback)
				KeyPicker.Changed = Callback
				Callback(KeyPicker.Value)
			end
	
			if ParentObj.Addons then
				table.insert(ParentObj.Addons, KeyPicker)
			end
	
			function KeyPicker:DoClick()
				if ParentObj.Type == 'Toggle' and KeyPicker.SyncToggleState then
					ParentObj:SetValue(not ParentObj.Value)
				end
	
				Library:SafeCallback(KeyPicker.Callback, KeyPicker.Toggled)
				Library:SafeCallback(KeyPicker.Clicked, KeyPicker.Toggled)
			end
	
			local Picking = false;
	
			PickOuter.InputBegan:Connect(function(Input)
				if 		(Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame()) or Input.UserInputType == Enum.UserInputType.Touch and not Library:MouseIsOverOpenedFrame()
	 then
					Picking = true;
	
					DisplayLabel.Text = '';
	
					local Break;
					local Text = '';
	
					task.spawn(function()
						while (not Break) do
							if Text == '...' then
								Text = '';
							end;
	
							Text = Text .. '.';
							DisplayLabel.Text = Text;
	
							wait(0.4);
						end;
					end);
	
					wait(0.2);
	
					local Event;
					Event = InputService.InputBegan:Connect(function(Input)
						local Key;
	
						if Input.UserInputType == Enum.UserInputType.Keyboard then
							Key = Input.KeyCode.Name;
						elseif Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
							Key = 'MB1';
						elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
							Key = 'MB2';
						end;
	
						Break = true;
						Picking = false;
	
						DisplayLabel.Text = Key;
						KeyPicker.Value = Key;
	
						Library:SafeCallback(KeyPicker.ChangedCallback, Input.KeyCode or Input.UserInputType)
						Library:SafeCallback(KeyPicker.Changed, Input.KeyCode or Input.UserInputType)
	
						Library:AttemptSave();
	
						Event:Disconnect();
					end);
				elseif Input.UserInputType == Enum.UserInputType.MouseButton2 and not Library:MouseIsOverOpenedFrame() then
					ModeSelectOuter.Visible = true;
				end;
			end);
	
			Library:GiveSignal(InputService.InputBegan:Connect(function(Input)
				if (not Picking) then
					if KeyPicker.Mode == 'Toggle' then
						local Key = KeyPicker.Value;
	
						if Key == 'MB1' or Key == 'MB2' then
							if Key == 'MB1' and Input.UserInputType == Enum.UserInputType.MouseButton1
								or Key == 'MB2' and Input.UserInputType == Enum.UserInputType.MouseButton2 then
								KeyPicker.Toggled = not KeyPicker.Toggled
								KeyPicker:DoClick()
							end;
						elseif Input.UserInputType == Enum.UserInputType.Keyboard then
							if Input.KeyCode.Name == Key then
								KeyPicker.Toggled = not KeyPicker.Toggled;
								KeyPicker:DoClick()
							end;
						end;
					end;
	
					KeyPicker:Update();
				end;
	
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					local AbsPos, AbsSize = ModeSelectOuter.AbsolutePosition, ModeSelectOuter.AbsoluteSize;
	
					if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
						or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then
	
						ModeSelectOuter.Visible = false;
					end;
				end;
			end))
	
			Library:GiveSignal(InputService.InputEnded:Connect(function(Input)
				if (not Picking) then
					KeyPicker:Update();
				end;
			end))
	
			KeyPicker:Update();
	
			Options[Idx] = KeyPicker;
	
			return self;
		end;
	
		BaseAddons.__index = Funcs;
		BaseAddons.__namecall = function(Table, Key, ...)
			return Funcs[Key](...);
		end;
	end;
	
	local BaseGroupbox = {};
	
	do
		local Funcs = {};
	
		function Funcs:AddBlank(Size)
			local Groupbox = self;
			local Container = Groupbox.Container;
	
			Library:Create('Frame', {
				BackgroundTransparency = 1;
				Size = UDim2.new(1, 0, 0, Size);
				ZIndex = 1;
				Parent = Container;
			});
		end;
	
		function Funcs:AddLabel(Text, DoesWrap)
			local Label = {};
	
			local Groupbox = self;
			local Container = Groupbox.Container;
	
			local TextLabel = Library:CreateLabel({
				Size = UDim2.new(1, -4, 0, 15);
				TextSize = 14;
				Text = Text;
				TextWrapped = DoesWrap or false,
				TextXAlignment = Enum.TextXAlignment.Left;
				ZIndex = 5;
				Parent = Container;
			});
	
			if DoesWrap then
				local Y = select(2, Library:GetTextBounds(Text, Library.Font, 14, Vector2.new(TextLabel.AbsoluteSize.X, math.huge)))
				TextLabel.Size = UDim2.new(1, -4, 0, Y)
			else
				Library:Create('UIListLayout', {
					Padding = UDim.new(0, 4);
					FillDirection = Enum.FillDirection.Horizontal;
					HorizontalAlignment = Enum.HorizontalAlignment.Right;
					SortOrder = Enum.SortOrder.LayoutOrder;
					Parent = TextLabel;
				});
			end
	
			Label.TextLabel = TextLabel;
			Label.Container = Container;
	
			function Label:SetText(Text)
				TextLabel.Text = Text
	
				if DoesWrap then
					local Y = select(2, Library:GetTextBounds(Text, Library.Font, 14, Vector2.new(TextLabel.AbsoluteSize.X, math.huge)))
					TextLabel.Size = UDim2.new(1, -4, 0, Y)
				end
	
				Groupbox:Resize();
			end
	
			if (not DoesWrap) then
				setmetatable(Label, BaseAddons);
			end
	
			Groupbox:AddBlank(5);
			Groupbox:Resize();
	
			return Label;
		end;
	
		function Funcs:AddButton(...)
			-- TODO: Eventually redo this
			local Button = {};
			local function ProcessButtonParams(Class, Obj, ...)
				local Props = select(1, ...)
				if type(Props) == 'table' then
					Obj.Text = Props.Text
					Obj.Func = Props.Func
					Obj.DoubleClick = Props.DoubleClick
					Obj.Tooltip = Props.Tooltip
				else
					Obj.Text = select(1, ...)
					Obj.Func = select(2, ...)
				end
	
				assert(type(Obj.Func) == 'function', 'AddButton: `Func` callback is missing.');
			end
	
			ProcessButtonParams('Button', Button, ...)
	
			local Groupbox = self;
			local Container = Groupbox.Container;
	
			local function CreateBaseButton(Button)
				local Outer = Library:Create('Frame', {
					BackgroundColor3 = Color3.new(0, 0, 0);
					BorderColor3 = Color3.new(0, 0, 0);
					Size = UDim2.new(1, -4, 0, 20);
					ZIndex = 5;
				});
	
				local Inner = Library:Create('Frame', {
					BackgroundColor3 = Library.MainColor;
					BorderColor3 = Library.OutlineColor;
					BorderMode = Enum.BorderMode.Inset;
					Size = UDim2.new(1, 0, 1, 0);
					ZIndex = 6;
					Parent = Outer;
				});
	
				local Label = Library:CreateLabel({
					Size = UDim2.new(1, 0, 1, 0);
					TextSize = 14;
					Text = Button.Text;
					ZIndex = 6;
					Parent = Inner;
				});
	
				Library:Create('UIGradient', {
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
					});
					Rotation = 90;
					Parent = Inner;
				});
	
				Library:AddToRegistry(Outer, {
					BorderColor3 = 'Black';
				});
	
				Library:AddToRegistry(Inner, {
					BackgroundColor3 = 'MainColor';
					BorderColor3 = 'OutlineColor';
				});
	
				Library:OnHighlight(Outer, Outer,
					{ BorderColor3 = 'AccentColor' },
					{ BorderColor3 = 'Black' }
				);
	
				return Outer, Inner, Label
			end
	
			local function InitEvents(Button)
				local function WaitForEvent(event, timeout, validator)
					local bindable = Instance.new('BindableEvent')
					local connection = event:Once(function(...)
	
						if type(validator) == 'function' and validator(...) then
							bindable:Fire(true)
						else
							bindable:Fire(false)
						end
					end)
					task.delay(timeout, function()
						connection:disconnect()
						bindable:Fire(false)
					end)
					return bindable.Event:Wait()
				end
	
				local function ValidateClick(Input)
					if Library:MouseIsOverOpenedFrame() then
						return false
					end
	
					if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch then
						return false
					end
	
					return true
				end
				
				Button.Outer.InputBegan:Connect(function(Input)
					if not ValidateClick(Input) then return end
					if Button.Locked then return end
	
					if Button.DoubleClick then
						Library:RemoveFromRegistry(Button.Label)
						Library:AddToRegistry(Button.Label, { TextColor3 = 'AccentColor' })
	
						Button.Label.TextColor3 = Library.AccentColor
						Button.Label.Text = 'Are you sure?'
						Button.Locked = true
	
						local clicked = WaitForEvent(Button.Outer.InputBegan, 0.5, ValidateClick)
	
						Library:RemoveFromRegistry(Button.Label)
						Library:AddToRegistry(Button.Label, { TextColor3 = 'FontColor' })
	
						Button.Label.TextColor3 = Library.FontColor
						Button.Label.Text = Button.Text
						task.defer(rawset, Button, 'Locked', false)
	
						if clicked then
							Library:SafeCallback(Button.Func)
						end
	
						return
					end
	
					Library:SafeCallback(Button.Func);
				end)
			end
	
			Button.Outer, Button.Inner, Button.Label = CreateBaseButton(Button)
			Button.Outer.Parent = Container
	
			InitEvents(Button)
	
			function Button:AddTooltip(tooltip)
				if type(tooltip) == 'string' then
					Library:AddToolTip(tooltip, self.Outer)
				end
				return self
			end
	
	
			function Button:AddButton(...)
				local SubButton = {}
	
				ProcessButtonParams('SubButton', SubButton, ...)
	
				self.Outer.Size = UDim2.new(0.5, -2, 0, 20)
	
				SubButton.Outer, SubButton.Inner, SubButton.Label = CreateBaseButton(SubButton)
	
				SubButton.Outer.Position = UDim2.new(1, 3, 0, 0)
				SubButton.Outer.Size = UDim2.fromOffset(self.Outer.AbsoluteSize.X - 2, self.Outer.AbsoluteSize.Y)
				SubButton.Outer.Parent = self.Outer
	
				function SubButton:AddTooltip(tooltip)
					if type(tooltip) == 'string' then
						Library:AddToolTip(tooltip, self.Outer)
					end
					return SubButton
				end
	
				if type(SubButton.Tooltip) == 'string' then
					SubButton:AddTooltip(SubButton.Tooltip)
				end
	
				InitEvents(SubButton)
				return SubButton
			end
	
			if type(Button.Tooltip) == 'string' then
				Button:AddTooltip(Button.Tooltip)
			end
	
			Groupbox:AddBlank(5);
			Groupbox:Resize();
	
			return Button;
		end;
	
		function Funcs:AddDivider()
			local Groupbox = self;
			local Container = self.Container
	
			local Divider = {
				Type = 'Divider',
			}
	
			Groupbox:AddBlank(2);
			local DividerOuter = Library:Create('Frame', {
				BackgroundColor3 = Color3.new(0, 0, 0);
				BorderColor3 = Color3.new(0, 0, 0);
				Size = UDim2.new(1, -4, 0, 5);
				ZIndex = 5;
				Parent = Container;
			});
	
			local DividerInner = Library:Create('Frame', {
				BackgroundColor3 = Library.MainColor;
				BorderColor3 = Library.OutlineColor;
				BorderMode = Enum.BorderMode.Inset;
				Size = UDim2.new(1, 0, 1, 0);
				ZIndex = 6;
				Parent = DividerOuter;
			});
	
			Library:AddToRegistry(DividerOuter, {
				BorderColor3 = 'Black';
			});
	
			Library:AddToRegistry(DividerInner, {
				BackgroundColor3 = 'MainColor';
				BorderColor3 = 'OutlineColor';
			});
	
			Groupbox:AddBlank(9);
			Groupbox:Resize();
		end
	
		function Funcs:AddInput(Idx, Info)
			assert(Info.Text, 'AddInput: Missing `Text` string.')
	
			local Textbox = {
				Value = Info.Default or '';
				Numeric = Info.Numeric or false;
				Finished = Info.Finished or false;
				Type = 'Input';
				Callback = Info.Callback or function(Value) end;
			};
	
			local Groupbox = self;
			local Container = Groupbox.Container;
	
			local InputLabel = Library:CreateLabel({
				Size = UDim2.new(1, 0, 0, 15);
				TextSize = 14;
				Text = Info.Text;
				TextXAlignment = Enum.TextXAlignment.Left;
				ZIndex = 5;
				Parent = Container;
			});
	
			Groupbox:AddBlank(1);
	
			local TextBoxOuter = Library:Create('Frame', {
				BackgroundColor3 = Color3.new(0, 0, 0);
				BorderColor3 = Color3.new(0, 0, 0);
				Size = UDim2.new(1, -4, 0, 20);
				ZIndex = 5;
				Parent = Container;
			});
	
			local TextBoxInner = Library:Create('Frame', {
				BackgroundColor3 = Library.MainColor;
				BorderColor3 = Library.OutlineColor;
				BorderMode = Enum.BorderMode.Inset;
				Size = UDim2.new(1, 0, 1, 0);
				ZIndex = 6;
				Parent = TextBoxOuter;
			});
	
			Library:AddToRegistry(TextBoxInner, {
				BackgroundColor3 = 'MainColor';
				BorderColor3 = 'OutlineColor';
			});
	
			Library:OnHighlight(TextBoxOuter, TextBoxOuter,
				{ BorderColor3 = 'AccentColor' },
				{ BorderColor3 = 'Black' }
			);
	
			if type(Info.Tooltip) == 'string' then
				Library:AddToolTip(Info.Tooltip, TextBoxOuter)
			end
	
			Library:Create('UIGradient', {
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
				});
				Rotation = 90;
				Parent = TextBoxInner;
			});
	
			local Container = Library:Create('Frame', {
				BackgroundTransparency = 1;
				ClipsDescendants = true;
	
				Position = UDim2.new(0, 5, 0, 0);
				Size = UDim2.new(1, -5, 1, 0);
	
				ZIndex = 7;
				Parent = TextBoxInner;
			})
	
			local Box = Library:Create('TextBox', {
				BackgroundTransparency = 1;
	
				Position = UDim2.fromOffset(0, 0),
				Size = UDim2.fromScale(5, 1),
	
				Font = Library.Font;
				PlaceholderColor3 = Color3.fromRGB(190, 190, 190);
				PlaceholderText = Info.Placeholder or '';
	
				Text = Info.Default or '';
				TextColor3 = Library.FontColor;
				TextSize = 14;
				TextStrokeTransparency = 0;
				TextXAlignment = Enum.TextXAlignment.Left;
	
				ZIndex = 7;
				Parent = Container;
			});
	
			Library:ApplyTextStroke(Box);
	
			function Textbox:SetValue(Text)
				if Info.MaxLength and #Text > Info.MaxLength then
					Text = Text:sub(1, Info.MaxLength);
				end;
	
				if Textbox.Numeric then
					if (not tonumber(Text)) and Text:len() > 0 then
						Text = Textbox.Value
					end
				end
	
				Textbox.Value = Text;
				Box.Text = Text;
	
				Library:SafeCallback(Textbox.Callback, Textbox.Value);
				Library:SafeCallback(Textbox.Changed, Textbox.Value);
			end;
	
			if Textbox.Finished then
				Box.FocusLost:Connect(function(enter)
					if not enter then return end
	
					Textbox:SetValue(Box.Text);
					Library:AttemptSave();
				end)
			else
				Box:GetPropertyChangedSignal('Text'):Connect(function()
					Textbox:SetValue(Box.Text);
					Library:AttemptSave();
				end);
			end
	
			-- https://devforum.roblox.com/t/how-to-make-textboxes-follow-current-cursor-position/1368429/6
			-- thank you nicemike40 :)
	
			local function Update()
				local PADDING = 2
				local reveal = Container.AbsoluteSize.X
	
				if not Box:IsFocused() or Box.TextBounds.X <= reveal - 2 * PADDING then
					-- we aren't focused, or we fit so be normal
					Box.Position = UDim2.new(0, PADDING, 0, 0)
				else
					-- we are focused and don't fit, so adjust position
					local cursor = Box.CursorPosition
					if cursor ~= -1 then
						-- calculate pixel width of text from start to cursor
						local subtext = string.sub(Box.Text, 1, cursor-1)
						local width = TextService:GetTextSize(subtext, Box.TextSize, Box.Font, Vector2.new(math.huge, math.huge)).X
	
						-- check if we're inside the box with the cursor
						local currentCursorPos = Box.Position.X.Offset + width
	
						-- adjust if necessary
						if currentCursorPos < PADDING then
							Box.Position = UDim2.fromOffset(PADDING-width, 0)
						elseif currentCursorPos > reveal - PADDING - 1 then
							Box.Position = UDim2.fromOffset(reveal-width-PADDING-1, 0)
						end
					end
				end
			end
	
			task.spawn(Update)
	
			Box:GetPropertyChangedSignal('Text'):Connect(Update)
			Box:GetPropertyChangedSignal('CursorPosition'):Connect(Update)
			Box.FocusLost:Connect(Update)
			Box.Focused:Connect(Update)
	
			Library:AddToRegistry(Box, {
				TextColor3 = 'FontColor';
			});
	
			function Textbox:OnChanged(Func)
				Textbox.Changed = Func;
				Func(Textbox.Value);
			end;
	
			Groupbox:AddBlank(5);
			Groupbox:Resize();
	
			Options[Idx] = Textbox;
	
			return Textbox;
		end;
	
		function Funcs:AddToggle(Idx, Info)
			assert(Info.Text, 'AddInput: Missing `Text` string.')
	
			local Toggle = {
				Value = Info.Default or false;
				Type = 'Toggle';
	
				Callback = Info.Callback or function(Value) end;
				Addons = {},
				Risky = Info.Risky,
			};
	
			local Groupbox = self;
			local Container = Groupbox.Container;
	
			local ToggleOuter = Library:Create('Frame', {
				BackgroundColor3 = Color3.new(0, 0, 0);
				BorderColor3 = Color3.new(0, 0, 0);
				Size = UDim2.new(0, 13, 0, 13);
				ZIndex = 5;
				Parent = Container;
			});
	
			Library:AddToRegistry(ToggleOuter, {
				BorderColor3 = 'Black';
			});
	
			local ToggleInner = Library:Create('Frame', {
				BackgroundColor3 = Library.MainColor;
				BorderColor3 = Library.OutlineColor;
				BorderMode = Enum.BorderMode.Inset;
				Size = UDim2.new(1, 0, 1, 0);
				ZIndex = 6;
				Parent = ToggleOuter;
			});
	
			Library:AddToRegistry(ToggleInner, {
				BackgroundColor3 = 'MainColor';
				BorderColor3 = 'OutlineColor';
			});
	
			local ToggleLabel = Library:CreateLabel({
				Size = UDim2.new(0, 216, 1, 0);
				Position = UDim2.new(1, 6, 0, 0);
				TextSize = 14;
				Text = Info.Text;
				TextXAlignment = Enum.TextXAlignment.Left;
				ZIndex = 6;
				Parent = ToggleInner;
			});
	
			Library:Create('UIListLayout', {
				Padding = UDim.new(0, 4);
				FillDirection = Enum.FillDirection.Horizontal;
				HorizontalAlignment = Enum.HorizontalAlignment.Right;
				SortOrder = Enum.SortOrder.LayoutOrder;
				Parent = ToggleLabel;
			});
	
			local ToggleRegion = Library:Create('Frame', {
				BackgroundTransparency = 1;
				Size = UDim2.new(0, 170, 1, 0);
				ZIndex = 8;
				Parent = ToggleOuter;
			});
	
			Library:OnHighlight(ToggleRegion, ToggleOuter,
				{ BorderColor3 = 'AccentColor' },
				{ BorderColor3 = 'Black' }
			);
	
			function Toggle:UpdateColors()
				Toggle:Display();
			end;
	
			if type(Info.Tooltip) == 'string' then
				Library:AddToolTip(Info.Tooltip, ToggleRegion)
			end
	
			function Toggle:Display()
				ToggleInner.BackgroundColor3 = Toggle.Value and Library.AccentColor or Library.MainColor;
				ToggleInner.BorderColor3 = Toggle.Value and Library.AccentColorDark or Library.OutlineColor;
	
				Library.RegistryMap[ToggleInner].Properties.BackgroundColor3 = Toggle.Value and 'AccentColor' or 'MainColor';
				Library.RegistryMap[ToggleInner].Properties.BorderColor3 = Toggle.Value and 'AccentColorDark' or 'OutlineColor';
			end;
	
			function Toggle:OnChanged(Func)
				Toggle.Changed = Func;
				Func(Toggle.Value);
			end;
	
			function Toggle:SetValue(Bool)
				Bool = (not not Bool);
	
				Toggle.Value = Bool;
				Toggle:Display();
	
				for _, Addon in next, Toggle.Addons do
					if Addon.Type == 'KeyPicker' and Addon.SyncToggleState then
						Addon.Toggled = Bool
						Addon:Update()
					end
				end
	
				Library:SafeCallback(Toggle.Callback, Toggle.Value);
				Library:SafeCallback(Toggle.Changed, Toggle.Value);
				Library:UpdateDependencyBoxes();
			end;
	
			ToggleRegion.InputBegan:Connect(function(Input)
				if 		(Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame()) or Input.UserInputType == Enum.UserInputType.Touch and not Library:MouseIsOverOpenedFrame()
	 then
					Toggle:SetValue(not Toggle.Value) -- Why was it not like this from the start?
					Library:AttemptSave();
				end;
			end);
	
			if Toggle.Risky then
				Library:RemoveFromRegistry(ToggleLabel)
				ToggleLabel.TextColor3 = Library.RiskColor
				Library:AddToRegistry(ToggleLabel, { TextColor3 = 'RiskColor' })
			end
	
			Toggle:Display();
			Groupbox:AddBlank(Info.BlankSize or 5 + 2);
			Groupbox:Resize();
	
			Toggle.TextLabel = ToggleLabel;
			Toggle.Container = Container;
			setmetatable(Toggle, BaseAddons);
	
			Toggles[Idx] = Toggle;
	
			Library:UpdateDependencyBoxes();
	
			return Toggle;
		end;
	
		function Funcs:AddSlider(Idx, Info)
			assert(Info.Default, 'AddSlider: Missing default value.');
			assert(Info.Text, 'AddSlider: Missing slider text.');
			assert(Info.Min, 'AddSlider: Missing minimum value.');
			assert(Info.Max, 'AddSlider: Missing maximum value.');
			assert(Info.Rounding, 'AddSlider: Missing rounding value.');
	
			local Slider = {
				Value = Info.Default;
				Min = Info.Min;
				Max = Info.Max;
				Rounding = Info.Rounding;
				MaxSize = 232;
				Type = 'Slider';
				Callback = Info.Callback or function(Value) end;
			};
	
			local Groupbox = self;
			local Container = Groupbox.Container;
	
			if not Info.Compact then
				Library:CreateLabel({
					Size = UDim2.new(1, 0, 0, 10);
					TextSize = 14;
					Text = Info.Text;
					TextXAlignment = Enum.TextXAlignment.Left;
					TextYAlignment = Enum.TextYAlignment.Bottom;
					ZIndex = 5;
					Parent = Container;
				});
	
				Groupbox:AddBlank(3);
			end
	
			local SliderOuter = Library:Create('Frame', {
				BackgroundColor3 = Color3.new(0, 0, 0);
				BorderColor3 = Color3.new(0, 0, 0);
				Size = UDim2.new(1, -4, 0, 13);
				ZIndex = 5;
				Parent = Container;
			});
	
			Library:AddToRegistry(SliderOuter, {
				BorderColor3 = 'Black';
			});
	
			local SliderInner = Library:Create('Frame', {
				BackgroundColor3 = Library.MainColor;
				BorderColor3 = Library.OutlineColor;
				BorderMode = Enum.BorderMode.Inset;
				Size = UDim2.new(1, 0, 1, 0);
				ZIndex = 6;
				Parent = SliderOuter;
			});
	
			Library:AddToRegistry(SliderInner, {
				BackgroundColor3 = 'MainColor';
				BorderColor3 = 'OutlineColor';
			});
	
			local Fill = Library:Create('Frame', {
				BackgroundColor3 = Library.AccentColor;
				BorderColor3 = Library.AccentColorDark;
				Size = UDim2.new(0, 0, 1, 0);
				ZIndex = 7;
				Parent = SliderInner;
			});
	
			Library:AddToRegistry(Fill, {
				BackgroundColor3 = 'AccentColor';
				BorderColor3 = 'AccentColorDark';
			});
	
			local HideBorderRight = Library:Create('Frame', {
				BackgroundColor3 = Library.AccentColor;
				BorderSizePixel = 0;
				Position = UDim2.new(1, 0, 0, 0);
				Size = UDim2.new(0, 1, 1, 0);
				ZIndex = 8;
				Parent = Fill;
			});
	
			Library:AddToRegistry(HideBorderRight, {
				BackgroundColor3 = 'AccentColor';
			});
	
			local DisplayLabel = Library:CreateLabel({
				Size = UDim2.new(1, 0, 1, 0);
				TextSize = 14;
				Text = 'Infinite';
				ZIndex = 9;
				Parent = SliderInner;
			});
	
			Library:OnHighlight(SliderOuter, SliderOuter,
				{ BorderColor3 = 'AccentColor' },
				{ BorderColor3 = 'Black' }
			);
	
			if type(Info.Tooltip) == 'string' then
				Library:AddToolTip(Info.Tooltip, SliderOuter)
			end
	
			function Slider:UpdateColors()
				Fill.BackgroundColor3 = Library.AccentColor;
				Fill.BorderColor3 = Library.AccentColorDark;
			end;
	
			function Slider:Display()
				local Suffix = Info.Suffix or '';
	
				if Info.Compact then
					DisplayLabel.Text = Info.Text .. ': ' .. Slider.Value .. Suffix
				elseif Info.HideMax then
					DisplayLabel.Text = string.format('%s', Slider.Value .. Suffix)
				else
					DisplayLabel.Text = string.format('%s/%s', Slider.Value .. Suffix, Slider.Max .. Suffix);
				end
	
				local X = math.ceil(Library:MapValue(Slider.Value, Slider.Min, Slider.Max, 0, Slider.MaxSize));
				Fill.Size = UDim2.new(0, X, 1, 0);
	
				HideBorderRight.Visible = not (X == Slider.MaxSize or X == 0);
			end;
	
			function Slider:OnChanged(Func)
				Slider.Changed = Func;
				Func(Slider.Value);
			end;
	
			local function Round(Value)
				if Slider.Rounding == 0 then
					return math.floor(Value);
				end;
	
	
				return tonumber(string.format('%.' .. Slider.Rounding .. 'f', Value))
			end;
	
			function Slider:GetValueFromXOffset(X)
				return Round(Library:MapValue(X, 0, Slider.MaxSize, Slider.Min, Slider.Max));
			end;
	
			function Slider:SetValue(Str)
				local Num = tonumber(Str);
	
				if (not Num) then
					return;
				end;
	
				Num = math.clamp(Num, Slider.Min, Slider.Max);
	
				Slider.Value = Num;
				Slider:Display();
	
				Library:SafeCallback(Slider.Callback, Slider.Value);
				Library:SafeCallback(Slider.Changed, Slider.Value);
			end;
	
			SliderInner.InputBegan:Connect(function(Input)
				if 		(Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame()) or Input.UserInputType == Enum.UserInputType.Touch and not Library:MouseIsOverOpenedFrame()
	 then
					local mPos = Mouse.X;
					local gPos = Fill.Size.X.Offset;
					local Diff = mPos - (Fill.AbsolutePosition.X + gPos);
	
					while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
						local nMPos = Mouse.X;
						local nX = math.clamp(gPos + (nMPos - mPos) + Diff, 0, Slider.MaxSize);
	
						local nValue = Slider:GetValueFromXOffset(nX);
						local OldValue = Slider.Value;
						Slider.Value = nValue;
	
						Slider:Display();
	
						if nValue ~= OldValue then
							Library:SafeCallback(Slider.Callback, Slider.Value);
							Library:SafeCallback(Slider.Changed, Slider.Value);
						end;
	
						RenderStepped:Wait();
					end;
	
					Library:AttemptSave();
				end;
			end);
	
			Slider:Display();
			Groupbox:AddBlank(Info.BlankSize or 6);
			Groupbox:Resize();
	
			Options[Idx] = Slider;
	
			return Slider;
		end;
	
		function Funcs:AddDropdown(Idx, Info)
			if Info.SpecialType == 'Player' then
				Info.Values = GetPlayersString();
				Info.AllowNull = true;
			elseif Info.SpecialType == 'Team' then
				Info.Values = GetTeamsString();
				Info.AllowNull = true;
			end;
	
			assert(Info.Values, 'AddDropdown: Missing dropdown value list.');
			assert(Info.AllowNull or Info.Default, 'AddDropdown: Missing default value. Pass `AllowNull` as true if this was intentional.')
	
			if (not Info.Text) then
				Info.Compact = true;
			end;
	
			local Dropdown = {
				Values = Info.Values;
				Value = Info.Multi and {};
				Multi = Info.Multi;
				Type = 'Dropdown';
				SpecialType = Info.SpecialType; -- can be either 'Player' or 'Team'
				Callback = Info.Callback or function(Value) end;
			};
	
			local Groupbox = self;
			local Container = Groupbox.Container;
	
			local RelativeOffset = 0;
	
			if not Info.Compact then
				local DropdownLabel = Library:CreateLabel({
					Size = UDim2.new(1, 0, 0, 10);
					TextSize = 14;
					Text = Info.Text;
					TextXAlignment = Enum.TextXAlignment.Left;
					TextYAlignment = Enum.TextYAlignment.Bottom;
					ZIndex = 5;
					Parent = Container;
				});
	
				Groupbox:AddBlank(3);
			end
	
			for _, Element in next, Container:GetChildren() do
				if not Element:IsA('UIListLayout') then
					RelativeOffset = RelativeOffset + Element.Size.Y.Offset;
				end;
			end;
	
			local DropdownOuter = Library:Create('Frame', {
				BackgroundColor3 = Color3.new(0, 0, 0);
				BorderColor3 = Color3.new(0, 0, 0);
				Size = UDim2.new(1, -4, 0, 20);
				ZIndex = 5;
				Parent = Container;
			});
	
			Library:AddToRegistry(DropdownOuter, {
				BorderColor3 = 'Black';
			});
	
			local DropdownInner = Library:Create('Frame', {
				BackgroundColor3 = Library.MainColor;
				BorderColor3 = Library.OutlineColor;
				BorderMode = Enum.BorderMode.Inset;
				Size = UDim2.new(1, 0, 1, 0);
				ZIndex = 6;
				Parent = DropdownOuter;
			});
	
			Library:AddToRegistry(DropdownInner, {
				BackgroundColor3 = 'MainColor';
				BorderColor3 = 'OutlineColor';
			});
	
			Library:Create('UIGradient', {
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
				});
				Rotation = 90;
				Parent = DropdownInner;
			});
	
			local DropdownArrow = Library:Create('ImageLabel', {
				AnchorPoint = Vector2.new(0, 0.5);
				BackgroundTransparency = 1;
				Position = UDim2.new(1, -16, 0.5, 0);
				Size = UDim2.new(0, 12, 0, 12);
				Image = 'http://www.roblox.com/asset/?id=6282522798';
				ZIndex = 8;
				Parent = DropdownInner;
			});
	
			local ItemList = Library:CreateLabel({
				Position = UDim2.new(0, 5, 0, 0);
				Size = UDim2.new(1, -5, 1, 0);
				TextSize = 14;
				Text = '--';
				TextXAlignment = Enum.TextXAlignment.Left;
				TextWrapped = true;
				ZIndex = 7;
				Parent = DropdownInner;
			});
	
			Library:OnHighlight(DropdownOuter, DropdownOuter,
				{ BorderColor3 = 'AccentColor' },
				{ BorderColor3 = 'Black' }
			);
	
			if type(Info.Tooltip) == 'string' then
				Library:AddToolTip(Info.Tooltip, DropdownOuter)
			end
	
			local MAX_DROPDOWN_ITEMS = 8;
	
			local ListOuter = Library:Create('Frame', {
				BackgroundColor3 = Color3.new(0, 0, 0);
				BorderColor3 = Color3.new(0, 0, 0);
				ZIndex = 20;
				Visible = false;
				Parent = ScreenGui;
			});
	
			local function RecalculateListPosition()
				ListOuter.Position = UDim2.fromOffset(DropdownOuter.AbsolutePosition.X, DropdownOuter.AbsolutePosition.Y + DropdownOuter.Size.Y.Offset + 1);
			end;
	
			local function RecalculateListSize(YSize)
				ListOuter.Size = UDim2.fromOffset(DropdownOuter.AbsoluteSize.X, YSize or (MAX_DROPDOWN_ITEMS * 20 + 2))
			end;
	
			RecalculateListPosition();
			RecalculateListSize();
	
			DropdownOuter:GetPropertyChangedSignal('AbsolutePosition'):Connect(RecalculateListPosition);
	
			local ListInner = Library:Create('Frame', {
				BackgroundColor3 = Library.MainColor;
				BorderColor3 = Library.OutlineColor;
				BorderMode = Enum.BorderMode.Inset;
				BorderSizePixel = 0;
				Size = UDim2.new(1, 0, 1, 0);
				ZIndex = 21;
				Parent = ListOuter;
			});
	
			Library:AddToRegistry(ListInner, {
				BackgroundColor3 = 'MainColor';
				BorderColor3 = 'OutlineColor';
			});
	
			local Scrolling = Library:Create('ScrollingFrame', {
				BackgroundTransparency = 1;
				BorderSizePixel = 0;
				CanvasSize = UDim2.new(0, 0, 0, 0);
				Size = UDim2.new(1, 0, 1, 0);
				ZIndex = 21;
				Parent = ListInner;
	
				TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
				BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
	
				ScrollBarThickness = 3,
				ScrollBarImageColor3 = Library.AccentColor,
			});
	
			Library:AddToRegistry(Scrolling, {
				ScrollBarImageColor3 = 'AccentColor'
			})
	
			Library:Create('UIListLayout', {
				Padding = UDim.new(0, 0);
				FillDirection = Enum.FillDirection.Vertical;
				SortOrder = Enum.SortOrder.LayoutOrder;
				Parent = Scrolling;
			});
	
			function Dropdown:Display()
				local Values = Dropdown.Values;
				local Str = '';
	
				if Info.Multi then
					for Idx, Value in next, Values do
						if Dropdown.Value[Value] then
							Str = Str .. Value .. ', ';
						end;
					end;
	
					Str = Str:sub(1, #Str - 2);
				else
					Str = Dropdown.Value or '';
				end;
	
				ItemList.Text = (Str == '' and '--' or Str);
			end;
	
			function Dropdown:GetActiveValues()
				if Info.Multi then
					local T = {};
	
					for Value, Bool in next, Dropdown.Value do
						table.insert(T, Value);
					end;
	
					return T;
				else
					return Dropdown.Value and 1 or 0;
				end;
			end;
	
			function Dropdown:BuildDropdownList()
				local Values = Dropdown.Values;
				local Buttons = {};
	
				for _, Element in next, Scrolling:GetChildren() do
					if not Element:IsA('UIListLayout') then
						Element:Destroy();
					end;
				end;
	
				local Count = 0;
	
				for Idx, Value in next, Values do
					local Table = {};
	
					Count = Count + 1;
	
					local Button = Library:Create('Frame', {
						BackgroundColor3 = Library.MainColor;
						BorderColor3 = Library.OutlineColor;
						BorderMode = Enum.BorderMode.Middle;
						Size = UDim2.new(1, -1, 0, 20);
						ZIndex = 23;
						Active = true,
						Parent = Scrolling;
					});
	
					Library:AddToRegistry(Button, {
						BackgroundColor3 = 'MainColor';
						BorderColor3 = 'OutlineColor';
					});
	
					local ButtonLabel = Library:CreateLabel({
						Active = false;
						Size = UDim2.new(1, -6, 1, 0);
						Position = UDim2.new(0, 6, 0, 0);
						TextSize = 14;
						Text = Value;
						TextXAlignment = Enum.TextXAlignment.Left;
						ZIndex = 25;
						Parent = Button;
					});
	
					Library:OnHighlight(Button, Button,
						{ BorderColor3 = 'AccentColor', ZIndex = 24 },
						{ BorderColor3 = 'OutlineColor', ZIndex = 23 }
					);
	
					local Selected;
	
					if Info.Multi then
						Selected = Dropdown.Value[Value];
					else
						Selected = Dropdown.Value == Value;
					end;
	
					function Table:UpdateButton()
						if Info.Multi then
							Selected = Dropdown.Value[Value];
						else
							Selected = Dropdown.Value == Value;
						end;
	
						ButtonLabel.TextColor3 = Selected and Library.AccentColor or Library.FontColor;
						Library.RegistryMap[ButtonLabel].Properties.TextColor3 = Selected and 'AccentColor' or 'FontColor';
					end;
					
					ButtonLabel.InputBegan:Connect(function(Input)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
							local Try = not Selected;
	
							if Dropdown:GetActiveValues() == 1 and (not Try) and (not Info.AllowNull) then
							else
								if Info.Multi then
									Selected = Try;
	
									if Selected then
										Dropdown.Value[Value] = true;
									else
										Dropdown.Value[Value] = nil;
									end;
								else
									Selected = Try;
	
									if Selected then
										Dropdown.Value = Value;
									else
										Dropdown.Value = nil;
									end;
	
									for _, OtherButton in next, Buttons do
										OtherButton:UpdateButton();
									end;
								end;
	
								Table:UpdateButton();
								Dropdown:Display();
	
								Library:SafeCallback(Dropdown.Callback, Dropdown.Value);
								Library:SafeCallback(Dropdown.Changed, Dropdown.Value);
	
								Library:AttemptSave();
							end;
						end;
					end);
	
					Table:UpdateButton();
					Dropdown:Display();
	
					Buttons[Button] = Table;
				end;
	
				Scrolling.CanvasSize = UDim2.fromOffset(0, (Count * 20) + 1);
	
				local Y = math.clamp(Count * 20, 0, MAX_DROPDOWN_ITEMS * 20) + 1;
				RecalculateListSize(Y);
			end;
	
			function Dropdown:SetValues(NewValues)
				if NewValues then
					Dropdown.Values = NewValues;
				end;
	
				Dropdown:BuildDropdownList();
			end;
	
			function Dropdown:OpenDropdown()
				ListOuter.Visible = true;
				Library.OpenedFrames[ListOuter] = true;
				DropdownArrow.Rotation = 180;
			end;
	
			function Dropdown:CloseDropdown()
				ListOuter.Visible = false;
				Library.OpenedFrames[ListOuter] = nil;
				DropdownArrow.Rotation = 0;
			end;
	
			function Dropdown:OnChanged(Func)
				Dropdown.Changed = Func;
				Func(Dropdown.Value);
			end;
	
			function Dropdown:SetValue(Val)
				if Dropdown.Multi then
					local nTable = {};
	
					for Value, Bool in next, Val do
						if table.find(Dropdown.Values, Value) then
							nTable[Value] = true
						end;
					end;
	
					Dropdown.Value = nTable;
				else
					if (not Val) then
						Dropdown.Value = nil;
					elseif table.find(Dropdown.Values, Val) then
						Dropdown.Value = Val;
					end;
				end;
	
				Dropdown:BuildDropdownList();
	
				Library:SafeCallback(Dropdown.Callback, Dropdown.Value);
				Library:SafeCallback(Dropdown.Changed, Dropdown.Value);
			end;
	
			DropdownOuter.InputBegan:Connect(function(Input)
				if 		(Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame()) or Input.UserInputType == Enum.UserInputType.Touch and not Library:MouseIsOverOpenedFrame()
	 then
					if ListOuter.Visible then
						Dropdown:CloseDropdown();
					else
						Dropdown:OpenDropdown();
					end;
				end;
			end);
	
			InputService.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					local AbsPos, AbsSize = ListOuter.AbsolutePosition, ListOuter.AbsoluteSize;
	
					if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
						or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then
	
						Dropdown:CloseDropdown();
					end;
				end;
			end);
	
			Dropdown:BuildDropdownList();
			Dropdown:Display();
	
			local Defaults = {}
	
			if type(Info.Default) == 'string' then
				local Idx = table.find(Dropdown.Values, Info.Default)
				if Idx then
					table.insert(Defaults, Idx)
				end
			elseif type(Info.Default) == 'table' then
				for _, Value in next, Info.Default do
					local Idx = table.find(Dropdown.Values, Value)
					if Idx then
						table.insert(Defaults, Idx)
					end
				end
			elseif type(Info.Default) == 'number' and Dropdown.Values[Info.Default] ~= nil then
				table.insert(Defaults, Info.Default)
			end
	
			if next(Defaults) then
				for i = 1, #Defaults do
					local Index = Defaults[i]
					if Info.Multi then
						Dropdown.Value[Dropdown.Values[Index]] = true
					else
						Dropdown.Value = Dropdown.Values[Index];
					end
	
					if (not Info.Multi) then break end
				end
	
				Dropdown:BuildDropdownList();
				Dropdown:Display();
			end
	
			Groupbox:AddBlank(Info.BlankSize or 5);
			Groupbox:Resize();
	
			Options[Idx] = Dropdown;
	
			return Dropdown;
		end;
	
		function Funcs:AddDependencyBox()
			local Depbox = {
				Dependencies = {};
			};
	
			local Groupbox = self;
			local Container = Groupbox.Container;
	
			local Holder = Library:Create('Frame', {
				BackgroundTransparency = 1;
				Size = UDim2.new(1, 0, 0, 0);
				Visible = false;
				Parent = Container;
			});
	
			local Frame = Library:Create('Frame', {
				BackgroundTransparency = 1;
				Size = UDim2.new(1, 0, 1, 0);
				Visible = true;
				Parent = Holder;
			});
	
			local Layout = Library:Create('UIListLayout', {
				FillDirection = Enum.FillDirection.Vertical;
				SortOrder = Enum.SortOrder.LayoutOrder;
				Parent = Frame;
			});
	
			function Depbox:Resize()
				Holder.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y);
				Groupbox:Resize();
			end;
	
			Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				Depbox:Resize();
			end);
	
			Holder:GetPropertyChangedSignal('Visible'):Connect(function()
				Depbox:Resize();
			end);
	
			function Depbox:Update()
				for _, Dependency in next, Depbox.Dependencies do
					local Elem = Dependency[1];
					local Value = Dependency[2];
	
					if Elem.Type == 'Toggle' and Elem.Value ~= Value then
						Holder.Visible = false;
						Depbox:Resize();
						return;
					end;
				end;
	
				Holder.Visible = true;
				Depbox:Resize();
			end;
	
			function Depbox:SetupDependencies(Dependencies)
				for _, Dependency in next, Dependencies do
					assert(type(Dependency) == 'table', 'SetupDependencies: Dependency is not of type `table`.');
					assert(Dependency[1], 'SetupDependencies: Dependency is missing element argument.');
					assert(Dependency[2] ~= nil, 'SetupDependencies: Dependency is missing value argument.');
				end;
	
				Depbox.Dependencies = Dependencies;
				Depbox:Update();
			end;
	
			Depbox.Container = Frame;
	
			setmetatable(Depbox, BaseGroupbox);
	
			table.insert(Library.DependencyBoxes, Depbox);
	
			return Depbox;
		end;
	
		BaseGroupbox.__index = Funcs;
		BaseGroupbox.__namecall = function(Table, Key, ...)
			return Funcs[Key](...);
		end;
	end;
	
	-- < Create other UI elements >
	do
		Library.NotificationArea = Library:Create('Frame', {
			BackgroundTransparency = 1;
			Position = UDim2.new(0, 0, 0, 40);
			Size = UDim2.new(0, 300, 0, 200);
			ZIndex = 100;
			Parent = ScreenGui;
		});
	
		Library:Create('UIListLayout', {
			Padding = UDim.new(0, 4);
			FillDirection = Enum.FillDirection.Vertical;
			SortOrder = Enum.SortOrder.LayoutOrder;
			Parent = Library.NotificationArea;
		});
	
		local WatermarkOuter = Library:Create('Frame', {
			BorderColor3 = Color3.new(0, 0, 0);
			Position = UDim2.new(0, 100, 0, -25);
			Size = UDim2.new(0, 213, 0, 20);
			ZIndex = 200;
			Visible = false;
			Parent = ScreenGui;
		});
	
		local WatermarkInner = Library:Create('Frame', {
			BackgroundColor3 = Library.MainColor;
			BorderColor3 = Library.AccentColor;
			BorderMode = Enum.BorderMode.Inset;
			Size = UDim2.new(1, 0, 1, 0);
			ZIndex = 201;
			Parent = WatermarkOuter;
		});
	
		Library:AddToRegistry(WatermarkInner, {
			BorderColor3 = 'AccentColor';
		});
	
		local InnerFrame = Library:Create('Frame', {
			BackgroundColor3 = Color3.new(1, 1, 1);
			BorderSizePixel = 0;
			Position = UDim2.new(0, 1, 0, 1);
			Size = UDim2.new(1, -2, 1, -2);
			ZIndex = 202;
			Parent = WatermarkInner;
		});
	
		local Gradient = Library:Create('UIGradient', {
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
				ColorSequenceKeypoint.new(1, Library.MainColor),
			});
			Rotation = -90;
			Parent = InnerFrame;
		});
	
		Library:AddToRegistry(Gradient, {
			Color = function()
				return ColorSequence.new({
					ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
					ColorSequenceKeypoint.new(1, Library.MainColor),
				});
			end
		});
	
		local WatermarkLabel = Library:CreateLabel({
			Position = UDim2.new(0, 5, 0, 0);
			Size = UDim2.new(1, -4, 1, 0);
			TextSize = 14;
			TextXAlignment = Enum.TextXAlignment.Left;
			ZIndex = 203;
			Parent = InnerFrame;
		});
	
		Library.Watermark = WatermarkOuter;
		Library.WatermarkText = WatermarkLabel;
		Library:MakeDraggable(Library.Watermark, Library.Watermark);
	
	
	
		local KeybindOuter = Library:Create('Frame', {
			AnchorPoint = Vector2.new(0, 0.5);
			BorderColor3 = Color3.new(0, 0, 0);
			Position = UDim2.new(0, 10, 0.5, 0);
			Size = UDim2.new(0, 210, 0, 20);
			Visible = false;
			ZIndex = 100;
			Parent = ScreenGui;
		});
	
		local KeybindInner = Library:Create('Frame', {
			BackgroundColor3 = Library.MainColor;
			BorderColor3 = Library.OutlineColor;
			BorderMode = Enum.BorderMode.Inset;
			Size = UDim2.new(1, 0, 1, 0);
			ZIndex = 101;
			Parent = KeybindOuter;
		});
	
		Library:AddToRegistry(KeybindInner, {
			BackgroundColor3 = 'MainColor';
			BorderColor3 = 'OutlineColor';
		}, true);
	
		local ColorFrame = Library:Create('Frame', {
			BackgroundColor3 = Library.AccentColor;
			BorderSizePixel = 0;
			Size = UDim2.new(1, 0, 0, 2);
			ZIndex = 102;
			Parent = KeybindInner;
		});
	
		Library:AddToRegistry(ColorFrame, {
			BackgroundColor3 = 'AccentColor';
		}, true);
	
		local KeybindLabel = Library:CreateLabel({
			Size = UDim2.new(1, 0, 0, 20);
			Position = UDim2.fromOffset(5, 2),
			TextXAlignment = Enum.TextXAlignment.Left,
	
			Text = 'Keybinds';
			ZIndex = 104;
			Parent = KeybindInner;
		});
	
		local KeybindContainer = Library:Create('Frame', {
			BackgroundTransparency = 1;
			Size = UDim2.new(1, 0, 1, -20);
			Position = UDim2.new(0, 0, 0, 20);
			ZIndex = 1;
			Parent = KeybindInner;
		});
	
		Library:Create('UIListLayout', {
			FillDirection = Enum.FillDirection.Vertical;
			SortOrder = Enum.SortOrder.LayoutOrder;
			Parent = KeybindContainer;
		});
	
		Library:Create('UIPadding', {
			PaddingLeft = UDim.new(0, 5),
			Parent = KeybindContainer,
		})
	
		Library.KeybindFrame = KeybindOuter;
		Library.KeybindContainer = KeybindContainer;
		Library:MakeDraggable(KeybindOuter, KeybindOuter);
	end;
	
	function Library:SetWatermarkVisibility(Bool)
		Library.Watermark.Visible = Bool;
	end;
	
	function Library:SetWatermark(Text)
		local X, Y = Library:GetTextBounds(Text, Library.Font, 14);
		Library.Watermark.Size = UDim2.new(0, X + 15, 0, (Y * 1.5) + 3);
		Library:SetWatermarkVisibility(true)
	
		Library.WatermarkText.Text = Text;
	end;
	
	function Library:Notify(Text, Time)
		local XSize, YSize = Library:GetTextBounds(Text, Library.Font, 14);
	
		YSize = YSize + 7
	
		local NotifyOuter = Library:Create('Frame', {
			BorderColor3 = Color3.new(0, 0, 0);
			Position = UDim2.new(0, 100, 0, 10);
			Size = UDim2.new(0, 0, 0, YSize);
			ClipsDescendants = true;
			ZIndex = 100;
			Parent = Library.NotificationArea;
		});
	
		local NotifyInner = Library:Create('Frame', {
			BackgroundColor3 = Library.MainColor;
			BorderColor3 = Library.OutlineColor;
			BorderMode = Enum.BorderMode.Inset;
			Size = UDim2.new(1, 0, 1, 0);
			ZIndex = 101;
			Parent = NotifyOuter;
		});
	
		Library:AddToRegistry(NotifyInner, {
			BackgroundColor3 = 'MainColor';
			BorderColor3 = 'OutlineColor';
		}, true);
	
		local InnerFrame = Library:Create('Frame', {
			BackgroundColor3 = Color3.new(1, 1, 1);
			BorderSizePixel = 0;
			Position = UDim2.new(0, 1, 0, 1);
			Size = UDim2.new(1, -2, 1, -2);
			ZIndex = 102;
			Parent = NotifyInner;
		});
	
		local Gradient = Library:Create('UIGradient', {
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
				ColorSequenceKeypoint.new(1, Library.MainColor),
			});
			Rotation = -90;
			Parent = InnerFrame;
		});
	
		Library:AddToRegistry(Gradient, {
			Color = function()
				return ColorSequence.new({
					ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
					ColorSequenceKeypoint.new(1, Library.MainColor),
				});
			end
		});
	
		local NotifyLabel = Library:CreateLabel({
			Position = UDim2.new(0, 4, 0, 0);
			Size = UDim2.new(1, -4, 1, 0);
			Text = Text;
			TextXAlignment = Enum.TextXAlignment.Left;
			TextSize = 14;
			ZIndex = 103;
			Parent = InnerFrame;
		});
	
		local LeftColor = Library:Create('Frame', {
			BackgroundColor3 = Library.AccentColor;
			BorderSizePixel = 0;
			Position = UDim2.new(0, -1, 0, -1);
			Size = UDim2.new(0, 3, 1, 2);
			ZIndex = 104;
			Parent = NotifyOuter;
		});
	
		Library:AddToRegistry(LeftColor, {
			BackgroundColor3 = 'AccentColor';
		}, true);
	
		pcall(NotifyOuter.TweenSize, NotifyOuter, UDim2.new(0, XSize + 8 + 4, 0, YSize), 'Out', 'Quad', 0.4, true);
	
		task.spawn(function()
			wait(Time or 5);
	
			pcall(NotifyOuter.TweenSize, NotifyOuter, UDim2.new(0, 0, 0, YSize), 'Out', 'Quad', 0.4, true);
	
			wait(0.4);
	
			NotifyOuter:Destroy();
		end);
	end;
	
	function Library:CreateWindow(...)
		local Arguments = { ... }
		local Config = { AnchorPoint = Vector2.zero }
	
		if type(...) == 'table' then
			Config = ...;
		else
			Config.Title = Arguments[1]
			Config.AutoShow = Arguments[2] or false;
		end
	
		if type(Config.Title) ~= 'string' then Config.Title = 'No title' end
		if type(Config.TabPadding) ~= 'number' then Config.TabPadding = 0 end
		if type(Config.MenuFadeTime) ~= 'number' then Config.MenuFadeTime = 0.2 end
	
		if typeof(Config.Position) ~= 'UDim2' then Config.Position = UDim2.fromOffset(175, 50) end
		if typeof(Config.Size) ~= 'UDim2' then Config.Size = UDim2.fromOffset(550, 600) end
	
		if Config.Center then
			Config.AnchorPoint = Vector2.new(0.5, 0.5)
			Config.Position = UDim2.fromScale(0.5, 0.5)
		end
	
		local Window = {
			Tabs = {};
		};
	
		local Outer = Library:Create('Frame', {
			AnchorPoint = Config.AnchorPoint,
			BackgroundColor3 = Color3.new(0, 0, 0);
			BorderSizePixel = 0;
			Position = Config.Position,
			Size = Config.Size,
			Visible = false;
			ZIndex = 1;
			Parent = ScreenGui;
		});
	
		Library:MakeDraggable(Outer, Outer);
	
		local Inner = Library:Create('Frame', {
			BackgroundColor3 = Library.MainColor;
			BorderColor3 = Library.AccentColor;
			BorderMode = Enum.BorderMode.Inset;
			Position = UDim2.new(0, 1, 0, 1);
			Size = UDim2.new(1, -2, 1, -2);
			ZIndex = 1;
			Parent = Outer;
		});
	
		Library:AddToRegistry(Inner, {
			BackgroundColor3 = 'MainColor';
			BorderColor3 = 'AccentColor';
		});
	
		local WindowLabel = Library:CreateLabel({
			Position = UDim2.new(0, 7, 0, 0);
			Size = UDim2.new(0, 0, 0, 25);
			Text = Config.Title or '';
			TextXAlignment = Enum.TextXAlignment.Left;
			ZIndex = 1;
			Parent = Inner;
		});
	
		local MainSectionOuter = Library:Create('Frame', {
			BackgroundColor3 = Library.BackgroundColor;
			BorderColor3 = Library.OutlineColor;
			Position = UDim2.new(0, 8, 0, 25);
			Size = UDim2.new(1, -16, 1, -33);
			ZIndex = 1;
			Parent = Inner;
		});
	
		Library:AddToRegistry(MainSectionOuter, {
			BackgroundColor3 = 'BackgroundColor';
			BorderColor3 = 'OutlineColor';
		});
	
		local MainSectionInner = Library:Create('Frame', {
			BackgroundColor3 = Library.BackgroundColor;
			BorderColor3 = Color3.new(0, 0, 0);
			BorderMode = Enum.BorderMode.Inset;
			Position = UDim2.new(0, 0, 0, 0);
			Size = UDim2.new(1, 0, 1, 0);
			ZIndex = 1;
			Parent = MainSectionOuter;
		});
	
		Library:AddToRegistry(MainSectionInner, {
			BackgroundColor3 = 'BackgroundColor';
		});
	
		local TabArea = Library:Create('Frame', {
			BackgroundTransparency = 1;
			Position = UDim2.new(0, 8, 0, 8);
			Size = UDim2.new(1, -16, 0, 21);
			ZIndex = 1;
			Parent = MainSectionInner;
		});
	
		local TabListLayout = Library:Create('UIListLayout', {
			Padding = UDim.new(0, Config.TabPadding);
			FillDirection = Enum.FillDirection.Horizontal;
			SortOrder = Enum.SortOrder.LayoutOrder;
			Parent = TabArea;
		});
	
		local TabContainer = Library:Create('Frame', {
			BackgroundColor3 = Library.MainColor;
			BorderColor3 = Library.OutlineColor;
			Position = UDim2.new(0, 8, 0, 30);
			Size = UDim2.new(1, -16, 1, -38);
			ZIndex = 2;
			Parent = MainSectionInner;
		});
	
	
		Library:AddToRegistry(TabContainer, {
			BackgroundColor3 = 'MainColor';
			BorderColor3 = 'OutlineColor';
		});
	
		function Window:SetWindowTitle(Title)
			WindowLabel.Text = Title;
		end;
	
		function Window:AddTab(Name)
			local Tab = {
				Groupboxes = {};
				Tabboxes = {};
			};
	
			local TabButtonWidth = Library:GetTextBounds(Name, Library.Font, 16);
	
			local TabButton = Library:Create('Frame', {
				BackgroundColor3 = Library.BackgroundColor;
				BorderColor3 = Library.OutlineColor;
				Size = UDim2.new(0, TabButtonWidth + 8 + 4, 1, 0);
				ZIndex = 1;
				Parent = TabArea;
			});
	
			Library:AddToRegistry(TabButton, {
				BackgroundColor3 = 'BackgroundColor';
				BorderColor3 = 'OutlineColor';
			});
	
			local TabButtonLabel = Library:CreateLabel({
				Position = UDim2.new(0, 0, 0, 0);
				Size = UDim2.new(1, 0, 1, -1);
				Text = Name;
				ZIndex = 1;
				Parent = TabButton;
			});
	
			local Blocker = Library:Create('Frame', {
				BackgroundColor3 = Library.MainColor;
				BorderSizePixel = 0;
				Position = UDim2.new(0, 0, 1, 0);
				Size = UDim2.new(1, 0, 0, 1);
				BackgroundTransparency = 1;
				ZIndex = 3;
				Parent = TabButton;
			});
	
			Library:AddToRegistry(Blocker, {
				BackgroundColor3 = 'MainColor';
			});
	
			local TabFrame = Library:Create('Frame', {
				Name = 'TabFrame',
				BackgroundTransparency = 1;
				Position = UDim2.new(0, 0, 0, 0);
				Size = UDim2.new(1, 0, 1, 0);
				Visible = false;
				ZIndex = 2;
				Parent = TabContainer;
			});
	
			local LeftSide = Library:Create('ScrollingFrame', {
				BackgroundTransparency = 1;
				BorderSizePixel = 0;
				Position = UDim2.new(0, 8 - 1, 0, 8 - 1);
				Size = UDim2.new(0.5, -12 + 2, 0, 507 + 2);
				CanvasSize = UDim2.new(0, 0, 0, 0);
				BottomImage = '';
				TopImage = '';
				ScrollBarThickness = 0;
				ZIndex = 2;
				Parent = TabFrame;
			});
	
			local RightSide = Library:Create('ScrollingFrame', {
				BackgroundTransparency = 1;
				BorderSizePixel = 0;
				Position = UDim2.new(0.5, 4 + 1, 0, 8 - 1);
				Size = UDim2.new(0.5, -12 + 2, 0, 507 + 2);
				CanvasSize = UDim2.new(0, 0, 0, 0);
				BottomImage = '';
				TopImage = '';
				ScrollBarThickness = 0;
				ZIndex = 2;
				Parent = TabFrame;
			});
	
			Library:Create('UIListLayout', {
				Padding = UDim.new(0, 8);
				FillDirection = Enum.FillDirection.Vertical;
				SortOrder = Enum.SortOrder.LayoutOrder;
				HorizontalAlignment = Enum.HorizontalAlignment.Center;
				Parent = LeftSide;
			});
	
			Library:Create('UIListLayout', {
				Padding = UDim.new(0, 8);
				FillDirection = Enum.FillDirection.Vertical;
				SortOrder = Enum.SortOrder.LayoutOrder;
				HorizontalAlignment = Enum.HorizontalAlignment.Center;
				Parent = RightSide;
			});
	
			for _, Side in next, { LeftSide, RightSide } do
				Side:WaitForChild('UIListLayout'):GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
					Side.CanvasSize = UDim2.fromOffset(0, Side.UIListLayout.AbsoluteContentSize.Y);
				end);
			end;
	
			function Tab:ShowTab()
				for _, Tab in next, Window.Tabs do
					Tab:HideTab();
				end;
	
				Blocker.BackgroundTransparency = 0;
				TabButton.BackgroundColor3 = Library.MainColor;
				Library.RegistryMap[TabButton].Properties.BackgroundColor3 = 'MainColor';
				TabFrame.Visible = true;
			end;
	
			function Tab:HideTab()
				Blocker.BackgroundTransparency = 1;
				TabButton.BackgroundColor3 = Library.BackgroundColor;
				Library.RegistryMap[TabButton].Properties.BackgroundColor3 = 'BackgroundColor';
				TabFrame.Visible = false;
			end;
	
			function Tab:SetLayoutOrder(Position)
				TabButton.LayoutOrder = Position;
				TabListLayout:ApplyLayout();
			end;
	
			function Tab:AddGroupbox(Info)
				local Groupbox = {};
	
				local BoxOuter = Library:Create('Frame', {
					BackgroundColor3 = Library.BackgroundColor;
					BorderColor3 = Library.OutlineColor;
					BorderMode = Enum.BorderMode.Inset;
					Size = UDim2.new(1, 0, 0, 507 + 2);
					ZIndex = 2;
					Parent = Info.Side == 1 and LeftSide or RightSide;
				});
	
				Library:AddToRegistry(BoxOuter, {
					BackgroundColor3 = 'BackgroundColor';
					BorderColor3 = 'OutlineColor';
				});
	
				local BoxInner = Library:Create('Frame', {
					BackgroundColor3 = Library.BackgroundColor;
					BorderColor3 = Color3.new(0, 0, 0);
					-- BorderMode = Enum.BorderMode.Inset;
					Size = UDim2.new(1, -2, 1, -2);
					Position = UDim2.new(0, 1, 0, 1);
					ZIndex = 4;
					Parent = BoxOuter;
				});
	
				Library:AddToRegistry(BoxInner, {
					BackgroundColor3 = 'BackgroundColor';
				});
	
				local Highlight = Library:Create('Frame', {
					BackgroundColor3 = Library.AccentColor;
					BorderSizePixel = 0;
					Size = UDim2.new(1, 0, 0, 2);
					ZIndex = 5;
					Parent = BoxInner;
				});
	
				Library:AddToRegistry(Highlight, {
					BackgroundColor3 = 'AccentColor';
				});
	
				local GroupboxLabel = Library:CreateLabel({
					Size = UDim2.new(1, 0, 0, 18);
					Position = UDim2.new(0, 4, 0, 2);
					TextSize = 14;
					Text = Info.Name;
					TextXAlignment = Enum.TextXAlignment.Left;
					ZIndex = 5;
					Parent = BoxInner;
				});
	
				local Container = Library:Create('Frame', {
					BackgroundTransparency = 1;
					Position = UDim2.new(0, 4, 0, 20);
					Size = UDim2.new(1, -4, 1, -20);
					ZIndex = 1;
					Parent = BoxInner;
				});
	
				Library:Create('UIListLayout', {
					FillDirection = Enum.FillDirection.Vertical;
					SortOrder = Enum.SortOrder.LayoutOrder;
					Parent = Container;
				});
	
				function Groupbox:Resize()
					local Size = 0;
	
					for _, Element in next, Groupbox.Container:GetChildren() do
						if (not Element:IsA('UIListLayout')) and Element.Visible then
							Size = Size + Element.Size.Y.Offset;
						end;
					end;
	
					BoxOuter.Size = UDim2.new(1, 0, 0, 20 + Size + 2 + 2);
				end;
	
				Groupbox.Container = Container;
				setmetatable(Groupbox, BaseGroupbox);
	
				Groupbox:AddBlank(3);
				Groupbox:Resize();
	
				Tab.Groupboxes[Info.Name] = Groupbox;
	
				return Groupbox;
			end;
	
			function Tab:AddLeftGroupbox(Name)
				return Tab:AddGroupbox({ Side = 1; Name = Name; });
			end;
	
			function Tab:AddRightGroupbox(Name)
				return Tab:AddGroupbox({ Side = 2; Name = Name; });
			end;
	
			function Tab:AddTabbox(Info)
				local Tabbox = {
					Tabs = {};
				};
	
				local BoxOuter = Library:Create('Frame', {
					BackgroundColor3 = Library.BackgroundColor;
					BorderColor3 = Library.OutlineColor;
					BorderMode = Enum.BorderMode.Inset;
					Size = UDim2.new(1, 0, 0, 0);
					ZIndex = 2;
					Parent = Info.Side == 1 and LeftSide or RightSide;
				});
	
				Library:AddToRegistry(BoxOuter, {
					BackgroundColor3 = 'BackgroundColor';
					BorderColor3 = 'OutlineColor';
				});
	
				local BoxInner = Library:Create('Frame', {
					BackgroundColor3 = Library.BackgroundColor;
					BorderColor3 = Color3.new(0, 0, 0);
					-- BorderMode = Enum.BorderMode.Inset;
					Size = UDim2.new(1, -2, 1, -2);
					Position = UDim2.new(0, 1, 0, 1);
					ZIndex = 4;
					Parent = BoxOuter;
				});
	
				Library:AddToRegistry(BoxInner, {
					BackgroundColor3 = 'BackgroundColor';
				});
	
				local Highlight = Library:Create('Frame', {
					BackgroundColor3 = Library.AccentColor;
					BorderSizePixel = 0;
					Size = UDim2.new(1, 0, 0, 2);
					ZIndex = 10;
					Parent = BoxInner;
				});
	
				Library:AddToRegistry(Highlight, {
					BackgroundColor3 = 'AccentColor';
				});
	
				local TabboxButtons = Library:Create('Frame', {
					BackgroundTransparency = 1;
					Position = UDim2.new(0, 0, 0, 1);
					Size = UDim2.new(1, 0, 0, 18);
					ZIndex = 5;
					Parent = BoxInner;
				});
	
				Library:Create('UIListLayout', {
					FillDirection = Enum.FillDirection.Horizontal;
					HorizontalAlignment = Enum.HorizontalAlignment.Left;
					SortOrder = Enum.SortOrder.LayoutOrder;
					Parent = TabboxButtons;
				});
	
				function Tabbox:AddTab(Name)
					local Tab = {};
	
					local Button = Library:Create('Frame', {
						BackgroundColor3 = Library.MainColor;
						BorderColor3 = Color3.new(0, 0, 0);
						Size = UDim2.new(0.5, 0, 1, 0);
						ZIndex = 6;
						Parent = TabboxButtons;
					});
	
					Library:AddToRegistry(Button, {
						BackgroundColor3 = 'MainColor';
					});
	
					local ButtonLabel = Library:CreateLabel({
						Size = UDim2.new(1, 0, 1, 0);
						TextSize = 14;
						Text = Name;
						TextXAlignment = Enum.TextXAlignment.Center;
						ZIndex = 7;
						Parent = Button;
					});
	
					local Block = Library:Create('Frame', {
						BackgroundColor3 = Library.BackgroundColor;
						BorderSizePixel = 0;
						Position = UDim2.new(0, 0, 1, 0);
						Size = UDim2.new(1, 0, 0, 1);
						Visible = false;
						ZIndex = 9;
						Parent = Button;
					});
	
					Library:AddToRegistry(Block, {
						BackgroundColor3 = 'BackgroundColor';
					});
	
					local Container = Library:Create('Frame', {
						BackgroundTransparency = 1;
						Position = UDim2.new(0, 4, 0, 20);
						Size = UDim2.new(1, -4, 1, -20);
						ZIndex = 1;
						Visible = false;
						Parent = BoxInner;
					});
	
					Library:Create('UIListLayout', {
						FillDirection = Enum.FillDirection.Vertical;
						SortOrder = Enum.SortOrder.LayoutOrder;
						Parent = Container;
					});
	
					function Tab:Show()
						for _, Tab in next, Tabbox.Tabs do
							Tab:Hide();
						end;
	
						Container.Visible = true;
						Block.Visible = true;
	
						Button.BackgroundColor3 = Library.BackgroundColor;
						Library.RegistryMap[Button].Properties.BackgroundColor3 = 'BackgroundColor';
	
						Tab:Resize();
					end;
	
					function Tab:Hide()
						Container.Visible = false;
						Block.Visible = false;
	
						Button.BackgroundColor3 = Library.MainColor;
						Library.RegistryMap[Button].Properties.BackgroundColor3 = 'MainColor';
					end;
	
					function Tab:Resize()
						local TabCount = 0;
	
						for _, Tab in next, Tabbox.Tabs do
							TabCount = TabCount + 1;
						end;
	
						for _, Button in next, TabboxButtons:GetChildren() do
							if not Button:IsA('UIListLayout') then
								Button.Size = UDim2.new(1 / TabCount, 0, 1, 0);
							end;
						end;
	
						if (not Container.Visible) then
							return;
						end;
	
						local Size = 0;
	
						for _, Element in next, Tab.Container:GetChildren() do
							if (not Element:IsA('UIListLayout')) and Element.Visible then
								Size = Size + Element.Size.Y.Offset;
							end;
						end;
	
						BoxOuter.Size = UDim2.new(1, 0, 0, 20 + Size + 2 + 2);
					end;
	
					Button.InputBegan:Connect(function(Input)
						if 		(Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame()) or Input.UserInputType == Enum.UserInputType.Touch and not Library:MouseIsOverOpenedFrame()
	 then
							Tab:Show();
							Tab:Resize();
						end;
					end);
	
					Tab.Container = Container;
					Tabbox.Tabs[Name] = Tab;
	
					setmetatable(Tab, BaseGroupbox);
	
					Tab:AddBlank(3);
					Tab:Resize();
	
					-- Show first tab (number is 2 cus of the UIListLayout that also sits in that instance)
					if #TabboxButtons:GetChildren() == 2 then
						Tab:Show();
					end;
	
					return Tab;
				end;
	
				Tab.Tabboxes[Info.Name or ''] = Tabbox;
	
				return Tabbox;
			end;
	
			function Tab:AddLeftTabbox(Name)
				return Tab:AddTabbox({ Name = Name, Side = 1; });
			end;
	
			function Tab:AddRightTabbox(Name)
				return Tab:AddTabbox({ Name = Name, Side = 2; });
			end;
	
			TabButton.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Tab:ShowTab();
				end;
			end);
	
			-- This was the first tab added, so we show it by default.
			if #TabContainer:GetChildren() == 1 then
				Tab:ShowTab();
			end;
	
			Window.Tabs[Name] = Tab;
			return Tab;
		end;
	
		local ModalElement = Library:Create('TextButton', {
			BackgroundTransparency = 1;
			Size = UDim2.new(0, 0, 0, 0);
			Visible = true;
			Text = '';
			Modal = false;
			Parent = ScreenGui;
		});
	
		local TransparencyCache = {};
		local Toggled = false;
		local Fading = false;
	
		function Library:Toggle()
			if Fading then
				return;
			end;
	
			local FadeTime = Config.MenuFadeTime;
			Fading = true;
			Toggled = (not Toggled);
			ModalElement.Modal = Toggled;
	
			if Toggled then
				-- A bit scuffed, but if we're going from not toggled -> toggled we want to show the frame immediately so that the fade is visible.
				Outer.Visible = true;
				
				task.spawn(function()
					local State = InputService.MouseIconEnabled;
	
					while Toggled and ScreenGui.Parent do
						InputService.MouseIconEnabled = true;
	
						RenderStepped:Wait();
					end;
	
					InputService.MouseIconEnabled = State;
				end);
			end;
	
			for _, Desc in next, Outer:GetDescendants() do
				local Properties = {};
	
				if Desc:IsA('ImageLabel') then
					table.insert(Properties, 'ImageTransparency');
					table.insert(Properties, 'BackgroundTransparency');
				elseif Desc:IsA('TextLabel') or Desc:IsA('TextBox') then
					table.insert(Properties, 'TextTransparency');
				elseif Desc:IsA('Frame') or Desc:IsA('ScrollingFrame') then
					table.insert(Properties, 'BackgroundTransparency');
				elseif Desc:IsA('UIStroke') then
					table.insert(Properties, 'Transparency');
				end;
	
				local Cache = TransparencyCache[Desc];
	
				if (not Cache) then
					Cache = {};
					TransparencyCache[Desc] = Cache;
				end;
	
				for _, Prop in next, Properties do
					if not Cache[Prop] then
						Cache[Prop] = Desc[Prop];
					end;
	
					if Cache[Prop] == 1 then
						continue;
					end;
	
					TweenService:Create(Desc, TweenInfo.new(FadeTime, Enum.EasingStyle.Linear), { [Prop] = Toggled and Cache[Prop] or 1 }):Play();
				end;
			end;
	
			task.wait(FadeTime);
	
			Outer.Visible = Toggled;
	
			Fading = false;
		end
	
		Library:GiveSignal(InputService.InputBegan:Connect(function(Input, Processed)
			if type(Library.ToggleKeybind) == 'table' and Library.ToggleKeybind.Type == 'KeyPicker' then
				if Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode.Name == Library.ToggleKeybind.Value then
					task.spawn(Library.Toggle)
				end
			elseif Input.KeyCode == Enum.KeyCode.P or (Input.KeyCode == Enum.KeyCode.P and (not Processed)) then
				task.spawn(Library.Toggle)
			end
		end))
	
		if Config.AutoShow then task.spawn(Library.Toggle) end
	
		Window.Holder = Outer;
	
		return Window;
	end;
	
	local function OnPlayerChange()
		local PlayerList = GetPlayersString();
	
		for _, Value in next, Options do
			if Value.Type == 'Dropdown' and Value.SpecialType == 'Player' then
				Value:SetValues(PlayerList);
			end;
		end;
	end;
	
	Players.PlayerAdded:Connect(OnPlayerChange);
	Players.PlayerRemoving:Connect(OnPlayerChange);
	
	getgenv().Library = Library
	return Library
end

modules[tbl.save_manager] = function()
	local script = tbl.save_manager

	local httpService = game:GetService('HttpService')
	local players = game:GetService("Players")
	
	local SaveManager = {} do
		SaveManager.Folder = shared.path
		SaveManager.Ignore = {}
		SaveManager.Parser = {
			Toggle = {
				Save = function(idx, object) 
					return { type = 'Toggle', idx = idx, value = object.Value } 
				end,
				Load = function(idx, data)
					if Toggles[idx] then 
						Toggles[idx]:SetValue(data.value)
					end
				end,
			},
			Slider = {
				Save = function(idx, object)
					return { type = 'Slider', idx = idx, value = tostring(object.Value) }
				end,
				Load = function(idx, data)
					if Options[idx] then 
						Options[idx]:SetValue(data.value)
					end
				end,
			},
			Dropdown = {
				Save = function(idx, object)
					return { type = 'Dropdown', idx = idx, value = object.Value, mutli = object.Multi }
				end,
				Load = function(idx, data)
					if Options[idx] then 
						Options[idx]:SetValue(data.value)
					end
				end,
			},
			ColorPicker = {
				Save = function(idx, object)
					return { type = 'ColorPicker', idx = idx, value = object.Value:ToHex(), transparency = object.Transparency }
				end,
				Load = function(idx, data)
					if Options[idx] then 
						Options[idx]:SetValueRGB(Color3.fromHex(data.value), data.transparency)
					end
				end,
			},
			KeyPicker = {
				Save = function(idx, object)
					return { type = 'KeyPicker', idx = idx, mode = object.Mode, key = object.Value }
				end,
				Load = function(idx, data)
					if Options[idx] then 
						Options[idx]:SetValue({ data.key, data.mode })
					end
				end,
			},
	
			Input = {
				Save = function(idx, object)
					return { type = 'Input', idx = idx, text = object.Value }
				end,
				Load = function(idx, data)
					if Options[idx] and type(data.text) == 'string' then
						Options[idx]:SetValue(data.text)
					end
				end,
			},
		}
	
		function SaveManager:SetIgnoreIndexes(list)
			for _, key in next, list do
				self.Ignore[key] = true
			end
		end
	
		function SaveManager:SetFolder(folder)
			self.Folder = folder;
			self:BuildFolderTree()
		end
	
		function SaveManager:Save()
			if not Toggles.auto_save.Value then
				return;
			end
	
			local fullPath = self.Folder .. '/settings/' .. players.LocalPlayer.Name .. '.json'
	
			local data = {
				objects = {}
			}
	
			for idx, option in next, Options do
				if not self.Parser[option.Type] then continue end
				if self.Ignore[idx] then continue end
	
				table.insert(data.objects, self.Parser[option.Type].Save(idx, option))
			end	
	
			for idx, toggle in next, Toggles do
				if self.Ignore[idx] then continue end
	
				table.insert(data.objects, self.Parser[toggle.Type].Save(idx, toggle))
			end
	
			local success, encoded = pcall(httpService.JSONEncode, httpService, data)
	
			if not success then
				return false, 'failed to encode data'
			end
	
			writefile(fullPath, encoded)
	
			return true
		end
	
		function SaveManager:Load()
			local file = self.Folder .. '/settings/' .. players.LocalPlayer.Name .. '.json'
			if not isfile(file) then return false, 'invalid file' end
	
			local success, decoded = pcall(httpService.JSONDecode, httpService, readfile(file))
			if not success then return false, 'decode error' end
	
			for _, option in next, decoded.objects do
				if self.Parser[option.type] then
					task.spawn(function() self.Parser[option.type].Load(option.idx, option) end) -- task.spawn() so the config loading wont get stuck.
				end
			end
	
			return true
		end
	
		function SaveManager:IgnoreThemeSettings()
			self:SetIgnoreIndexes({ 
				"BackgroundColor", "MainColor", "AccentColor", "OutlineColor", "FontColor", -- themes
				"ThemeManager_ThemeList", 'ThemeManager_CustomThemeList', 'ThemeManager_CustomThemeName', -- themes
			})
		end
	
		function SaveManager:BuildFolderTree()
			local paths = {
				self.Folder,
				self.Folder .. '/themes',
				self.Folder .. '/settings'
			}
	
			for i = 1, #paths do
				local str = paths[i]
				if not isfolder(str) then
					makefolder(str)
				end
			end
		end
	
		function SaveManager:SetLibrary(library)
			self.Library = library
			self.Library.SaveManager = self
		end
	
		function SaveManager:BuildConfigSection(tab)
			assert(self.Library, 'Must set SaveManager.Library')
	
			local section = tab:AddRightGroupbox('Configuration')
	
			section:AddToggle("auto_save", { Text = "Auto Save", Tooltip = "Automatically saves your config!" })
	
			--SaveManager:SetIgnoreIndexes({ 'auto_save' })
		end
	
		SaveManager:BuildFolderTree()
	end
	
	return SaveManager
end

modules[tbl.theme_manager] = function()
	local script = tbl.theme_manager

	local httpService = game:GetService('HttpService')
	local ThemeManager = {} do
		ThemeManager.Folder = shared.path
		-- if not isfolder(ThemeManager.Folder) then makefolder(ThemeManager.Folder) end
	
		ThemeManager.Library = nil
		ThemeManager.BuiltInThemes = {
			['Default'] 		= { 1, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1c1c1c","AccentColor":"0055ff","BackgroundColor":"141414","OutlineColor":"323232"}') },
			['BBot'] 			= { 2, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1e1e1e","AccentColor":"7e48a3","BackgroundColor":"232323","OutlineColor":"141414"}') },
			['Fatality']		= { 3, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1e1842","AccentColor":"c50754","BackgroundColor":"191335","OutlineColor":"3c355d"}') },
			['Jester'] 			= { 4, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"242424","AccentColor":"db4467","BackgroundColor":"1c1c1c","OutlineColor":"373737"}') },
			['Mint'] 			= { 5, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"242424","AccentColor":"3db488","BackgroundColor":"1c1c1c","OutlineColor":"373737"}') },
			['Tokyo Night'] 	= { 6, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"191925","AccentColor":"6759b3","BackgroundColor":"16161f","OutlineColor":"323232"}') },
			['Ubuntu'] 			= { 7, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"3e3e3e","AccentColor":"e2581e","BackgroundColor":"323232","OutlineColor":"191919"}') },
			['Quartz'] 			= { 8, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"232330","AccentColor":"426e87","BackgroundColor":"1d1b26","OutlineColor":"27232f"}') },
		}
	
		function ThemeManager:ApplyTheme(theme)
			local customThemeData = self:GetCustomTheme(theme)
			local data = customThemeData or self.BuiltInThemes[theme]
	
			if not data then return end
	
			-- custom themes are just regular dictionaries instead of an array with { index, dictionary }
	
			local scheme = data[2]
			for idx, col in next, customThemeData or scheme do
				self.Library[idx] = Color3.fromHex(col)
	
				if Options[idx] then
					Options[idx]:SetValueRGB(Color3.fromHex(col))
				end
			end
	
			self:ThemeUpdate()
		end
	
		function ThemeManager:ThemeUpdate()
			-- This allows us to force apply themes without loading the themes tab :)
			local options = { "FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor" }
			for i, field in next, options do
				if Options and Options[field] then
					self.Library[field] = Options[field].Value
				end
			end
	
			self.Library.AccentColorDark = self.Library:GetDarkerColor(self.Library.AccentColor);
			self.Library:UpdateColorsUsingRegistry()
		end
	
		function ThemeManager:LoadDefault()		
			local theme = 'Default'
			local content = isfile(self.Folder .. '/themes/default.txt') and readfile(self.Folder .. '/themes/default.txt')
	
			local isDefault = true
			if content then
				if self.BuiltInThemes[content] then
					theme = content
				elseif self:GetCustomTheme(content) then
					theme = content
					isDefault = false;
				end
			elseif self.BuiltInThemes[self.DefaultTheme] then
				theme = self.DefaultTheme
			end
	
			if isDefault then
				Options.ThemeManager_ThemeList:SetValue(theme)
			else
				self:ApplyTheme(theme)
			end
		end
	
		function ThemeManager:SaveDefault(theme)
			writefile(self.Folder .. '/themes/default.txt', theme)
		end
	
		function ThemeManager:CreateThemeManager(groupbox)
			groupbox:AddLabel('Background color'):AddColorPicker('BackgroundColor', { Default = self.Library.BackgroundColor });
			groupbox:AddLabel('Main color')	:AddColorPicker('MainColor', { Default = self.Library.MainColor });
			groupbox:AddLabel('Accent color'):AddColorPicker('AccentColor', { Default = self.Library.AccentColor });
			groupbox:AddLabel('Outline color'):AddColorPicker('OutlineColor', { Default = self.Library.OutlineColor });
			groupbox:AddLabel('Font color')	:AddColorPicker('FontColor', { Default = self.Library.FontColor });
	
			local ThemesArray = {}
			for Name, Theme in next, self.BuiltInThemes do
				table.insert(ThemesArray, Name)
			end
	
			table.sort(ThemesArray, function(a, b) return self.BuiltInThemes[a][1] < self.BuiltInThemes[b][1] end)
	
			groupbox:AddDivider()
			groupbox:AddDropdown('ThemeManager_ThemeList', { Text = 'Theme list', Values = ThemesArray, Default = 1 })
	
			groupbox:AddButton('Set as default', function()
				self:SaveDefault(Options.ThemeManager_ThemeList.Value)
				self.Library:Notify(string.format('Set default theme to %q', Options.ThemeManager_ThemeList.Value))
			end)
	
			Options.ThemeManager_ThemeList:OnChanged(function()
				self:ApplyTheme(Options.ThemeManager_ThemeList.Value)
			end)
	
			groupbox:AddDivider()
			groupbox:AddInput('ThemeManager_CustomThemeName', { Text = 'Custom theme name' })
			groupbox:AddDropdown('ThemeManager_CustomThemeList', { Text = 'Custom themes', Values = self:ReloadCustomThemes(), AllowNull = true, Default = 1 })
			groupbox:AddDivider()
	
			groupbox:AddButton('Save theme', function() 
				self:SaveCustomTheme(Options.ThemeManager_CustomThemeName.Value)
	
				Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
				Options.ThemeManager_CustomThemeList:SetValue(nil)
			end):AddButton('Load theme', function() 
				self:ApplyTheme(Options.ThemeManager_CustomThemeList.Value) 
			end)
	
			groupbox:AddButton('Refresh list', function()
				Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
				Options.ThemeManager_CustomThemeList:SetValue(nil)
			end)
	
			groupbox:AddButton('Set as default', function()
				if Options.ThemeManager_CustomThemeList.Value ~= nil and Options.ThemeManager_CustomThemeList.Value ~= '' then
					self:SaveDefault(Options.ThemeManager_CustomThemeList.Value)
					self.Library:Notify(string.format('Set default theme to %q', Options.ThemeManager_CustomThemeList.Value))
				end
			end)
	
			ThemeManager:LoadDefault()
	
			local function UpdateTheme()
				self:ThemeUpdate()
			end
	
			Options.BackgroundColor:OnChanged(UpdateTheme)
			Options.MainColor:OnChanged(UpdateTheme)
			Options.AccentColor:OnChanged(UpdateTheme)
			Options.OutlineColor:OnChanged(UpdateTheme)
			Options.FontColor:OnChanged(UpdateTheme)
		end
	
		function ThemeManager:GetCustomTheme(file)
			local path = self.Folder .. '/themes/' .. file
			if not isfile(path) then
				return nil
			end
	
			local data = readfile(path)
			local success, decoded = pcall(httpService.JSONDecode, httpService, data)
	
			if not success then
				return nil
			end
	
			return decoded
		end
	
		function ThemeManager:SaveCustomTheme(file)
			if file:gsub(' ', '') == '' then
				return self.Library:Notify('Invalid file name for theme (empty)', 3)
			end
	
			local theme = {}
			local fields = { "FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor" }
	
			for _, field in next, fields do
				theme[field] = Options[field].Value:ToHex()
			end
	
			writefile(self.Folder .. '/themes/' .. file .. '.json', httpService:JSONEncode(theme))
		end
	
		function ThemeManager:ReloadCustomThemes()
			local list = listfiles(self.Folder .. '/themes')
	
			local out = {}
			for i = 1, #list do
				local file = list[i]
				if file:sub(-5) == '.json' then
					-- i hate this but it has to be done ...
	
					local pos = file:find('.json', 1, true)
					local char = file:sub(pos, pos)
	
					while char ~= '/' and char ~= '\\' and char ~= '' do
						pos = pos - 1
						char = file:sub(pos, pos)
					end
	
					if char == '/' or char == '\\' then
						table.insert(out, file:sub(pos + 1))
					end
				end
			end
	
			return out
		end
	
		function ThemeManager:SetLibrary(lib)
			self.Library = lib
		end
	
		function ThemeManager:BuildFolderTree()
			local paths = {}
	
			-- build the entire tree if a path is like some-hub/phantom-forces
			-- makefolder builds the entire tree on Synapse X but not other exploits
	
			local parts = self.Folder:split('/')
			for idx = 1, #parts do
				paths[#paths + 1] = table.concat(parts, '/', 1, idx)
			end
	
			table.insert(paths, self.Folder .. '/themes')
			table.insert(paths, self.Folder .. '/settings')
	
			for i = 1, #paths do
				local str = paths[i]
				if not isfolder(str) then
					makefolder(str)
				end
			end
		end
	
		function ThemeManager:SetFolder(folder)
			self.Folder = folder
			self:BuildFolderTree()
		end
	
		function ThemeManager:CreateGroupBox(tab)
			assert(self.Library, 'Must set ThemeManager.Library first!')
			return tab:AddLeftGroupbox('Themes')
		end
	
		function ThemeManager:ApplyToTab(tab)
			assert(self.Library, 'Must set ThemeManager.Library first!')
			local groupbox = self:CreateGroupBox(tab)
			self:CreateThemeManager(groupbox)
		end
	
		function ThemeManager:ApplyToGroupbox(groupbox)
			assert(self.Library, 'Must set ThemeManager.Library first!')
			self:CreateThemeManager(groupbox)
		end
	
		ThemeManager:BuildFolderTree()
	end
	
	return ThemeManager
end

modules[tbl.playerMovement] = function()
	local script = tbl.playerMovement

	local playerMovement = {}
	playerMovement.movementFinished = require(script.Parent.signal).new()
	
	local moveToConnections = {}
	local destination
	
	local function clearConnections()
		for _, connection in moveToConnections do
			connection:Disconnect()
		end
		table.clear(moveToConnections)
	end
	
	function playerMovement.newDestination(newDestination)
		local character = shared.character
		local humanoid : Humanoid = character and character:FindFirstChild("Humanoid") 
	
		if humanoid then
			playerMovement.stop(nil, 'new')
			
			destination = newDestination
			
			local distance = (destination-character.PrimaryPart.Position).Magnitude
			local time = distance/humanoid.WalkSpeed
			local moveToConnection
			
			local startTime = os.time()
		
			moveToConnection = humanoid.MoveToFinished:Connect(function(r)
				if destination ~= newDestination then  if moveToConnection then moveToConnection:Disconnect() moveToConnection = nil  end return  end
				if not r and os.time() - startTime < 10 then
					humanoid:MoveTo(newDestination)
				else
					local distance = (character.PrimaryPart.Position-Vector3.new(newDestination.X, character.PrimaryPart.Position.Y, newDestination.Z)).Magnitude
					if moveToConnection then moveToConnection:Disconnect() moveToConnection = nil  end
	
					--if distance >= 8 and os.time() - startTime < 10 then
					--	return
					--end
					playerMovement.movementFinished:fire(true)
				end
			end)
			table.insert(moveToConnections, moveToConnection)
			humanoid:MoveTo(newDestination)
		end
	end
	
	function playerMovement.stop(fireSignal, source)
		clearConnections()
		require(script.Parent.signal).killThreads()
	
		local character = shared.character
		local humanoid = character and character:FindFirstChild("Humanoid") :: Humanoid
	
		if humanoid then
			humanoid:MoveTo(character.PrimaryPart.Position)
		end
	end
	
	return playerMovement
end

modules[tbl.tween] = function()
	local script = tbl.tween

	local module = {}
	
	local runService = game:GetService("RunService")
	
	local connection 
	
	module.tweenComplete = require(script.Parent.signal).new()
	
	function module.tween(cframe)
		module.stop()
		connection = runService.Heartbeat:Connect(function(delta)
			local character = shared.character
			
			
			if character then
				local primaryPart = character.PrimaryPart
				local distance = (primaryPart.Position - cframe.Position).Magnitude
				
				if distance < 5 then
					module.tweenComplete:fire()
					return module.stop()
				end
				
				primaryPart.Velocity = Vector3.new()
				primaryPart.RotVelocity = Vector3.new()
				
				character:PivotTo(primaryPart.CFrame:Lerp(cframe, runService.Heartbeat:Wait()*75/distance))
			end
		end)
	end
	
	function module.stop()
		if connection then
			connection:Disconnect()
		end
	end
	
	return module
end

modules[tbl.signal] = function()
	local script = tbl.signal

	local signal = {} 
	signal.__index = signal
	
	local signals = {}
	
	function signal.new()
		local self = {
			signalCallbacks = {},
			waitingThreads = {}
		}
		table.insert(signals, self)
	
		return setmetatable(self, signal)
	end
	
	function signal:connect(signalCallback)
		local parentSignal = self
	
		local newConnection = {
			connectionCallback = signalCallback,
			connected = false,
			fireOnce = false
		}
	
		function newConnection:disconnect()
			parentSignal.signalCallbacks[self] = nil
		end
	
		self.signalCallbacks[newConnection] = true
	
		return newConnection
	end
	
	function signal:once(signalCallback)
		local connection = self:connect(signalCallback)
	
		connection.fireOnce = true
	
		return connection
	end
	
	function signal:wait()
		local running = coroutine.running()
	
		self.waitingThreads[running] = true
	
		return coroutine.yield()
	end
	
	function signal:fire(...)
		for signalCallback in self.signalCallbacks do
			if typeof(signalCallback.connectionCallback) == "thread" then
				coroutine.resume(signalCallback.connectionCallback, ...)
			else
				signalCallback.connectionCallback(...)
			end
	
			if signalCallback.fireOnce then
				signalCallback:disconnect()
			end
		end
	
		for waitingThread in self.waitingThreads do
			self.waitingThreads[waitingThread] = nil
	
			task.spawn(waitingThread, ...)
		end
	end
	
	function signal.killThreads()
		for _, self in signals do
			for waitingThread in self.waitingThreads do
				self.waitingThreads[waitingThread] = nil
			end
		end
	end
	
	function signal:disconnectAll()
		for signalCallback in self.signalCallbacks do
			signalCallback:disconnect()
		end
	end
	
	return signal
end

modules[tbl.keyPress] = function()
	local script = tbl.keyPress

	local module = {}
	
	local vim = game:GetService("VirtualInputManager")
	
	function keypress(key)
		vim:SendKeyEvent(true, key, false, game)
	end
	
	function keyrelease(key)
		vim:SendKeyEvent(false, key, false, game)
	end
	
	function module.pressE()
		keypress(Enum.KeyCode.E)
		task.wait()
		keyrelease(Enum.KeyCode.E)
	end
	
	return module
end

modules[tbl.monsterData] = function()
	local script = tbl.monsterData

	
	local monstersData = {Spawners = {}, MonsterTypes = {}}
	local monsterSpawners = monstersData.Spawners
	for i,v in (workspace.MonsterSpawners:GetChildren()) do
		monsterSpawners[v] = {}
		monsterSpawners[v].monsterType = v.MonsterType.Value
		monsterSpawners[v].spawner = v
		if v.Name == "WerewolfCave" then
			monsterSpawners[v].territory = v.Territory.Value.w
		elseif v.Name == "MushroomBush" then
			monsterSpawners[v].territory = v.Territory.Value.Part
		else
			monsterSpawners[v].territory = v.Territory.Value
		end
	
		if not table.find(monstersData.MonsterTypes, v.MonsterType.Value) then
			table.insert(monstersData.MonsterTypes, v.MonsterType.Value)
		end
	end
	return monstersData
end

modules[tbl.getTokens] = function()
	local script = tbl.getTokens

	return function(pos, Maxdistance)
		if not pos then
			return {}
		end
		local tokenTable={}
	
		for index, token in (workspace.Collectibles:GetChildren()) do
			local distance = (pos-token.Position).Magnitude
	
			if distance <= Maxdistance then
				table.insert(tokenTable, token)
			end
		end
		return tokenTable
	end
end

modules[tbl.buffComponents] = function()
	local script = tbl.buffComponents

	local module = {}
	local replicatedStorage = game:GetService('ReplicatedStorage')
	
	local serverTime = require(replicatedStorage.OsTime)
	local timeToString = require(replicatedStorage.TimeString)
	local buffTileModule = require(replicatedStorage.Gui.TileDisplay.BuffTile)
	
	
	function module.getBuffTime(buffName, convertToHMS)
		local buff = buffTileModule.GetBuffTile(buffName)
		if not buff or not buff.TimerDur or not buff.TimerStart then 
			return 0 
		end
	
		local toReturn = buff.TimerDur - (math.floor(serverTime()) - buff.TimerStart)
		if convertToHMS then 
			toReturn = timeToString(toReturn) 
		end
	
		return toReturn
	end
	
	function module.getBuffStack(buffName)
		local buff = buffTileModule.GetBuffTile(buffName)
	
		return (buff and tonumber(buff.Combo)) or 0
	end
	
	return module
end

modules[tbl.getPlanters] = function()
	local script = tbl.getPlanters

	local planterTypes = require(game.ReplicatedStorage.PlanterTypes)
	local planters = planterTypes.GetTypes()
	
	return function()
		local t = {}
	
		for _, planter in planterTypes.GetTypes() do
			if not planter.Reusable then continue end
			local name =  _
			table.insert(t, name)
		end
	
		return t
	end
end

modules[tbl.getFieldsByColor] = function()
	local script = tbl.getFieldsByColor

	return function()
		local fields = workspace.FlowerZones:GetChildren()
		local t = {
			Red = {},
			Blue = {},
			White = {}
		}
		for _, field in fields do
			if field:FindFirstChild("ColorGroup") then
				table.insert(t[field.ColorGroup.Value], field.Name)
				continue	
			end
			
			local bestColor
			local bestMulti
			
			for color, f in t do
				local multi = field[color].Value
				if not bestColor or multi >= bestMulti then
					bestMulti = multi
					bestColor = color
				end
			end
			table.insert(t[bestColor], field.Name)
		end
		
		
		return t
	end
end

modules[tbl.planterTab] = function()
	local script = tbl.planterTab

	local autofarmTab = {}
	
	local Features = script.Parent.Parent.Features
	local components = script.Parent.Parent.components
	
	local planterFeature = require(Features.planters)
	
	local uiLibrary = require(components.linoria)
	local getPlanters = require(components.getPlanters)
	
	local planterTypes = require(game.ReplicatedStorage.PlanterTypes)
	local planters = planterTypes.GetTypes()
	
	local fields = {}
	
	local function getFields()
		for _, field in workspace.FlowerZones:GetChildren() do
			table.insert(fields, field.Name)
		end
	end
	
	local planters = getPlanters()
	
	local function createCycle(cycle, tab)
		local group = tab:AddRightGroupbox('Cycle '..cycle)
		
		group:AddToggle('Use hours'..cycle, {
			Text = "Use hours",
			Callback = function() end
		})
		
		group:AddToggle('Use percent'..cycle, {
			Text = "Use percent",
			Callback = function() end
		})
		
		group:AddDropdown('Planter'..cycle, {
			Values = planters,
			Default = 1, 
			Text = 'Planter',
			Callback = planterFeature.toggle
		})
		
		group:AddSlider('planterPercent'..cycle, {
			Text = "Planter Percent",
			Default = 50,
			Min = 1,
			Max = 100,
			Rounding = 1,
			Compact = 1,
			HideMax = false,
	
		})
		group:AddSlider('planterTime'..cycle, {
			Text = "Harvest Time",
			Default = 12,
			Min = 1,
			Max = 24,
			Rounding = 1,
			Compact = 1,
			HideMax = false,
	
		})
	end
	
	
	function autofarmTab.init(window)	
		local tab = window:AddTab("Planters")
		local mainGroupBox = tab:AddLeftGroupbox('Main')
		--local autofarmTogglesBox = tab:AddLeftGroupbox('Toggles')
		local settingsBox = tab:AddLeftGroupbox('Settings')
	
		mainGroupBox:AddToggle('Auto_Planters', {
			Text = 'Auto Planters',
			Callback = planterFeature.toggle
		})
	
		
		mainGroupBox:AddDropdown('Planter_Mode', {
			Values = {"Auto", "Manual"},
			Default = 1, 
			Text = 'Mode',
			Tooltip = "Auto mode is where the field and cycles is done automatically based on settings. Auto is for custom fields and cycles.",
			Callback = planterFeature.toggle
		})
		
		--settings
		
		settingsBox:AddToggle('harvestsmoking', {
			Text = "Don't harvest smoking planters",
			Callback = function() end
		})
		settingsBox:AddSlider('planterTimeAuto', {
			Text = "Harvest Time",
			Default = 2,
			Tooltip = "Harvest time for auto mode.",
			Min = 1,
			Max = 24,
			Rounding = 1,
			Compact = 1,
			HideMax = false,
			Callback = planterFeature.changeAutoHarvestTime
		})
	
		mainGroupBox:AddDropdown('Allowed_Planters', {
			Values = planters,
			Default = 1, 
			Text = 'Allowed Planters',
			Multi = true,
			Tooltip = "Auto mode is where the field and cycles is done automatically based on settings. Auto is for custom fields and cycles.",
			Callback = planterFeature.toggleAllowedPlanters
		})
		
		for i = 1,3 do
			createCycle(i, tab)
		end
	end
	
	return autofarmTab
end

modules[tbl.toysTab] = function()
	local script = tbl.toysTab

	local autofarmTab = {}
	
	local Features = script.Parent.Parent.Features
	local Toys = require(Features.toys)
	local Mobs = require(Features.mobs)
	local mobData = require(script.Parent.Parent.components.monsterData).MonsterTypes
	
	local fieldBoosters = {"Red Field Booster", "Blue Field Booster", "Field Booster"}
	
	function autofarmTab.init(window)	
		local tab = window:AddTab("Toys/Kill")
		local mainGroupBox = tab:AddLeftGroupbox('Main')
		local autofarmSettingsBox = tab:AddLeftGroupbox('Settings')
		local killgroupbox = tab:AddRightGroupbox('Auto Kill')
	
		mainGroupBox:AddDropdown('Toys', {
			Values = fieldBoosters,
			Multi = true,
			AllowNull = true,
			Text = 'Toys',
			Callback = Toys.changeToyEnabled
		})
		
	
		killgroupbox:AddDropdown('Monsters', {
			Values = mobData,
			Multi = true,
			AllowNull = true,
			Text = 'Monsters',
			Callback = Mobs.changeMobsEnabled
		})
		killgroupbox:AddDropdown('BabyLoveMonsters', {
			Values = mobData,
			Multi = true,
			AllowNull = true,
			Text = 'Baby Love',
			Tooltip = "Mobs to wait for baby love before killing.",
			Callback = Toys.changeToyEnabled
		})
	end
	
	return autofarmTab
end

modules[tbl.questTab] = function()
	local script = tbl.questTab

	local autofarmTab = {}
	
	local Features = script.Parent.Parent.Features
	local components = script.Parent.Parent.components
	
	local quest = require(Features.quest)
	local taskSystem = require(components.taskSystem)
	local uiLibrary = require(components.linoria)
	
	local fields = {}
	
	local function getFields()
		for _, field in workspace.FlowerZones:GetChildren() do
			table.insert(fields, field.Name)
		end
	end
	
	local npcs = {"Science Bear", "Polar Bear", "Black Bear", "Dapper Bear", "Bucko Bee", "Riley Bee", "Brown Bear", "Spirit Bear", "Mother Bear", "Onett", "Panda Bear"}
	
	function autofarmTab.init(window)
		getFields()
		
		local tab = window:AddTab("Quest")
		local mainGroupBox = tab:AddLeftGroupbox('Main')
		local autofarmTogglesBox = tab:AddLeftGroupbox('Toggles')
		
	
		mainGroupBox:AddToggle('Auto Quest', {
			Text = 'Auto Quest',
			Callback = quest.toggle
		})
		
		autofarmTogglesBox:AddDropdown('Npcs', {
			Values = npcs,
			Default = 0, 
			Text = 'Npcs',
			Callback = quest.changeNpcsEnabled,
			AllowNull = true,
			Multi = true
		})
	end
	
	return autofarmTab
end

modules[tbl.autofarmTab] = function()
	local script = tbl.autofarmTab

	local autofarmTab = {}
	
	local Features = script.Parent.Parent.Features
	local components = script.Parent.Parent.components
	
	local Autofarm = require(Features.autofarm)
	local puffshroom = require(Features.pushrooms)
	local convert = require(Features.convert)
	
	local taskSystem = require(components.taskSystem)
	local uiLibrary = require(components.linoria)
	
	local fields = {}
	
	local function getFields()
		for _, field in workspace.FlowerZones:GetChildren() do
			table.insert(fields, field.Name)
		end
	end
	
	local materials = {"Oil", "Enzymes", "Red Extract", "Blue Extract", "Super Smoothie", "Purple Potion"}
	
	function autofarmTab.init(window)
		getFields()
		
		local tab = window:AddTab("Autofarm")
		local mainGroupBox = tab:AddLeftGroupbox('Main')
		local autofarmTogglesBox = tab:AddLeftGroupbox('Toggles')
		local pushroomBox = tab:AddRightGroupbox('Puffshrooms')
		local settingsBox = tab:AddRightGroupbox('Settings')
	
		mainGroupBox:AddToggle('Autofarm', {
			Text = 'Autofarm',
			Callback = Autofarm.toggled
		})
		
		mainGroupBox:AddToggle('AutoDig', {
			Text = 'Auto Dig',
			Callback = Autofarm.autodig
		})
		
		settingsBox:AddToggle('ConvertToggle', {
			Text = 'Convert Backpack',
			Callback = convert.toggleConvert
		})
		
		mainGroupBox:AddButton({
			Text = 'gake',
			Func = function()
				game:GetService("TeleportService"):Teleport(game.PlaceId)
			end,
			DoubleClick = false,
			Tooltip = 'gake'
		})
	
		
		
		autofarmTogglesBox:AddDropdown('Field', {
			Values = fields,
			Default = 1, 
			Text = 'Field',
			Callback = Autofarm.changeField
		})
		autofarmTogglesBox:AddToggle('Bubbles', {
			Text = 'Collect Bubbles',
			Callback = Autofarm.setBubblesEnabled
		})
		autofarmTogglesBox:AddToggle('FuzzyBombs', { --	UNFINISHED
			Text = 'Get Fuzzy Bombs',
			Callback = Autofarm.setBubblesEnabled
		})
		autofarmTogglesBox:AddToggle('PreciseTargets', {
			Text = 'Get Precise Targets',
			Callback = Autofarm.setPreciseEnabled
		})
	
		autofarmTogglesBox:AddToggle('farmInMarks', {
			Text = 'Farm in Marks',
			Callback = Autofarm.setMarksEnabled
		})
		
		autofarmTogglesBox:AddToggle('farmInFlames', {
			Text = 'Farm in Flames',
			Callback = Autofarm.setFlamesEnabled
		})
		
		autofarmTogglesBox:AddToggle('dupedTokens', {
			Text = 'Farm Dupe Tokens',
			Callback = Autofarm.setDupedTokens
		})
		
		--sliders
		
		settingsBox:AddToggle('autoWalkspeed', {
			Text = 'Auto Walkspeed',
			Callback = function() end
		})
	
		settingsBox:AddSlider('walkspeedSlider', {
			Text = "Autofarm Speed",
			Default = 50,
			Min = 16,
			Max = 100,
			Rounding = 1,
			Compact = 1,
			HideMax = false,
			
		})
		
		
		--pushroom side
		
		pushroomBox:AddToggle('PuffAutofarm', {
			Text = 'Autofarm',
			Callback = Autofarm.toggled
		})
		pushroomBox:AddToggle('glitterForPuffs', {
			Text = 'Glitter high rarity puffs',
			Callback = Autofarm.toggled,
			Tooltip = 'Uses glitter in a field if a legendary or mythic pushroom is detected',
		})
		pushroomBox:AddDropdown('MaterialsForPuffs', {
			Values = materials,
			Tooltip = "Materials to use for pushrooms.",
			Default = 0, 
			Text = 'Materials',
			AllowNull = true,
			Callback = puffshroom.changeMaterials
		})
	end
	
	return autofarmTab
end

modules[tbl.autofarm] = function()
	local script = tbl.autofarm

	local autofarm = {}
	
	local replicatedStorage = game:GetService("ReplicatedStorage")
	
	local components = script.Parent.Parent.components
	
	local taskSystem = require(components.taskSystem)
	local tween = require(components.tween)
	local playerMovement = require(components.playerMovement)
	local buffComponents = require(components.buffComponents)
	
	local autofarmHelpers = require(script.helpers)
	local preciseMarkGetter = require(script.precisePathfind)
	local autofarmTaskManager = require(script.autofarmTaskManager)
	
	local collectiblesAnimate = require(replicatedStorage.CollectiblesAnimator)
	local collectModule = require(replicatedStorage.Collectors.LocalCollect)
	local preciseCrosshairsModule = require(replicatedStorage.LocalFX.LocalTargetPracticeBeam)
	
	local fields = workspace:WaitForChild("FlowerZones")
	local dupedTokens = workspace:WaitForChild("Camera"):WaitForChild("DupedTokens")
	local PlayerActiveEvent = replicatedStorage:WaitForChild("Events"):WaitForChild("PlayerActivesCommand")
	
	local player : Player = shared.localPlayer
	
	local CoreStats = player:WaitForChild("CoreStats")
	
	local backpack = {
		Pollen = CoreStats:WaitForChild("Pollen"),
		Capacity = CoreStats:WaitForChild("Capacity")
	}
	
	local tokenIndex = 1
	local preciseIndex = 1
	local lastPreciseTarget
	
	local targetToken 
	local tokens = autofarmHelpers.getCollectibles()
	local autodigThread
	
	local DEFAULT_TOKEN_DISTANCE = 75	
	local PUFFSHROOM_TOKEN_DISTANCE = 30	
	
	local autofarmTasks = {}
	local autofarmSettings = {
		field = fields["Dandelion Field"],
		autodig = false,
		doPrecise = false,
		farmDupedTokens = false,
		flames = false,
		collectBubbles = false,
		tokenDistance = DEFAULT_TOKEN_DISTANCE,
		task = {
			collectingTokens = true,
			precise = false
		},
		preciseQueue = {},
		allCrosshairs = {},
		smartAutofarms = {
			red = false,
			blue = false
		}
	}
	autofarm.config = autofarmSettings
	
	local autofarmTask 
	
	local function shouldConvertPrecise()
		local fullPercent = backpack.Pollen.Value / backpack.Capacity.Value
		
		return fullPercent >= .7
	end
	
	local function preciseTargetsDead()
		if not lastPreciseTarget then
			return true
		end
		if not lastPreciseTarget.Disk.Part.Parent or lastPreciseTarget.Disk.Activated then
			return true
		end
		return false
	end
	
	local function moveToBestMarks()
		local mark = autofarmHelpers.getMarksWithFlames()
		if mark then
			playerMovement.newDestination(mark.Position)
			playerMovement.movementFinished:wait() 
		end
	end
	
	local function shouldGetPreciseMark()
		local precionCount = buffComponents.getBuffStack("Precision")
		local precisionTime = buffComponents.getBuffTime("Precision")
			
		if precionCount < 10 then
			return false
		end
		if precisionTime < 25 then
			return false
		end
		if buffComponents.getBuffStack("Red Boost") < 10 or buffComponents.getBuffTime("Red Boost") <= 6 then
			return true
		end
		if autofarmHelpers.hasActiveScorchingStar() then
			return false -- false when not debugging
		end
	
		return true
	end
	
	local lastCrosshairAdded = time()
	local preciseCount = 0
	
	local function preciseValidator(activeCrosshairs)
	
		if #autofarmSettings.preciseQueue == 0 then
			return false
		end
		if not activeCrosshairs then
			if time() - lastCrosshairAdded < 2.5 then
				return true
			end
			table.clear(autofarmSettings.preciseQueue) table.clear(autofarmSettings.allCrosshairs) 
			return false
		end
		return true
	end
	
	local function doPreciseMarks()
		setthreadidentity(8)
	
		local activeCrosshairs = debug.getupvalue(preciseCrosshairsModule.InitBeams, 1)
		if preciseValidator(activeCrosshairs) then
			if not activeCrosshairs then return doPreciseMarks(task.wait()) end
		else
			autofarmTasks.preciseMark:stop(true)
			return false
		end
		
		local preciseParams = autofarmSettings.preciseQueue[1]	
		local preciseData = activeCrosshairs[preciseParams.id]
	
		if preciseData or not preciseData and time() - preciseParams.spawnTime >= 2.5 then
			table.remove(autofarmSettings.preciseQueue, 1)
		end
	
		if not preciseData or preciseData.Disk.Activated or preciseData.Touched or not preciseParams.ismark then
			return doPreciseMarks(task.wait()) 
		end
		preciseMarkGetter.addCrosshairHitboxes(autofarmSettings.allCrosshairs)
		local crosshairPart = preciseData.Disk.Part
		local path = preciseMarkGetter.getPath(crosshairPart)
		if not path then
			return doPreciseMarks(task.wait())
		end
		
		targetToken = crosshairPart
		
		local pathBlocked
		
		local waypoints = path:GetWaypoints()
		local c = nil; c = path.Blocked:Once(function()
			pathBlocked = true
			playerMovement.stop(true, 'blcoked')
			c = nil
			doPreciseMarks()
		end)
		autofarmTasks.preciseMark:addConnection(c)
		
		for _, waypoint in waypoints do
			if pathBlocked or not crosshairPart.Parent then
				if c then c:Disconnect() c = nil end
				return if not crosshairPart.Parent then doPreciseMarks() else nil
			end
			preciseMarkGetter.addCrosshairHitboxes(autofarmSettings.allCrosshairs)
			playerMovement.newDestination(waypoint.Position)
	 		playerMovement.movementFinished:wait()
		end
		if c then c:Disconnect() c = nil end
		
		local newCrosshair = preciseMarkGetter.searchForPurpleTargets(autofarmSettings.allCrosshairs, crosshairPart)
		if newCrosshair then
			return doPreciseMarks()
		end
		if crosshairPart.Parent then
			crosshairPart.Destroying:Wait()
		end
		
		autofarmTasks.preciseMark:stop(true)
	
		return false
	end
	
	local function doPrecise()	
		setthreadidentity(8)
		local activeCrosshairs = debug.getupvalue(preciseCrosshairsModule.InitBeams, 1)
		if preciseValidator(activeCrosshairs) then
		
			if not activeCrosshairs then return doPrecise(task.wait()), print('do precise') end
		else
			autofarmTasks.precise:stop(true)
			return false
		end
			
		
		if preciseTargetsDead() or shouldGetPreciseMark() then
			lastPreciseTarget = nil
			preciseCount = 0
		end
	
		local preciseParams = autofarmSettings.preciseQueue[1]	
		local preciseData = activeCrosshairs[preciseParams.id]
	
		if preciseData or not preciseData and time() - preciseParams.spawnTime >= 2.5 then
			table.remove(autofarmSettings.preciseQueue, 1)
		end
	
		if not preciseData or preciseData.Disk.Activated or preciseData.Touched or lastPreciseTarget and preciseData.FE ~= lastPreciseTarget.FE then
			return doPrecise(task.wait()) 
		end
	
		lastPreciseTarget = preciseData
		targetToken = preciseData.Disk.Part
		playerMovement.newDestination(targetToken.Position)
		table.remove(autofarmSettings.allCrosshairs, 1)
		preciseCount += 1
		if autofarmSettings.smartAutofarms.red and preciseCount == 3 then
			playerMovement.movementFinished:wait() 
		
			local time = game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue() / 1000 + .05
			task.wait(time)
		
			if preciseTargetsDead() then
				preciseCount = 0
				if shouldConvertPrecise() and targetToken.Parent then
					return targetToken.Destroying:Wait()
				end
				moveToBestMarks()
			end
		end
	end
	
	local function farmFlame()
		local flame = autofarmHelpers.getFlame(autofarmSettings.field, autofarmSettings.tokenDistance, autofarmSettings.puffs)
		if not flame then 
			return
		end
		if autofarmSettings.smartAutofarms.red then
			return autofarmHelpers.darkHeat(flame, autofarmSettings.field, autofarmTasks.token)
		end
		playerMovement.newDestination(flame.F.Position)
	end
	
	local function farmDupedTokens()
		for _, token in dupedTokens:GetChildren() do
			if token.FrontDecal.Texture =="http://www.roblox.com/asset/?id=5877939956" then
				playerMovement.newDestination(token.Position)
				playerMovement.movementFinished:wait() 
				task.wait(1) break
			end
		end
	end
	
	local function nextToken()
		setthreadidentity(8)
		--if not autofarmTask.running and not autofarmSettings.puffs and not  then
		--	return false
		--end
	
		if autofarmSettings.flames then
			farmFlame()
		end
		if autofarmSettings.farmDupedTokens then
			farmDupedTokens()
		end
		if #tokens == 0 then
			return autofarmHelpers.moveToRandomPos(autofarmSettings.field)
		end
		
		local target = tokens[1]
		
		table.remove(tokens, 1)
	
		if not autofarmHelpers.canGetItem(target, autofarmSettings.field, autofarmSettings.tokenDistance, autofarmSettings.puffs) then
			return nextToken() -- this causes the freeze sometimes
		end
		targetToken = target
		
		playerMovement.newDestination(targetToken.Position)
	end
	
	local function endAutofarm()
		autofarmTaskManager.pause()
		local task = autofarmTaskManager.getTask() 
		if task and task.running then
			task:stop(nil, true)
		end
		player.DevComputerMovementMode = Enum.DevComputerMovementMode.UserChoice
		player.DevTouchMovementMode = Enum.DevTouchMovementMode.UserChoice
	end
	
	
	local function startAutofarm()
		endAutofarm()
	
		player.DevComputerMovementMode = Enum.DevComputerMovementMode.Scriptable
		player.DevTouchMovementMode = Enum.DevTouchMovementMode.Scriptable
	
		tween.tween(autofarmSettings.field.CFrame)
		tween.tweenComplete:wait()
		task.wait(.5)
		PlayerActiveEvent:FireServer({Name = "Sprinkler Builder"}) -- add auto sprinkler later 
	
		autofarmTaskManager.reset()
		autofarmTaskManager.resume()
	
		autofarmTasks.token:addToQueue()
	
		while task.wait(1) do
			local pos = shared.character.PrimaryPart.Position
			local field = autofarmHelpers.posToField(pos)
			if not field or (field.Instance ~= autofarmSettings.field) then
				tween.tween(autofarmSettings.field.CFrame)
			end
		end
	end 
	
	local function autodig()
		while task.wait() do
			setthreadidentity(2)
			collectModule.Run()
		end
	end
	
	function autofarm.setField(field)
		if type(field) == 'string' then
			autofarmSettings.field = fields[field]
			return
		end
		autofarmSettings.field = field
	end
	
	function autofarm.togglePuffshrooms(value)
		autofarmSettings.puffs = value	
		autofarmSettings.tokenDistance = if value then PUFFSHROOM_TOKEN_DISTANCE else DEFAULT_TOKEN_DISTANCE
		
		if not value then
			autofarm.setField(fields[Options.Field.Value])
		end
	end
	
	function autofarm.toggled(value)
		if value then
			autofarmTask:addToQueue()
		else
			autofarmTask:stop(true, true)
		end
	end
	
	function autofarm.changeField(field)
		autofarmSettings.field = fields[field]
		
		if autofarmTask.running then
			autofarmTask:stop()
			autofarmTask:addToQueue()
		end
	end
	
	function autofarm.autodig(value)
		if not value then
			return task.cancel(autodigThread)
		end
		autodigThread = task.spawn(autodig)
	end
	
	function autofarm.setBubblesEnabled(value)
		autofarmHelpers.setExtraEnabled("bubbles", value)
	end
	
	function autofarm.setPreciseEnabled(value)
		autofarmSettings.doPrecise = value
	end
	
	function autofarm.setMarksEnabled(value)
		autofarmHelpers.markToggle(value)
	end
	
	function autofarm.setFlamesEnabled(value)
		autofarmSettings.flames = value
	end
	
	function autofarm.setDupedTokens(value)
		autofarmSettings.farmDupedTokens = value
	end
	
	local function startLoop(callback)
		targetToken = nil
	
		while true do
			local playerPos = shared.character.PrimaryPart.Position
	
			local distance = targetToken and (Vector3.new(targetToken.Position.X, playerPos.Y, targetToken.Position.Z) - playerPos).Magnitude or 0
			local humanoid = shared.character.Humanoid.WalkSpeed
			if not targetToken or not targetToken.Parent or targetToken.Transparency == 1 or distance and distance < math.max(humanoid/12, 3.25) then
				if callback() == false then return end
				local t = autofarmTaskManager.getTask() 
				if t then
					print(t.name)
				end
			end
			task.wait()
		end
	end
	
	local function startPrecise()
		startLoop(doPrecise)
	end
	
	local function startToken()
		startLoop(nextToken)
	end
	
	function autofarm.init()
		autofarmTasks = {
			token = autofarmTaskManager.new('tokens', 1, startToken),
			precise = autofarmTaskManager.new('precise', 2, startPrecise),
			preciseMark = autofarmTaskManager.new('preciseMark', 3, doPreciseMarks)
		}
		
		autofarmHelpers.init()
		autofarmTask = taskSystem.new("Autofarm", 1, startAutofarm, endAutofarm)
		
		local old = nil; old = hookfunction(preciseCrosshairsModule.Make, function(...)
			local params = ...;
	
			if params.Player == shared.localPlayer and autofarmSettings.doPrecise then
				lastCrosshairAdded = time()
				table.insert(autofarmSettings.preciseQueue, {id = params.ID, ismark = params.Mark, spawnTime = time()})
				table.insert(autofarmSettings.allCrosshairs, {id = params.ID, ismark = params.Mark})	
				if not params.Mark and not shouldGetPreciseMark() then
					autofarmTasks.precise:addToQueue()
				elseif params.Mark and shouldGetPreciseMark() then
					autofarmTasks.preciseMark:addToQueue()
				end
			end
	
			return old(...);
		end)
		autofarm.startAutofarm = startAutofarm
		autofarm.endAutofarm = endAutofarm
		
		--task.spawn(function()
		--	while task.wait(3) do
		--			printtable(autofarmTaskManager.getQueue())
				
		--	end
		--end)
	end
	
	function autofarm.changeTarget(v)
		targetToken = v
	end
	
	return autofarm
end

modules[tbl.helpers] = function()
	local script = tbl.helpers

	local module = {}
	
	local DIRECTION = Vector3.new(0, -10, 0)
	
	local RunService = game:GetService("RunService")
	
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Include
	rayParams.FilterDescendantsInstances = workspace.FlowerZones:GetChildren()
	
	local tokens = workspace.Collectibles:GetChildren()
	
	local particles = workspace:WaitForChild("Particles")
	local flamesFolder = workspace:WaitForChild("PlayerFlames")
	
	local stationManager = require(game.ReplicatedStorage.ClientScripts.Listeners.StationsListener)
	local scorchingStarManager = require(game.ReplicatedStorage.LocalFX.ScorchingStar)
	local localFlames = require(game.ReplicatedStorage.LocalFX.LocalFlames)
	
	local playerMovement = require(script.Parent.Parent.Parent.components.playerMovement)
	
	local flameids = {}
	
	local markCount = 0
	
	local extras = {
		bubbles = false,
		marks = false,
	}
	
	local function markCheck(token)
		local marks = module.getMarks()
		
		local markRaycastParams = RaycastParams.new()
		markRaycastParams.FilterDescendantsInstances = marks
		markRaycastParams.FilterType = Enum.RaycastFilterType.Include
		
		local result = workspace:Raycast(token.Position, Vector3.new(0,-10,0), markRaycastParams)
		local result2 = workspace:Raycast(token.Position, Vector3.new(0,10,0), markRaycastParams)
	
		if not result or result.Instance.Name ~= "AreaRing" then
			if not result2 or result2.Instance.Name ~= "AreaRing" then
				return false
			end
		end
		return true
	end
	
	function module.get_random_position(instance)
		local size = instance.Size;
		local position = instance.Position;
	
		local min_x = position.X - size.X / 2;
		local max_x = position.X + size.X / 2;
		local min_z = position.Z - size.Z / 2;
		local max_z = position.Z + size.Z / 2;
	
		local random_x = math.random() * (max_x - min_x) + min_x;
		local random_z = math.random() * (max_z - min_z) + min_z;
	
		return Vector3.new(random_x, position.Y, random_z);
	end
	
	function module.moveToRandomPos(field)
		playerMovement.newDestination(module.get_random_position(field))
		playerMovement.movementFinished:wait()
	end
	
	function module.getMarksWithFlames() 
		local BestFlames = 0
		local BestMark = nil
	
	
		for _, particle in (module.getMarks()) do
			local region = Region3.new(particle.Position - particle.Size / 2, particle.Position + particle.Size / 2)
			local flames = workspace:FindPartsInRegion3WithWhiteList(region, flamesFolder:GetChildren())
			local FlameAmount = #flames
	
			if FlameAmount > BestFlames then
				BestFlames = FlameAmount
				BestMark = particle
			end
		end
		return BestMark
	end
	
	function module.posToField(pos)
		return workspace:Raycast(pos, DIRECTION, rayParams)
	end
	
	function module.canGetItem(item, field, maxDistance, puffs)
		if not item.Parent then
			return false
		end
		local distance = shared.localPlayer:DistanceFromCharacter(item.Position)
		if distance > maxDistance then
			return false
		end
		
		if puffs then
			local ray = module.posToField(field.Position)
			if ray then
				field = ray.Instance
			end
		end
		
		local ray = module.posToField(item.Position)
		
		if not puffs and extras.marks and markCount >= 3 and not markCheck(item) then
			return false
		end
		
		return ray and ray.Instance.Name == field.Name
	end
	
	function module.getCollectibles()
		return tokens
	end
	
	function module.setExtraEnabled(key, value)
		extras[key] = value
	end 
	
	function module.getMarks()
		local marks = debug.getupvalue(stationManager.Actions.Activate, 1)
		local models = {}
		
		for _, mark in marks do
			table.insert(models, mark)
		end
		
		return models
	end
	
	function module.hasActiveScorchingStar()
		local activestars = debug.getupvalue(debug.getupvalue(scorchingStarManager, 1).MakeStar, 1)
		
		if not activestars then
			return false
		end
		return activestars[shared.character] ~= nil
	end
	
	local function tokenAdded(t)
		table.insert(tokens, t)
		table.sort(tokens, function(a, b)
			local ref = shared.character.PrimaryPart.Position
			return (a.Position - ref).Magnitude < (b.Position - ref).Magnitude
		end)
	end
	
	local function tokensRemoved(t)
		local exist = table.find(tokens,t)
		if exist then table.remove(tokens,exist) end
	end
	
	local function particleAdded(particle)
		if particle.Name == "Bubble" and extras.bubbles then
			table.insert(tokens, particle)
		end
	end
	
	function module.markToggle(toggle)
		extras.marks = toggle
	end
	
	function module.getFlame(field, maxDistance, puffs)
		if #flameids == 0 then
			return nil
		end
		local activeFlames = debug.getupvalue(localFlames.IncrementTicks, 4)
		
		local bestDistance, bestFlame
		local playerPos = shared.character.PrimaryPart.Position
		
		for _, id in flameids do
			local flameData = activeFlames[id]
			table.remove(flameids, _)
			
			if not flameData or not flameData.M or not module.canGetItem(flameData.F, field, maxDistance, puffs) then
				continue
			end
			local distance = (flameData.F.Position - playerPos).Magnitude
			if not bestDistance or distance < bestDistance then
				bestDistance = distance
				bestFlame = flameData
			end
		end
		return bestFlame
	end
	
	local radius = 18
	
	local function getXAndZPositions(angle)
		local x = math.cos(angle) * radius
		local z = math.sin(angle) * radius
		return x, z
	end
	local function createFlamesParts(flame, field)
	
		local fullCircle = 2 * math.pi
		local add = 1
		local p = (flame.CFrame * CFrame.new(x, 0, z)).p
		local position = Vector3.new(p.X,p.Y,p.Z)
		while true do
			local cast = module.posToField(position)
	
			if cast and cast.Instance == field then return position end
	
			task.spawn(function ()
				local angle = add * (fullCircle / add+1)
				local x, z = getXAndZPositions(angle)
				p = (flame.CFrame * CFrame.new(x, 0, z)).p
	
				position = Vector3.new(p.X,p.Y,p.Z)
			end)
			add+=1
	
			if add >= 10 or not flame or not flame.Parent then return if flame and flame.Parent then p else nil end
	
			task.wait()
		end    
	
		return position
	end
	
	function module.darkHeat(flameData, field, tokentask)
		if flameData.D then
			return
		end
		local character = shared.character
		local hrp = character.PrimaryPart
		local v = flameData.F
	
		if not hrp:FindFirstChild("BodyGyro") then
			local BodyGyro = Instance.new("BodyGyro", character.PrimaryPart)
			BodyGyro.D = 0
			BodyGyro.MaxTorque = Vector3.new(0, math.huge, 0)
		end
		local BodyGyro = hrp.BodyGyro
		
		local heartbeat = RunService.Heartbeat:Connect(function ()
			local forwardVector = (hrp.Position - v.Position).Unit
			local rightVector = forwardVector:Cross(Vector3.new(0,1,0))
			local upVector = rightVector:Cross(forwardVector)
	
			local cframe = CFrame.fromMatrix(hrp.Position, -rightVector, upVector)
			BodyGyro.CFrame = cframe
		end)
		tokentask:addConnection(heartbeat)
		
		local p = createFlamesParts(v, field)
		if not p or not v or not v.Parent then
			heartbeat:Disconnect()
			BodyGyro:Destroy()
			return
		end
	
		playerMovement.newDestination(p)
		if not playerMovement.movementFinished:wait() then return heartbeat:Disconnect() end
		heartbeat:Disconnect()
		BodyGyro:Destroy()
		if module.hasActiveScorchingStar() then
			task.wait(.5)
		--else
		--	task.wait(.1)
		end
	end
	
	function module.init()
		workspace.Collectibles.ChildAdded:Connect(tokenAdded)
		workspace.Collectibles.ChildRemoved:Connect(tokensRemoved)
		
		particles.ChildAdded:Connect(particleAdded)
		
		local oldSpawn = nil; oldSpawn = hookfunction(stationManager.Actions.Spawn, function(...)
			markCount += 1
			return oldSpawn(...)
		end)
		local oldDestroy = nil; oldDestroy = hookfunction(stationManager.Actions.Destroy, function(...)
			markCount -= 1
			return oldDestroy(...)
		end)
		
		local oldAddFlame = nil; oldAddFlame = hookfunction(localFlames.AddFlame, function(...)
			local p = {...}
			local id = p[3]
			
			table.insert(flameids, id)
			
			return oldAddFlame(...)
		end)
	end
	
	return module
end

modules[tbl.precisePathfind] = function()
	local script = tbl.precisePathfind

	local pathfinding = game:GetService("PathfindingService")
	
	local playerMovement = require(script.Parent.Parent.Parent.components.playerMovement)
	local preciseCrosshairsModule = require(game.ReplicatedStorage.LocalFX.LocalTargetPracticeBeam)
	
	local autofarmtaskmanager = require(script.Parent.autofarmTaskManager)
	
	local module = {}
	
	function module.addCrosshairHitboxes(crosshairs)
		print('making hitboxes')
		for _, params in crosshairs do
			local id = params.id
			local activeCrosshairs = debug.getupvalue(preciseCrosshairsModule.InitBeams, 1)
			if not activeCrosshairs then
				return false
			end
			local preciseData = activeCrosshairs[id]
			
			if not preciseData then
				continue
			end
			local child : Part = preciseData.Disk.Part
	
			if child:FindFirstChild("PathfindingModifierPart") then
				if preciseData.Touched then
					child.PathfindingModifierPart:Destroy()
				end
				continue
			end
			if preciseData.Touched then
				continue
			end
			if child.Color == Color3.fromRGB(119, 85, 255) then
				continue
			end
			local Part = Instance.new("Part")
			Part.Size = child.Size * 1.2
			Part.Size += Vector3.new(0,5,0)
			Part.CanCollide = false
			Part.Transparency = 0
			Part.Anchored = true
			Part.Position = child.Position
			Part.Parent = child
			Part.Name = 'PathfindingModifierPart'
	
			local modifier = Instance.new("PathfindingModifier")
			modifier.Label = "Crosshair"
			modifier.Parent = Part
		end
		return true
	end
	
	function module.searchForPurpleTargets(crosshairs, c)
		for _, params in crosshairs do
			local id = params.id
			local activeCrosshairs = debug.getupvalue(preciseCrosshairsModule.InitBeams, 1)
			if not activeCrosshairs then
				return false
			end
			local preciseData = activeCrosshairs[id]
	
			if not preciseData then
				continue
			end
			local child : Part = preciseData.Disk.Part
			--if child.Transparency > 0 then
			--	continue
			--end
			if child.Color == Color3.fromRGB(119, 85, 255) and child.Parent then
				if not c.Parent or c ~= child then
					return child
				end
			end
		end
	end
	
	function module.getPath(child)
		local path = pathfinding:CreatePath({
			AgentCanJump = false,
			AgentCanClimb = false,
			AgentHeight = 6,
			AgentRadius = 5,
			Costs = {
				Crosshair = math.huge
			},
			WaypointSpacing = math.huge -- experimental (will see if duck suicides or not)
		})
		local p = shared.character.PrimaryPart.Position
		local childp = child.Position
		local success, errorMessage = pcall(function()
			path:ComputeAsync(p, childp)
		end)
		
		return if success and path.Status == Enum.PathStatus.Success then path elseif errorMessage then warn(errorMessage) else nil
	end
	
	local function pathfind(child, crosshairs, path)
		local hitboxstatus =  addCrosshairHitboxes(crosshairs)
		if not child or not child.Parent or not hitboxstatus then
			return print(child, child.Parent, hitboxstatus)
		end
		local path : Path? = path or getPath(child)
		if not path then return print('no path') end
		print('a path exist')
		local p = shared.character.PrimaryPart.Position
		local childp = child.Position
	
		local pathBlocked 
		local preciseTask = autofarmtaskmanager.getTask()
		if not preciseTask or preciseTask.name ~= 'precise' then return print('isnt precise task', preciseTask.name) end
		local c = nil; c = path.Blocked:Once(function()
			print('path blocked')
			pathBlocked = true
			playerMovement.stop(true, 'blcoked')
			print('new pathfind')
			pathfind(child, crosshairs)
		end)
		preciseTask:addConnection(c)
		
		local waypoints = path:GetWaypoints()
		
		require(script.Parent).changeTarget(child)
		for index, waypoint in (waypoints) do
			local Part = Instance.new("Part")
			Part.Size = child.Size 
			Part.Size += Vector3.new(0,10,0)
			Part.CanCollide = false
			Part.Transparency = 0
			Part.Anchored = true
			Part.Position = waypoint.Position
			Part.Parent = child
			Part.Name = 'f'
		end   
		print('walk started')
		for index, waypoint in (waypoints) do
			if pathBlocked then
				return print('block return')
			end
			if not child or not child.Parent then
				return c:Disconnect(), print('no child or parent' ,child, child.Parent)
			end
			playerMovement.newDestination(waypoint.Position)
			print('1')
			playerMovement.movementFinished:wait() 
			print('2')
		end   
		print('walk complete')
		c:Disconnect()
		c = nil
		local newCrosshair = searchForPurpeTargets(crosshairs, child)
		local newPath = if newCrosshair then getPath(newCrosshair) else nil
		if newCrosshair and newPath then
			print('new crosshair')
			return pathfind(newCrosshair, crosshairs, newPath)
		end
		if child.Parent then
			if (shared.character.PrimaryPart.Position - child.Position).Magnitude >= 5 then
				print('distance precise')
				return pathfind(child, crosshairs)
			end
			print('destroy wait')
			child.Destroying:Wait()
			task.wait(.1)
		end
		print('exited function precise pathfind')
	end
	return module
end

modules[tbl.autofarmTaskManager] = function()
	local script = tbl.autofarmTaskManager

	-- temp bandaid
	-- temp bandaid
	-- temp bandaid
	-- temp bandaid
	-- the whole script is a temp bandaid
	local taskSystem = {}
	taskSystem.__index = taskSystem
	
	local queue = {}
	local runningTask
	
	local playerMovement = require(script.Parent.Parent.Parent.components.playerMovement)
	local tween = require(script.Parent.Parent.Parent.components.tween)
	local signal = require(script.Parent.Parent.Parent.components.signal)
	
	local dead = false
	
	local function getBestTask()
		local bestLevel = 0
		local bestTask
		for _, task in queue do
			if task.priorityLevel > bestLevel and task ~= runningTask then
				bestTask = task
				bestLevel = task.priorityLevel
			end
		end
		return bestTask
	end
	
	local function startTask(self)
		if dead then 
			return
		end
		local oldTask = runningTask
		runningTask = self --prob can remove this cus idk why theres 2 lmao
	
		if oldTask then
			oldTask:stop()
		end
		runningTask = self
		local queuePos = table.find(queue, self)
		table.remove(queue, queuePos)
		self.running = true
	
		self.mainThread = task.spawn(self.callback)
	
		
	end
	
	local function runTasks()
		local task = getBestTask()
	
		if task then
			if not runningTask or task.priorityLevel > runningTask.priorityLevel then
				startTask(task)
			end
		end
	end
	
	function taskSystem:addToQueue()	
		if table.find(queue, self) or self.running then
			return false
		end
	
		table.insert(queue, self)
	
		runTasks()
	
		return true 
	end
	
	function taskSystem:stop(taskEnded, forceCancel)
		task.spawn(function() -- new thread cus of thread identities
			if not self.running then
				return
			end
			setthreadidentity(8)
			signal.killThreads()
	
			for _, connection in self.connections do
				connection:Disconnect()
				table.remove(self.connections, _)
			end
	
			tween.stop()
			playerMovement.stop()
	
			self:killSecondaryThreads()
			if forceCancel then
				task.cancel(self.mainThread)
			end
	
			if self.endCallback then
				self.endCallback()
			end
			self.running = false
	
			if taskEnded then --task has finished mark running task as nil and run others in queue
				runningTask = nil
	
				runTasks()
			else
				if runningTask == self then --bandaid right here i forgot why its here but its important but could be better
					runningTask = nil
				end
	
				task.cancel(self.mainThread)
	
				self:addToQueue()
			end
		end)
	end
	
	function taskSystem:addConnection(connection)
		table.insert(self.connections, connection)
	end
	
	function taskSystem:killSecondaryThreads()
		for _, thread in self.secondaryThreads do
			pcall(task.cancel, thread) -- temp bandaid
		end
		table.clear(self.secondaryThreads)
		playerMovement.stop()
	end
	
	function taskSystem:addSecondaryThread(func)
		table.insert(self.secondaryThreads, task.spawn(func))
	end
	
	function taskSystem.new(name, priority, callback, endCallback)
		local self = setmetatable({}, taskSystem)
	
		self.connections = {}
		self.secondaryThreads = {}
	
		self.priorityLevel = priority
		self.name = name
		self.callback = callback
		self.endCallback = endCallback
	
		return self
	end
	
	function taskSystem.taskSystemDestroy()
		dead = true
		table.clear(queue)
		if runningTask then
			runningTask:stop(true,true)
		end
	end
	
	function taskSystem.reset()
		table.clear(queue)
		if runningTask then
			runningTask:stop(true,true)
		end
		runningTask = nil
	end
	
	function taskSystem.pause()
		dead = true
	end
	
	function taskSystem.resume()
		dead = false
	end
	
	function taskSystem.restart()
		if runningTask then
			runningTask:stop()
		end
	end
	
	function taskSystem.getQueue()
		return queue
	end
	
	function taskSystem.getTask()
		return runningTask
	end
	
	return taskSystem
end

modules[tbl.toys] = function()
	local script = tbl.toys

	local toy = {}
	
	local replicatedStorage = game:GetService("ReplicatedStorage")
	
	local components = script.Parent.Parent.components
	
	local tweenModule = require(components.tween)
	local taskSystem = require(components.taskSystem)
	local keyPress = require(components.keyPress)
	
	local toysModule = require(replicatedStorage.Activatables.Toys)
	
	local onCooldownFunc = debug.getupvalue(toysModule.ButtonEffect, 2)
	
	local toysFolder = workspace:WaitForChild("Toys")
	
	
	local toySettings = {
		toysEnabled = {["Red Field Booster"] = false, ["Blue Field Booster"] = false, ["Mountain Top Field Booster"] = false}
	}
	
	local toyTask 
	local toysToGet = {}
	
	local function getToy(toy)
		set_thread_identity(2)
	
		local canUse = onCooldownFunc(nil, toysFolder[toy])
	
		while canUse  do
			local cframe = toysFolder[toy].Platform.Position + Vector3.yAxis * 2
			tweenModule.tween(CFrame.new(cframe))
			tweenModule.tweenComplete:wait()
			set_thread_identity(8)
			keyPress.pressE()
			set_thread_identity(2)
			canUse = onCooldownFunc(nil, toysFolder[toy])
			task.wait()
		end
	end
	
	local function startGettingToys()
		for _, toy in toysToGet do
			table.remove(toysToGet, table.find(toysToGet, toy))
			getToy(toy)
			task.wait(.5)
		end
		toyTask:stop(true)
	end 
	
	local function loop()
		while task.wait(1) do
	
			for toy, enabled in toySettings.toysEnabled do
				if not enabled then
					continue
				end
				set_thread_identity(2)
	
				local canUse = onCooldownFunc(nil, toysFolder[toy])
				if not table.find(toysToGet, toy) and canUse and not toyTask.running then
					table.insert(toysToGet, toy)
					toyTask:addToQueue()
				end
			end
		end
	end
	
	function toy.toggled(value)
		if not value then
			toyTask:stop(true)
		end
	end
	
	function toy.changeToyEnabled(toy)
		toySettings.toysEnabled = Options.Toys.Value
	end
	
	function toy.init()
		toyTask = taskSystem.new("toy", 3, startGettingToys)
		
		task.spawn(loop)
	end
	
	return toy
end

modules[tbl.convert] = function()
	local script = tbl.convert

	local convert = {}
	
	local player : Player = shared.localPlayer
	
	local CoreStats = player:WaitForChild("CoreStats")
	local Pollen = CoreStats:WaitForChild("Pollen")
	local Capacity = CoreStats:WaitForChild("Capacity")
	local SpawnPos = player:WaitForChild("SpawnPos")
	
	local components = script.Parent.Parent.components
	
	local taskManager = require(components.taskSystem)
	local tweenModule = require(components.tween)
	local keyPress = require(components.keyPress)
	
	local activateButton = player.PlayerGui.ScreenGui.ActivateButton.TextBox
	
	local convertTask
	local convertToggled
	
	local function gethiveballoon()
		for _,balloon in (game.Workspace.Balloons.HiveBalloons:GetChildren()) do
			if balloon:FindFirstChild("BalloonRoot") then
				if balloon.BalloonRoot.CFrame.p.X == player.SpawnPos.Value.p.X then
					return true
				end
			end
		end
		return false
	end
	
	local function checkConvert()
		if not convertToggled then
			return
		end
		if Pollen.Value >= Capacity.Value then
			convertTask:addToQueue()
		elseif convertTask.running and Pollen.Value == 0 then
			while gethiveballoon() do
				task.wait(1)
			end
			
			task.wait(4) --will make this automatic based on when the convert trails disappear
			convertTask:stop(true, true)
		end
	end
	
	local function convertBag()
		local convertPosition = SpawnPos.Value + Vector3.new(0,0,9)
		local distance = player:DistanceFromCharacter(convertPosition.Position)
	
		while task.wait(1) or distance >= 4 do
			if activateButton.Text ~= "Stop Making Honey" then
	
				tweenModule.tween(convertPosition)
				tweenModule.tweenComplete:wait()
				task.wait(.5)
				keyPress.pressE()
			end
		end
	end
	
	function convert.toggleConvert(value)
		convertToggled = value
		if not value and convertTask.running then
			return convertTask:stop(true, true)
		end
		checkConvert()
	end
	
	function convert.init()
		convertTask = taskManager.new("convert", 9, convertBag)
		
		checkConvert()
		Pollen.Changed:Connect(checkConvert)
		Capacity.Changed:Connect(checkConvert)
	end
	
	return convert
end

modules[tbl.pushrooms] = function()
	local script = tbl.pushrooms

	local puffshroom = {}
	
	local player = shared.localPlayer
	
	local components = script.Parent.Parent.components
	
	local taskManager = require(components.taskSystem)
	local tweenModule = require(components.tween)
	local keyPress = require(components.keyPress)
	
	local puffTools = require(script.pushroomTools)
	local autofarm = require(script.Parent.autofarm)
	local rarities = require(script.rarities)
	
	local activateButton = player.PlayerGui.ScreenGui.ActivateButton.TextBox
	local puffshroomFolder = workspace:WaitForChild("Happenings"):WaitForChild("Puffshrooms")
	
	local puffTask
	local puffsEnabled = false
	local attempts = 0
	
	local puffType = {
		target = nil,
		level = nil,
		rarity = nil
	}
	
	local function doPuffs()
		if not puffTask.running then
			return
		end
		if attempts >= 10 then
			return puffTask:stop(true)
		end
		
		local target, level, rarity = puffTools.getBestPuff()
		
		if not target then
			attempts +=1
	
			task.wait(1)
			return doPuffs()
		end
		local stem = target:WaitForChild("Puffball Stem", 5)
		if not stem then
			attempts +=1
	
			task.wait(1)
			return doPuffs()
		end
	
		puffTask:killSecondaryThreads()
		
		autofarm.setField(stem)
		
		puffTask:addSecondaryThread(autofarm.startAutofarm, autofarm.endAutofarm)
		
		target.Destroying:Wait()
		local lootTime = puffTools.getAutoLootTime(level, rarity)
	
		task.wait(lootTime)
		
		doPuffs()
	end
	
	local function puffshroomAdded()
		if not puffsEnabled then
			return
		end
		puffTask:addToQueue()
	end
	
	local function puffshroomsEnding()
		autofarm.togglePuffshrooms(false)
	end
	
	
	local function startPuffs()
		attempts = 0
		autofarm.togglePuffshrooms(true)
		doPuffs()
	end
	
	function puffshroom.changeMaterials()
		
	end
	
	function puffshroom.init()
		puffTask = taskManager.new("puffshroom", 8, startPuffs, puffshroomsEnding)
		
		puffshroomFolder.ChildAdded:Connect(puffshroomAdded)
	end
	
	return puffshroom
end

modules[tbl.pushroomTools] = function()
	local script = tbl.pushroomTools

	local module = {}
	
	local RarityTable = require(script.Parent.rarities)
	
	local puffshroomFolder = workspace:WaitForChild("Happenings"):WaitForChild("Puffshrooms")
	
	function module.getRarity(puff)
		return string.split(tostring(puff), "Model")[2]
	end
	
	function module.getLevel(puff)
		repeat task.wait()  
		until not puff or puff:FindFirstChild("Puffball Top") or not puff.Parent
	
		if not puff or not puff.Parent or not puff:FindFirstChild("Puffball Top")  then
			return nil
		end    
		local text = puff["Puffball Top"].Attachment.Gui.NameRow.TextLabel.Text
		local split = string.split(text, " ")
		return tonumber(string.split(split[3], ")")[1]) or tonumber(string.split(split[4],")")[1])
	end
	
	
	function module.getBestPuff()
		local bestTarget = nil
		local BestRarity = nil
		local BestLevel = nil
	
		for index, puff in (puffshroomFolder:GetChildren()) do
			local Rarity = module.getRarity(puff)
			local Level = module.getLevel(puff)
			if not Rarity or not Level  then
				continue
			end
			if not puff or not puff.Parent then
				continue
			end
			
			local RarityLevel = RarityTable[Rarity]
			if RarityLevel == 5 or RarityLevel == 4 then
				return puff
			end
			
			if not BestLevel or Level >= BestLevel then
				BestLevel = Level
				if not BestRarity or RarityLevel >= BestRarity then
					BestRarity = RarityLevel
					bestTarget = puff
				end
			end
		end
	
		return bestTarget, BestLevel, BestRarity
	end 
	
	function module.getAutoLootTime(level, rarityLevel)
		if not rarityLevel or not level then
			return nil
		end
	
		local startTime = 5
	
		startTime += math.ceil(rarityLevel/2) +  math.ceil(level/4.5)
		return startTime
	end
	
	return module
end

modules[tbl.rarities] = function()
	local script = tbl.rarities

	return {
		["Common"] = 1,
		["Rare"] = 2,
		["Epic"] = 3,
		["Legendary"] = 4,
		["Mythic"] = 5
	}
end

modules[tbl.mobs] = function()
	local script = tbl.mobs

	local mob = {}
	
	local replicatedStorage = game:GetService("ReplicatedStorage")
	
	local components = script.Parent.Parent.components
	
	local tweenModule = require(components.tween)
	local taskSystem = require(components.taskSystem)
	local keyPress = require(components.keyPress)
	local mobData = require(components.monsterData).Spawners
	local tokens = require(components.getTokens)
	local playerMovement = require(components.playerMovement)
	
	local mobTools = require(replicatedStorage.ClientMonsterTools)
	
	local mobSettings = {
		mobsEnabled = {}
	}
	
	local mobTask 
	local mobsToKill = {}
	
	local function killMob(monsterData)
		setthreadidentity(2)
	
		local isOnCooldown = mobTools.CheckSpawnerCooldown(monsterData.spawner.Name)
		local cframe = monsterData.territory.CFrame
	
		tweenModule.tween(cframe)
		tweenModule.tweenComplete:wait()
		
		
		while not isOnCooldown  do
			local character = shared.character
			local humanoid : Humanoid = character and character:FindFirstChild("Humanoid")
			
			if humanoid then
				humanoid.Jump = true
			end
			
			isOnCooldown = mobTools.CheckSpawnerCooldown(monsterData.spawner.Name)
			task.wait(1)
		end
		
		setthreadidentity(8)
		
		task.wait(1)
		local pos = shared.character and shared.character.PrimaryPart
		local tokens = tokens(pos.Position, 60)
		
		for _, token in tokens do
			if not token.Parent then continue end
			playerMovement.newDestination(token.Position)
			if not playerMovement.movementFinished:wait() then return end
		end
	end
	
	local function startGettingMobs()
		for _, mob in mobsToKill do
			table.remove(mobsToKill, _)
			killMob(mob)
			task.wait(.5)
		end
		table.clear(mobsToKill)
		print('end mob')
		mobTask:stop(true)
	end 
	
	local function loop()
		while task.wait(1) do
			set_thread_identity(2)
	
			for spawner, monsterData in mobData do
				local enabled = Options.Monsters.Value[monsterData.monsterType]
				
				if not enabled then
					continue
				end
	
				local isOnCooldown = mobTools.CheckSpawnerCooldown(monsterData.spawner.Name)
				if not table.find(mobsToKill, monsterData) and not isOnCooldown and not mobTask.running then
					table.insert(mobsToKill, monsterData)
				end
			end
			if #mobsToKill > 0 then
				mobTask:addToQueue()
			end
			set_thread_identity(8)
		end
	end
	
	function mob.addMob(mobType, count, addToQueue)
		set_thread_identity(2)
	
		local x = 0
		for spawner, monsterData in mobData do
			if x > count then
				break
			end
			
			local enabled = monsterData.monsterType == mobType
			if not enabled then
				continue
			end
			
			local isOnCooldown = mobTools.CheckSpawnerCooldown(monsterData.spawner.Name)
			if not table.find(mobsToKill, monsterData) and not isOnCooldown and not mobTask.running then
				x += 1
				table.insert(mobsToKill, monsterData)
			end
		end
	end
	
	function mob.toggled(value)
		if not value then
			mobTask:stop(true)
		end
	end
	
	function mob.getMobsInQueue()
		return mobsToKill	
	end
	
	function mob.changeMobsEnabled()
		mobSettings.mobsEnabled = Options.Monsters.Value
	end
	
	function mob.init()
		mobTask = taskSystem.new("mobs", 4, startGettingMobs)
		mob.start = startGettingMobs
		
		task.spawn(loop)
	end
	
	return mob
end

modules[tbl.quest] = function()
	local script = tbl.quest

	local quest = {}
	
	local components = script.Parent.Parent.components
	
	local taskSystem = require(components.taskSystem)
	local tween = require(components.tween)
	local playerMovement = require(components.playerMovement)
	local keyPress = require(components.keyPress)
	
	local replicatedStorage = game:GetService("ReplicatedStorage")
	
	local clientStatCache = require(replicatedStorage.ClientStatCache)
	local questModule = require(replicatedStorage.Quests)
	
	local npcContainer = workspace:WaitForChild("NPCs")
	
	local questSettings = {
		npcsEnabled = nil,
	}
	local questTask 
	
	local function resetSettings()
		
	end
	
	local function getTasks(bear)
		local activeTasks = {}
		local stats = clientStatCache:Get()
		local activeQuest= stats.Quests.Active
		set_thread_identity(2)
	
	
		for index, data in (activeQuest) do
			local questName = data.Name
			local questData = questModule:Get(questName)
			if questData then
				if questData.NPC ~= bear then
					continue
				end
	
				local Task = questData.Tasks
				local progress = questModule:Progress(questName, stats)
	
				if progress then
					for index, taskData in (Task) do
						if progress[index][1] < 1 then
							table.insert(activeTasks, taskData)
						end
					end
				end
			end
		end
		set_thread_identity(8)
	
		return activeTasks
	end
	
	local function talkToNpc(npc)
		local platform = npcContainer[npc].Platform
		local npcButton = shared.localPlayer.PlayerGui.ScreenGui.NPC
		while not npcButton.Visible do
			local goalCFrame = CFrame.new(platform.Position + Vector3.new(0,5,0))
			tween.tween(goalCFrame)
			tween.tweenComplete:wait()
			keyPress.pressE()
			task.wait(.1)
		end
	
		setthreadidentity(2)
		while npcButton.Visible do
			firesignal(npcButton.ButtonOverlay.MouseButton1Click)
	
	
			task.wait(.1)
		end
		if #getTasks(npc) == 0 then
			return talkToNpc(npc)
		end
	end
	
	local function waitForTaskComplete(taskData, npc) --complex way to see if complete
		while task.wait(.5) do
			local tasks = getTasks(npc)
			local taskExist = false
			
			for _, task in tasks do
				if task == taskData then
					taskExist = true
					break
				end
			end
			if not taskExist then
				return
			end
		end
	end
	
	local function doTask(npc, tasks)
		local inCompatiableQuest 
		for _, taskData in tasks do
			local taskModule = if script:FindFirstChild(taskData.Type) then require(script[taskData.Type]) else nil
			if not taskModule then
				inCompatiableQuest = true
				continue
			end
			taskModule.startTask(taskData, questTask)
			waitForTaskComplete(taskData, npc)
			
			questTask:killSecondaryThreads()
		end
		
		if inCompatiableQuest then
			questTask:stop(true)
		end
	end
	
	local function startQuest()
		if not questSettings.npcsEnabled then
			return questTask:stop(true)
		end
		for npc, value in questSettings.npcsEnabled do
			if not value then
				continue
			end
			local npcTasks = getTasks(npc)
			if #npcTasks == 0 then
				talkToNpc(npc)
			end
			doTask(npc, npcTasks)
		end
		startQuest(task.wait())
	end
	
	function quest.init()
		questTask = taskSystem.new("Quest", 2, startQuest)
	end
	
	function quest.changeNpcsEnabled(t)
		questSettings.npcsEnabled = t
		if questTask.running then
			questTask:stop()
		end
	end
	
	function quest.toggle(value)
		if value then
			questTask:addToQueue()
		else
			questTask:stop(true, true)
			resetSettings()
		end
	end
	
	return quest
end

modules[tbl.Collect_Pollen] = function()
	local script = tbl.Collect_Pollen

	local module = {}
	
	local autofarm = require(script.Parent.Parent.autofarm)
	
	local colorsField = {
		Red = "Pepper Patch",
		Blue = "Pine Tree Forest",
		White = "Spider Field"
	}
	
	local function getField(taskData)
		if taskData.Zone then
			return taskData.Zone
		end
		if taskData.Color then
			return colorsField[taskData.Color]
		end
		return Options.Field.Value
	end
	
	function module.startTask(taskData, questTask)
		local field = getField(taskData)
	
		autofarm.setField(field)
		questTask:addSecondaryThread(autofarm.startAutofarm, autofarm.endAutofarm)
	end
	
	return module
end

modules[tbl.Defeat_Monsters] = function()
	local script = tbl.Defeat_Monsters

	local module = {}
	
	local autofarm = require(script.Parent.Parent.autofarm)
	local mobKiller = require(script.Parent.Parent.mobs)
	
	function module.startTask(taskData, questTask)
		autofarm.setField(Options.Field.Value)
		questTask:addSecondaryThread(autofarm.startAutofarm, autofarm.endAutofarm)
		while true do
			mobKiller.addMob(taskData.MonsterType, taskData.Amount, true)
			task.wait(1)
		end
	end
	
	return module
end

modules[tbl.Collect_Tokens] = function()
	local script = tbl.Collect_Tokens

	local module = {}
	
	local autofarm = require(script.Parent.Parent.autofarm)
	
	local colorsField = {
		['Sunflower Seed'] = "Sunflower Field",
		['Blueberry'] = "Pine Tree Forest",
		['Strawberry'] = "Strawberry Field",
		['Pineapple'] = "Pineapple Patch"
	}
	
	local function getField(taskData)
		if colorsField[taskData.Tag] then
			return colorsField[taskData.Tag]
		end
		return Options.Field.Value
	end
	
	function module.startTask(taskData, questTask)
		local field = getField(taskData)
	
		autofarm.setField(field)
		questTask:addSecondaryThread(autofarm.startAutofarm, autofarm.endAutofarm)
	end
	
	return module
end

modules[tbl.Collect_Goo] = function()
	local script = tbl.Collect_Goo

	local module = {}
	
	local autofarm = require(script.Parent.Parent.autofarm)
	
	local colorsField = {
		Red = "Pepper Patch",
		Blue = "Pine Tree Forest",
		White = "Spider Field"
	}
	
	local function getField(taskData)
		if taskData.Zone then
			return taskData.Zone
		end
		if taskData.Color then
			return colorsField[taskData.Color]
		end
		return Options.Field.Value
	end
	
	function module.startTask(taskData, questTask)
		local field = getField(taskData)
	
		autofarm.setField(field)
		questTask:addSecondaryThread(autofarm.startAutofarm, autofarm.endAutofarm)
	end
	
	return module
end

modules[tbl.planters] = function()
	local script = tbl.planters

	local planter = {}
	
	local replicatedStorage = game:GetService("ReplicatedStorage")
	
	local player = shared.localPlayer
	
	local components = script.Parent.Parent.components
	
	local taskManager = require(components.taskSystem)
	local tweenModule = require(components.tween)
	local keyPress = require(components.keyPress)
	local buffComponents = require(components.buffComponents)
	local getPlanters = require(components.getPlanters)
	local fieldByColor = require(components.getFieldsByColor)()
	
	local nectarTypes = require(replicatedStorage.NectarTypes).GetTypes()
	local planterTypes = require(replicatedStorage.PlanterTypes).GetTypes()
	local localPlanters = require(replicatedStorage.LocalPlanters)
	
	local planterCollectEvent = replicatedStorage.Events.PlanterModelCollect
	local planterPlaceEvent = replicatedStorage.Events.PlayerActivesCommand
	
	local blockedFields = {"Ant Field", 'White Brick Field', 'Red Brick Field', 'Blue Brick Field', 'Hub Field'}
	
	local planterTask
	local lastHarvest = time()
	
	local planterConfig = {
		enabled = false,
		mode = 'Auto',
		allowedPlanters = {},
		nectarData = {},
		harvestTimeAuto = 2 * 3600
	}
	local nectars = {"Satisfying Nectar", "Motivating Nectar", "Refreshing Nectar", "Invigorating Nectar", "Comforting Nectar"}
	local degradingFields = {}
	
	local function getNectarTimes()
		local t = {}
		for nectar, data in nectarTypes do
			t[nectar.. " Nectar"] = buffComponents.getBuffTime(nectar.." Nectar")
		end
		return t
	end
	
	local function sortNectars(a, b)
		local nectar1 = planterConfig.nectarData[a]
		local nectar2 = planterConfig.nectarData[b]
		local nectarTimes = getNectarTimes()
	
		local nectar1AtMin = nectarTimes[a] >= nectar1.minHour
		local nectar2AtMin = nectarTimes[b] >= nectar2.minHour
	
		if nectar1AtMin ~= nectar2AtMin then
			return not nectar1AtMin
		end
	
		return nectar1.priority < nectar2.priority
	end
	
	
	local function nectarsLeveledOut() --basically all nectars are at ther min level or they are close to each other (ex: sat: 15hr, mot: 14hr, comf:15hr) all close to eachother!
		local nectarTimes = getNectarTimes()
		
		for _, nectar in nectars do
			local lastNectar = nectars[_-1] or nectars[5]
			
			local targetNectarTime = nectarTimes[nectar]
			local nextNectarTime = nectarTimes[lastNectar]
			
			local hoursApart = math.abs(targetNectarTime - nextNectarTime)
			local atMin = targetNectarTime >= planterConfig.nectarData[nectar].minHour
	
			if hoursApart > 2 and not atMin then
				return false
			end
		end
		return true
	end
	
	local function anectarBelowMin()
		local nectarTimes = getNectarTimes()
		for _, nectar in nectars do
	
			local targetNectarTime = nectarTimes[nectar]
	
			local atMin = targetNectarTime >= planterConfig.nectarData[nectar].minHour
	
			if not atMin then
				return true
			end
		end
		return false
	end
	
	local function getPlanterCountForNectar(currentPlanterCount, priority, time, minTime)
		if nectarsLeveledOut() then
			return 1
		end
	
		if time >= minTime then
			return (currentPlanterCount < 2) and 0 or 1
		end
	
		local timeRatio = time / minTime
	
		if priority <= 2 then
			if timeRatio <= 0.25 then return 3 end
			if timeRatio <= 0.5 then return 3 end
			return 2
		end
	
		if priority >= 3 then
			if timeRatio <= 0.25 then return 2 end
			if timeRatio <= 0.5 then return 2 end
			return 1
		end
	
		return (priority <= 2) and 2 or 1
	end
	
	
	local function fieldToColor(field)
		for color, fields in fieldByColor do
			if table.find(fields, field) then
				return color
			end
		end
	end
		
	
	local function fieldToPlanter(field, chosenPlanters)
		for _, planter in getPlanters() do
			if not planterConfig.allowedPlanters[planter] or table.find(chosenPlanters, planter) then
				continue
			end
			
			local planterGrowthData = planterTypes[planter].GrowthMultipliers
			if planterGrowthData.Zones and table.find(planterGrowthData.Zones, field) then
				return planter
			end
			if planterGrowthData.Colors then
				for color, multi in planterGrowthData.Colors do
					local fieldColor = fieldToColor(field)
					
					if multi > 1 and fieldColor == color then
						return planter
					end
				end
			end
		end
		
		--didnt find a planter? lets return a random one!
		
		for planter, value in planterConfig.allowedPlanters do
			if value and not table.find(chosenPlanters, planter) then
				return planter
			end
		end
	end
	
	local function nectarToFields(nectar)
		for nectarType, data in nectarTypes do
			if string.find(nectar, nectarType) then
				return data.Fields
			end
		end
	end
	
	local function getFieldAndPlanter(nectar, chosenFields, chosenPlanters, ignoreDegrade)
		local possibleFields = nectarToFields(nectar)
		
		for _, field in possibleFields do
			if table.find(chosenFields, field) or table.find(blockedFields, field) or degradingFields[field] and not ignoreDegrade then
				continue
			end
			local planter = fieldToPlanter(field, chosenPlanters)
			if planter then
				return field, planter
			end
		end
		--didnt find any redoing and ignoring degrade
		return getFieldAndPlanter(nectar, chosenFields, chosenPlanters, true)
	end
	
	local function getPlanters()
		table.sort(nectars, sortNectars)
		local nectarTimes = getNectarTimes()
		local planters = {}
		
		local chosenFields = {}
		local chosenPlanters ={}
		
		for _, nectar in nectars do
			local nectarData = planterConfig.nectarData[nectar]
			if not nectarData.enabled then continue end
			
			local time = nectarTimes[nectar]
			local planterCount = getPlanterCountForNectar(#planters, _, time, nectarData.minHour)
		
			if planterCount > 0 then
				for i = 1, planterCount do
					local field, planter = getFieldAndPlanter(nectar, chosenFields, chosenPlanters)	
				
					table.insert(chosenFields, field)
					table.insert(chosenPlanters, planter)
					
					table.insert(planters, {
						field = field,
						planter = planter
					})
					
					degradingFields[field] = 1
					
					if #planters == 3 then
						return planters
					end
				end
			end
		end
		return planters
	end
	
	local function lootPlanter()
		local character = shared.character
		local tokens = require(components.getTokens)(character.PrimaryPart.Position, 35)
		local playerMovement = require(components.playerMovement)
		
		for _, token in tokens do
			if token.Parent then
				playerMovement.newDestination(token.Position)
				playerMovement.movementFinished:wait()
			end
		end
	end
	
	local function harvestAll()
		local loadPlanterFunc = localPlanters.LoadPlanter
		local PlanterTable = debug.getupvalues(loadPlanterFunc)[4]
	
		for k, v in (PlanterTable) do
			if v.PotModel and v.IsMine then
				local Position = v.Pos
				local CFrame = CFrame.new(Position)
				local planter_string = tostring(v.PotModel)
				
				tweenModule.tween(CFrame)
				tweenModule.tweenComplete:wait()
				
				planterCollectEvent:FireServer(v.ActorID)
				task.wait(2)
				lootPlanter()
			end
		end
	end
	
	local function placePlanterInField(planter, field)
		local fieldCFrame = workspace.FlowerZones[field].CFrame
		tweenModule.tween(fieldCFrame)
		tweenModule.tweenComplete:wait()
		task.wait(1)
		planterPlaceEvent:FireServer({["Name"] = planter})
	end
	
	local function doAutoPlanters()
		local planters = getPlanters()
		printtable(planters)
		for _, data in planters do
			placePlanterInField(data.planter.." Planter", data.field)
			print(data.planter, data.field)
			task.wait(.5)
		end
		for field, cycle in degradingFields do
			if cycle+1 > 3 then
				degradingFields[field] = nil
				continue
			end
			degradingFields[field] += 1
		end
	end
	
	local function doManualPlanters()
	
	
	end
	
	local function startPlanters()
		harvestAll()
		
		doAutoPlanters()
		
		lastHarvest = time()
		
		planterTask:stop(true)
	end
	
	function planter.changeAutoHarvestTime(value)
		planterConfig.harvestTimeAuto = value * 3600
	end
	
	function planter.toggle(value)
		planterConfig.enabled = value
		if value then
			planterTask:addToQueue()
		end
	end
	
	function planter.toggleAllowedPlanters(value)
		planterConfig.allowedPlanters = value
		
	end
	
	local function loop()
		while task.wait(1) do
			if (time() - lastHarvest) >= planterConfig.harvestTimeAuto * 3600 and planterConfig.enabled then
				planterTask:addToQueue()
			end
		end
	end
	
	function planter.init()
		for _, nectar in nectars do
			planterConfig.nectarData[nectar] = {
				priority = math.random(1,5),
				enabled = true,
				minHour = 18 * 3600,
			}
		end
		--local nectars = {"Satisfying Nectar", "Motivating Nectar", "Refreshing Nectar", "Invigorating Nectar", "Comforting Nectar"}
	
		--temporily til i add fuckinng ui lol
		planterConfig.nectarData['Invigorating Nectar'].enabled = false
		planterConfig.nectarData['Comforting Nectar'].priority = 1
		planterConfig.nectarData['Satisfying Nectar'].priority = 2
		planterConfig.nectarData['Refreshing Nectar'].priority = 3
		planterConfig.nectarData['Motivating Nectar'].priority = 1
	
		printtable(planterConfig.nectarData)
		
		planterTask = taskManager.new("planter", 9, startPlanters)	
		task.spawn(loop)	
	end
	
	return planter
end

task.spawn(function()
	local script = tbl.bee_swarm_simulator

	if not game:IsLoaded() then
		game.Loaded:Wait()
	end
	
	local components = script.components
	local tabs = script.tabs
	local features = script.Features
	
	local library = require(components.linoria)
	local tween = require(components.tween)
	local keypress = require(components.keyPress)
	
	local players = game:GetService("Players")
	local hives = workspace.Honeycombs:GetChildren()
	
	local Window = library:CreateWindow({
		Title = 'Starlight v2',
		Center = true,
		AutoShow = true,
		TabPadding = 8,
		MenuFadeTime = 0.2
	})
	
	local function loadTabs()
		for _, module in tabs:GetChildren() do
			require(module).init(Window)
		end
	end
	
	local function loadFeatures()
		for _, module in features:GetChildren() do
			require(module).init()
		end
	end
	
	local function autofarmWalkspeed()
		if not Options.walkspeedSlider.Value then
			return
		end
		local speed = Options.walkspeedSlider.Value
		local humanoid = shared.character.Humanoid
		if humanoid.WalkSpeed == speed then
			return
		end
		humanoid.WalkSpeed = speed
	end
	
	function PrintTable(t, indent)
		indent = indent or 0
		local prefix = string.rep("  ", indent)
		for key, value in pairs(t) do
			if type(value) == "table" then
				print(prefix .. tostring(key) .. ":")
				PrintTable(value, indent + 1)
			else
				print(prefix .. tostring(key) .. ": " .. tostring(value))
			end
		end
	end
	
	getgenv().printtable = PrintTable
	
	shared.localPlayer = players.LocalPlayer
	shared.character = players.LocalPlayer.Character or players.LocalPlayer.CharacterAdded:Wait()
	
	players.LocalPlayer.CharacterAdded:Connect(function(character)
		shared.character = character
		autofarmWalkspeed()
		character:WaitForChild("Humanoid"):GetPropertyChangedSignal("WalkSpeed"):Connect(autofarmWalkspeed)
	end)
	
	players.LocalPlayer.CharacterRemoving:Connect(function(character)
		players.LocalPlayer.CharacterAdded:Wait()
		task.wait(1)
		require(script.components.taskSystem).restart()
	end)
	
	while not shared.localPlayer:FindFirstChild("Honeycomb") do
		for i = #hives, 1, -1 do
			local hive = game.Workspace.Honeycombs:GetChildren()[i]
			if hive.Owner.Value == shared.localPlayer or hive.Owner.Value == shared.localPlayer.Name or shared.localPlayer:FindFirstChild("Honeycomb") then
				break
			end
			if hive.Owner.Value == nil then
				tween.tween(hive.SpawnPos.Value)
				task.wait(.5)
				keypress.pressE()
	
				break        
			end
		end
	end
	
	loadFeatures()
	loadTabs()
	
	local vu = cloneref(game:GetService("VirtualUser"))
	shared.localPlayer.Idled:Connect(function()
	    vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
		task.wait(1)
		vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	end)
	shared.character:WaitForChild("Humanoid"):GetPropertyChangedSignal("WalkSpeed"):Connect(autofarmWalkspeed)
end)
