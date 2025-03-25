local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Window = Fluent:CreateWindow({
    Title = "[🧟] Sovereign",
    SubTitle = "Dead Rails",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "locate" }),
    Visual = Window:AddTab({ Title = "Visual", Icon = "eye" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "box" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

local Items = workspace:WaitForChild("RuntimeItems")
local Highlight = Instance.new("Highlight")

function createESP(obj,color)
	if not obj then return warn("No objects specified.") end
	local esp = Instance.new("Highlight",obj)
	esp.FillColor = color
	esp.OutlineColor = color
end

function clearESP(parent)
	for _,v in ipairs(parent:GetDescendants()) do
		if v:IsA("Highlight") then
			v:Destroy()
		end
	end
end

function refreshESP()
	clearESP(Items)
	for _, item in ipairs(Items:GetDescendants()) do
		if item:IsA("Model") then
			createESP(item,Color3.fromRGB(255,0,255))
		end
	end
end

function UpdateESP()
	while true do
		refreshESP()
		wait(2)
	end
end

do
    Fluent:Notify({
        Title = "[🧟] Sovereign Loaded.",
        Content = "Dead rails script by @.spctrzz on dc:3",
        SubContent = "@ DevTest 1.1.0",
        Duration = 5
    })

    Tabs.Main:AddButton({
        Title = "Noclip",
        Description = "Makes you go through walls. (creds to inf yield)",
        Callback = function()
            local player = game:GetService("Players").LocalPlayer
            local character = player.Character
            local root = character:WaitForChild("HumanoidRootPart")
            local runservice = game:GetService("RunService")

            local function NoclipLoop()
                for _, child in pairs(character:GetDescendants()) do
                    if child:IsA("BasePart") and child.CanCollide == true then
                	child.CanCollide = false
                    end
                end
            end

            Noclipping = runservice.Stepped:Connect(NoclipLoop)
        end
    })

    Tabs.Main:AddButton({
        Title = "AntiVoid",
        Description = "Anti void, if you fall into the void you'll get bounced back up. (creds to inf yield)",
        Callback = function()
            local player = game:GetService("Players").LocalPlayer
            local character = player.Character
            local root = character:WaitForChild("HumanoidRootPart")
            local runservice = game:GetService("RunService")

            local maxFallDistance = 26
            local gameMaxFallDistance = workspace.FallenPartsDestroyHeight
            local antiVoid = runservice.RenderStepped:Connect(function()
	            if root and root.Position.Y <= gameMaxFallDistance + 25 then
		            root.Velocity = root.Velocity + Vector3.new(0,300,0)
	            end
            end)
        end
    })

    Tabs.Visual:AddButton({
        Title = "Train Esp",
        Description = "Allows you to see the train behind walls.",
        Callback = function()
            local train = workspace:FindFirstChild("Train")
            local esp = Instance.new("Highlight",train)

            esp.FillTransparency = 0.75
        end
    })

    Tabs.Visual:AddButton({
        Title = "Item ESP",
        Description = "Allows you to see items behind walls.",
        Callback = function()
            UpdateESP()
        end
    })

    Tabs.Visual:AddButton({
        Title = "Fullbright",
        Description = "Allows you to see in the darkness. (creds to inf yield)",
        Callback = function()
            local function brightFunc()
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
                Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            end

            brightLoop = RunService.RenderStepped:Connect(brightFunc)
        end
    })

    Tabs.Misc:AddButton({
        Title = "Rejoin",
        Description = "Rejoin into the same server and game.",
        Callback = function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId)
        end
    })
end

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("Sovereign")
SaveManager:SetFolder("Sovereign/DeadRails")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

SaveManager:LoadAutoloadConfig()
