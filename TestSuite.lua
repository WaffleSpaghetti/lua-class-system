local Class = require(game.ServerScriptService.ClassSystem)

--====================================================
-- BASE CLASS: Shape
--====================================================

local Shape = Class{
	static = {
		subclassCount = 0,
		shapeCount = 1,
		onSubclass = function(class, subclass)
			-- Assign ID based on parent's counter
			subclass.id = class.static.subclassCount
			class.static.subclassCount += 1
			return subclass
		end,
		onInstance = function(class, instance)
			-- Ensure parent has a shapeCount
			class.static.shapeCount = class.static.shapeCount or 0
			-- Assign ID based on parent's counter
			instance.id = class.static.shapeCount
			class.static.shapeCount += 1
			-- Optionally initialize the child static table for subclass-specific counters
			instance.static = instance.static or {}
			instance.static.shapeCount = 0

			return instance
		end,
		passOnInstance = true,
	},
	getters = {
		P = function(self)
			warn("no perimeter function!")
			return 0
		end,
		area = function(self)
			warn("no area function!")
			return 0
		end,
	},
	pos = { X = 0, Y = 0 },
	goto = function(self, newX, newY)
		self.pos = { X = newX, Y = newY }
		return self.pos
	end,
	move = function(self, dx, dy)
		self.pos = { X = self.pos.X + dx, Y = self.pos.Y + dy }
		return self.pos
	end,
}

--====================================================
-- SUBCLASS: Square
--====================================================

local Square = Class({
	getters = {
		P = function(self) return 4 * self.width end,
		area = function(self) return self.width^2 end,
	},
	width = 0,
}, Shape)

--====================================================
-- SUBCLASS: Triangle
--====================================================

local Triangle = Class({
	getters = {
		P = function(self) return self.A + self.B + self.C end,
		area = function(self)
			local halfP = self.P / 2
			return math.sqrt(halfP * (halfP - self.A) * (halfP - self.B) * (halfP - self.C))
		end,
	},
	A = 0, B = 0, C = 0,
}, Shape)

--====================================================
-- SUBCLASS: Circle
--====================================================

local Circle = Class({
	getters = {
		P = function(self) return 2 * math.pi * self.radius end,
		area = function(self) return math.pi * self.radius^2 end,
	},
	radius = 0,
}, Shape)

--====================================================
-- INSTANCE TESTS: Square
--====================================================

local sq1 = Square{ pos = { X = 100, Y = 50 }, width = 20 }
print("Square Area:", sq1.area)         -- 400
print("Square Perimeter:", sq1.P)       -- 80

--====================================================
-- INSTANCE TESTS: Triangle
--====================================================

local tr1 = Triangle{ pos = { X = -30, Y = 10 }, A = 20, B = 10, C = 15 }
print("Triangle Area:", tr1.area)       -- ≈ 72.618
print("Triangle Perimeter:", tr1.P)     -- 45

-- Movement test
print("Original Position:", tr1.pos.X, tr1.pos.Y) -- -30 10
tr1:move(20, 40)
print("New Position:", tr1.pos.X, tr1.pos.Y) -- -10 50

-- Default instance
local tr2 = Triangle{}
print("Default Triangle Perimeter:", tr2.P)     -- 0
print("Default Triangle Area:", tr2.area)       -- 0
tr2:goto(-40, 600)
print("New Goto Position:", tr2.pos.X, tr2.pos.Y) -- -40 600

--====================================================
-- STATIC COUNT & ONINIT HOOK TESTS
--====================================================

print("Subclass Count (Base):", Shape.static.subclassCount) -- 3
print("Pure Shape Instance Count (Base):", Shape.static.shapeCount) -- should be 1
print("Triangle Count:", Triangle.static.shapeCount) -- 2

print("Triangle IDs:", tr1.id, tr2.id) -- 0 1
print("Class static fields:", Square.id, Triangle.id, Circle.id) -- 0 1 2

--====================================================
-- Circle Instances
--====================================================

local c1 = Circle{ radius = 10 }
local c2 = Circle{ radius = 15 }
print("Circle1 Area:", c1.area)     -- 314.15
print("Circle1 ID:", c1.id)         -- 0
print("Circle2 Area:", c2.area)     -- 706.85
print("Circle2 ID:", c2.id)         -- 1

--====================================================
-- MULTI-LEVEL INHERITANCE: Rectangle -> Square -> Shape
--====================================================

local Rectangle = Class({
	getters = {
		P = function(self) return 2 * (self.width + self.height) end,
		area = function(self) return self.width * self.height end,
	},
	height = 0,
	move = function(self)
		print("Rectangle custom move!")
	end,
}, Square)

local rect1 = Rectangle{ width = 5, height = 7 }
print("Rectangle Area:", rect1.area)              -- 35
print("Rectangle Super Getter Area:", rect1:superGetter("area")) -- 25 (Square’s area = width^2)

print("Before Move Position:", rect1.pos.X, rect1.pos.Y) -- 0 0
rect1:move()                                     -- custom method
print("After Own Move Position:", rect1.pos.X, rect1.pos.Y) -- 0 0
rect1:super("move", 23, 45)                      -- inherited from Shape
print("After Super Move Position:", rect1.pos.X, rect1.pos.Y) -- 23 45

--====================================================
-- ADDITIONAL EDGE CASES
--====================================================

-- Manually call proto.new()
local manual = Square:new{ width = 5 }
print("Manual Square Area:", manual.area)

-- Getter vs Field Shadowing
local shadow = Square{ width = 10 }
shadow.area = 999
print("Shadowed area field:", shadow.area)      -- 999

-- Unknown field access
print("Unknown field:", shadow.doesNotExist)    -- nil

-- Inherited getters fallback
local WeirdShape = Class({}, Shape)
local ws = WeirdShape{}
print("WeirdShape area (fallback):", ws.area)   -- a warning || 0, from Shape getter

-- Override static.onInstance in subclass
local SubCircle = Class({
	static = {
		onInstance = function(_, obj)
			obj.radius = 42
			return obj
		end
	}
}, Circle)

local sc = SubCircle{}
print("SubCircle Radius:", sc.radius)           -- 42

--====================================================
-- GETTER INJECTION
--====================================================

Square.proto.getters.newProp = function(self) return 123 end
print(sq1.newProp) -- 123

--====================================================
-- GETTER FIELD OVERRIDE
--====================================================

local s = Square{}
s.P = 999
print(s.P) -- should be 999, field overrides getter || 999
s.P = nil
print(s.P) -- now fallback to getter || 0

--====================================================
-- NONEXISTENT SUPER WARNING TEST
--====================================================

local ok, err = pcall(function() sq1:super("doesNotExist") end)
assert(not ok and err:match("super method")) -- nothing
local ok, err = pcall(function() sq1:superGetter("doesNotExist") end)
assert(not ok and err:match("super getter")) -- nothing

--====================================================
-- METAMETHOD OVERRIDE
--====================================================

-- my complex class is basically an example of adding and overriding metamethods of classes

--====================================================
-- LIVE PARENT-CHILD METHOD PROPAGATION
--====================================================

Shape.proto.newMethod = function(self) return "hello" end
print(sq1:newMethod()) -- hello

--====================================================
-- SUMMARY
--====================================================

print("All tests completed successfully.")


--[[
--Dev Notes:
1)
local WeirdCombo = Class({}, Square, Triangle)
-- invalid usage, wont work: currently only one base class per subclass is supported

2)
-- reusing same table
local Proto = { a = 1 }
local A = Class(Proto)
local B = Class(Proto, A) 
-- weird metatable errors and unexpected behaviour may appear
-- this is untested and invalid weird usage, though if you find something cool that this does, please, do tell in the subreddit!

3)--CCCO1:super("super", "override", 3, 4) -- won't work, error: attempt to index nil with '__index' 
--i couldnt find a solution which also kept this pretty syntax, so just dont chain supers

4)--also, ALWAYS use ":" and not "." when calling methods, and never forget that the first arg should always be self when defining new methods
--ive had SO many bugs happen that i spent HOURS trying to fix just because i forgot to add self or used a dot and not a colon
]]
