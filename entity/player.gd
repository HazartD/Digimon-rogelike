class_name Player extends DigimonCORE
#var data:Array[float]=[]
var alive:bool=true
var line_id:Array[int]=[0,16,3]
func _init()->void:
	var plus=Iniload.statsplus
	for i in plus.keys(): set(i,plus[i])

func _on_child_entered_tree(node)->void:
	if node is DigimonBody:
		line_id.append(node.Digimon_Id)
		node.player=true
		var cam=Camera2D.new()
		var l=AudioListener2D.new()
		node.add_child(cam)
		node.add_child(l)
		cam.zoom=Vector2(0.5,0.5)
		l.make_current()

func dead(cause)->void:
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
	alive=false

func _on_tree_exiting()->void:
#	if alive:dead("exit game")
	pass


#func ded(a:DigimonBody)->void:
	#await get_tree().process_frame
	#await get_tree().process_frame
	#if current_life<=0:dead(a.Digimon_Id)
