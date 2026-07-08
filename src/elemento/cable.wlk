import wollok.game.*

class Cable {
  const property esAtravesable = true
  const property image = "cable.png"
  const property position
  const gestorEnemigos
  const property rango = 6
  var activada = false

  method manejarColisionConJugador(jugador) {
    if (!activada) {
      activada = true
      gestorEnemigos.alertarCercaDe(position, rango)
    }
  }
}

object inicializadorCable {
  method inicializar(nivel, x, y) {
    game.addVisual(
      new Cable(
        position = game.at(x, y),
        gestorEnemigos = nivel.gestorEnemigos()
      )
    )
  }
}