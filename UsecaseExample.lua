local Class = require(game.ServerScriptService.ClassSystem)
local Complex = require(game.ServerScriptService.ComplexClass)
local C, R, I, toComplex, approxEq = Complex.getHelpers()


local function F(z, c)
	return C(math.abs(z.R),math.abs(z.I))^2 + c
end
local t=0
for x = -200, 200 do
	for y = -200, 200 do
		t = t + 1
		local c = C(x / 100, y / 100)
		local Z = C(0, 0)
		local max = 100
		for i = 0, 100 do
			Z = F(Z, c)
			if Z.abs > 2 then
				max = i
				break
			end
		end
		if t >= 3000 then
			task.wait()
			t = 0
		end
		local part = Instance.new("Part")
		part.Anchored = true
		part.Size = Vector3.one
		part.Position = Vector3.new(x, 10, y)
		local g = max / 100
		part.Color = Color3.new(g, g, g)
		part.Material = Enum.Material.SmoothPlastic
		part.CanCollide = false
		part.CastShadow = false
		part.Parent = workspace
	end
end
