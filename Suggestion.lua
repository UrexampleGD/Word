--#Made by Trick/Curse
--#Crediting Cao Mod also.
--#Script made by Curse
--#GUI made by Trick

-- DO NOT DELETE THIS. IF YOU DELETE THIS THIS SCRIPT WILL NOT WORK!! --
local DictionaryURL = "https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt"

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Nigga"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 300, 0, 240)
Main.Position = UDim2.new(0.5, -150, 0.5, -120)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- Gradientation Part --
local Gradient = Instance.new("UIGradient", Main)
Gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(50,0,80)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120,0,200)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(70,0,150))
}
Gradient.Rotation = 45

local stroke = Instance.new("UIStroke", Main)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(200, 100, 255)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -20, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "Trick/Curse Word Suggestion"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local Box = Instance.new("TextBox", Main)
Box.Size = UDim2.new(1, -20, 0, 30)
Box.Position = UDim2.new(0, 10, 0, 40)
Box.BackgroundColor3 = Color3.fromRGB(80, 20, 120)
Box.TextColor3 = Color3.fromRGB(255, 255, 255)
Box.TextSize = 14
Box.PlaceholderText = "Type shortcutted things okay?"
Box.ClearTextOnFocus = false
Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 8)

local List = Instance.new("ScrollingFrame", Main)
List.Size = UDim2.new(1, -20, 1, -80)
List.Position = UDim2.new(0, 10, 0, 75)
List.BackgroundTransparency = 0.5
List.BackgroundColor3 = Color3.fromRGB(60, 0, 100)
List.ScrollBarThickness = 6
List.AutomaticCanvasSize = Enum.AutomaticSize.Y

local UIList = Instance.new("UIListLayout", List)
UIList.Padding = UDim.new(0, 4)
UIList.SortOrder = Enum.SortOrder.LayoutOrder

local Words = {}

-- This is for hat URL inside data, where words are there. --
task.spawn(function()
	local data = game:HttpGet(DictionaryURL)
	for word in data:gmatch("%S+") do
		table.insert(Words, word:lower())
	end
end)

-- Will clear the buttons after you deleted text in box --
local function Clear()
	for _,v in ipairs(List:GetChildren()) do
		if v:IsA("TextButton") then v:Destroy() end
	end
end

-- Shuffle, randomized. --
local function Shuffle(t)
	for i = #t, 2, -1 do
		local j = math.random(1,i)
		t[i], t[j] = t[j], t[i]
	end
end

-- Word Suggestion Part --
local function Suggest(prefix)
	Clear()
	if #prefix < 1 then return end
	local lower = prefix:lower()
	local possible = {}

	for _,w in ipairs(Words) do
		if w:sub(1,#lower) == lower then
			table.insert(possible, w)
		end
	end

	if #possible == 0 then return end

	Shuffle(possible)

	local amount = 0
	for _,w in ipairs(possible) do
		amount += 1
		local B = Instance.new("TextButton", List)
		B.Size = UDim2.new(1, -8, 0, 26)
		B.BackgroundColor3 = Color3.fromRGB(100, 30, 160)
		B.TextColor3 = Color3.fromRGB(255, 255, 255)
		B.TextSize = 14
		B.Font = Enum.Font.Gotham
		B.Text = w
		Instance.new("UICorner", B).CornerRadius = UDim.new(0, 6)

		B.MouseButton1Click:Connect(function()
			Box.Text = w
			Clear()
		end)

		if amount >= 70 then break end -- Change the 50 but dont add too high or it will break --
	end

	List.CanvasSize = UDim2.new(0,0,0,UIList.AbsoluteContentSize.Y + 8)
end

-- Functional Detection --
Box:GetPropertyChangedSignal("Text"):Connect(function()
	Suggest(Box.Text)
end)

