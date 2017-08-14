local Signal = {}
Signal.__index = Signal

function Signal:Connect(listener)
	return self.Bind.Event:connect(function (key)
		listener(unpack(self.Cache[key]))
	end)
end

function Signal:Wait()
	return unpack(self.Cache[self.Bind.Event:wait()])
end

function Signal:Fire(...)
	local key = tick()
	self.Cache[key] = {...}
	self.Bind:Fire(key)
	self.Cache[key] = nil
end

Signal.connect = Signal.Connect
Signal.wait = Signal.Wait

function Signal:Destroy()
	self.Bind:Destroy()
	self.Bind = nil
	self.Cache = nil
end

function Signal.new()
	return setmetatable({
		Bind = Instance.new("BindableEvent"),
		Cache = {},
	}, Signal)
end

return Signal
