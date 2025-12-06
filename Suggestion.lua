--#Made by Trick/Curse
--#Crediting Cao Mod also.
--#Script made by Curse
--GUI made by Trick

-- DO NOT DELETE THIS. IF YOU DELETE THIS THIS SCRIPT WILL NOT WORK!! --
local DictionaryURL = "https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt"

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Nigga"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 380, 0, 430)
Main.Position = UDim2.new(0.5, -190, 0.5, -215)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 16)

-- Gradient Part --
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
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "Trick/Curse Word Suggestion"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 19
Title.TextXAlignment = Enum.TextXAlignment.Left

local Box = Instance.new("TextBox", Main)
Box.Size = UDim2.new(1, -20, 0, 40)
Box.Position = UDim2.new(0, 10, 0, 60)
Box.BackgroundColor3 = Color3.fromRGB(80, 20, 120)
Box.TextColor3 = Color3.fromRGB(255, 255, 255)
Box.TextSize = 18
Box.PlaceholderText = "Type shortcutted things okay?"
Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 8)

local List = Instance.new("ScrollingFrame", Main)
List.Size = UDim2.new(1, -20, 1, -120)
List.Position = UDim2.new(0, 10, 0, 110)
List.BackgroundTransparency = 0.5
List.BackgroundColor3 = Color3.fromRGB(60, 0, 100)
List.ScrollBarThickness = 8
List.AutomaticCanvasSize = Enum.AutomaticSize.Y

local UIList = Instance.new("UIListLayout", List)
UIList.Padding = UDim.new(0, 6)
UIList.SortOrder = Enum.SortOrder.LayoutOrder

-- Load words (This a extra word test, dw) --
local Words = {}
local ExtraWords = {"bruh","yeet","pog","sus","lol","noob","cool","wow","game","play","curse","trick","haunt","ghost","spooky"}

-- Rlly? Do I have to explain this? --
task.spawn(function()
    local data = game:HttpGet(DictionaryURL)
    for word in data:gmatch("%S+") do
        table.insert(Words, word:lower())
    end
end)

-- Clear when you delete text on textbox --
local function Clear()
    for _,v in ipairs(List:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
end

-- Suggestion Button Part --
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
    for _,w in ipairs(ExtraWords) do
        if w:sub(1,#lower) == lower then
            table.insert(possible, w)
        end
    end

    local count = 0
    for _,w in ipairs(possible) do
        count += 1
        local B = Instance.new("TextButton", List)
        B.Size = UDim2.new(1, -10, 0, 32)
        B.BackgroundColor3 = Color3.fromRGB(100, 30, 160)
        B.TextColor3 = Color3.fromRGB(255, 255, 255)
        B.TextSize = 15
        B.Font = Enum.Font.Gotham
        B.Text = w
        Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)
        B.MouseButton1Click:Connect(function()
            Box.Text = w
            Clear()
        end)
        if count >= 100 then break end -- Change the 100 to a amount of numbers to break the word, don't add too much numbers or it will break! --
    end

    List.CanvasSize = UDim2.new(0,0,0,UIList.AbsoluteContentSize.Y + 10)
end

-- Detects typing --
Box:GetPropertyChangedSignal("Text"):Connect(function()
    Suggest(Box.Text)
end)
