--[[

Feel free to use this however you like, whether its for a running system, a walking system and what not

]]
mt = {
	frequency = 10,
	amplitude = .50,
	percent = .25,
	character = game.Players.LocalPlayer.Character,
	humanoid = game.Players.LocalPlayer.Character:FindFirstChild('Humanoid')
}
mt.__index = mt

local runservice = game:GetService("RunService")

local connection

function mt.New(character:Model,humanoid:Humanoid,frequency:number,amplitude:number,percent:number)
	local self = setmetatable({},mt)
	self.frequency = frequency --10
	self.amplitude = amplitude --.50
	self.character = character
	self.humanoid = humanoid
	self.percent = percent --.25
	return self
end

function mt:updateBobbleEffect()
	self.CurrentTime = tick()
	local BobbleX = math.cos(self.CurrentTime * self.frequency) * self.amplitude
	local BobbleY = math.abs(math.sin(self.CurrentTime * self.frequency)) * self.amplitude --adjust your values as needed
	local Bobble = Vector3.new(BobbleX, BobbleY, 0)
	self.humanoid.CameraOffset = self.humanoid.CameraOffset:lerp(Bobble, self.percent)
	--self.humanoid.CameraOffset = Bobble (you may use this as an alternative)
end

--we used math.abs on math.sin because its usually -1 and 1, math.abs makes it 0 and 1, without math.abs it will have downward motion, which means its bad


function mt:enableBobble()
	if connection == nil then
		connection = runservice.RenderStepped:Connect(function()
			self:updateBobbleEffect()
		end)
	end
end


function mt:disableBobble()
	if connection then
		connection:Disconnect()
		connection = nil
	end
	self.humanoid.CameraOffset = Vector3.zero
end

return mt
