import src.enemigo.gestor.*
import src.utilidades.tablero.tablero

class Nivel {
  var property estado
  const property plano
  var property jugador = null
  var property puerta = null
  const property gestorEnemigos = new GestorEnemigos()

  method inicializar() {
    gestorEnemigos.estado(estado)
    game.ground(estado.ground())
    tablero.inicializar(self)
    game.onTick(500, "enemigos", { gestorEnemigos.actualizar(jugador) })
  }
}