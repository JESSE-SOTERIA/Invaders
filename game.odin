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
}

update_game :: proc() {

}

handle_input_game :: proc(game: ^Game) {
	//player movement
	if (rl.IsKeyDown(rl.KeyboardKey.A)) {
		move_left_player(game)
	} else if (rl.IsKeyDown(rl.KeyboardKey.D)) {
		move_right_player(game)
	}

	//firing laser

}


//NOTE: call functions that free assets here
free_everything_game :: proc(game: ^Game) {
	delete_spaceship(&game.player)
}
