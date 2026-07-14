CreateSummaryClass = Class({ __includes = BaseState })

function CreateSummaryClass:init(def)
	self.font = gFonts["small"]
	self.x = VIRTUAL_WIDTH / 4
	self.y = VIRTUAL_HEIGHT / 4
	self.width = VIRTUAL_WIDTH / 2
	self.height = VIRTUAL_HEIGHT / 2
	self.panel = Panel(self.x - 10, self.y - self.font:getLineHeight() - 10, self.width + 20, self.height + 20)
	-- array of user's pokemons
	self.party = def.party
	-- current highlighted pokemon
	self.highlighted = 1
	love.graphics.setFont(self.font)
end

function CreateSummaryClass:update(dt)
	-- page through pokemons using left/right keys and "M" key to exit menu
	if love.keyboard.wasPressed("left") then
		self.highlighted = (self.highlighted + 1 - 1) % #self.party + 1
	elseif love.keyboard.wasPressed("right") then
		self.highlighted = (self.highlighted - 1 - 1) % #self.party + 1
	elseif love.keyboard.wasPressed("m") then
		gStateStack:pop()
	end
end

function CreateSummaryClass:render()
	self.panel:render()
	-- display party size
	love.graphics.printf(
		"SIZE: " .. tostring(#self.party) .. "/6",
		self.panel.x,
		self.panel.y + 2,
		self.panel.width - 2,
		"right"
	)
	local pokemon = self.party[self.highlighted]
	-- display currently highlighted pokemon's name
	love.graphics.setColor(1, 1, 0, 1)
	love.graphics.printf(pokemon.name, self.panel.x, self.panel.y + 2, self.panel.width - 2, "center")
	love.graphics.setColor(1, 1, 1, 1)
	-- display front image, level and all stats of current highlighted pokemon
	local yGap = self.font:getLineHeight() + 5
	local xOff = 70
	love.graphics.draw(gTextures[pokemon.battleSpriteFront], self.x, self.y)
	love.graphics.print("name: " .. pokemon.name, self.x + xOff, self.y + 1 * yGap)
	love.graphics.print("level: " .. tostring(pokemon.level), self.x + xOff, self.y + 2 * yGap)
	love.graphics.print("current exp: " .. tostring(pokemon.currentExp), self.x + xOff, self.y + 3 * yGap)
	love.graphics.print("exp to level: " .. tostring(pokemon.expToLevel), self.x + xOff, self.y + 4 * yGap)
	love.graphics.print("current HP: " .. tostring(pokemon.currentHP), self.x + xOff, self.y + 5 * yGap)

	love.graphics.print("base HP: " .. tostring(pokemon.baseHP), self.x + xOff, self.y + 6 * yGap)
	love.graphics.print("base ATK: " .. tostring(pokemon.baseAttack), self.x + xOff, self.y + 7 * yGap)
	love.graphics.print("base DEF: " .. tostring(pokemon.baseDefense), self.x + xOff, self.y + 8 * yGap)
	love.graphics.print("base SPD: " .. tostring(pokemon.baseSpeed), self.x + xOff, self.y + 9 * yGap)

	love.graphics.print("HP IV: " .. tostring(pokemon.HPIV), self.x + xOff, self.y + 10 * yGap)
	love.graphics.print("ATK IV: " .. tostring(pokemon.attackIV), self.x + xOff, self.y + 11 * yGap)
	love.graphics.print("DEF IV: " .. tostring(pokemon.defenseIV), self.x + xOff, self.y + 12 * yGap)
	love.graphics.print("SPD IV: " .. tostring(pokemon.speedIV), self.x + xOff, self.y + 13 * yGap)

	love.graphics.print("HP: " .. tostring(pokemon.HP), self.x + xOff, self.y + 14 * yGap)
	love.graphics.print("ATK: " .. tostring(pokemon.attack), self.x + xOff, self.y + 15 * yGap)
	love.graphics.print("DEF: " .. tostring(pokemon.defense), self.x + xOff, self.y + 16 * yGap)
	love.graphics.print("SPD: " .. tostring(pokemon.speed), self.x + xOff, self.y + 17 * yGap)
end
