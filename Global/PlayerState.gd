extends Node

var collectables = {}
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

func clear():
	hasSavedState = false
	health = 0
	collectables = {}
