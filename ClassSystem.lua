local Class = {}
Class.outerMeta = {}
Class.innerMeta = {}
Class.define = function(self, o, base)
	assert(type(o) == "table", "Expected a table for prototype")
	local parentProto = base and base.proto
	local parentStatic = base and base.static
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
		end,
		superGetter = function(self, getterName)
			local proto = getmetatable(self).__proto
			local parentMeta = getmetatable(proto)
			local parentProto = parentMeta and parentMeta.__index
			if parentProto then
				local parentGetters = parentProto.getters
				local getter = parentGetters and parentGetters[getterName]
				if getter then
					return getter(self)
				end
			end
			error("super getter '"..getterName.."' not found")
		end
	}
	for k, v in pairs(o) do
		if k ~= "static" then
			proto[k] = v
		end
	end
	if parentStatic and parentStatic.onInstance and parentStatic.passOnInstance then
		static.onInstance = parentStatic.onInstance
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
	if parentStatic and parentStatic.onSubclass then
		class = parentStatic.onSubclass(base, class) or class
	end
	return class
end
Class.proto = {
	new = function(self, obj)
		obj = obj or {}
		setmetatable(obj, self.meta)
		local static = self.static
		if static and static.onInstance then
			obj = static.onInstance(self, obj) or obj
		end
		return obj
	end,
}
Class.outerMeta.__index = Class.proto
Class.outerMeta.__call = function(self, obj)
	return self:new(obj)
end
Class.innerMeta.__call = function(self, obj, base) return self:define(obj, base) end
setmetatable(Class, Class.innerMeta)
return Class
