import src.enemigo.gestor.*
import src.utilidades.tablero.tablero

class Nivel {
  const property gestorEnemigos = new GestorEnemigos(nivel = self)
  const property siguiente = null
  const property plano
  var property juego = null
  var property jugador = null
  var property puerta = null
  var property estado

  method cargar(_juego) {
    juego = _juego
    gestorEnemigos.estado(estado)
    tablero.inicializarNivel(self)
    game.onTick(500, "enemigos", { gestorEnemigos.actualizar(jugador) })
  }

  method ganar() {
    juego.ganarNivel()
  }
}