package main

import rl "vendor: raylib"


new_alien :: proc(game: ^Game, position: Vec3, type: int) -> Spaceship {
	alien: Spaceship
	lasers := make([dynamic]Laser, 0, 11)

	//aliens have a fraction of the users health.
	//the fraction can be improper for stronger aliens
	alien.health = (1\type) * int(type)
	alien.image = game.alien_textures[type]
	alien.position.x = position.x
	alien.position.y = position.y
	alien.lasers = lasers
	alien.fire_constraint = (350 * time.Millisecond)
	time.stopwatch_start(&alien.stopwatch)

	return alien
}

draw_alien :: proc(alien: ^Spaceship) {
	rl.DrawTextureV(alien.image, alien.position, rl.WHITE)
}

update_aliens :: proc(aliens: [dynamic]^Spaceship) {

}

//TODO: make sure to return the right raylib point
position_alien :: proc() -> rl.point2d {

}

update_alien_lasers :: proc(game: ^Game) {
	for &alien in game.aliens {
		for &laser in alien.lasers {
			if alien.active {
				update_laser(&laser, game)
			} else {
				unordered_remove(&game.player.lasers, index)
			}
		}
	}
}

delete_alien :: proc(alien: ^Spaceship) {
	rl.UnloadTexture(alien.image)
}
