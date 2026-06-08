import wollok.game.*

object player {
  var property position = game.center()
  var imagenActual = "byteman-arriba.png"
  method image() = imagenActual
  
  method position() = position// no necesario por el 'property'
  
  method mover(nuevaPosicion, nuevaImagen) {
    if (self.estaDentroDelTablero(nuevaPosicion)) {
      position = nuevaPosicion
      imagenActual = nuevaImagen
    }
  }
  
  method estaDentroDelTablero(nuevaPos) = nuevaPos.x().between(
    0,
    game.width() - 1
  ) && nuevaPos.y().between(0, game.height() - 1)
}

object inicializadorJugador {
  method inicializar(nivel, x, y) {
    nivel.jugador(player)
    player.position(game.at(x, y))
    game.addVisual(player)
  }
}