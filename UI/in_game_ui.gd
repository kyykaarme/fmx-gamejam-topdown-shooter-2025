extends CanvasLayer

@export var player: Player
@export var Cages: CageHolder
var playerStat
@onready var HealthBar = $HP/HealthyBar
@onready var XPBar = $EXP/XPBar
@onready var CagesCount = Cages.get_child_count()
@onready var child_count_label = $ChildCountLabel
func _ready():
	_update_child_count_display()
	playerStat = player.get_node("Stats") as Stats
	update()
	playerStat.takenDam.connect(update)
	playerStat.gainExp.connect(update)
	
func _process(delta):
	_update_child_count_display()

func update():
	HealthBar.value = playerStat.current_HP * 100 / playerStat.max_HP
	XPBar.value = playerStat.currExp * 100 / playerStat.expToUpgrade
	
func _update_child_count_display():
	var child_count = Cages.get_child_count()
	child_count_label.text = "Child Count: " + str(child_count) + " / " + str(CagesCount)
