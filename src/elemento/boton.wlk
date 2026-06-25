import wollok.game.*

class Boton {
  const property esAtravesable = true
  const property position
  const nivel
  var estado = levantado
  
  method image() = estado.image()
  
  method tocar() {
    estado.tocar(self)
  }
  
  method manejarColisionConJugador(jugador) {
    self.tocar()
  }
  
  method presionar() {
    estado = presionado
    nivel.puerta().abrir()
  }
  
  method levantar() {
    estado = levantado
    nivel.puerta().cerrar()
  }
}

object inicializadorBoton {
  method inicializar(_nivel, x, y) {
    game.addVisual(new Boton(position = game.at(x, y), nivel = _nivel))
  }
}

/* ESTADOS */

object levantado {
  method image() = "boton-levantado.png"
  
  method tocar(boton) {
    boton.presionar()
  }
}

object presionado {
  method image() = "boton-presionado.png"
  
  method tocar(boton) {
    boton.levantar()
  }
}