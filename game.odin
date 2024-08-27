package main
import rl "vendor:raylib"

//keep track of the elements in the game.

Game :: struct {
	player: Spaceship,
}

new_game :: proc() -> Game {
	game: Game
	game.player = new_spaceship()
	return game
}

draw_game :: proc(game: ^Game) {
	draw_spaceship(&game.player)
}

update_game :: proc() {

}

handle_input_game :: proc(game: ^Game) {
	if (rl.IsKeyDown(rl.KeyboardKey.A)) {
		move_left_player(game)
	} else if (rl.IsKeyDown(rl.KeyboardKey.D)) {
		move_right_player(game)
	}

}


//NOTE: call functions that free assets here
free_everything_game :: proc(game: ^Game) {
	delete_spaceship(&game.player)
}
