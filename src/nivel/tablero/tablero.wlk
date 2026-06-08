import src.jugador.player.player

class Tablero {
  const plano
  
  method inicializar(nivel) {
    game.height(plano.alto())
    game.width(plano.ancho())
    self.inicializarCeldas(nivel)
    self.traerAdelante(nivel.jugador())
  }
  
  method inicializarCeldas(nivel) {
    plano.coordenadasX().forEach(
      { x => plano.coordenadasY().forEach(
          { y => self.inicializarCelda(nivel, x, y) }
        ) }
    )
  }
  
  method inicializarCelda(nivel, x, y) {
    self.inicializadorEnCelda(x, y).inicializar(nivel, x, y)
  }
  
  method inicializadorEnCelda(x, y) = plano.coordenada(x, y)
  
  method traerAdelante(elemento) {
    game.removeVisual(elemento)
    game.addVisual(elemento)
  }
}