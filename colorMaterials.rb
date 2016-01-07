require 'sketchup.rb'

UI.menu('Tools').add_item('Parkitect recoloring') { colorMaterials }

$paletteLocation = "Full path to 256palette.tga"

def colorMaterials()
	SKETCHUP_CONSOLE.clear
	SKETCHUP_CONSOLE.show
	
	model = Sketchup.active_model
	materials = model.materials
	selection = model.selection
	
	# Create new material
	material = materials.add("Recolor Material")
	material.texture = $paletteLocation
	
	# Feet to meter (39 etc)
	material.texture.size = 1000*39.3700787

	ents = model.active_entities
	
	# Color offsets
	color1_x = -0.03
	color1_y = 0.03
	
	color2_x = -0.1
	color2_y = 0.03
	
	color3_x = -0.03
	color3_y = 0.09
	
	color4_x = -0.1
	color4_y = 0.09
	
	count = 0
	total = ents.length
	
	for e in ents
		if e.is_a? Sketchup::Face
		
			# Texture position
			pt_array = []
			pt_array[0] = Geom::Point3d.new(e.vertices[0].position.x, e.vertices[0].position.y, e.vertices[0].position.z)
			pt_array[1] = Geom::Point3d.new(0, 0, 0)

			# puts "posx: #{e.vertices[0].position.x}"
			
			if e.material
				if e.material.display_name == "Color 1"
					pt_array[1] = Geom::Point3d.new(color1_x, color1_y, 0)
					e.position_material(material, pt_array, true)
				end
				
				if e.material.display_name == "Color 2"
					pt_array[1] = Geom::Point3d.new(color2_x, color2_y, 0)
					e.position_material(material, pt_array, true)
				end
				
				if e.material.display_name == "Color 3"
					pt_array[1] = Geom::Point3d.new(color3_x, color3_y, 0)
					e.position_material(material, pt_array, true)
				end
				
				if e.material.display_name == "Color 4"
					pt_array[1] = Geom::Point3d.new(color4_x, color4_y, 0)
					e.position_material(material, pt_array, true)
				end
			end
			
			if e.back_material
				if e.back_material.display_name == "Color 1"
					pt_array[1] = Geom::Point3d.new(color1_x, color1_y, 0)
					e.position_material(material, pt_array, false)
				end
				
				if e.back_material.display_name == "Color 2"
					pt_array[1] = Geom::Point3d.new(color2_x, color2_y, 0)
					e.position_material(material, pt_array, false)
				end
				
				if e.back_material.display_name == "Color 3"
					pt_array[1] = Geom::Point3d.new(color3_x, color3_y, 0)
					e.position_material(material, pt_array, false)
				end
				
				if e.back_material.display_name == "Color 4"
					pt_array[1] = Geom::Point3d.new(color4_x, color4_y, 0)
					e.position_material(material, pt_array, false)
				end
			end
		end
		
		puts "Done (#{count+1} of #{total})"
		count = count+1
	end
	
	materials.each{|material|
		tempColor = material.color
		
		# material.texture = 'C:/empty.jpg'
		# material.texture.size = input[0]*39.3700787
		# material.color = tempColor
		
		# puts material.name
	}
	
	UI.beep
	puts 'UV map complete'
end
