local Class = require(game.ServerScriptService.ClassSystem)
local Quaternion = Class{
	R = 0,
	I = 0,
	J = 0,
	K = 0,
	type = "Complex",
	approxEq = function(self, other, epsilon)
		epsilon = epsilon or 1e-10
		return (self.R - other.R)^2 + (self.I - other.I)^2 + (self.J - other.J)^2 + (self.K - other.K)^2 < epsilon
	end
}
function Q(r, i, j, k)
	return Quaternion{
		R = r,
		I = i,
		J = j,
		K = k,
	}
end
local function R(x)
	return Q(x.R,0,0,0)
end
local function I(x)
	return Q(0, x.I, x.J, x.K)
end
local function QfromAxisAngle(halftheta, i, j, k)
	local length = math.sqrt(i*i + j*j + k*k)
	if length == 0 then
		error("Axis vector cannot be zero")
	end
	local nx, ny, nz = i/length, j/length, k/length

	local cosHalf = math.cos(halftheta)
	local sinHalf = math.sin(halftheta)

	return Q(
		cosHalf,
		nx * sinHalf,
		ny * sinHalf,
		nz * sinHalf
	)
end
local function toQuaternion(x)
	return type(x) == "number" and Q(x,0,0,0) or x
end
local getters = {
	abs = function(self) return math.sqrt(self.R^2+self.I^2+self.J^2+self.K^2) end,
	norm = function(self)
		return self.abs ~= 0 and self/self.abs or Q(0,0,0,0)
	end,
	conj = function(self) return Q(self.R, -self.I, -self.J, -self.K) end,
	inverse = function(self)
		local n2 = self.norm ^ 2
		if n2 == 0 then
			error("Cannot invert a zero quaternion")
		end
		local conj = self.conj
		return Q(conj.R / n2, conj.I / n2, conj.J / n2, conj.K / n2)
	end,
}
Quaternion.proto.getters = getters
Quaternion.meta.__add = function(a,b)
	a, b = toQuaternion(a), toQuaternion(b)
	return Q(a.R + b.R,a.I + b.I,a.J + b.J,a.K + b.K)
end
Quaternion.meta.__sub = function(a,b)
	a, b = toQuaternion(a), toQuaternion(b)
	return Q(a.R - b.R,a.I - b.I,a.J - b.J,a.K - b.K)
end
Quaternion.meta.__mul = function(a, b)
	a, b = toQuaternion(a), toQuaternion(b)
	return Q(
		a.R * b.R - a.I * b.I - a.J * b.J - a.K * b.K,
		a.R * b.I + a.I * b.R + a.J * b.K - a.K * b.J,
		a.R * b.J - a.I * b.K + a.J * b.R + a.K * b.I,
		a.R * b.K + a.I * b.J - a.J * b.I + a.K * b.R
	)
end
Quaternion.meta.__div = function(a, b)
	a, b = toQuaternion(a), toQuaternion(b)
	return a * b.inverse
end
local function qlog(q)
	local r, i, j, k = q.R, q.I, q.J, q.K
	local qabs = q.abs
	local vnorm = math.sqrt(i^2 + j^2 + k^2)

	if vnorm < 1e-15 then
		return Q(math.log(qabs), 0, 0, 0)
	else
		local theta = math.acos(r / qabs)
		local coeff = theta / vnorm
		return Q(math.log(qabs), coeff * i, coeff * j, coeff * k)
	end
end
local function qexp(q)
	local r, i, j, k = q.R, q.I, q.J, q.K
	local vnorm = math.sqrt(i^2 + j^2 + k^2)
	local exp_r = math.exp(r)
	if vnorm < 1e-15 then
		return Q(exp_r, 0, 0, 0)
	else
		local cos_v = math.cos(vnorm)
		local sin_v = math.sin(vnorm)
		local coeff = exp_r * sin_v / vnorm
		return Q(
			exp_r * cos_v,
			coeff * i,
			coeff * j,
			coeff * k
		)
	end
end
Quaternion.meta.__pow = function(a, b)
	a, b = toQuaternion(a), toQuaternion(b)
	return a.abs ~= 0 and qexp(b * qlog(a)) or 0
end
Quaternion.meta.__unm = function(a)
	return Q(-a.R, -a.I, -a.J, -a.K)
end
Quaternion.meta.__eq = function(a, b)
	return a.R == b.R and a.I == b.I and a.J == b.J and a.K == b.K
end

Quaternion.meta.__tostring = function(self)
	local function formatComponent(name, val)
		return (val >= 0 and "+" or "-") .. tostring(val) .. name
	end
	return string.format("(%g%s%s%s)", self.R,
		formatComponent("i", self.I),
		formatComponent("j", self.J),
		formatComponent("k", self.K)
	)
end
Quaternion.meta.__concat = function(a, b)
	return tostring(a) .. tostring(b)
end
Quaternion.meta.__lt = function(a,b)
	return (a.abs < b.abs)
end
Quaternion.meta.__le = function(a,b)
	return (a.abs <= b.abs)
end
Quaternion.meta.__type = "Quaternion"
Quaternion.getHelpers = function()
	return Q, R, I, toQuaternion, QfromAxisAngle, qexp, qlog
end
return Quaternion
