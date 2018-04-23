function setup()
    size(640, 500)
    stroke(0)
    fill(0)
    local f = loadFont("data/Karla.ttf",12)
    nodes = init(30)
end

function draw()
    background(255)
	
	text("Original",150,400)
	text("Optimized",430,400)

	local order = orderedArray(nodes)
	circularGraphLayout(nodes,order,160,200,300)
	drawLinks(nodes)
	drawNodes(nodes)
	
	barycenter(nodes,order)
	circularGraphLayout(nodes,order,480,200,300)
	drawLinks(nodes)
	drawNodes(nodes)
end

function Node()
	node = {
        x = 0,
        y = 0,
        label = "",
        data = 0,
        position = 1,
        neighbors = {}
    }
    return node
end

function OrderedNode ()
	return {
        index = 0,
        average = 0
    }
end

function init(N)
    nodes = {}
	for i = 1, N do
		local node = Node()
		node.neighbors = {}
		local m = math.floor((math.random() * 2) + 1)
        for j = 1, m do
            table.insert(node.neighbors, math.floor((math.random() * N) + 1))
        end
        table.insert(nodes,node)
    end
    return nodes
end

function angle(nodes,p)
	local N = #nodes
	return p*2*PI/N
end

function drawLinks(nodes)
    local N = #nodes
	for i = 1, N do
		local neighbors = nodes[i].neighbors
		for j = 1, #neighbors do
			local k = neighbors[j]
			line(nodes[i].x,nodes[i].y,nodes[k].x,nodes[k].y)
		end
	end
end

function drawNodes(nodes)
    local N = #nodes
    for i = 1, N do
		arc(nodes[i].x,nodes[i].y,5,5,0,2*PI)
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

function map(value, istart, istop, ostart, ostop)
	return ostart + (ostop - ostart) * ((value - istart) / (istop - istart))
end

function circularGraphLayout(nodes,order,dx,dy,w)
	local N = #nodes
	for i = 1, N do
		local index = order[i].index
		nodes[index].x = math.cos(angle(nodes,i))*w/2+dx
		nodes[index].y = math.sin(angle(nodes,i))*w/2+dy
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

function angleOfVector( x, y )
	local hypotenuse = math.sqrt( x*x + y*y )
	local theta = math.asin( y / hypotenuse )
	if (x < 0) then
        theta = PI - theta
    end
	if (theta < 0) then
        theta = theta + 2*PI
    end
	return theta
end

function barycenter(nodes,orderedNodes)
	local N = #nodes
	for i0 = 0, N*2 do
		for i1 = 1, N do
			local node1 = nodes[i1]
			local p1 = positionOfNode(i1,nodes,orderedNodes)
			local sum_x = math.cos(angle(nodes,p1))
			local sum_y = math.sin(angle(nodes,p1))
			for j = 1, #node1.neighbors do
				local i2 = node1.neighbors[j]
				local node2 = nodes[i2]
				local p2 = positionOfNode(i2,nodes,orderedNodes)
				sum_x = sum_x + math.cos(angle(nodes,p2))
				sum_y = sum_y + math.sin(angle(nodes,p2))
				orderedNodes[p1].average = angleOfVector(sum_x,sum_y)
			end
		end
		table.sort(orderedNodes, function(a,b) return a.average<b.average end)
	end
end