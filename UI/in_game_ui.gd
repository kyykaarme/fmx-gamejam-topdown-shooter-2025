extends CanvasLayer

@export var player: Player
var playerStat
@onready var HealthBar = $HP/HealthyBar
@onready var XPBar = $EXP/XPBar

func _ready():
	playerStat = player.get_node("Stats") as Stats
	update()
	playerStat.takenDam.connect(update)
	playerStat.gainExp.connect(update)

func update():
	HealthBar.value = playerStat.current_HP * 100 / playerStat.max_HP
	XPBar.value = playerStat.currExp * 100 / playerStat.expToUpgrade
