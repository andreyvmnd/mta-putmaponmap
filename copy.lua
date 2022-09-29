--MAP
changeMap = function( mapPathDown, mapPathUp, x, y, w, h )
	tableAddInNew = {}
	if ( fileExists( mapPathUp ) ) then
		local rootNode = xmlLoadFile( mapPathUp )
        local elementNodes = xmlNodeGetChildren( rootNode )
		for _, elementNode in pairs( elementNodes ) do
            local elementName = xmlNodeGetName( elementNode )
            if ( elementName == "object" or elementName == "removeWorldObject" ) then
                -- object
                local id = xmlNodeGetAttribute( elementNode, "id" )
                local breakable = xmlNodeGetAttribute( elementNode, "breakable" ) or false
                local collisions = xmlNodeGetAttribute( elementNode, "collisions" ) or false
                local interior = xmlNodeGetAttribute( elementNode, "interior" ) or false
                local dimension = xmlNodeGetAttribute( elementNode, "dimension" ) or false
                local alpha = xmlNodeGetAttribute( elementNode, "alpha" ) or false
                local model = xmlNodeGetAttribute( elementNode, "model" )
                local doublesided = xmlNodeGetAttribute( elementNode, "doublesided" ) or false
                local scale = xmlNodeGetAttribute( elementNode, "scale" ) or false
                local radius = xmlNodeGetAttribute( elementNode, "radius" ) or false
                local lodModel = xmlNodeGetAttribute( elementNode, "lodModel" ) or false
                local posX = tonumber(xmlNodeGetAttribute( elementNode, "posX" ))
                local posY = tonumber(xmlNodeGetAttribute( elementNode, "posY" ))
                local posZ = tonumber(xmlNodeGetAttribute( elementNode, "posZ" ))
                local rotX = tonumber(xmlNodeGetAttribute( elementNode, "rotX" ))
                local rotY = tonumber(xmlNodeGetAttribute( elementNode, "rotY" ))
                local rotZ = tonumber(xmlNodeGetAttribute( elementNode, "rotZ" ))

				if posX > x and posX < x+w and posY > y and posY < y+h then
					table.insert(tableAddInNew, {elementName,{id,breakable,interior,collisions,alpha,model,doublesided,scale,dimension,posX,posY,posZ,rotX,rotY,rotZ,radius,lodModel}})
				end
            end
        end
	end
	if ( fileExists( mapPathDown ) ) then    
        local rootNode = xmlLoadFile( mapPathDown )
        local elementNodes = xmlNodeGetChildren( rootNode )
        
        for _, elementNode in pairs( elementNodes ) do
            local elementName = xmlNodeGetName( elementNode )
            if ( elementName == "object" or elementName == "removeWorldObject" ) then
                -- object
                local id = xmlNodeGetAttribute( elementNode, "id" )
                local breakable = xmlNodeGetAttribute( elementNode, "breakable" ) or false
                local collisions = xmlNodeGetAttribute( elementNode, "collisions" ) or false
                local alpha = xmlNodeGetAttribute( elementNode, "alpha" ) or false
                local model = xmlNodeGetAttribute( elementNode, "model" )
                local doublesided = xmlNodeGetAttribute( elementNode, "doublesided" ) or false
                local scale = xmlNodeGetAttribute( elementNode, "scale" ) or false
                local posX = tonumber(xmlNodeGetAttribute( elementNode, "posX" ))
                local posY = tonumber(xmlNodeGetAttribute( elementNode, "posY" ))
                local posZ = tonumber(xmlNodeGetAttribute( elementNode, "posZ" ))
                local rotX = tonumber(xmlNodeGetAttribute( elementNode, "rotX" ))
                local rotY = tonumber(xmlNodeGetAttribute( elementNode, "rotY" ))
                local rotZ = tonumber(xmlNodeGetAttribute( elementNode, "rotZ" ))

				if posX > x and posX < x+w and posY > y and posY < y+h then
					xmlDestroyNode(elementNode)
				end
            end
        end

		for i, item in ipairs(tableAddInNew) do
			if item[1] == "object" then
				local NewNode = xmlCreateChild(rootNode, item[1])
				xmlNodeSetAttribute(NewNode, "id", item[2][1])
				xmlNodeSetAttribute(NewNode, "breakable", item[2][2])
				xmlNodeSetAttribute(NewNode, "interior", item[2][3])
				xmlNodeSetAttribute(NewNode, "collisions", item[2][4])
				xmlNodeSetAttribute(NewNode, "alpha", item[2][5])
				xmlNodeSetAttribute(NewNode, "model", item[2][6])
				xmlNodeSetAttribute(NewNode, "doublesided", item[2][7])
				xmlNodeSetAttribute(NewNode, "scale", item[2][8])
				xmlNodeSetAttribute(NewNode, "dimension", item[2][9])
				xmlNodeSetAttribute(NewNode, "posX", item[2][10])
				xmlNodeSetAttribute(NewNode, "posY", item[2][11])
				xmlNodeSetAttribute(NewNode, "posZ", item[2][12])
				xmlNodeSetAttribute(NewNode, "rotX", item[2][13])
				xmlNodeSetAttribute(NewNode, "rotY", item[2][14])
				xmlNodeSetAttribute(NewNode, "rotZ", item[2][15])
			elseif item[1] == "removeWorldObject" then
				local NewNode = xmlCreateChild(rootNode, item[1])
				xmlNodeSetAttribute(NewNode, "id", item[2][1])
				xmlNodeSetAttribute(NewNode, "radius", item[2][16])
				xmlNodeSetAttribute(NewNode, "interior", item[2][3])
				xmlNodeSetAttribute(NewNode, "model", item[2][6])
				xmlNodeSetAttribute(NewNode, "lodModel", item[2][17])
				xmlNodeSetAttribute(NewNode, "posX", item[2][10])
				xmlNodeSetAttribute(NewNode, "posY", item[2][11])
				xmlNodeSetAttribute(NewNode, "posZ", item[2][12])
				xmlNodeSetAttribute(NewNode, "rotX", item[2][13])
				xmlNodeSetAttribute(NewNode, "rotY", item[2][14])
				xmlNodeSetAttribute(NewNode, "rotZ", item[2][15])

			end
		end

		xmlSaveFile(rootNode)
		xmlUnloadFile(rootNode)
    end	
end;


function loadMap(mapName, alpha)	
	if ( fileExists( mapName ) ) then    
        local rootNode = xmlLoadFile( mapName )
        local elementNodes = xmlNodeGetChildren( rootNode )
        
        for _, elementNode in pairs( elementNodes ) do
            local elementName = xmlNodeGetName( elementNode )

			local id = xmlNodeGetAttribute( elementNode, "id" )
			local breakable = xmlNodeGetAttribute( elementNode, "breakable" ) or false
			local collisions = xmlNodeGetAttribute( elementNode, "collisions" ) or false
			local alpha = alpha or xmlNodeGetAttribute( elementNode, "alpha" ) or false
			local model = xmlNodeGetAttribute( elementNode, "model" )
			local lodModel = xmlNodeGetAttribute( elementNode, "lodModel" ) or false
			local doublesided = xmlNodeGetAttribute( elementNode, "doublesided" ) or false
			local scale = xmlNodeGetAttribute( elementNode, "scale" ) or false
			local radius = tonumber(xmlNodeGetAttribute( elementNode, "radius" ) or 0)
			local posX = tonumber(xmlNodeGetAttribute( elementNode, "posX" ))
			local posY = tonumber(xmlNodeGetAttribute( elementNode, "posY" ))
			local posZ = tonumber(xmlNodeGetAttribute( elementNode, "posZ" ))
			local rotX = tonumber(xmlNodeGetAttribute( elementNode, "rotX" ))
			local rotY = tonumber(xmlNodeGetAttribute( elementNode, "rotY" ))
			local rotZ = tonumber(xmlNodeGetAttribute( elementNode, "rotZ" ))
            if ( elementName == "object" ) then
               	-- IsLowLod - false?
                local object = createObject( tonumber( model ), tonumber( posX ), tonumber( posY ), tonumber( posZ ), tonumber( rotX ), tonumber( rotY ), tonumber( rotZ ), false )
                
                if ( id ~= false ) then
                    setElementID( object, id )
                end
                if ( collisions ~= false ) then
                    if ( collisions == "true" ) then
                        setElementCollisionsEnabled( object, true )
                    else
                        setElementCollisionsEnabled( object, false )
                    end
                end
                if ( alpha ~= false and alpha ~= "255" ) then
                    alpha = tonumber( alpha )
                    setElementAlpha( object, alpha )
                end
                if ( scale ~= false ) then
                    setObjectScale( object, tonumber( scale ) )
                end
                if ( doublesided ~= false ) then
                    if ( doublesided == "true" ) then
                        setElementDoubleSided( object, true )
                    else
                        setElementDoubleSided( object, false )
                    end
                end
			elseif elementName == "removeWorldObject" then
				removeWorldModel ( model, radius, posX, posY, posZ )
				removeWorldModel ( lodModel, radius, posX, posY, posZ )
            end
        end
    end	
end

addCommandHandler("loadMap",function(command,map)
	loadMap(map..".map", 255)
end)

step = 0
x,y,w,h = 0,0,0,0
newColShape = nil
function mouseClick(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
	if state == "down" then
		if step == 2 then
			x, y, w, h = worldX, worldY, 10, 10

			if isElement(newColShape) then
				destroyElement(newColShape)
			end

			newColShape = createColRectangle(x, y, w, h)
		elseif step == 3 then
			w, h = worldX-x, worldY-y

			if not isElement(newColShape) then
				newColShape = createColRectangle(x, y, w, h)
			else
				setColShapeSize(newColShape, w, h)  
			end
		end
	end
end

addCommandHandler("startC", function()	
	setDevelopmentMode(true)
	outputChatBox("Введи /showcol")
	if step == 0 then
		loadMap("down.map", 255)
		loadMap("up.map", 150)
		step = 1
	elseif step == 1 then
		outputChatBox("Выбери первую точку")
		step = 2
		addEventHandler("onClientClick", root, mouseClick)
	elseif step == 2 then
		outputChatBox("Выбери вторую точку")
		step = 3
	elseif step == 3 then
		outputChatBox("Выбрано ".. #getElementsWithinColShape(newColShape, "object").." объектов")
	end
end)

addCommandHandler("changeC", function()	
	outputChatBox("Перенос ".. #getElementsWithinColShape(newColShape, "object").." объектов")
	changeMap("down.map", "up.map", x, y, w, h)
	step = 0
end)