extends Node
var time:float=0.0
var player_name:String="rodrigo2"
var digimon_id:int=1
var data:Array[float]=[]
var life:int=102
var energy:int=120
var attack:int=102
var defend:int=102
var speed:int=102
var inteligent:int=210
var will:int=102
var fighter:float
func _ready():
	dead()
	print(Time.get_datetime_dict_from_system())
func _process(delta):
	time+=delta

func dead():
	var _statsplus:Array=[]
	_statsplus+=[life/0.001]
	_statsplus+=[energy/0.001]
	_statsplus+=[attack/0.001]
	_statsplus+=[defend/0.001]
	_statsplus+=[speed/0.001]
	_statsplus+=[inteligent/0.001]
	_statsplus+=[will/0.001]
	var save_data={
	"player_name":player_name,
	"digimon_id":digimon_id,
	"life":life,
	"energy":energy,
	"attack":attack,
	"defend":defend,
	"speed":speed,
	"inteligent":inteligent,
	"will":will}
	Iniload.savedead(save_data)
	
	
