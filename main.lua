-- main.lua
-- einfaches Fangspiel mit LÖVE2D

function love.load()
  love.window.setTitle("Catch Game")
  windowWidth, windowHeight = love.graphics.getDimensions()

  player = {
    x = windowWidth / 2 - 30,
    y = windowHeight - 40,
    w = 60,
    h = 20,
    speed = 300,
    sprintFactor = 2.2 -- 1.8 -- bewegt sich ~80 % schneller, wenn Shift gehalten wird
  }

  objects = {}
  spawnTimer = 0
  spawnInterval = 1 -- seconds
  score = 0
  lives = 3
  font = love.graphics.newFont(20)
  love.graphics.setFont(font)
  gameOver = false
end

local function spawnObject()
  local size = 20
  local object = {
    x = math.random(size, windowWidth - size),
    y = -size,
    size = size,
    speed = 200
  }
  table.insert(objects, object)
end

function love.update(dt)
  if gameOver then return end

  -- horizontale Richtung (-1, 0, 1).
  local direction = 0
  if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
    direction = direction - 1
  end
  if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
    direction = direction + 1
  end

  -- Sprint-Multiplikator, wenn Shift gehalten wird
  local currentSpeed = player.speed
  if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
    currentSpeed = currentSpeed * player.sprintFactor
  end

  player.x = player.x + direction * currentSpeed * dt

  -- Spieler innerhalb des Fensters halten
  player.x = math.max(0, math.min(player.x, windowWidth - player.w))

  -- fallende Objekte erzeugen
  spawnTimer = spawnTimer + dt
  if spawnTimer >= spawnInterval then
    spawnObject()
    spawnTimer = 0
  end

  -- Objekte aktualisieren
  for i = #objects, 1, -1 do
    local o = objects[i]
    o.y = o.y + o.speed * dt

    -- Kollisionserkennung: Spieler fängt Objekt
    local caught = o.y + o.size > player.y
                   and o.x < player.x + player.w
                   and o.x + o.size > player.x

    if caught then
      score = score + 1
      table.remove(objects, i)
    elseif o.y - o.size > windowHeight then -- fehlendes Objekt
      lives = lives - 1
      table.remove(objects, i)
      if lives <= 0 then
        gameOver = true
      end
    end
  end
end

function love.draw()
  -- Spieler erzeugen
  love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)

  -- fallende Objekte erzeugen
  for _, o in ipairs(objects) do
    love.graphics.circle("fill", o.x, o.y, o.size)
  end

  -- HUD
  love.graphics.print("Score: " .. score, 10, 10)
  love.graphics.print("Lives: " .. lives, 10, 40)
  love.graphics.print("Shift = Turbo", 10, 70)

  if gameOver then
    love.graphics.printf("Game Over! Press R to restart", 0, windowHeight / 2 - 20, windowWidth, "center")
  end
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  elseif gameOver and key == "r" then
    -- Spiel zurücksetzen
    objects = {}
    score = 0
    lives = 3
    gameOver = false
  end
end
