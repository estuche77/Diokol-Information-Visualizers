local xoffset = 150
local yoffset = 20

function setup()
    size(620, 460)
	stroke(0)
	fill(0)
    local f = loadFont("data/Karla.ttf",12)
end

function draw()
    background(255)
    local root = init()
    NodoSpace(root)
    indent(root,10,10,620,460)
    drawing(root)
end

function Node ()
	local x = 0
	local y = 0
	local label = ""
	local data = 0
	local leaves = 0
    local height = 0
    local space = 0
	local children = {}
end

function init()
	local root = {x=0,y=0,label="world",data=0,leaves=11,height=3,space=1,children={
			{x=0,y=0,label="america",data=0,leaves=4,height=2,space=1,children={
				{x=0,y=0,label="canada",data=0,leaves=2,height=1,space=1,children={
					{x=0,y=0,label="quebec",data=0,leaves=0,height=0,space=1,children={}},
					{x=0,y=0,label="montreal",data=0,leaves=0,height=0,space=1,children={}}
				}},
				{x=0,y=0,label="mexico",data=0,leaves=1,height=1,space=1,children={
					{x=0,y=0,label="monterrey",data=0,leaves=0,height=0,space=1,children={}}
				}},
				{x=0,y=0,label="brazil",data=0,leaves=1,height=1,space=1,children={
					{x=0,y=0,label="sao paulo",data=0,leaves=0,height=0,space=1,children={}}
				}}
			}},
			{x=0,y=0,label="europe",data=0,leaves=4,height=2,space=1,children={
				{x=0,y=0,label="portugal",data=0,leaves=2,height=1,space=1,children={
					{x=0,y=0,label="lisboa",data=0,leaves=0,height=0,space=1,children={}},
					{x=0,y=0,label="porto",data=0,leaves=0,height=0,space=1,children={}}
				}},
				{x=0,y=0,label="germany",data=0,leaves=2,height=1,space=1,children={
					{x=0,y=0,label="munich",data=0,leaves=0,height=0,space=1,children={}},
					{x=0,y=0,label="berlin",data=0,leaves=0,height=0,space=1,children={}}
				}}
			}},
			{x=0,y=0,label="asia",data=0,leaves=3,height=2,space=1,children={
				{x=0,y=0,label="india",data=0,leaves=1,height=1,space=1,children={
					{x=0,y=0,label="bombay",data=0,leaves=0,height=0,space=1,children={}}
				}},
				{x=0,y=0,label="china",data=0,leaves=2,height=1,space=1,children={
					{x=0,y=0,label="shangai",data=0,leaves=0,height=0,space=1,children={}},
					{x=0,y=0,label="pekin",data=0,leaves=0,height=0,space=1,children={}}
				}}
			}}
		}
	}
	return root
end

function drawing(node)
	n = #node.children
    rect(node.x-4,node.y-4,8,8)
    text(node.label,node.x+6,node.y)
	for i = 1, n do
        child = node.children[i]
        line(node.x,node.y, node.x,child.y)
		line(node.x,child.y, child.x,child.y)
        drawing(child)
    end
end

function indent(node,x,y,w,h)
	node.x = x
	node.y = y
    if #node.children ~= 0 then
        local espacio = 1
        for i = 1, #node.children do
            indent(node.children[i],x+xoffset,y + (yoffset * espacio),w,h)
            espacio = espacio + node.children[i].space
        end
    end
end

function NodoSpace(node)
	node.space = 1
	if #node.children ~= 0 then
		for i = 1, #node.children do
			NodoSpace(node.children[i])
            node.space = node.space + node.children[i].space
        end
    end
end