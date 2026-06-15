import wollok.game.*

object tablero {
  method inicializar(nivel) {
    const plano = nivel.plano()

    game.height(plano.alto())
    game.width(plano.ancho())
    self.inicializarCeldas(nivel)
    self.traerAdelante(nivel.jugador())
  }
  
  method inicializarCeldas(nivel) {
    const plano = nivel.plano()

    plano.coordenadasX().forEach(
      { x => plano.coordenadasY().forEach(
          { y => self.inicializarCelda(nivel, x, y) }
        ) }
    )
  }
  
  method inicializarCelda(nivel, x, y) {
    const plano = nivel.plano()

    self.inicializadorEnCelda(plano, x, y).inicializar(nivel, x, y)
  }
  
  method inicializadorEnCelda(plano, x, y) = plano.coordenada(x, y)
  
  method traerAdelante(elemento) {
    game.removeVisual(elemento)
    game.addVisual(elemento)
  }

  method elementosEnCelda(posicion) = game.getObjectsIn(posicion)
}