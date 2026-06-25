import src.utilidades.tablero.tablero

class Nivel {
  var property estado
  const property plano
  var property jugador = null
  var property puerta = null
  
  method inicializar() {
    game.ground(estado.ground())
    tablero.inicializar(self)
  }
}