extends Node

var collectables = {
	CollectableType.COIN: 0,
	CollectableType.POTION_HEAL: 0
}
var health = 0
var hasSavedState = false

func load(stats, playerStats):
	if hasSavedState:
		stats.health = health
		for collectable in collectables.keys():
			playerStats.collect(collectable, collectables[collectable])
	
func save(stats, playerStats):
	hasSavedState = true
	health = stats.health
	collectables = playerStats.collectables
