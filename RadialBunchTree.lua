TOP = 101
BOTTOM = 102
BOX = 200
ROUND = 201

function setup()
    size(750, 600)
    stroke(0)
    noFill()
    local f = loadFont("data/Karla.ttf",12)
    root = init()
    initialize(root)
    RadialTree1(root,350,300)
end

function draw()
    background(255)
    drawNodes(root,3,ROUND)
    --drawLabels(root,TOP,4,0)
	drawLinks(root,350,300)
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
	local root = {
 label= "flare",
 children= {
  {
   label= "analytics",
   children= {
    {
     label= "cluster",
     children= {
      {label= "AgglomerativeCluster", children={}, size= 3938},
      {label= "CommunityStructure", children={}, size= 3812},
      {label= "HierarchicalCluster", children={}, size= 6714},
      {label= "MergeEdge", children={}, size= 743}
     }
    },
    {
     label= "graph",
     children= {
      {label= "BetweennessCentrality", children={}, size= 3534},
      {label= "LinkDistance", children={}, size= 5731},
      {label= "MaxFlowMinCut", children={}, size= 7840},
      {label= "ShortestPaths", children={}, size= 5914},
      {label= "SpanningTree", children={}, size= 3416}
     }
    },
    {
     label= "optimization",
     children= {
      {label= "AspectRatioBanker", children={}, size= 7074}
     }
    }
   }
  },
  {
   label= "animate",
   children= {
    {label= "Easing", children={}, size= 17010},
    {label= "FunctionSequence", children={}, size= 5842},
    {
     label= "interpolate",
     children= {
      {label= "ArrayInterpolator", children={}, size= 1983},
      {label= "ColorInterpolator", children={}, size= 2047},
      {label= "DateInterpolator", children={}, size= 1375},
      {label= "Interpolator", children={}, size= 8746},
      {label= "MatrixInterpolator", children={}, size= 2202},
      {label= "NumberInterpolator", children={}, size= 1382},
      {label= "ObjectInterpolator", children={}, size= 1629},
      {label= "PointInterpolator", children={}, size= 1675},
      {label= "RectangleInterpolator", children={}, size= 2042}
     }
    },
    {label= "ISchedulable", children={}, size= 1041},
    {label= "Parallel", children={}, size= 5176},
    {label= "Pause", children={}, size= 449},
    {label= "Scheduler", children={}, size= 5593},
    {label= "Sequence", children={}, size= 5534},
    {label= "Transition", children={}, size= 9201},
    {label= "Transitioner", children={}, size= 19975},
    {label= "TransitionEvent", children={}, size= 1116},
    {label= "Tween", children={}, size= 6006}
   }
  },
  {
   label= "data",
   children= {
    {
     label= "converters",
     children= {
      {label= "Converters", children={}, size= 721},
      {label= "DelimitedTextConverter", children={}, size= 4294},
      {label= "GraphMLConverter", children={}, size= 9800},
      {label= "IDataConverter", children={}, size= 1314},
      {label= "JSONConverter", children={}, size= 2220}
     }
    },
    {label= "DataField", children={}, size= 1759},
    {label= "DataSchema", children={}, size= 2165},
    {label= "DataSet", children={}, size= 586},
    {label= "DataSource", children={}, size= 3331},
    {label= "DataTable", children={}, size= 772},
    {label= "DataUtil", children={}, size= 3322}
   }
  },
  {
   label= "display",
   children= {
    {label= "DirtySprite", children={}, size= 8833},
    {label= "LineSprite", children={}, size= 1732},
    {label= "RectSprite", children={}, size= 3623},
    {label= "TextSprite", children={}, size= 10066}
   }
  },
  {
   label= "flex",
   children= {
    {label= "FlareVis", children={}, size= 4116}
   }
  },
  {
   label= "physics",
   children= {
    {label= "DragForce", children={}, size= 1082},
    {label= "GravityForce", children={}, size= 1336},
    {label= "IForce", children={}, size= 319},
    {label= "NBodyForce", children={}, size= 10498},
    {label= "Particle", children={}, size= 2822},
    {label= "Simulation", children={}, size= 9983},
    {label= "Spring", children={}, size= 2213},
    {label= "SpringForce", children={}, size= 1681}
   }
  },
  {
   label= "query",
   children= {
    {label= "AggregateExpression", children={}, size= 1616},
    {label= "And", children={}, size= 1027},
    {label= "Arithmetic", children={}, size= 3891},
    {label= "Average", children={}, size= 891},
    {label= "BinaryExpression", children={}, size= 2893},
    {label= "Comparison", children={}, size= 5103},
    {label= "CompositeExpression", children={}, size= 3677},
    {label= "Count", children={}, size= 781},
    {label= "DateUtil", children={}, size= 4141},
    {label= "Distinct", children={}, size= 933},
    {label= "Expression", children={}, size= 5130},
    {label= "ExpressionIterator", children={}, size= 3617},
    {label= "Fn", children={}, size= 3240},
    {label= "If", children={}, size= 2732},
    {label= "IsA", children={}, size= 2039},
    {label= "Literal", children={}, size= 1214},
    {label= "Match", children={}, size= 3748},
    {label= "Maximum", children={}, size= 843},
    {
     label= "methods",
     children= {
      {label= "add", children={}, size= 593},
      {label= "and", children={}, size= 330},
      {label= "average", children={}, size= 287},
      {label= "count", children={}, size= 277},
      {label= "distinct", children={}, size= 292},
      {label= "div", children={}, size= 595},
      {label= "eq", children={}, size= 594},
      {label= "fn", children={}, size= 460},
      {label= "gt", children={}, size= 603},
      {label= "gte", children={}, size= 625},
      {label= "iff", children={}, size= 748},
      {label= "isa", children={}, size= 461},
      {label= "lt", children={}, size= 597},
      {label= "lte", children={}, size= 619},
      {label= "max", children={}, size= 283},
      {label= "min", children={}, size= 283},
      {label= "mod", children={}, size= 591},
      {label= "mul", children={}, size= 603},
      {label= "neq", children={}, size= 599},
      {label= "not", children={}, size= 386},
      {label= "or", children={}, size= 323},
      {label= "orderby", children={}, size= 307},
      {label= "range", children={}, size= 772},
      {label= "select", children={}, size= 296},
      {label= "stddev", children={}, size= 363},
      {label= "sub", children={}, size= 600},
      {label= "sum", children={}, size= 280},
      {label= "update", children={}, size= 307},
      {label= "variance", children={}, size= 335},
      {label= "where", children={}, size= 299},
      {label= "xor", children={}, size= 354},
      {label= "_", children={}, size= 264}
     }
    },
    {label= "Minimum", children={}, size= 843},
    {label= "Not", children={}, size= 1554},
    {label= "Or", children={}, size= 970},
    {label= "Query", children={}, size= 13896},
    {label= "Range", children={}, size= 1594},
    {label= "StringUtil", children={}, size= 4130},
    {label= "Sum", children={}, size= 791},
    {label= "Variable", children={}, size= 1124},
    {label= "Variance", children={}, size= 1876},
    {label= "Xor", children={}, size= 1101}
   }
  },
  {
   label= "scale",
   children= {
    {label= "IScaleMap", children={}, size= 2105},
    {label= "LinearScale", children={}, size= 1316},
    {label= "LogScale", children={}, size= 3151},
    {label= "OrdinalScale", children={}, size= 3770},
    {label= "QuantileScale", children={}, size= 2435},
    {label= "QuantitativeScale", children={}, size= 4839},
    {label= "RootScale", children={}, size= 1756},
    {label= "Scale", children={}, size= 4268},
    {label= "ScaleType", children={}, size= 1821},
    {label= "TimeScale", children={}, size= 5833}
   }
  },
  {
   label= "util",
   children= {
    {label= "Arrays", children={}, size= 8258},
    {label= "Colors", children={}, size= 10001},
    {label= "Dates", children={}, size= 8217},
    {label= "Displays", children={}, size= 12555},
    {label= "Filter", children={}, size= 2324},
    {label= "Geometry", children={}, size= 10993},
    {
     label= "heap",
     children= {
      {label= "FibonacciHeap", children={}, size= 9354},
      {label= "HeapNode", children={}, size= 1233}
     }
    },
    {label= "IEvaluable", children={}, size= 335},
    {label= "IPredicate", children={}, size= 383},
    {label= "IValueProxy", children={}, size= 874},
    {
     label= "math",
     children= {
      {label= "DenseMatrix", children={}, size= 3165},
      {label= "IMatrix", children={}, size= 2815},
      {label= "SparseMatrix", children={}, size= 3366}
     }
    },
    {label= "Maths", children={}, size= 17705},
    {label= "Orientation", children={}, size= 1486},
    {
     label= "palette",
     children= {
      {label= "ColorPalette", children={}, size= 6367},
      {label= "Palette", children={}, size= 1229},
      {label= "ShapePalette", children={}, size= 2059},
      {label= "SizePalette", children={}, size= 2291}
     }
    },
    {label= "Property", children={}, size= 5559},
    {label= "Shapes", children={}, size= 19118},
    {label= "Sort", children={}, size= 6887},
    {label= "Stats", children={}, size= 6557},
    {label= "Strings", children={}, size= 22026}
   }
  },
  {
   label= "vis",
   children= {
    {
     label= "axis",
     children= {
      {label= "Axes", children={}, size= 1302},
      {label= "Axis", children={}, size= 24593},
      {label= "AxisGridLine", children={}, size= 652},
      {label= "AxisLabel", children={}, size= 636},
      {label= "CartesianAxes", children={}, size= 6703}
     }
    },
    {
     label= "controls",
     children= {
      {label= "AnchorControl", children={}, size= 2138},
      {label= "ClickControl", children={}, size= 3824},
      {label= "Control", children={}, size= 1353},
      {label= "ControlList", children={}, size= 4665},
      {label= "DragControl", children={}, size= 2649},
      {label= "ExpandControl", children={}, size= 2832},
      {label= "HoverControl", children={}, size= 4896},
      {label= "IControl", children={}, size= 763},
      {label= "PanZoomControl", children={}, size= 5222},
      {label= "SelectionControl", children={}, size= 7862},
      {label= "TooltipControl", children={}, size= 8435}
     }
    },
    {
     label= "data",
     children= {
      {label= "Data", children={}, size= 20544},
      {label= "DataList", children={}, size= 19788},
      {label= "DataSprite", children={}, size= 10349},
      {label= "EdgeSprite", children={}, size= 3301},
      {label= "NodeSprite", children={}, size= 19382},
      {
       label= "render",
       children= {
        {label= "ArrowType", children={}, size= 698},
        {label= "EdgeRenderer", children={}, size= 5569},
        {label= "IRenderer", children={}, size= 353},
        {label= "ShapeRenderer", children={}, size= 2247}
       }
      },
      {label= "ScaleBinding", children={}, size= 11275},
      {label= "Tree", children={}, size= 7147},
      {label= "TreeBuilder", children={}, size= 9930}
     }
    },
    {
     label= "events",
     children= {
      {label= "DataEvent", children={}, size= 2313},
      {label= "SelectionEvent", children={}, size= 1880},
      {label= "TooltipEvent", children={}, size= 1701},
      {label= "VisualizationEvent", children={}, size= 1117}
     }
    },
    {
     label= "legend",
     children= {
      {label= "Legend", children={}, size= 20859},
      {label= "LegendItem", children={}, size= 4614},
      {label= "LegendRange", children={}, size= 10530}
     }
    },
    {
     label= "operator",
     children= {
      {
       label= "distortion",
       children= {
        {label= "BifocalDistortion", children={}, size= 4461},
        {label= "Distortion", children={}, size= 6314},
        {label= "FisheyeDistortion", children={}, size= 3444}
       }
      },
      {
       label= "encoder",
       children= {
        {label= "ColorEncoder", children={}, size= 3179},
        {label= "Encoder", children={}, size= 4060},
        {label= "PropertyEncoder", children={}, size= 4138},
        {label= "ShapeEncoder", children={}, size= 1690},
        {label= "SizeEncoder", children={}, size= 1830}
       }
      },
      {
       label= "filter",
       children= {
        {label= "FisheyeTreeFilter", children={}, size= 5219},
        {label= "GraphDistanceFilter", children={}, size= 3165},
        {label= "VisibilityFilter", children={}, size= 3509}
       }
      },
      {label= "IOperator", children={}, size= 1286},
      {
       label= "label",
       children= {
        {label= "Labeler", children={}, size= 9956},
        {label= "RadialLabeler", children={}, size= 3899},
        {label= "StackedAreaLabeler", children={}, size= 3202}
       }
      },
      {
       label= "layout",
       children= {
        {label= "AxisLayout", children={}, size= 6725},
        {label= "BundledEdgeRouter", children={}, size= 3727},
        {label= "CircleLayout", children={}, size= 9317},
        {label= "CirclePackingLayout", children={}, size= 12003},
        {label= "DendrogramLayout", children={}, size= 4853},
        {label= "ForceDirectedLayout", children={}, size= 8411},
        {label= "IcicleTreeLayout", children={}, size= 4864},
        {label= "IndentedTreeLayout", children={}, size= 3174},
        {label= "Layout", children={}, size= 7881},
        {label= "NodeLinkTreeLayout", children={}, size= 12870},
        {label= "PieLayout", children={}, size= 2728},
        {label= "RadialTreeLayout", children={}, size= 12348},
        {label= "RandomLayout", children={}, size= 870},
        {label= "StackedAreaLayout", children={}, size= 9121},
        {label= "TreeMapLayout", children={}, size= 9191}
       }
      },
      {label= "Operator", children={}, size= 2490},
      {label= "OperatorList", children={}, size= 5248},
      {label= "OperatorSequence", children={}, size= 4190},
      {label= "OperatorSwitch", children={}, size= 2581},
      {label= "SortOperator", children={}, size= 2023}
     }
    },
    {label= "Visualization", children={}, size= 16540}
   }
  }
 }
}
	return root
end

function drawLinks(node,x,y)
	local n = #node.children
    if n==0 then return end
	local minAngle = node.children[1].a
	local maxAngle = node.children[1].a
	local radius = node.children[1].r-10
	for i = 1, n do
		local child = node.children[i]
		if (minAngle > child.a) then
            minAngle = child.a
        end
		if (maxAngle < child.a) then
            maxAngle = child.a
        end
		drawLinks(child,x,y)
	end
    arc(x,y,radius*2,radius*2,minAngle,maxAngle,OPEN)
	local medAngle = (minAngle + maxAngle)/2
	local xT = (radius*math.cos(medAngle))+x
    local yT = (radius*math.sin(medAngle))+y
    line(node.x,node.y,xT,yT)
	for i = 1, n do
		local r = radius
		local child = node.children[i]
		local xT = (r*math.cos(child.a))+x
		local yT = (r*math.sin(child.a))+y
		line(child.x,child.y,xT,yT)
	end
end

function drawNodes(node,size,symbol)
	local n = #node.children
	if (symbol==ROUND) then
		arc(node.x,node.y,size,size,0,2*PI,OPEN)
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

function secondWalk(v, dx, dy)
	local r = v.r
	if (v.isFacing) then r = r-20 end
	v.x = (r*math.cos(v.a))+dx
	v.y = (r*math.sin(v.a))+dy
	
	for i=1, #v.children do
		local u = v.children[i]
		secondWalk(u,dx,dy)
	end
end

function firstWalk(v,radius,begin,fin,e)
	local begin = begin + 0.02
	v.r = radius
    v.a = (begin + fin)/2

    local s = 0
    if v.leaves ~= 0 then
        s = (fin - begin)/v.leaves
    end

	local a1 = begin
	local a2 = begin
	for i=1, #v.children do
		local u = v.children[i]
		if (not u.isFacing) then
			firstWalk(u,radius+e,a1,a1+s*u.leaves,e)
			if (not u.isLeave) then
				a1 = a1 + s * u.leaves
			else
                a1 = a1 + s
            end
		else
			firstWalk(u,radius+e,a2,a2+s,e)
			a2 = a2 + s
		end
	end
end

function RadialTree1(n,x,y)
	firstWalk(n,0,0,2*PI,60)
	secondWalk(n,x,y)
end

function initialize(node)
	node.c = 0
	node.r = 0
	node.a = 0
	node.isFacing = false
	node.isLeave = false
	node.leaves = 0
	if (#node.children==0) then
		node.isLeave = true
		return
	end
	local sumLeaves = 0
	local childrenLeave = 0
	for i=1, #node.children do
		local child = node.children[i]
		child.index = i
		child.parent = node
		initialize(child)
		sumLeaves = sumLeaves + child.leaves
		if (child.isLeave) then childrenLeave = childrenLeave + 1 end
	end
	if (sumLeaves > childrenLeave) then
		node.leaves = sumLeaves
		for i=1, #node.children do
			if (node.children[i].isLeave) then
                node.children[i].isFacing=true
            end
        end
    else
		local total = sumLeaves + childrenLeave
		node.leaves = math.floor(total/2)
		local j=0
		for i=1, #node.children do
			if (node.children[i].isLeave) then
				node.children[i].isFacing=true
				j = j + 1
				if (j==node.leaves) then break end
            end
        end
	end
end