--THIS ONLY WORKS IN ROBLOX, BUT YOU CAN DEFINITELY REWRITE THIS A LITTLE BIT TO PLOT STUFF WITH LÖVE2D OR OTHER LIBS
local Complex = require(game.ServerScriptService.ComplexClass)
local C, R, I, toComplex, cexp, clog = Complex.getHelpers()
--[[
local function F(z,c)
	return z^2 + c
end
--]]
---[[
local function F(z, c)
	return C(math.abs(z.R),math.abs(z.I))^2 + c -- burning ship fractal function, for mandelbrot use the commented out one
end
--]]
local t=0
local res = 0.05
for x = -2, 2, res do
	for y = -2, 2, res do
		t = t + 1
		local c = C(x, y)
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
		part.Size = Vector3.one*res*10
		part.Position = Vector3.new(x*10, 2, y*10)
		local g = max / 100
		part.Color = Color3.new(g, g, g)
		part.Material = Enum.Material.SmoothPlastic
		part.CanCollide = false
		part.CastShadow = false
		part.Parent = workspace
	end
end
