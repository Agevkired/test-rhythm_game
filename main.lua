function love.load()
	--BG = love.graphics.newImage("New_Decade-jacket.png")
	local am3p = require("am3p")
	BG = love.graphics.newImage("AM-3P-jacket.png")
	grid = love.graphics.newImage("grid30.png")
	music = love.audio.newSource("AM-3P.wav")
	--music = love.audio.newSource("New_Decade.wav")
	music:play()
	--titlebg = love.graphics.newImage()
	--titlemenu = love.graphics.newImage()
	--stagegrid = love.graphics.newImage()
	lx = 4 --LEFT BOX
	ly = 9
	rx = 15 --RIGHT BOX
	ry = 9
	
	--GAME VARIABLES
	life = 275 --TEST
	life = 200
	lifeloss = 0 --flash red when life lost
	score = 0
	
	testscale = 0
	timepassed = 0 --time passed in song
	deltatimer = 0 --limiter?
	mult = .4 --note speed multiplier, 1x is by BPM
	
	--TESTING PURPOSES
	bpm = 130 --AM-3P
	--bpm = 400
	bps = bpm / 60 --beats per second, around 2.166666... a second for AM-3P
	spb = 1 / bps --seconds per beat
	notes = 1
	ntime = 1 --testing noteposition
	noteposition = {} --initialize variables
	color = {}
	xpos = {}
	ypos = {}
	
	am3p.loadsong()
	love.graphics.setBackgroundColor(0,0,0)
	love.window.setMode(800, 600, {fullscreen=false, resizable=false, vsync=true, minwidth=400, minheight=300})
	love.keyboard.setKeyRepeat(false)
end
 
function love.draw()
	--DRAW THE BACKGROUND AND GRID
	love.graphics.reset()
	love.graphics.setColor(255,255, 255, 128)
	love.graphics.draw(BG, 100, 0, 0, 600/BG:getWidth(), 600/BG:getHeight())
	love.graphics.reset()
	love.graphics.draw(grid, 0, 0)
	
	--DRAW THE LIFEBAR
	--lifebar
	love.graphics.setColor(255*(lifeloss), 255*(1-lifeloss), 0, 255)
	love.graphics.rectangle("fill", 25, 575, 50, -(2*life))
	lifeloss = 0 --reset bool

	--SCROLL THROUGH CHART AND DRAW SQUARES
	for n=1,notes do
		if (timepassed-(noteposition[n]*spb-(1/bps/mult))) > 0 and timepassed < (noteposition[n]*spb) then --If timer is within note position
			ntimedelta = (timepassed-(noteposition[n]*spb-(1/bps/mult)))
			love.graphics.setColor(128*(1-color[n]), 0, 128*color[n], 255*bps*mult*ntimedelta) --Draw red or blue
			if color[n] == 2 then
				love.graphics.setColor(192, 0, 192, 255*bps*mult*ntimedelta)
			end
			love.graphics.rectangle("fill", 100+(30*xpos[n]), 30*ypos[n], 30, 30) --draw corresponding color
			--love.graphics.rectangle("fill", 400-15, 300-15, 30, 30) --draw corresponding color
			
			--love.graphics.setColor(255, 255, 0, 200) --yellow
			--love.graphics.rectangle("line", 100+(30*xpos[n])+15-(15*bps*mult*ntimedelta), 30*ypos[n]+15-(15*bps*mult*ntimedelta), (30*bps)*mult*ntimedelta, (30*bps)*mult*ntimedelta) --draw note timer
			--love.graphics.rectangle("line", 400-(15*bps*mult*ntimedelta), 300-(15*bps*mult*ntimedelta), (30*bps)*mult*ntimedelta, (30*bps)*mult*ntimedelta) --draw note timer
		end
		if timepassed > (noteposition[n]*spb) and not passed[n] then
			life = life - 2
			lifeloss = 1
			if color[n]==0 then --red
				if xpos[n] == lx and ypos[n] == ly then
					life = life + 3
					passed[n] = true
					lifeloss = 0
				end
			elseif color[n]==1 then --blue
				if xpos[n] == rx and ypos[n] == ry then
					life = life + 3
					passed[n] = true
					lifeloss = 0
				end
			elseif color[n]==2 then --purple
				if xpos[n] == lx and ypos[n] == ly and xpos[n] == lx and ypos[n] == ly then
					life = life + 3
					passed[n] = true
					lifeloss = 0
				end
			end
			if life > 275 then
				life = 275
			end
			passed[n] = true
		end
	end
	
	--DRAW THE PLAYER SQUARES
	if lx==rx and ly==ry then
		love.graphics.setColor(192, 0, 192, 255)  --Draw Purple
		love.graphics.rectangle("fill", 100+(30*lx), 30*ly, 30, 30 )
	else
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.rectangle("fill", 100+(30*lx), 30*ly, 30, 30 ) --Player controlled, left-red
		love.graphics.setColor(0, 0, 255, 255)
		love.graphics.rectangle("fill", 100+(30*rx), 30*ry, 30, 30 ) --Player controlled, right-blue
	end
	
	for n=1,notes do
		ntimedelta = (timepassed-(noteposition[n]*spb-(1/bps/mult)))
		if (timepassed-(noteposition[n]*spb-(1/bps/mult))) > 0 and timepassed < (noteposition[n]*spb) then --If timer is within note position
			love.graphics.setColor(255, 255, 0, 200) --yellow
			love.graphics.rectangle("line", 100+(30*xpos[n])+15-(15*bps*mult*ntimedelta), 30*ypos[n]+15-(15*bps*mult*ntimedelta), (30*bps)*mult*ntimedelta, (30*bps)*mult*ntimedelta) --draw note timer
			--love.graphics.rectangle("line", 400-(15*bps*mult*ntimedelta), 300-(15*bps*mult*ntimedelta), (30*bps)*mult*ntimedelta, (30*bps)*mult*ntimedelta) --draw note timer
		end
	end
	
	--TESTING
	--if (timepassed-(ntime*spb-(1/bps/mult))) > 0 and timepassed < (ntime*spb) then --If timer is within note position
		--ntimedelta = (timepassed-(ntime*spb-(1/bps/mult)))
		--love.graphics.setColor(0, 0, 128, 200*bps*mult*ntimedelta)
		--love.graphics.rectangle("fill", 400-15, 300-15, 30, 30) --draw corresponding color
		
		--love.graphics.setColor(255, 255, 0, 200) --yellow
		--love.graphics.rectangle("line", 400-(15*bps*mult*ntimedelta), 300-(15*bps*mult*ntimedelta), (30*bps)*mult*ntimedelta, (30*bps)*mult*ntimedelta) --draw note timer
	--end
	
end

function love.update(dt) --sum of dt for 1 second = 1
	deltatimer = deltatimer + dt
	if love.keyboard.isDown('q') then
		testscale = testscale - dt
	end
	if love.keyboard.isDown('e') then
		testscale = testscale + dt
	end
	timepassed = timepassed + dt
end

function love.keypressed(key, scancode, isrepeat)
	--LEFT BOX CONTROL
	if key == "a" then --left
		lx = lx - 1
		if lx < 0 then
			lx = 19
		end
	end
	if key == "d" then --right
		lx = lx + 1
		if lx > 19 then
			lx = 0
		end
	end
	if key == "w" then --up
		ly = ly - 1
		if ly < 0 then
			ly = 19
		end
	end
	if key == "s" then --down
		ly = ly + 1
		if ly > 19 then
			ly = 0
		end
	end
	--RIGHT BOX CONTROL
	if key == "left" then --left
		rx = rx - 1
		if rx < 0 then
			rx = 19
		end
	end
	if key == "right" then --right
		rx = rx + 1
		if rx > 19 then
			rx = 0
		end
	end
	if key == "up" then --up
		ry = ry - 1
		if ry < 0 then
			ry = 19
		end
	end
	if key == "down" then --down
		ry = ry + 1
		if ry > 19 then
			ry = 0
		end
	end
	
	if key == "escape" then
		love.event.quit()
	end
end
