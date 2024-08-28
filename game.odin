package main
import rl "vendor:raylib"

//keep track of the elements in the game.

Game :: struct {
	player:        Spaceship,
	velocity:      Speed "defined in movement code",
	screen_width:  i32,
	screen_height: i32,
}

new_game :: proc() -> Game {
	game: Game
	game.player = new_spaceship()
	game.velocity.x = 7
	game.velocity.y = 7
	game.screen_width = rl.GetScreenWidth()
	game.screen_height = rl.GetScreenHeight()
	return game
}

draw_game :: proc(game: ^Game) {
	draw_spaceship(&game.player)

	//draw lasers
	//loop by reference
	for &laser in game.player.lasers {
		draw_laser(&laser)
	}
}

update_game :: proc(game: ^Game) {
	//update lasers
	for &laser in game.player.lasers {
		update_laser(&laser, game)
	}
}

handle_input_game :: proc(game: ^Game) {

	switch {
	case rl.IsKeyDown(rl.KeyboardKey.A):
		move_left_player(game)

	case rl.IsKeyDown(rl.KeyboardKey.D):
		move_right_player(game)

	case rl.IsKeyDown(rl.KeyboardKey.SPACE):
		//just creates a new laser, the position of which is updated by the 
		//update game function.
		firelaser_spaceship(&game.player)
	}

}


//NOTE: call functions that free assets here
free_everything_game :: proc(game: ^Game) {
	delete_spaceship(&game.player)
}
