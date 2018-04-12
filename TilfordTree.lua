local TOP = 101
local BOTTOM = 102
local RIGHT = 103
local LEFT = 104
local CENTER = 105
local BOX = 200
local ROUND = 201

local DISTANCE = 30

function setup()
    size(640, 480)
	stroke(0)
    local f = loadFont("data/Karla.ttf",12)
    root = init()
end

function draw()
    background(255)
    initialize(root,0)
	TilfordLayout(root,60,120)
	drawLinks(root)
    fill(153)
	drawNodes(root,6,ROUND)
    fill(0)
	drawLabels(root,LEFT,10,45)
end

function Node ()
	local x = 0
	local y = 0
	local label = ""
	local data = 0
	local leaves = 0
	local height = 0
	local status = 0
	local children = {}
end

function init()
	root = {x=0,y=0,label="world",data=0,leaves=27,height=3,children={
			{x=0,y=0,label="america",data=0,leaves=9,height=2,children={
				{x=0,y=0,label="canada",data=0,leaves=3,height=1,children={
					{x=0,y=0,label="otawa",data=0,leaves=0,height=0,children={}},
					{x=0,y=0,label="quebec",data=0,leaves=0,height=0,children={}},
					{x=0,y=0,label="montreal",data=0,leaves=0,height=0,children={}}
				}},
				{x=0,y=0,label="mexico",data=0,leaves=3,height=1,children={}},
				{x=0,y=0,label="brazil",data=0,leaves=3,height=1,children={
					{x=0,y=0,label="rio de janeiro",data=0,leaves=0,height=0,children={}},
					{x=0,y=0,label="sao paulo",data=0,leaves=0,height=0,children={}},
					{x=0,y=0,label="recife",data=0,leaves=0,height=0,children={}}
				}}
			}},
			{x=0,y=0,label="europe",data=0,leaves=9,height=2,children={
				{x=0,y=0,label="portugal",data=0,leaves=3,height=1,children={
					{x=0,y=0,label="lisboa",data=0,leaves=0,height=0,children={}},
					{x=0,y=0,label="oporto",data=0,leaves=0,height=0,children={}},
					{x=0,y=0,label="braga",data=0,leaves=0,height=0,children={}}
				}},
				{x=0,y=0,label="spain",data=0,leaves=3,height=1,children={}},
				{x=0,y=0,label="germany",data=0,leaves=3,height=1,children={
					{x=0,y=0,label="berlin",data=0,leaves=0,height=0,children={}},
					{x=0,y=0,label="hamburgo",data=0,leaves=0,height=0,children={}},
					{x=0,y=0,label="munich",data=0,leaves=0,height=0,children={}}
				}}
			}},
			{x=0,y=0,label="asia",data=0,leaves=9,height=2,children={
				{x=0,y=0,label="india",data=0,leaves=3,height=1,children={
					{x=0,y=0,label="bombay",data=0,leaves=0,height=0,children={}},
					{x=0,y=0,label="delhi",data=0,leaves=0,height=0,children={}},
					{x=0,y=0,label="bangalore",data=0,leaves=0,height=0,children={}}
				}},
				{x=0,y=0,label="rusia",data=0,leaves=3,height=1,children={
					{x=0,y=0,label="moscu",data=0,leaves=0,height=0,children={}},
					{x=0,y=0,label="san petersburgos",data=0,leaves=0,height=0,children={}},
					{x=0,y=0,label="novosibirsk",data=0,leaves=0,height=0,children={}}
				}},
				{x=0,y=0,label="china",data=0,leaves=3,height=0,children={}}
			}}
		}
	}
	return root
end

function drawLinks(node)
	local n = #node.children
	for i = 1, n do
		child = node.children[i]
        line(node.x,node.y,child.x,child.y)
        stroke(0)
		drawLinks(child)
	end
end

function drawNodes(node,size,symbol)
	local n = #node.children
	if symbol==ROUND then
        arc(node.x,node.y,size,size,0,2 * PI)
	else
        rect(node.x-size/2,node.y-size/2,size,size)
    end
	for i = 1, n do
		child = node.children[i]
		drawNodes(child,size,symbol)
	end
end

function drawLabels(node,position,offset,degrees)
    local dx=0
    local dy=0
	textAlign(CENTER)
	local n = #node.children
	if position == TOP then
		dy = -offset
	elseif position == BOTTOM then
		dy = offset
    elseif position == RIGHT then
 		dx = -offset
         textAlign(RIGHT)
    elseif position == LEFT then
		dx = offset
		textAlign(LEFT)
	end
    --local h = draw.measureText('M').width - 2
    local h = 2
	pushMatrix()
	translate(node.x,node.y)
	if degrees then rotate(degrees*PI/180) end
	text(node.label,dx,dy+h/2)
	popMatrix()
	for i = 1, n do
		child = node.children[i]
		drawLabels(child,position,offset,degrees)
	end
end

function initialize(node,level)
	node.prelim = 0
	node.mod = 0
	node.level = level
	for i = 1, #node.children do
		initialize(node.children[i],level+1)
	end
end

function secondWalk(t, dx, dy)
	local dx=dx+t.mod
	t.x = t.prelim + dx
	t.y = t.level * 60 + dy
	for i = 1, #t.children do
        secondWalk(t.children[i],dx,dy)
    end
end

function positionRoot(t)
	local n = #t.children
	t.prelim = (t.children[1].prelim + t.children[1].mod + t.children[n].mod + t.children[n].prelim + DISTANCE)/2 - DISTANCE/2
end

function setRightThread(t, i, sr, modsumsr) 
	local ri = t.children[i].er
	ri.tr = sr
	local diff = (modsumsr - sr.mod) - t.children[i].mser 
	ri.mod = ri.mod + diff
	ri.prelim = ri.prelim - diff
	t.children[i].er = t.children[i-1].er 
	t.children[i].mser = t.children[i-1].mser
end

function setLeftThread(t, i, cl, modsumcl) 
	local li = t.children[1].el
	li.tl = cl
	local diff = (modsumcl - cl.mod) - t.children[1].msel 
	li.mod = li.mod + diff
	li.prelim = li.prelim - diff
	t.chldren[1].el = t.children[i].el 
	t.children[1].msel = t.children[i].msel
end

function nextRightContour(t)
    if #t.children==0 then
        return t.tr
    else
        return t.children[#t.children]
    end
end

function nextLeftContour(t)
    if #t.children==0 then
        return t.tl
    else
        return t.children[1]
    end
end

function moveSubtree(t, i, dist)
	t.children[i].mod=t.children[i].mod+dist 
	t.children[i].msel=t.children[i].msel+dist 
	t.children[i].mser=t.children[i].mser+dist
end

function separate(t,i,ih)
	local sr = t.children[i-1] 
	local mssr = sr.mod
	local cl = t.children[i] 
	local mscl = cl.mod
	while (sr ~= nil) and (cl ~= nil) do
		local dist = (mssr + sr.prelim + DISTANCE) - (mscl + cl.prelim)
		if dist > 0 then
			mscl=mscl+dist
			moveSubtree(t,i,dist)
		end
		
		sr = nextRightContour(sr) 
		if sr ~= nil then mssr=mssr+sr.mod end
		
		cl = nextLeftContour(cl) 
		if cl ~= nil then mscl=mscl+cl.mod end
	end
	if (sr == nil) and (cl ~= nil) then
		setLeftThread(t,i,cl, mscl)
	elseif (sr ~= nil) and (cl == null) then
        setRightThread(t,i,sr,mssr)
    end
end

function setExtremes(t)
	local n = #t.children
	if n == 0 then
        t.el = t
        t.er = t
        t.msel = 0
        t.mser = 0
	else
		t.el = t.children[1].el t.msel = t.children[1].msel
		t.er = t.children[n].er t.mser = t.children[n].mser
	end
end

function firstWalk(t)
    local cs = #t.children
	if cs==0 then
		setExtremes(t)
		return
	end
	firstWalk(t.children[1])
	for i = 2, cs do
		firstWalk(t.children[i])
		separate(t,i)
	end
	positionRoot(t)
	setExtremes(t)
end

function TilfordLayout(t,dx,dy)
	firstWalk(t)
	secondWalk(t,dx,dy)
end