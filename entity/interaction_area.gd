extends Node2D
const ROTATION:Dictionary={Vector2.UP:0,Vector2.DOWN:180,Vector2.LEFT:270,Vector2.RIGHT:90,Vector2(1,-1):45,Vector2(1,1):120,Vector2(-1,1):225,Vector2(-1,-1):320}
func rotar(previus_dir:Vector2)->void:rotation_degrees=ROTATION[previus_dir]
