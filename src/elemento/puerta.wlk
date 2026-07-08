import wollok.game.*

class Puerta {
  const property position
  var estado = cerrada
  
  method image() = estado.image()
  
  method esAtravesable() = estado.esAtravesable()
  
  method abrir() {
    estado = abierta
  }
  
  method cerrar() {
    estado = cerrada
  }
  
  method manejarColisionConJugador(jugador) {
    
  }
}

object inicializadorPuerta {
  method inicializar(nivel, x, y) {
    const puerta = new Puerta(position = game.at(x, y))
    nivel.puerta(puerta)
    game.addVisual(puerta)
  }
}

/* ESTADOS */

object abierta {
  const property esAtravesable = true
  
  method image() = "puerta-abierta.png"
}

object cerrada {
  const property esAtravesable = false
  
  method image() = "puerta-cerrada.png"
}