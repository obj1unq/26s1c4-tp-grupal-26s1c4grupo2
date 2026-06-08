class Nivel {
  var property estado
  const tablero
  var property jugador = null
  
  method inicializar() {
    game.ground(estado.ground())
    tablero.inicializar(self)
  }
}