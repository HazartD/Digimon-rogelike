class_name Player extends DigimonCORE
const MENU:PackedScene=preload("res://ui/pause_menu.tscn")
#var data:Array[float]=[]
var line_id:Array[int]=[0,16,3]
#@onready var ui=$UI
func _init()->void:
	var plus=Iniload.statsplus
	for i in plus.keys(): set(i,plus[i])

func _on_child_entered_tree(node)->void:
	if node is DigimonBody:
		line_id.append(node.Digimon_Id)
		var cam=Camera2D.new()
		#var l=AudioListener2D.new()
		#l.make_current()
		#node.add_child(l)
		node.add_child(cam)
		cam.zoom=Vector2(0.25,0.25)


func _on_tree_exiting()->void:pass#	if alive:dead()

#func ded(a:DigimonBody)->void:
	#await get_tree().process_frame
	#await get_tree().process_frame
	#if current_life<=0:dead(a.Digimon_Id)

func dead(cause="exit game")->void:
	var save_data={
	"time":time,
	"player_name":Iniload.player_name,
	"digimon_id":digimon_id,
	"line_id":line_id,
	"life":life,
	"energy":energy,
	"attack":attack,
	"defend":defend,
	"speed":speed,
	"inteligent":inteligent,
	"will":will,
	"fighter":fighter,
	"dead cause":cause}
	Iniload.savedead(save_data)
	line_id.clear()
