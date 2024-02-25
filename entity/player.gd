class_name Player extends DigimonBase
var time:float=0.0
var digimon_id:float=1
var data:Array[float]=[]
var player_name:String

func _ready():
	var plus=Iniload.statsplus
	for i in plus.keys(): set(i,plus[i])
	dead()
	print(life)
func _process(delta):
	time+=delta

func dead():
	var save_data={
	"time":time,
	"player_name":player_name,
	"digimon_id":digimon_id,
	"life":life,
	"energy":energy,
	"attack":attack,
	"defend":defend,
	"speed":speed,
	"inteligent":inteligent,
	"will":will,
	"fighter":fighter}
	Iniload.savedead(save_data)


