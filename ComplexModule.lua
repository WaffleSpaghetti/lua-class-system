local Class = require(game.ServerScriptService.ClassSystem)
local Complex = Class{
	R = 0,
	I = 0,
	isRect = true,
	type = "Complex",
	approxEq = function(self, other, epsilon)
		epsilon = epsilon or 1e-10
		return (self.R - other.R)^2 + (self.I - other.I)^2 < epsilon
	end
}
function C(r, i)
	return Complex{
		R = r,
		I = i,
	}
end
local function toComplex(x)
	return type(x) == "number" and C(x,0) or x
end
local function R(x)
	return x.R
end
local function I(x)
	return x.I
end
local getters = {
	abs = function(self) return math.sqrt(self.R^2+self.I^2) end,
	arg = function(self) return math.atan2(self.I,self.R) end,
	to_polar = function(self)
		local p = C(self.abs, self.arg)
		p.isRect = false
		return p
	end,
	to_rect = function(self)
		local r = C(self.R*math.cos(self.I), self.R*math.sin(self.I))
		r.isRect = true
		return r
	end,
	norm = function(self)
		return self.abs ~= 0 and self/self.abs or 0
	end,
	conj = function(self) return C(self.R, -self.I) end,
}
Complex.proto.getters = getters
Complex.meta.__add = function(a,b)
	a, b = toComplex(a), toComplex(b)
	return C(a.R+b.R,a.I+b.I)
end
Complex.meta.__sub = function(a,b)
	a, b = toComplex(a), toComplex(b)
	return C(a.R-b.R,a.I-b.I)
end
Complex.meta.__mul = function(a,b)
	a, b = toComplex(a), toComplex(b)
	return C(a.R*b.R-a.I*b.I,a.R*b.I+b.R*a.I)
end
Complex.meta.__div = function(a,b)
	a, b = toComplex(a), toComplex(b)
	return C((a.R*b.R+a.I*b.I)/(b.R^2+b.I^2),(a.R*b.I-b.R*a.I)/(b.R^2+b.I^2))
end
local cexp = function(z)
	local ea = math.exp(z.R)
	return C(ea * math.cos(z.I), ea * math.sin(z.I))
end
local clog = function(z)
	local modulus = math.sqrt(z.R^2 + z.I^2)
	local angle = math.atan2(z.I, z.R)
	return C(math.log(modulus), angle)
end
Complex.meta.__pow = function(a,b)
	a, b = toComplex(a), toComplex(b)
	return a.abs ~= 0 and cexp(b * clog(a)) or 0
end
Complex.meta.__unm = function(a)
	return a.isRect and C(-a.R, -a.I) or C(a.R, a.I+math.pi)
end
Complex.meta.__tostring = function(self)
	local sign = (self.I >= 0) and "+" or "-"
	return string.format("(%g %s %gi)", self.R, sign, math.abs(self.I))
end
Complex.meta.__concat = function(a,b)
	return tostring(a) .. tostring(b)
end
Complex.meta.__eq = function(a,b)
	return (a.R == b.R and a.I == b.I)
end
Complex.meta.__lt = function(a,b)
	return (a.abs < b.abs)
end
Complex.meta.__le = function(a,b)
	return (a.abs <= b.abs)
end
Complex.meta.__type = "Complex"
Complex.getHelpers = function()
	return C, R, I, toComplex
end
return Complex
