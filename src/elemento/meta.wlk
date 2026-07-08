import wollok.game.*

class Meta {
  const property esAtravesable = true
  const property image = "meta.png"
  const property position
  const nivel
    
  method manejarColisionConJugador(jugador) {
    self.cruzar()
  }
  
  method cruzar() {
    game.schedule(500, { nivel.juego().ganar() })
  }
}

object inicializadorMeta {
  method inicializar(_nivel, x, y) {
    game.addVisual(new Meta(position = game.at(x, y), nivel = _nivel))
  }
}