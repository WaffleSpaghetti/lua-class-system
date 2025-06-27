local Class = require(game.ServerScriptService.ClassSystem)
local Complex = require(game.ServerScriptService.ComplexClass)
local C, R, I, toComplex, approxEq = Complex.getHelpers()

--tests
---[[
local a = C(1,-2)
local b = C(-3,4)

print(a + b)
print(a - b)
print(a * b)
print(a / b)
print(a ^ b)

print(a.abs)
print(a.arg)
print(a.to_polar)
print(a.to_rect)
print(a.norm)
print(a.conj)

print(2 + b)
print(2 - b)
print(2 * b)
print(2 / b)
print(2 ^ b)
print(a + 2)
print(a - 2)
print(a * 2)
print(a / 2)
print(a ^ 2)

print(-a)

print(a == b)
print(a >= b)
print(a <= b)
print(a > b)
print(a < b)
print(a ~= b)

print(a)

print(R(a))
print(I(a))

print(a.R)
print(a.I)

print(approxEq(a,b,0.01))
print(a:approxEq(b))

print(a.type)

print(a)
print(-a)
print(-(a.to_polar))
print((-(a.to_polar)).to_rect)

local c = C(0,0)

print(c + b)
print(c - b)
print(c * b)
print(c / b)
print(c ^ b)

print(a + c)
print(a - c)
print(a * c)
print(a / c)
print(a ^ c)

print(c + 2)
print(c - 2)
print(c * 2)
print(c / 2)
print(c ^ 2)

print(2 + c)
print(2 - c)
print(2 * c)
print(2 / c)
print(2 ^ c)

print(c + c)
print(c - c)
print(c * c)
print(c / c)
print(c ^ c)

print(c.abs)
print(c.arg)
print(c.to_polar)
print(c.to_rect)
print(c.norm)
print(c.conj)

print(c)
print(-c)
--]]
--[[
  00:17:18.260  (-2 + 2i)  -  Server - Script:159
  00:17:18.260  (4 - 6i)  -  Server - Script:160
  00:17:18.260  (5 + 10i)  -  Server - Script:161
  00:17:18.260  (-0.44 - 0.08i)  -  Server - Script:162
  00:17:18.260  (7.25004 + 1.90646i)  -  Server - Script:163
  00:17:18.260  2.23606797749979  -  Server - Script:165
  00:17:18.260  -1.1071487177940904  -  Server - Script:166
  00:17:18.260  (2.23607 - 1.10715i)  -  Server - Script:167
  00:17:18.260  (-0.416147 - 0.909297i)  -  Server - Script:168
  00:17:18.261  (0.447214 + 0.894427i)  -  Server - Script:169
  00:17:18.261  (1 + 2i)  -  Server - Script:170
  00:17:18.261  (-1 + 4i)  -  Server - Script:172
  00:17:18.261  (5 - 4i)  -  Server - Script:173
  00:17:18.261  (-6 + 8i)  -  Server - Script:174
  00:17:18.261  (-0.24 + 0.32i)  -  Server - Script:175
  00:17:18.261  (-0.116586 + 0.0450858i)  -  Server - Script:176
  00:17:18.261  (3 - 2i)  -  Server - Script:177
  00:17:18.261  (-1 - 2i)  -  Server - Script:178
  00:17:18.261  (2 - 4i)  -  Server - Script:179
  00:17:18.261  (0.5 + 1i)  -  Server - Script:180
  00:17:18.261  (-3 - 4i)  -  Server - Script:181
  00:17:18.261  (-1 + 2i)  -  Server - Script:183
  00:17:18.261  false  -  Server - Script:185
  00:17:18.262  false  -  Server - Script:186
  00:17:18.262  true  -  Server - Script:187
  00:17:18.262  false  -  Server - Script:188
  00:17:18.262  true  -  Server - Script:189
  00:17:18.262  true  -  Server - Script:190
  00:17:18.262  (1 - 2i)  -  Server - Script:192
  00:17:18.262  1  -  Server - Script:194
  00:17:18.262  -2  -  Server - Script:195
  00:17:18.262  1  -  Server - Script:197
  00:17:18.263  -2  -  Server - Script:198
  00:17:18.263  false  -  Server - Script:200
  00:17:18.263  false  -  Server - Script:201
  00:17:18.263  Complex  -  Server - Script:203
  00:17:18.263  (1 - 2i)  -  Server - Script:205
  00:17:18.263  (-1 + 2i)  -  Server - Script:206
  00:17:18.263  (2.23607 + 2.03444i)  -  Server - Script:207
  00:17:18.263  (-1 + 2i)  -  Server - Script:208
  00:17:18.263  (-3 + 4i)  -  Server - Script:212
  00:17:18.263  (3 - 4i)  -  Server - Script:213
  00:17:18.263  (-0 + 0i)  -  Server - Script:214
  00:17:18.263  (0 + 0i)  -  Server - Script:215
  00:17:18.263  (0 + 0i)  -  Server - Script:216
  00:17:18.264  (1 - 2i)  -  Server - Script:218
  00:17:18.264  (1 - 2i)  -  Server - Script:219
  00:17:18.264  (0 + 0i)  -  Server - Script:220
  00:17:18.264  (nan - nani)  -  Server - Script:221
  00:17:18.264  (1 + 0i)  -  Server - Script:222
  00:17:18.264  (2 + 0i)  -  Server - Script:224
  00:17:18.264  (-2 + 0i)  -  Server - Script:225
  00:17:18.264  (0 + 0i)  -  Server - Script:226
  00:17:18.264  (0 + 0i)  -  Server - Script:227
  00:17:18.264  (0 + 0i)  -  Server - Script:228
  00:17:18.265  (2 + 0i)  -  Server - Script:230
  00:17:18.265  (2 + 0i)  -  Server - Script:231
  00:17:18.265  (0 + 0i)  -  Server - Script:232
  00:17:18.265  (nan - nani)  -  Server - Script:233
  00:17:18.265  (1 + 0i)  -  Server - Script:234
  00:17:18.265  (0 + 0i)  -  Server - Script:236
  00:17:18.265  (0 + 0i)  -  Server - Script:237
  00:17:18.265  (0 + 0i)  -  Server - Script:238
  00:17:18.265  (nan - nani)  -  Server - Script:239
  00:17:18.265  (0 + 0i)  -  Server - Script:240
  00:17:18.265  0  -  Server - Script:242
  00:17:18.265  0  -  Server - Script:243
  00:17:18.266  (0 + 0i)  -  Server - Script:244
  00:17:18.266  (0 + 0i)  -  Server - Script:245
  00:17:18.266  0  -  Server - Script:246
  00:17:18.266  (0 + 0i)  -  Server - Script:247
  00:17:18.266  (0 + 0i)  -  Server - Script:249
  00:17:18.266  (-0 + 0i)  -  Server - Script:250
]]

---[[
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
--]]

-- tests
---[[
---[[
local testClass1 = Class{
	a = 0,
	b = 2,
	test = function(self)
		print(self.a + self.b)
	end,
}
local testClass2 = Class:define{
	TRUE = "HI!",
	FALSE = "BYE!",
	METHOD = function(self, expression)
		return expression and self.TRUE or self.FALSE
	end,
}

local a = testClass1{
	a = 3,
	b = 6
}
local b = testClass2:new{
	FALSE = "TEST"
}

a:test() -- 9
print(b:METHOD(1 == 1)) -- HI!
print(b:METHOD(1 == 2)) -- TEST

local ParentClass = Class{
	something = 2025,
	func = function(self, a, b)
		return a+b-self.something
	end,
}

local ChildClass = Class({
	A = "wow, inheritance!",
	test = function(self)
		print((self.something or "nil") .. self.A)
	end,
}, ParentClass)

local objj1 = ParentClass{
	static = {
		secret = 123
	},
	something = 2305
}
print(objj1:func(3030,5050)) -- 5775


local objj2 = ChildClass{
	A = "hello world!"
}
local objj3 = ChildClass{}

objj2:test() --> 2025hello world!
objj3:test() --> 2025wow, inheritance!

print(objj1.static.secret) --123
print(objj2.static) --nil
print(objj2.secret) --nil

local unique = Class{
	static = {
		id = 0,
		init = function(parent, child)
			child.id = parent.static.id
			parent.static.id = parent.static.id + 1
			return child
		end,
	},
	myId = function(self)
		print(self.id)
		return self.id
	end,
}

local O1 = unique{}
local O2 = unique{}
local O3 = unique{}

O1:myId() -- 0
O2:myId() -- 1
O3:myId() -- 2

-- multiple inheritance test

local PClass = Class{
	static = {
		secret = "my favourite color is yellow and my social security number is 1",
		init = function(p, c)
			c.superSecretDataDontShare = p.static.secret
			return c
		end,
	},
	method = function(self)
		print("method! " .. self.superSecretDataDontShare)
	end,
	override = function(self, a, b)
		print(a*b)
	end,
}

local CClass = Class({
	static = {
		secret = "im a child class",
		passInit = true,
		init = function(p, c)
			c.wow = "Wow!"
			return c
		end,
	},
	method = function(self)
		print("overriden!")
	end,
	override = function()
		print("nothing to see here!")
	end,
	test = function(self)
		print(self.wow)
	end
}, PClass)

local CCClass = Class({}, CClass)

local PCO1 = PClass{}
local CCO1 = CClass{}
local CCCO1 = CCClass{}

PCO1:method() -- method! my favourite color is yellow and my social security number is 1
CCO1:method() -- overriden!
CCO1:test() -- Wow!
CCCO1:method() -- overriden!
CCCO1:test() -- Wow!

PCO1:override(3,4) --12
CCO1:override(3,4) --nothing to see here!
CCCO1:override(3,4) --nothing to see here!

-- super tests

CCO1:super("override", 3,4) --12
CCCO1:super("override", 3,4) --nothing to see here!

-- all tests above pass!
--real console output:
--[[
  21:28:51.059  9  -  Server - Script:58
  21:28:51.059  HI!  -  Server - Script:78
  21:28:51.059  TEST  -  Server - Script:79
  21:28:51.059  5775  -  Server - Script:101
  21:28:51.059  2025hello world!  -  Server - Script:91
  21:28:51.059  2025wow, inheritance!  -  Server - Script:91
  21:28:51.059  123  -  Server - Script:112
  21:28:51.059  nil  -  Server - Script:113
  21:28:51.059  nil  -  Server - Script:114
  21:28:51.060  0  -  Server - Script:126
  21:28:51.060  1  -  Server - Script:126
  21:28:51.060  2  -  Server - Script:126
  21:28:51.060  method! my favourite color is yellow and my social security number is 1  -  Server - Script:150
  21:28:51.060  overriden!  -  Server - Script:167
  21:28:51.060  Wow!  -  Server - Script:173
  21:28:51.060  overriden!  -  Server - Script:167
  21:28:51.060  Wow!  -  Server - Script:173
  21:28:51.060  12  -  Server - Script:153
  21:28:51.060   ▶ nothing to see here! (x2)  -  Server - Script:170
  21:28:51.060  12  -  Server - Script:153
  21:28:51.060  nothing to see here!  -  Server - Script:170
]]








---@!!! IMPORTANT INFO !!!---

--CCCO1:super("super", "override", 3, 4) -- won't work, error: attempt to index nil with '__index' 
--i couldnt find a solution which also kept this pretty syntax, so just dont chain supers
--also, always use : and not . when calling methods, and never forget that the first arg should always be self when defining new methods









--]]


---[[

-- 1) Base class: Person
local Person = Class{
	static = {
		count = 0,  -- initialize Person counter
		init = function(cls, obj)
			cls.static.count = cls.static.count + 1
			obj.id = cls.static.count
			return obj
		end,
	},
	sayHello = function(self)
		print(("Person #%d says: Hello!"):format(self.id))
	end,
}

-- 2) Subclass: Employee
local Employee = Class({
	static = {
		count = 0,  -- **you must initialize this**, even though we call Person.init
		init = function(cls, obj)
			-- since cls = Employee here, this will bump Employee.static.count
			Person.static.init(cls, obj)
			obj.role = "Developer"
			return obj
		end,
	},
	sayHello = function(self)
		-- call Person’s behavior (using super)
		self:super("sayHello")
		-- then extend
		print(("...and I work as a %s."):format(self.role))
	end,
}, Person)

-- 3) Create instances
local p1 = Person{}   -- Person.static.count → 1
local p2 = Person{}   -- Person.static.count → 2
local e1 = Employee{} -- Employee.static.count → 1
local e2 = Employee{} -- Employee.static.count → 2

-- 4) Use them
p1:sayHello()  
-- Person #1 says: Hello!
p2:sayHello()
-- Person #2 says: Hello!

e1:sayHello()
-- Person #1 says: Hello!
-- ...and I work as a Developer.
e2:sayHello()
-- Person #2 says: Hello!
-- ...and I work as a Developer.

-- 5) Inspect counters
print("People created:", Person.static.count)     -- People created: 2
print("Employees created:", Employee.static.count) -- Employees created: 2
--]]

---[[

-- 1) Base Shape class (abstract area)
local Shape = Class{
	static = {
		count = 0,
		init = function(cls, obj)
			cls.static.count = cls.static.count + 1
			obj.id = cls.static.count
			return obj
		end,
	},
	area = function(self)
		error(("Shape #%d: area() not implemented"):format(self.id))
	end,
	describe = function(self)
		print(("Shape #%d → area = %.2f"):format(self.id, self:area()))
	end,
}

-- 2) Circle subclass
local Circle = Class({
	static = { count = 0, init = function(cls, obj)
		Shape.static.init(cls, obj)      -- bump Circle.counter & set id
		obj.areaValue = math.pi * obj.radius^2
		return obj
	end,
	},
	radius = 1,
	area = function(self) return self.areaValue end,
}, Shape)

-- 3) ColoredCircle subclass
local ColoredCircle = Class({
	static = { count = 0, init = function(cls, obj)
		Circle.static.init(cls, obj)     -- bump ColoredCircle.counter & set id
		return obj
	end,
	},
	color = "red",
	describe = function(self)
		self:super("describe")            -- call Circle/Shape.describe
		print(("…and I’m %s"):format(self.color))
	end,
}, Circle)

-- 4) Instantiate (we’ll only call describe on implementors)
local _   = Shape{}    -- id = 1 (counter bumped, but abstract)
local _   = Shape{}    -- id = 2
local c1  = Circle{ radius = 2 }       -- id = 1
local c2  = Circle{ radius = 4 }       -- id = 2
local cc1 = ColoredCircle{ radius = 3, color = "blue" }  -- id = 1
local cc2 = ColoredCircle{ radius = 5 }                 -- id = 2

-- 5) Use them
print("**Circles:**")
c1:describe()      -- Shape #1 → area = 12.57
c2:describe()      -- Shape #2 → area = 50.27

print("\n**Colored Circles:**")
cc1:describe()
-- Shape #1 → area = 28.27
-- …and I’m blue

cc2:describe()
-- Shape #2 → area = 78.54
-- …and I’m red

print("\n**Counters:**")
print("Shapes:",        Shape.static.count)        -- Shapes: 2
print("Circles:",       Circle.static.count)       -- Circles: 2
print("ColoredCircles:", ColoredCircle.static.count) -- ColoredCircles: 2
--]]
--]]



--the code above correctly plots the burning ship fractal
-- full console output
--[[
  00:52:40.113  (-2 + 2i)  -  Server - lua classes, complex numbers:159
  00:52:40.113  (4 - 6i)  -  Server - lua classes, complex numbers:160
  00:52:40.113  (5 + 10i)  -  Server - lua classes, complex numbers:161
  00:52:40.113  (-0.44 - 0.08i)  -  Server - lua classes, complex numbers:162
  00:52:40.113  (7.25004 + 1.90646i)  -  Server - lua classes, complex numbers:163
  00:52:40.113  2.23606797749979  -  Server - lua classes, complex numbers:165
  00:52:40.113  -1.1071487177940904  -  Server - lua classes, complex numbers:166
  00:52:40.113  (2.23607 - 1.10715i)  -  Server - lua classes, complex numbers:167
  00:52:40.113  (-0.416147 - 0.909297i)  -  Server - lua classes, complex numbers:168
  00:52:40.113  (0.447214 + 0.894427i)  -  Server - lua classes, complex numbers:169
  00:52:40.113  (1 + 2i)  -  Server - lua classes, complex numbers:170
  00:52:40.113  (-1 + 4i)  -  Server - lua classes, complex numbers:172
  00:52:40.113  (5 - 4i)  -  Server - lua classes, complex numbers:173
  00:52:40.113  (-6 + 8i)  -  Server - lua classes, complex numbers:174
  00:52:40.113  (-0.24 + 0.32i)  -  Server - lua classes, complex numbers:175
  00:52:40.114  (-0.116586 + 0.0450858i)  -  Server - lua classes, complex numbers:176
  00:52:40.114  (3 - 2i)  -  Server - lua classes, complex numbers:177
  00:52:40.114  (-1 - 2i)  -  Server - lua classes, complex numbers:178
  00:52:40.114  (2 - 4i)  -  Server - lua classes, complex numbers:179
  00:52:40.114  (0.5 + 1i)  -  Server - lua classes, complex numbers:180
  00:52:40.114  (-3 - 4i)  -  Server - lua classes, complex numbers:181
  00:52:40.114  (-1 + 2i)  -  Server - lua classes, complex numbers:183
  00:52:40.114  false  -  Server - lua classes, complex numbers:185
  00:52:40.114  false  -  Server - lua classes, complex numbers:186
  00:52:40.114  true  -  Server - lua classes, complex numbers:187
  00:52:40.114  false  -  Server - lua classes, complex numbers:188
  00:52:40.114  true  -  Server - lua classes, complex numbers:189
  00:52:40.114  true  -  Server - lua classes, complex numbers:190
  00:52:40.114  (1 - 2i)  -  Server - lua classes, complex numbers:192
  00:52:40.114  1  -  Server - lua classes, complex numbers:194
  00:52:40.114  -2  -  Server - lua classes, complex numbers:195
  00:52:40.114  1  -  Server - lua classes, complex numbers:197
  00:52:40.114  -2  -  Server - lua classes, complex numbers:198
  00:52:40.115  false  -  Server - lua classes, complex numbers:200
  00:52:40.115  false  -  Server - lua classes, complex numbers:201
  00:52:40.115  Complex  -  Server - lua classes, complex numbers:203
  00:52:40.115  (1 - 2i)  -  Server - lua classes, complex numbers:205
  00:52:40.115  (-1 + 2i)  -  Server - lua classes, complex numbers:206
  00:52:40.115  (2.23607 + 2.03444i)  -  Server - lua classes, complex numbers:207
  00:52:40.115  (-1 + 2i)  -  Server - lua classes, complex numbers:208
  00:52:40.115  (-3 + 4i)  -  Server - lua classes, complex numbers:212
  00:52:40.115  (3 - 4i)  -  Server - lua classes, complex numbers:213
  00:52:40.115  (-0 + 0i)  -  Server - lua classes, complex numbers:214
  00:52:40.115  (0 + 0i)  -  Server - lua classes, complex numbers:215
  00:52:40.115  (0 + 0i)  -  Server - lua classes, complex numbers:216
  00:52:40.115  (1 - 2i)  -  Server - lua classes, complex numbers:218
  00:52:40.115  (1 - 2i)  -  Server - lua classes, complex numbers:219
  00:52:40.115  (0 + 0i)  -  Server - lua classes, complex numbers:220
  00:52:40.115  (nan - nani)  -  Server - lua classes, complex numbers:221
  00:52:40.115  (1 + 0i)  -  Server - lua classes, complex numbers:222
  00:52:40.115  (2 + 0i)  -  Server - lua classes, complex numbers:224
  00:52:40.115  (-2 + 0i)  -  Server - lua classes, complex numbers:225
  00:52:40.116  (0 + 0i)  -  Server - lua classes, complex numbers:226
  00:52:40.116  (0 + 0i)  -  Server - lua classes, complex numbers:227
  00:52:40.116  (0 + 0i)  -  Server - lua classes, complex numbers:228
  00:52:40.116  (2 + 0i)  -  Server - lua classes, complex numbers:230
  00:52:40.116  (2 + 0i)  -  Server - lua classes, complex numbers:231
  00:52:40.116  (0 + 0i)  -  Server - lua classes, complex numbers:232
  00:52:40.116  (nan - nani)  -  Server - lua classes, complex numbers:233
  00:52:40.116  (1 + 0i)  -  Server - lua classes, complex numbers:234
  00:52:40.116  (0 + 0i)  -  Server - lua classes, complex numbers:236
  00:52:40.116  (0 + 0i)  -  Server - lua classes, complex numbers:237
  00:52:40.116  (0 + 0i)  -  Server - lua classes, complex numbers:238
  00:52:40.116  (nan - nani)  -  Server - lua classes, complex numbers:239
  00:52:40.116  (0 + 0i)  -  Server - lua classes, complex numbers:240
  00:52:40.116  0  -  Server - lua classes, complex numbers:242
  00:52:40.116  0  -  Server - lua classes, complex numbers:243
  00:52:40.116  (0 + 0i)  -  Server - lua classes, complex numbers:244
  00:52:40.116  (0 + 0i)  -  Server - lua classes, complex numbers:245
  00:52:40.116  0  -  Server - lua classes, complex numbers:246
  00:52:40.116  (0 + 0i)  -  Server - lua classes, complex numbers:247
  00:52:40.116  (0 + 0i)  -  Server - lua classes, complex numbers:249
  00:52:40.117  (-0 + 0i)  -  Server - lua classes, complex numbers:250
  00:52:45.895  9  -  Server - lua classes, complex numbers:371
  00:52:45.895  HI!  -  Server - lua classes, complex numbers:391
  00:52:45.895  TEST  -  Server - lua classes, complex numbers:392
  00:52:45.895  5775  -  Server - lua classes, complex numbers:414
  00:52:45.895  2025hello world!  -  Server - lua classes, complex numbers:404
  00:52:45.895  2025wow, inheritance!  -  Server - lua classes, complex numbers:404
  00:52:45.895  123  -  Server - lua classes, complex numbers:425
  00:52:45.895  nil  -  Server - lua classes, complex numbers:426
  00:52:45.895  nil  -  Server - lua classes, complex numbers:427
  00:52:45.895  0  -  Server - lua classes, complex numbers:439
  00:52:45.895  1  -  Server - lua classes, complex numbers:439
  00:52:45.895  2  -  Server - lua classes, complex numbers:439
  00:52:45.895  method! my favourite color is yellow and my social security number is 1  -  Server - lua classes, complex numbers:463
  00:52:45.896  overriden!  -  Server - lua classes, complex numbers:480
  00:52:45.896  Wow!  -  Server - lua classes, complex numbers:486
  00:52:45.896  overriden!  -  Server - lua classes, complex numbers:480
  00:52:45.896  Wow!  -  Server - lua classes, complex numbers:486
  00:52:45.896  12  -  Server - lua classes, complex numbers:466
  00:52:45.896   ▶ nothing to see here! (x2)  -  Server - lua classes, complex numbers:483
  00:52:45.896  12  -  Server - lua classes, complex numbers:466
  00:52:45.896  nothing to see here!  -  Server - lua classes, complex numbers:483
  00:52:45.896  Person #1 says: Hello!  -  Server - lua classes, complex numbers:557
  00:52:45.896  Person #2 says: Hello!  -  Server - lua classes, complex numbers:557
  00:52:45.896  Person #1 says: Hello!  -  Server - lua classes, complex numbers:557
  00:52:45.897  ...and I work as a Developer.  -  Server - lua classes, complex numbers:576
  00:52:45.897  Person #2 says: Hello!  -  Server - lua classes, complex numbers:557
  00:52:45.897  ...and I work as a Developer.  -  Server - lua classes, complex numbers:576
  00:52:45.897  People created: 2  -  Server - lua classes, complex numbers:600
  00:52:45.897  Employees created: 2  -  Server - lua classes, complex numbers:601
  00:52:45.897  **Circles:**  -  Server - lua classes, complex numbers:659
  00:52:45.897  Shape #1 → area = 12.57  -  Server - lua classes, complex numbers:620
  00:52:45.897  Shape #2 → area = 50.27  -  Server - lua classes, complex numbers:620
  00:52:45.897  
**Colored Circles:**  -  Server - lua classes, complex numbers:663
  00:52:45.897  Shape #1 → area = 28.27  -  Server - lua classes, complex numbers:620
  00:52:45.897  …and I’m blue  -  Server - lua classes, complex numbers:646
  00:52:45.897  Shape #2 → area = 78.54  -  Server - lua classes, complex numbers:620
  00:52:45.898  …and I’m red  -  Server - lua classes, complex numbers:646
  00:52:45.898  
**Counters:**  -  Server - lua classes, complex numbers:672
  00:52:45.898  Shapes: 2  -  Server - lua classes, complex numbers:673
  00:52:45.898  Circles: 2  -  Server - lua classes, complex numbers:674
  00:52:45.898  ColoredCircles: 2  -  Server - lua classes, complex numbers:675
]]
