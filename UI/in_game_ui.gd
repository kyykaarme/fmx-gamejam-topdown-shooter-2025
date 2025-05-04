extends CanvasLayer

@onready var player = $"../Player"
@onready var playerStat = player.get_node("Stats") as Stats
@onready var HealthBar = $HP/HealthyBar
@onready var XPBar = $EXP/XPBar
func _ready():
	HealthBar.value = 100
	XPBar.value = 0
func update():
	HealthBar.value = playerStat.current_HP * 100 / playerStat.max_HP
	XPBar.value = playerStat.currExp * 100 / playerStat.expToUpgrade
	
