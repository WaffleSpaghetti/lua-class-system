local Quaternion = require(game.ServerScriptService.QuaternionClass)
local Q, R, I, toQuaternion, QfromAxisAngle, qexp, qlog = Quaternion.getHelpers()

local t=0
local res = 0.2
for z = -2, 2, res do
	for y = -2, 2, res do
		for x = -2, 2, res do
			t+=1
			local C = Q(x, y, z, 0) -- J = 0
			local Z = Q(0, 0, 0, 0)
			local max = 100
			for i = 1, 100 do
				Z = Z * Z + C
				if Z.abs > 2 then
					max = i
					break
				end
			end
			if t>3000 then
				task.wait()
				t=0
			end
			local part = Instance.new("Part")
			part.Anchored = true
			part.Size = Vector3.one * res * 10
			part.Position = Vector3.new(x * 10, y * 10 + 10, z * 10)
			local g = max / 100
			part.Color = Color3.new(g, g, g)
			part.Transparency = 1 - g
			part.Material = Enum.Material.SmoothPlastic
			part.CanCollide = false
			part.CastShadow = false
			part.Parent = workspace
		end
	end
end
