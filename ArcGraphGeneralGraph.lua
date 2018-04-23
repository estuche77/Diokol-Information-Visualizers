function setup()
    size(640, 500)
    stroke(0)
    noFill()
	local f = loadFont("data/Karla.ttf",12)
	math.randomseed(os.time())
	
	nodes = init(30)

	order = orderedArray(nodes)
	linearGraphLayout(nodes,order,20,300,300)
	
	nodesB = deepCopy(nodes)
	barycenter(nodesB,order)
	linearGraphLayout(nodesB,order,330,300,300)
end

function draw()
    background(255)
	
	text("Original",150,400)
	text("Optimized",430,400)

    drawArcs(nodes)
    drawNodes(nodes)
	
    drawArcs(nodesB)
    drawNodes(nodesB)
end

function deepCopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
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

function drawArcs(nodes)
	local N = #nodes
	for i = 1, N do
		local neighbors = nodes[i].neighbors
		for j = 1, #neighbors do
			local k = neighbors[j]
			local radius = math.abs(nodes[i].x-nodes[k].x)/2
			arc((nodes[i].x+nodes[k].x)/2,nodes[i].y,radius*2,radius*2,PI,2*PI,OPEN)
        end
    end
end

function drawNodes(nodes)
	local N = #nodes
	for i = 1, N do
		arc(nodes[i].x,nodes[i].y,3,3,0,2*PI,OPEN);
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

function linearGraphLayout(nodes,order,dx,dy,w)
	local N = #nodes
	for i = 1, N do
		local index = order[i].index
		coord = map(i,0,N,0,w)
		nodes[index].x = coord+dx
		nodes[index].y = dy
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

function barycenter(nodes,orderedNodes)
	local N = #nodes
	for i0 = 0, N*2 do
		for i1 = 1, N do
			local node1 = nodes[i1]
			local p1 = positionOfNode(i1,nodes,orderedNodes)
			local sum = p1
			for j = 1, #node1.neighbors do
				local i2 = node1.neighbors[j]
				local p2 = positionOfNode(i2,nodes,orderedNodes)
				sum = sum + p2
            end
			orderedNodes[p1].average = sum / ( #node1.neighbors + 1 )
		end
		table.sort(orderedNodes, function(a,b) return a.average<b.average end)
	end
end