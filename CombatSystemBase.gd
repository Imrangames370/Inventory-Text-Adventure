extends Node2D

# Combat System Base notes

# _________________________________________________________________

# Player stats
@export_group("Player Stats")
@export var player_healthPoints : int 	# HP
@export var player_damage : int 		# Damage
@export var player_armor : int			# Armor
@export var player_initiative : int		# Initiative - the higher the number --> your turn is first
@export var player_perception : int		# Perception - before attacking, checks if you will miss/land the attack
@export var player_evasion : int		# Evasion
@export var player_luck : int			# Luck

# Player item stats
@export_group("Player Item Stats")
@export var itemDamage : int 	
@export var itemStatusDamage : int 		



# Enemy stats
@export_group("Enemy Stats")
@export var enemy_healthPoints : int
@export var enemy_damage : int
@export var enemy_armor : int
@export var enemy_initiative : int
@export var enemy_perception : int
@export var enemy_evasion : int
@export var enemy_luck : int

# should be float numbers but then normalized to whole numbers
# before being displayed to player

# _________________________________________________________________

# Equations

# Will need to be tweaked but this should work as a base for now
func caluculateDMGtoPlayer():
	var enemyDMG :int  
	enemyDMG = enemy_damage + enemy_luck
	player_healthPoints -= player_armor - enemyDMG
	return player_healthPoints


func calculateDMGtoEnemy():
	var playerDMG :int 
	playerDMG = player_damage + itemDamage + itemStatusDamage + player_luck
	enemy_healthPoints -= enemy_armor - playerDMG
	return enemy_healthPoints
 # enemy denfense and attack should be considerably higher than player


func _ready() -> void: 
	print(caluculateDMGtoPlayer())
	print(calculateDMGtoEnemy())


# For initiative and perception/evassion they just needed to be pitted against 
# each other in a </>/= if statement. if theyre == then use a random rng to determine winner
