class_name Player extends DigimonCORE
#var data:Array[float]=[]
var alive:bool=true
var line_id:Array[int]=[0,16,3]
func _init()->void:
	var plus=Iniload.statsplus
	for i in plus.keys(): set(i,plus[i])

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
func hit(damage:float,dir:Vector2,a:DigimonBody,physic:bool,area:bool=false)->void:
	if area:_hit(damage,dir,a.attribute,physic)
	else:
		if physic:a.core.attack+=0.01
		else:a.core.inteligent+=0.01
		var limit=(body.get_speed()-a.get_speed())
		if limit<=0:_hit(damage,dir,a.attribute,physic)
		elif randi_range(0,limit/2)==0:_hit(damage,dir,a.attribute,physic)
		else:
			speed+=0.1/limit
			body.flee()
	body.enemies.push_back(a)
#	if current_life<=0: dead(a.Digimon_Id)

func _on_tree_exiting()->void:
#	if alive:dead("exit game")
	pass

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
