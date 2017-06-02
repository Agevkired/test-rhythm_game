local M={}
--STARTING POSITION
--lx = 4 --LEFT BOX
--ly = 9
--rx = 15 --RIGHT BOX
--ry = 9

function loadsong()
	notes = 300
	notes = 51
	noteposition = {} --initialize variables
	color = {}
	xpos = {}
	ypos = {}
	passed = {}
	--TESTING
	--for n=1,300 do
	for n=1,51 do
		--noteposition[n] = n + 4
		--color[n] = 0 --0=red 1=blue 2=purple
		--20x20 grid
		--xpos[n] = n%20
		--ypos[n] = math.floor(n/20)
		passed[n] = false
	end
	setupnoteposition()
	setupcolor()
	setupxpos()
	setupypos()
end

function setupnoteposition()
	--300 notes on beat
	--16 starts
	--for n=1,300 do
		--noteposition[n] = n + 4
	--end
	for n=1,16 do --PATH 1 and 2  GOOD
		noteposition[n] = n
	end
	noteposition[17] = 17 --PATH 3
	noteposition[18] = 17
	noteposition[19] = 18
	noteposition[20] = 18
	noteposition[21] = 19
	noteposition[22] = 19
	noteposition[23] = 20
	noteposition[24] = 20
	for n=21,23 do --PATH 4 - 5
		noteposition[n+4] = n
	end
	for n=24,37 do --PATH 6
		noteposition[n+4] = n
	end
	--position 41
	noteposition[42] = 38 --PATH 7
	noteposition[43] = 38
	noteposition[44] = 39
	noteposition[45] = 39
	noteposition[46] = 40
	noteposition[47] = 40
	noteposition[48] = 41
	noteposition[49] = 41
	noteposition[50] = 42
	noteposition[51] = 42
	for n=1,51 do
		noteposition[n] = noteposition[n] + 15
	end
end

function setupcolor()
	--alternate between red and blue starting with blue
	--for n=1,300 do
	--	color[n] = n%2
	--end
	--for n=1,300 do
	--	color[n] = 2
	--end
	for n=1,8 do --PATH 1
		color[n] = 0
	end
	for n=9,16 do --PATH 2
		color[n] = 1
	end
	color[17]= 0 --PATH 3
	color[18]= 1
	color[19]=0
	color[20]=1
	color[21]=0
	color[22]=1
	color[23]=0
	color[24]=1
	color[25]=1 --PATH 4
	color[26]=0 --PATH 5
	color[27]=0
	for n=28,41 do --PATH 6
		color[n] = 2
	end
	color[42]= 0
	color[43]= 1
	color[44]= 0
	color[45]= 1
	color[46]= 0
	color[47]= 1
	color[48]= 0
	color[49]= 1
	color[50]= 0
	color[51]= 1
end

function setupxpos()
	xpos[1] = 3 --PATH 1
	xpos[2] = 2
	xpos[3] = 1
	xpos[4] = 1
	xpos[5] = 1
	xpos[6] = 2
	xpos[7] = 3
	xpos[8] = 4
	xpos[9] = 16 --PATH 2
	xpos[10] = 17
	xpos[11] = 18
	xpos[12] = 18
	xpos[13] = 18
	xpos[14] = 17
	xpos[15] = 16
	xpos[16] = 15
	xpos[17] = 5--PATH 3, 2 at a time
	xpos[18] = 14
	xpos[19] = 6
	xpos[20] = 13
	xpos[21] = 7
	xpos[22] = 12
	xpos[23] = 8
	xpos[24] = 11
	xpos[25] = 10 --PATH 4
	xpos[26] =  9 --PATH 5
	xpos[27] = 10
	xpos[28] = 10 --PATH 6
	xpos[29] = 10
	xpos[30] = 10
	xpos[31] = 10
	xpos[32] = 10
	xpos[33] = 10
	xpos[34] = 10
	xpos[35] = 9
	xpos[36] = 8
	xpos[37] = 8
	xpos[38] = 8
	xpos[39] = 9
	xpos[40] = 10
	xpos[41] = 10
	xpos[42] = 11 --PATH 7, 2 at a time
	xpos[43] = 9
	xpos[44] = 12
	xpos[45] = 8
	xpos[46] = 13
	xpos[47] = 7
	xpos[48] = 14
	xpos[49] = 6
	xpos[50] = 15
	xpos[51] = 5
end

function setupypos()
	ypos[1] = 9 --PATH 1
	ypos[2] = 9
	ypos[3] = 9
	ypos[4] = 8
	ypos[5] = 7
	ypos[6] = 7
	ypos[7] = 7
	ypos[8] = 7
	ypos[9] = 9--PATH 2
	ypos[10] = 9
	ypos[11] = 9
	ypos[12] = 8
	ypos[13] = 7
	ypos[14] = 7
	ypos[15] = 7
	ypos[16] = 7
	ypos[17] = 7--PATH 3, 2 at a time
	ypos[18] = 7
	ypos[19] = 7
	ypos[20] = 7
	ypos[21] = 7
	ypos[22] = 7
	ypos[23] = 7
	ypos[24] = 7
	ypos[25] = 7--PATH 4
	ypos[26] = 7--PATH 5
	ypos[27] = 7
	ypos[28] = 8--PATH 6
	ypos[29] = 9
	ypos[30] = 10
	ypos[31] = 11
	ypos[32] = 12
	ypos[33] = 13
	ypos[34] = 14
	ypos[35] = 14
	ypos[36] = 14
	ypos[37] = 15
	ypos[38] = 16
	ypos[39] = 16
	ypos[40] = 16
	ypos[41] = 15
	ypos[42] = 15--PATH 7, 2 at a time
	ypos[43] = 15
	ypos[44] = 15
	ypos[45] = 15
	ypos[46] = 15
	ypos[47] = 15
	ypos[48] = 15
	ypos[49] = 15
	ypos[50] = 15
	ypos[51] = 15
end

M.loadsong = loadsong

return M