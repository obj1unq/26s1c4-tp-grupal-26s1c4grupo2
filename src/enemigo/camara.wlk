import wollok.game.*

class Camara {
  var imagen = ""
  const property position
  
  method image() = imagen
  
  method manejarEstado(nuevoEstado) {
    nuevoEstado.afectar(self)
  }
  
  method establecerSigilo() {
    imagen = "camara-arriba-sigilo.png"
  }
  
  method establecerAlarma() {
    imagen = "camara-arriba-alarma.png"
  }
  
  method establecerReinicio() {
    imagen = "camara-arriba-reinicio.png"
  }
}

object inicializadorCamara {
  method inicializar(nivel, x, y) {
    const camara = new Camara(position = game.at(x, y))
    camara.manejarEstado(nivel.estado())
    game.addVisual(camara)
  }
}