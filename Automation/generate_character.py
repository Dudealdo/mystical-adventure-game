import bpy

# Clear the scene
bpy.ops.object.select_all(action='SELECT')
bpy.ops.object.delete(use_global=False)

# Add a basic 3D model (e.g., a cube)
bpy.ops.mesh.primitive_cube_add(size=2, location=(0, 0, 1))

# Save the model to the output directory
output_path = "/home/dude/game_assets/characters/character_model.obj"
bpy.ops.export_scene.obj(filepath=output_path)

print(f"Character model saved at: {output_path}")

