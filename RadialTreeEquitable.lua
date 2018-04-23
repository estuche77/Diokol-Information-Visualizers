require 'data/datalist'

local BOX = 200
local ROUND = 201

function setup()
    size(620, 520)
	stroke(0)
    noFill()
    strokeWeight(0.5)
    local f = loadFont("data/Karla.ttf",12)
	root = init()
	initialize(root)
	RadialTree(root)
end

function draw()
	background(255)
	drawLinks(root)
	drawNodes(root,3,ROUND)
end

function Node ()
	x = 0
	y = 0
	label = ""
	data = 0
	leaves = 0
	height = 0
	children = {}
end

function drawLinks(node)
	local n = #node.children
	for i = 1, n do
		child = node.children[i]
		line(node.x,node.y,child.x,child.y)
		drawLinks(child)
	end
end

function drawNodes(node,size,symbol)
    local n = #node.children
	if symbol == ROUND then
		arc(node.x,node.y,size,size,0,2 * PI,OPEN)
	else
        rect(node.x-size/2,node.y-size/2,size,size)
    end
	for i = 1, n do
		child = node.children[i]
		drawNodes(child,size,symbol)
	end
end

function secondWalk(v, dx, dy)
	v.x = (v.r*math.cos(v.a))+dx
	v.y = (v.r*math.sin(v.a))+dy
	
	for i = 1, #v.children do
		local u = v.children[i]
		secondWalk(u,dx,dy)
	end
end

function firstWalk(v,r,a1,a2,e)
	v.r = r
	v.a = (a1 + a2)/2
	local s = (a2 - a1)/v.leaves
	local a = a1
	for i = 1, #v.children do
		local u = v.children[i]
		firstWalk(u,r+e,a,a+s*u.leaves,e)
		a = a + s* u.leaves
	end
end

function RadialTree(n)
	firstWalk(n,0,0,2*PI,70)
	secondWalk(n,320,290)
end

function initialize(node)
	node.c = 0
	node.r = 0
	node.a = 0
	local leaves = 0
	if #node.children == 0 then
        leaves = 1
    end
	for i = 1, #node.children do
		local child = node.children[i]
		child.index = i
		child.parent = node
		initialize(child)
		leaves = leaves + child.leaves
	end
	node.leaves = leaves
end
