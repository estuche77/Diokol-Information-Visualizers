local BOTTOM = 1
local TOP = 2

local TOP_SPACE = 100
local BOTTOM_SPACE = 100
local LEFT_SPACE = 0

function setup()
    size(1024, 768)
    stroke(0)
    noFill()
    local f = loadFont("data/Karla.ttf",12)
    nodesU = initU()
    nodesV = initV()

    table.sort(nodesU, function(a,b) return #a.neighbors < #b.neighbors end)

    setVCoordenates(nodesV, 768, 1024)
    setUCoordenates(nodesU, nodesV, 768)

end

function draw()
    background(255)
	
	drawSierras(768, nodesU, nodesV)

    drawNodes(nodesU)
    drawNodes(nodesV)

    drawLabels(nodesU, TOP)
    drawLabels(nodesV, BOTTOM)

    drawLinks(nodesU, nodesV)
end

-- DATA
function initV()
    root = {{id=0,x=0,y=0,label="Turdus falcklandii",type=1,pos=0,neighbors={1,2,3,4,6,7,9}},
        {id=1,x=0,y=0,label="Mimus thenca",type=1,pos=0,neighbors={1,2,3,4,7,11,12}},
        {id=2,x=0,y=0,label="Elania albiceps",type=1,pos=0,neighbors={1,2,3,4,8,9}},
        {id=3,x=0,y=0,label="Lycalopex culpaeus",type=1,pos=0,neighbors={1,2,6,8,10}},
        {id=4,x=0,y=0,label="Lycalopex griseus",type=1,pos=0,neighbors={1,2,6}},
        {id=5,x=0,y=0,label="Curaeus curaeus",type=1,pos=0,neighbors={1,7}},
        {id=6,x=0,y=0,label="Zonotrichia capensis",type=1,pos=0,neighbors={3,4}},
        {id=7,x=0,y=0,label="Phytotoma rara",type=1,pos=0,neighbors={2}},
        {id=8,x=0,y=0,label="Columba araucana",type=1,pos=0,neighbors={1}},
        {id=9,x=0,y=0,label="Colaptes pitius",type=1,pos=0,neighbors={3}},
        {id=10,x=0,y=0,label="Colorhamphus parvirostris",type=1,pos=0,neighbors={5}},
        {id=11,x=0,y=0,label="Xolmis pyrope",type=1,pos=0,neighbors={5}},
        {id=12,x=0,y=0,label="Anairetes parulus",type=1,pos=0,neighbors={5}},
        {id=13,x=0,y=0,label="Oryctolagus cuniculus",type=1,pos=0,neighbors={2}}
    }
    return root
end

function initU()
    root = {{id=0,x=0,y=0,label="Aristotelia chilensis",type=0,pos=0,neighbors={1,2,3,4,5,6,9}},
        {id=1,x=0,y=0,label="Lithrea caustica",type=0,pos=0,neighbors={1,2,3,4,5,8,14}},
        {id=2,x=0,y=0,label="Schinus polygamus",type=0,pos=0,neighbors={1,2,3,7,10}},
        {id=3,x=0,y=0,label="Cestrum parqui",type=0,pos=0,neighbors={1,2,3,7}},
        {id=4,x=0,y=0,label="Maytenus boaria",type=0,pos=0,neighbors={11,12,13}},
        {id=5,x=0,y=0,label="Muehlenbeckia hastulata",type=0,pos=0,neighbors={1,4,5}},
        {id=6,x=0,y=0,label="Tristerix corymbosus",type=0,pos=0,neighbors={1,2,6}},
        {id=7,x=0,y=0,label="Schinus molle",type=0,pos=0,neighbors={3,4}},
        {id=8,x=0,y=0,label="Azara dentata",type=0,pos=0,neighbors={1,3}},
        {id=9,x=0,y=0,label="Porlieria chilensis",type=0,pos=0,neighbors={4}},
        {id=10,x=0,y=0,label="Tristerix aphyllus",type=0,pos=0,neighbors={2}},
        {id=11,x=0,y=0,label="Trichocereus chilensis",type=0,pos=0,neighbors={2}}
    }
    return root
end

function getYDistance(nodes, drawHeight)
    local amount = 0
    local currentNeighbors = 0

    for i = 1, #nodes do
        if (currentNeighbors ~= #nodes[i].neighbors) then
            currentNeighbors = #nodes[i].neighbors
            amount = amount + 1
        end
    end

    return math.round( (drawHeight - TOP_SPACE - BOTTOM_SPACE ) / amount )
end

function getXDistance(nodes, drawWidth)
    return math.round( (drawWidth - LEFT_SPACE) / (#nodes + 1) )
end

function setUCoordenates(nodesU, nodesV, drawHeight)
    local distanceBetweenY = getYDistance(nodesU, drawHeight)

    local currentNeighbors = #nodesU[1].neighbors
    local currentY = TOP_SPACE
    for i = 1, #nodesU do

        if (currentNeighbors ~= #nodesU[i].neighbors) then
            currentNeighbors = #nodesU[i].neighbors
            currentY = currentY + distanceBetweenY
        end

        local averageX = getAverageX(nodesU[i].neighbors, nodesV)
        while ( checkRepeatedX(nodesU, averageX)) do
            averageX = averageX + 10
        end

        nodesU[i].x = averageX
        nodesU[i].y = currentY
    end
end

function getFarLeft(neighbors, nodesV)
    local x = nodesV[neighbors[1]].x

    for i = 1, #neighbors do
        local currentX = nodesV[neighbors[i]].x
        if (currentX < x) then
            x = currentX
        end
    end
    return x
end

function getFarRight(neighbors, nodesV)
    local x = 0

    for i = 1, #neighbors do
        local currentX = nodesV[neighbors[i]].x
        if (currentX > x) then
            x = currentX
        end
    end
    return x
end

function getAverageX(neighbors, nodesV)
    return ( (getFarLeft(neighbors, nodesV) + getFarRight(neighbors, nodesV) ) / 2)
end

function checkRepeatedX(nodes, x)
    local found = false
    for i = 1, #nodesU do
        if (nodes[i].x == x) then
            found = true
            break
        end
    end
    return found
end

function setVCoordenates(nodes, drawHeight, drawWidth)
    local distanceBetweenX = getXDistance(nodes, drawWidth)
    local currentX = LEFT_SPACE

    for i = 1, #nodes do
        currentX = currentX + distanceBetweenX

        nodes[i].x = currentX
        nodes[i].y = drawHeight - BOTTOM_SPACE
    end
end

function drawNodes(nodes)
    for i = 1, #nodes do
        arc(nodes[i].x, nodes[i].y, 2, 2, 0, 2*PI, OPEN)
    end
end

function drawLinks(nodesU, nodesV)
    local n = #nodesU
    for i = 1, n do
        local neighbors = nodesU[i].neighbors
        for j = 1, #neighbors do
            local k = neighbors[j]
            line(nodesU[i].x,nodesU[i].y,nodesV[k].x,nodesV[k].y)
            --dashLine(nodesU[i].x,nodesU[i].y,nodesV[k].x,nodesV[k].y)
        end
    end
end

function dashLine(x1, y1, x2, y2)
    for i = 1, 10 do
        local x = lerp(x1, x2, i/10.0) + 10
        local y = lerp(y1, y2, i/10.0)
        point(x, y)
    end
end

function lerp(start, stop, amt)
    return map(amt,0,1,start,stop)
end

function drawLabels(nodes, mode)
    local xoffset = 4

    textAlign(LEFT)

    pushMatrix()

    if (mode==TOP) then
        translate( width() - 1, 0 )
        rotate(3 * PI / 2)

        for i = 1, #nodes do
            text(nodes[i].label, -nodes[i].y + xoffset, nodes[i].x, TOP_SPACE-4)
        end
    elseif (mode==BOTTOM) then
        translate( 0, 0 )
        rotate(PI/2)

        for i = 1, #nodes do
            text(nodes[i].label, nodes[i].y + xoffset, -nodes[i].x, BOTTOM_SPACE-4)
        end
    end
    popMatrix()
end

function drawSierras(drawHeight, nodesU, nodesV)
    pushMatrix()
    local lumPercentage = 0

    for i = 1, #nodesU do
        if (#nodesU[i].neighbors == 1) then
            fill("#614126")
            line(nodesU[i].x, nodesU[i].y,nodesU[i].x - 5, drawHeight - BOTTOM_SPACE)
            line(nodesU[i].x - 5, drawHeight - BOTTOM_SPACE,nodesU[i].x + 5, drawHeight - BOTTOM_SPACE)
        else
            line(nodesU[i].x, nodesU[i].y,getFarLeft(nodesU[i].neighbors, nodesV), drawHeight - BOTTOM_SPACE)
            line(getFarLeft(nodesU[i].neighbors, nodesV), drawHeight - BOTTOM_SPACE,getFarRight(nodesU[i].neighbors, nodesV), drawHeight - BOTTOM_SPACE)
            
            --draw.lineWidth = 2
            --draw.stroke()
            --draw.fillStyle = colorLuminance("#556B2F", lumPercentage/100)
            --draw.fill()

            lumPercentage = lumPercentage + 15
        end
    end
    popMatrix()
end

--[[
function colorLuminance(hex, lum)
    hex = String(hex).replace(/[^0-9a-f]/gi, '')
    if (#hex < 6)
        hex = hex[0]+hex[0]+hex[1]+hex[1]+hex[2]+hex[2]
    end
    lum = lum || 0

    local rgb = "#", c, i
    for (i = 0 i < 3 i++)
        c = parseInt(hex.substr(i*2,2), 16)
        c = math.round(math.min(math.max(0, c + (c * lum)), 255)).toString(16)
        rgb += ("00"+c).substr(#c)
    end

    return rgb
end
]]

function math.round(a)
    return math.floor(a+0.5)
end