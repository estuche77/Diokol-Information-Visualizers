function setup()
    size(640, 500)
    stroke(0)
    noFill()
    local f = loadFont("data/Karla.ttf",12)
    nodesU = initU()
	nodesV = initV()
	orderU = orderedArray(nodesU)
	orderV = orderedArray(nodesV)
	circularLayout(nodesU,orderU,350,250,400)
	centroid(nodesU,nodesV)
end

function draw()
    background(255)
	
	drawRadialAxis(350,250,400)
	drawLinks(nodesU,nodesV)
	drawNodes(nodesU)
	drawNodes(nodesV)
	drawLabels(nodesU)
	drawLabels(nodesV)
end

function Node()
	node = {
        x = 0,
        y = 0,
        label = "",
        data = 0,
        pos = 1,
		neighbors = {},
		type = 0
    }
    return node
end

function OrderedNode ()
	return {
        index = 0,
        average = 0
    }
end

function initU()
	root = {{id=0,x=0,y=0,label="Lord of the Rings 1",type=1,pos=1,neighbors={1,2,9}},
			{id=1,x=0,y=0,label="The Hobbit 1",type=1,pos=1,neighbors={1,2,9}},
			{id=2,x=0,y=0,label="Pirates of the Caribbean",type=1,pos=1,neighbors={2,3}},
			{id=3,x=0,y=0,label="Sin City",type=1,pos=1,neighbors={1,4,5}},
			{id=4,x=0,y=0,label="Pulp Fiction",type=1,pos=1,neighbors={5,6,10}},
			{id=5,x=0,y=0,label="Unbreakable",type=1,pos=1,neighbors={5,6}},
			{id=6,x=0,y=0,label="Star Wars Episode 1",type=1,pos=1,neighbors={3,6,7}},
			{id=7,x=0,y=0,label="Cold Mountain",type=1,pos=1,neighbors={7,8}},
			{id=8,x=0,y=0,label="Anna Karenina",type=1,pos=1,neighbors={3,8}},
			{id=9,x=0,y=0,label="The Aviator",type=1,pos=1,neighbors={8,9}},
			{id=10,x=0,y=0,label="Gattaca",type=1,pos=1,neighbors={8,10}}
		}
	return root
end

function initV()		
	root = {{id=0,x=0,y=0,label="Elijah Wood",type=0,pos=1,neighbors={1,2,4}},
			{id=1,x=0,y=0,label="Orlando Bloom",type=0,pos=1,neighbors={1,2,3}},
			{id=2,x=0,y=0,label="Keira Knightley",type=0,pos=1,neighbors={3,7,9}},
			{id=3,x=0,y=0,label="Jessica Alba",type=0,pos=1,neighbors={4}},
			{id=4,x=0,y=0,label="Bruce Willis",type=0,pos=1,neighbors={4,5}},
			{id=5,x=0,y=0,label="Samuel L. Jackson",type=0,pos=1,neighbors={5,6,7}},
			{id=6,x=0,y=0,label="Natalie Portman",type=0,pos=1,neighbors={7,8}},
			{id=7,x=0,y=0,label="Jude Law",type=0,pos=1,neighbors={8,9,10}},
			{id=8,x=0,y=0,label="Cate Blanchett",type=0,pos=1,neighbors={1,2,10}},
			{id=9,x=0,y=0,label="Uma Thurman",type=0,pos=1,neighbors={5,11}}
		}
	return root
end

function drawLinks(nodesU,nodesV)
	local n = #nodesU
	for i = 1, n do
		local neighbors = nodesU[i].neighbors
		for j = 1, #neighbors do
			local k = neighbors[j]
			line(nodesU[i].x,nodesU[i].y,nodesV[k].x,nodesV[k].y)
		end
	end
end

function drawNodes(nodes)
	local N = #nodes
	for i = 1, N do
		arc(nodes[i].x,nodes[i].y,2,2,0,2*PI,OPEN)
	end
end

function drawLabels(nodes)
	local N = #nodes
	for i = 1, N do
		local xoffset = 0
		if nodes[i].align==RIGHT then
			textAlign(RIGHT)
			xoffset = -4
		else
			textAlign(LEFT)
			xoffset = 4
		end
		text(nodes[i].label,nodes[i].x+xoffset,nodes[i].y)
	end
end

function positionOfNode(i,nodes,orderedNodes)
	local N = #nodes
	if (orderedNodes[nodes[i].position].index ~= i) then
		for p = 1, N do
            nodes[orderedNodes[p].index].position = p
        end
    end
	return nodes[i].position
end

function angle(nodes,p)
	local N = #nodes
	return p*2*PI/N
end

function drawRadialAxis(x,y,r)
	arc(x,y,r,r,0,2*PI,OPEN)
end

function circularLayout(nodes,order,dx,dy,w)
	local N = #nodes
	for i = 1, N do
		local index = order[i].index
		local radians = angle(nodes,i)
		nodes[index].x = math.cos(radians)*w/2+dx
		nodes[index].y = math.sin(radians)*w/2+dy
		if ((radians>=PI/2) and (radians<=3*PI/2)) then
			nodes[index].align = RIGHT
		else
			nodes[index].align = LEFT
		end
	end
end

function orderedArray(nodes)
	local N = #nodes
	local orderedNodes = {}
	for i = 1, N do
		local node = OrderedNode()
		node.index = i
		table.insert(orderedNodes, node)
	end
	return orderedNodes
end

function centroid(nodesU,nodesV)
	local N = #nodesV
	for i = 1, N do
		local node1 = nodesV[i]
		local degree = #node1.neighbors
		for j = 1, degree do
			local index = node1.neighbors[j]
			local node2 = nodesU[index]
			node1.x = node1.x + node2.x
			node1.y = node1.y + node2.y
		end
		node1.x = node1.x / degree
		node1.y = node1.y / degree
	end
end