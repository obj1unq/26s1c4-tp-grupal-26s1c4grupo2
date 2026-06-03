import wollok.game.*

object player {
  var property position = game.center()
  var imagenActual = "byteman-arriba.png"
  method image() = imagenActual
  
  method position() = position
  
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