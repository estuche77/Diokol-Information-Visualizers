local VERTICAL = 0
local HORIZONTAL = 1

function setup()
    size(640, 500)
    stroke(0)
    fill(0)
    local f = loadFont("data/Karla.ttf",12)
end

function draw()
    background(255)
	
	local nodesU = initU()
	local nodesV = initV()
	
	text("Original",150,400)
	text("Optimized",450,400)

	local orderU = orderedArray(nodesU)
	local orderV = orderedArray(nodesV)
	linearLayout(nodesU,orderU,120,80,300,VERTICAL)
	linearLayout(nodesV,orderV,220,80,300,VERTICAL)
	drawLinks(nodesU,nodesV)
	drawNodes(nodesU)
	drawNodes(nodesV)
	drawLabels(nodesU,RIGHT)
	drawLabels(nodesV,LEFT)

	translate(320,0)
	
	local orderU = orderedArray(nodesU)
	local orderV = orderedArray(nodesV)
	barycenter(nodesU,orderU,nodesV,orderV)
	linearLayout(nodesU,orderU,120,80,300,VERTICAL)
	linearLayout(nodesV,orderV,220,80,300,VERTICAL)
	drawLinks(nodesU,nodesV)
	drawNodes(nodesU)
	drawNodes(nodesV)
	drawLabels(nodesU,RIGHT)
	drawLabels(nodesV,LEFT)	
end

function Node ()
	local x = 0
	local y = 0
	local label = ""
    local data = 0
    local pos = 0
	local neighbors = {}
	local type = 0
end

function OrderedNode ()
    node = {index = 0, average = 0}
    return node
end

function initU()
	local root = {{id=0,x=0,y=0,label="Lord of the Rings 1",type=1,pos=1,neighbors={0,1,8}},
			{id=1,x=0,y=0,label="The Hobbit 1",type=1,pos=1,neighbors={0,1,8}},
			{id=2,x=0,y=0,label="Pirates of the Caribbean",type=1,pos=1,neighbors={1,2}},
			{id=3,x=0,y=0,label="Sin City",type=1,pos=1,neighbors={0,3,4}},
			{id=4,x=0,y=0,label="Pulp Fiction",type=1,pos=1,neighbors={4,5,9}},
			{id=5,x=0,y=0,label="Unbreakable",type=1,pos=1,neighbors={4,5}},
			{id=6,x=0,y=0,label="Star Wars Episode 1",type=1,pos=1,neighbors={2,5,6}},
			{id=7,x=0,y=0,label="Cold Mountain",type=1,pos=1,neighbors={6,7}},
			{id=8,x=0,y=0,label="Anna Karenina",type=1,pos=1,neighbors={2,7}},
			{id=9,x=0,y=0,label="The Aviator",type=1,pos=1,neighbors={7,8}},
			{id=10,x=0,y=0,label="Gattaca",type=1,pos=1,neighbors={7,9}}
		}
	return root
end

function initV()		
	local root = {{id=0,x=0,y=0,label="Elijah Wood",type=0,pos=1,neighbors={0,1,3}},
			{id=1,x=0,y=0,label="Orlando Bloom",type=0,pos=1,neighbors={0,1,2}},
			{id=2,x=0,y=0,label="Keira Knightley",type=0,pos=1,neighbors={2,6,8}},
			{id=3,x=0,y=0,label="Jessica Alba",type=0,pos=1,neighbors={3}},
			{id=4,x=0,y=0,label="Bruce Willis",type=0,pos=1,neighbors={3,4}},
			{id=5,x=0,y=0,label="Samuel L. Jackson",type=0,pos=1,neighbors={4,5,6}},
			{id=6,x=0,y=0,label="Natalie Portman",type=0,pos=1,neighbors={6,7}},
			{id=7,x=0,y=0,label="Jude Law",type=0,pos=1,neighbors={7,8,9}},
			{id=8,x=0,y=0,label="Cate Blanchett",type=0,pos=1,neighbors={0,1,9}},
			{id=9,x=0,y=0,label="Uma Thurman",type=0,pos=1,neighbors={4,10}}
		}
	return root
end

function drawLinks(nodesU,nodesV)
	for i = 1, #nodesU do
		local neighbors = nodesU[i].neighbors
		for j = 1, #neighbors do
            local k = neighbors[j] + 1
			line(nodesU[i].x,nodesU[i].y,nodesV[k].x,nodesV[k].y)
		end
	end
end

function drawNodes(nodes)
	local N = #nodes
    for i = 1, N do
		arc(nodes[i].x,nodes[i].y,4,4,0,2*PI)
	end
end

function drawLabels(nodes,mode)
	local N = #nodes
    local xoffset = 0
	if (mode==LEFT) then
		xoffset = 4
	elseif (mode==RIGHT) then
		xoffset = -4
    end
    textAlign(mode)
    for i = 1, N do
		text(nodes[i].label,nodes[i].x+xoffset,nodes[i].y)
	end
end

function posOfNode(i,nodes,orderedNodes)
    local N = #nodes
	if (orderedNodes[nodes[i].pos].index ~= i) then
		for p = 1, N do
            nodes[orderedNodes[p].index].pos = p
        end
    end
	return nodes[i].pos
end

function map(value, istart, istop, ostart, ostop)
	return ostart + (ostop - ostart) * ((value - istart) / (istop - istart))
end

function linearLayout(nodes,order,dx,dy,ext,mode)
	local N = #nodes
	for i = 1, N do
		local index = order[i].index
		local coord = map(i,0,N,0,ext)
		if (mode==VERTICAL) then
			nodes[index].x = dx
			nodes[index].y = coord+dy
		else
			nodes[index].x = coord+dx
			nodes[index].y = dy
		end
	end
end

function orderedArray(nodes)
	local N = #nodes
	orderedNodes = {}
	for i = 1, N do
		local node = OrderedNode()
		node.index = i
		table.insert(orderedNodes, node)
	end
	return orderedNodes
end

function barycenter(nodesU,orderU,nodesV,orderV)
	local n = #nodesU
	local m = #nodesV
	
	for k = 1, n*2 do
		
		for i = 1, n do
			local node1 = nodesU[i]
			local p1 = posOfNode(i,nodesU,orderU)
			local sum = 0
			for j = 1, #node1.neighbors do
				local i2 = node1.neighbors[j] + 1
				local p2 = posOfNode(i2,nodesV,orderV)
				sum = sum + p2
			end
			orderU[p1].average = sum / #node1.neighbors
        end
		table.sort(orderU, function(a,b) return a.average<b.average end)
		
		for i = 1, m do
			local node1 = nodesV[i]
			local p1 = posOfNode(i,nodesV,orderV)
			local sum = 0
			for j = 1, #node1.neighbors do
				local i2 = node1.neighbors[j] + 1
				local p2 = posOfNode(i2,nodesU,orderU)
				sum = sum + p2
			end
			orderV[p1].average = sum / #node1.neighbors
        end
		table.sort(orderV, function(a,b) return a.average<b.average end)
	end
end