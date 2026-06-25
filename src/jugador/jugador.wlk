import wollok.game.*
import src.utilidades.direcciones.*
import src.utilidades.tablero.tablero

object jugador {
  const imagen = jugadorImagen
  var property position = game.center()
  var property orientacion = arriba
  var estado = visible
  
  method image() = imagen.image()
  
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

/* OBJETOS ÚTILES */

object jugadorImagen {
  const base = "byteman"
  const extension = ".png"
  
  method orientacion() = jugador.orientacion().comoCadena()
  
  method tamaño() = if (tablero.comparteCelda(jugador)) "35" else "50"
  
  method image() = ((((base + "-") + self.orientacion()) + "-") + self.tamaño()) + extension
} 

/* ESTADOS */

object visible {
  const property esAtravesable = true
  
  method mover(direccion, jugador) {
    jugador.mover(direccion)
  }
}

object escondido {
  const property esAtravesable = false
  var property escondite = null
  
  method mover(direccion, jugador) {
    jugador.mover(direccion)
    jugador.visibilizar()
    escondite.liberar()
  }
}