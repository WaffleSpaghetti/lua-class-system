local Class = {}
Class.outerMeta = {}
Class.innerMeta = {}
Class.define = function(self, o, base)
	assert(type(o) == "table", "Expected a table for prototype")
	local parentProto = base and base.proto
	o = o or {}
	local static = o.static
	static = static or {}
	local proto = {
		super = function(self, methodName, ...)
			local proto = getmetatable(self).__proto
			local parentProto = proto and getmetatable(proto) and getmetatable(proto).__index
			local method = parentProto and parentProto[methodName]
			if method then
				return method(self, ...)
			else
				error("super method '"..methodName.."' not found")
			end
		end
	}
	for k, v in pairs(o) do
		if k ~= "static" then
			proto[k] = v
		end
	end
	if base and base.static and base.static.init and base.static.passInit then
		static.init = base.static.init
	end
	local class = {
		proto = setmetatable(proto, {__index = parentProto}),
		static = static,
		meta = {},
	}
	class.meta.__proto = class.proto
	class.meta.__index = function(self, key)
		local proto = getmetatable(self).__proto
		local gtrs = proto.getters
		if gtrs and gtrs[key] then
			return gtrs[key](self)
		end
		return proto[key]
	end
	setmetatable(class, self.outerMeta)
	return class
end
Class.proto = {
	new = function(self, obj)
		obj = obj or {}
		setmetatable(obj, self.meta)
		obj = (self.static and self.static.init) and self.static.init(self, obj) or obj
		return obj
	end,
}
Class.outerMeta.__index = Class.proto
Class.outerMeta.__call = function(self, obj)
	return self:new(obj)
end
Class.innerMeta.__call = function(self, obj, base) return self:define(obj, base) end
setmetatable(Class, Class.innerMeta)



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
Complex.meta.__pow = function(a,b)
	a, b = toComplex(a), toComplex(b)
	return a.abs~=0 and C(a.abs^b.R*math.exp(-b.I*a.arg),b.R*a.arg+b.I*math.log(a.abs)).to_rect or C(0,0)
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

local function approxEq(a,b,epsilon)
	epsilon = epsilon or 1e-10
	return (a.R - b.R)^2 + (a.I - b.I)^2 < epsilon
end
