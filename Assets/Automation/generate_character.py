import bpy

# Clean the scene by removing all existing objects
bpy.ops.object.select_all(action='SELECT')
bpy.ops.object.delete(use_global=False)

# Create a UV sphere as a placeholder for a character model
bpy.ops.mesh.primitive_uv_sphere_add(radius=1, location=(0, 0, 0))

# Set up a basic material
mat = bpy.data.materials.new(name="CharacterMaterial")
mat.use_nodes = True
bsdf = mat.node_tree.nodes["Principled BSDF"]
bsdf.inputs['Base Color'].default_value = (1, 0.5, 0.5, 1)  # Light pink color
bpy.context.object.data.materials.append(mat)

# Save the generated character as a Blender file
output_file = "/home/dude/game_assets/characters/generated_character.blend"
bpy.ops.wm.save_as_mainfile(filepath=output_file)

print(f"Character generated and saved to {output_file}")
