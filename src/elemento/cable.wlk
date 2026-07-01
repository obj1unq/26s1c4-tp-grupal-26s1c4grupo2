import wollok.game.*

class Cable {
  const property esAtravesable = true
  const property image = "cable.png"
  const property position
  const gestorEnemigos
  var activada = false
  
  method manejarColisionConJugador(jugador) {
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