package main

import rl "vendor:raylib"
import "core:time"


new_alien :: proc(game: ^Game, position: rl.Vector3, type: int) -> Spaceship {
	alien: Spaceship
	lasers := make([dynamic]Laser, 0, 11)

	//aliens have a fraction of the users health.
	//the fraction can be improper for stronger aliens
	//health decreases as the type increases(closer to the player in the beginning of the game)
	//NOTE:prevent division by zero
	if type == 0 {
		alien.health = 2
	} else {
	    //TODO: @improvement: reduce the type casts.
		alien.health = i32(1 / type * int(type))
	}

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

update_aliens :: proc(aliens: ^[dynamic]Spaceship) {

}

//TODO: pointer depencence could be handled better,
//TODO: @improvement: implement logic for updating lasers in any direction.
// in case the alien in question is destroyed and the memory is freed.
update_alien_lasers :: proc(game: ^Game) {

	for &alien in game.aliens {
		for &laser in alien.lasers {
				update_laser(&laser, game)
			}
		}
	}

//TODO: definitely need to do more than just unload the texture here!
delete_alien :: proc(alien: ^Spaceship) {
	rl.UnloadTexture(alien.image)
}
