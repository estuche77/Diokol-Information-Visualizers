local MAX_DISPLACEMENT_SQUARED = 9

function setup()
    size(690, 500)
    stroke(0)
    noFill()
    local f = loadFont("data/Karla.ttf",12)
    math.randomseed(os.time())
    nodes = init(40,300,300)
    nodesF = deepCopy(nodes)
    forceDirectedLayout(nodesF,50,6250,1,0.04)
end

function draw()
    background(255)

    text("Original",150,400)
	text("Optimized",430,400)
	
	translate(10,50)
	drawArcs(nodes)
	drawNodes(nodes,4)
	
	translate(340,0)
	drawArcs(nodesF)
	drawNodes(nodesF,4)
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

function init(N,w,h)
    local nodes = {}
	for i = 1, N do
		local node = Node()
		node.neighbors = {}
        node.x = math.random() * w
		node.y = math.random() * h
		local m = math.floor(math.random() * 2 + 1)
        for j = 1, m do
            table.insert(node.neighbors, math.floor((math.random() * N) + 1))
        end
        table.insert(nodes, node)
    end
    return nodes
end

function drawArcs(nodes)
	local N = #nodes
	for i = 1, N do
		local node = nodes[i]
		for j = 1, #node.neighbors do
            local k = node.neighbors[j]
            line(nodes[i].x,nodes[i].y, nodes[k].x,nodes[k].y)
		end
	end
end

function drawNodes(nodes,size)
	local N = #nodes
	for i = 1, N do
		arc(nodes[i].x,nodes[i].y,size,size,0,2*PI,OPEN)
	end
end

function forceDirectedLayout(nodes, L, K_r, K_s, delta_t)

    local N = #nodes

    while (true) do

        -- initialize net forces
        for i = 1, N do
            nodes[i].force_x = 0
            nodes[i].force_y = 0
        end

        -- repulsion between all pairs
        for i1 = 1, N-1 do
            local node1 = nodes[i1]
            for i2 = i1+1, N do
                local node2 = nodes[i2]
                local dx = node2.x - node1.x
                local dy = node2.y - node1.y
                if ((dx ~= 0) or (dy ~= 0)) then
                    local distanceSquared = dx*dx + dy*dy
                    local distance = math.sqrt(distanceSquared)
                    local force = K_r / distanceSquared
                    local fx = force * dx / distance
                    local fy = force * dy / distance
                    node1.force_x = node1.force_x - fx
                    node1.force_y = node1.force_y - fy		
                    node2.force_x = node2.force_x + fx
                    node2.force_y = node2.force_y + fy
                end
            end
        end

        -- spring force between adjacent pairs
        for i1 = 1, N do
            local node1 = nodes[i1]
            for j = 1, #node1.neighbors do
                local i2 = node1.neighbors[j]
                local node2 = nodes[i2]
                if (i1 < i2) then
                    local dx = node2.x - node1.x
                    local dy = node2.y - node1.y
                    if ((dx ~= 0) or (dy ~= 0)) then
                        local distance = math.sqrt( dx*dx + dy*dy )
                        local force = K_s * ( distance - L )
                        local fx = force * dx / distance
                        local fy = force * dy / distance
                        node1.force_x = node1.force_x + fx
                        node1.force_y = node1.force_y + fy
                        node2.force_x = node2.force_x - fx
                        node2.force_y = node2.force_y - fy
                    end
                end
            end
        end

        local acum = 0

        -- update positions
        for i = 1, N do
            local node = nodes[i]
            local dx = delta_t * node.force_x
            local dy = delta_t * node.force_y
            local displacementSquared = dx*dx + dy*dy
            if ( displacementSquared > MAX_DISPLACEMENT_SQUARED ) then
                local s = math.sqrt( MAX_DISPLACEMENT_SQUARED / displacementSquared ) 
                dx = dx * s
                dy = dy * s
            end
            acum = acum + math.abs(dx)+math.abs(dy)
            node.x = node.x + dx
            node.y = node.y + dy
        end

        if (acum<N) then
            break
        end
    end
end