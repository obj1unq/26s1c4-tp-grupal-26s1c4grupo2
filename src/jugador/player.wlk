import wollok.game.*
import src.utilidades.direcciones.*
import src.utilidades.tablero.tablero

object player {
  const property esAtravesable = true
  var orientacion = arriba
  var property position = game.center()
  
  method image() = ("byteman-" + orientacion.comoCadena()) + ".png"
  
  method inicializar(nivel, x, y) {
    nivel.jugador(self)
    self.position(game.at(x, y))
    self.inicializarMovimiento()
    game.addVisual(self)
  }
  
  method inicializarMovimiento() {
    keyboard.up().onPressDo({ self.orientarHaciaYMoverSiPuede(arriba) })
    keyboard.right().onPressDo({ self.orientarHaciaYMoverSiPuede(derecha) })
    keyboard.down().onPressDo({ self.orientarHaciaYMoverSiPuede(abajo) })
    keyboard.left().onPressDo({ self.orientarHaciaYMoverSiPuede(izquierda) })
  }
  
  method orientarHaciaYMoverSiPuede(direccion) {
    self.orientarHacia(direccion)
    
    if (self.puedeMoverse(direccion)) self.mover(direccion)
  }
  
  method orientarHacia(direccion) {
    orientacion = direccion
  }
  
  method puedeMoverse(direccion) = tablero.elementosEnCelda(
    direccion.siguiente(position)
  ).all({ elemento => elemento.esAtravesable() })
  
  method mover(direccion) {
    position = direccion.siguiente(position)
  }
}