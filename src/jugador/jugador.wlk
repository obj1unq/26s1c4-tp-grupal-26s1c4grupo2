import wollok.game.*
import src.utilidades.direcciones.*
import src.utilidades.tablero.tablero

object jugador {
  var property position = game.center()
  var property orientacion = arriba
  var estado = visible
  
  method image() = estado.image(orientacion)
  
  method esAtravesable() = estado.esAtravesable()
  
  method visibilizar() {
    estado = visible
  }
  
  method esconder(armario) {
    estado = escondido
    estado.escondite(armario)
  }
  
  method mover(direccion) {
    position = direccion.siguiente(position)
  }
  
  method puedeMoverse(direccion) = tablero.elementosEnCelda(
    direccion.siguiente(position)
  ).all({ elemento => elemento.esAtravesable() })
  
  method orientarHacia(direccion) {
    orientacion = direccion
  }
  
  method orientarHaciaYMoverSiPuede(direccion) {
    self.orientarHacia(direccion)
    
    if (self.puedeMoverse(direccion)) estado.mover(direccion, self)
  }
  
  method inicializarColision() {
    game.onCollideDo(
      self,
      { colisionado => colisionado.manejarColisionConJugador(self) }
    )
  }
  
  method inicializarMovimiento() {
    keyboard.up().onPressDo({ self.orientarHaciaYMoverSiPuede(arriba) })
    keyboard.right().onPressDo({ self.orientarHaciaYMoverSiPuede(derecha) })
    keyboard.down().onPressDo({ self.orientarHaciaYMoverSiPuede(abajo) })
    keyboard.left().onPressDo({ self.orientarHaciaYMoverSiPuede(izquierda) })
  }
  
  method inicializar(nivel, x, y) {
    nivel.jugador(self)
    self.position(game.at(x, y))
    self.inicializarColision()
    self.inicializarMovimiento()
    game.addVisual(self)
  }
} 

/* ESTADOS */

// Dependen de si ByteMan está dentro o fuera del Armario.

object visible {
  const property esAtravesable = true
  
  method image(orientacion) = ("byteman-" + orientacion.comoCadena()) + ".png"
  
  method mover(direccion, jugador) {
    jugador.mover(direccion)
  }
}

object escondido {
  const property esAtravesable = false
  var property escondite = null
  
  method image(orientacion) {
    
    // No debe aparecer ninguna imagen  
  }
  
  method mover(direccion, jugador) {
    jugador.mover(direccion)
    jugador.visibilizar()
    escondite.liberar()
  }
}