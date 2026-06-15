import wollok.game.*
import src.utilidades.direcciones.*

class Camara {
  const property esAtravesable = false
  var orientacion = arriba
  const property position
  var estadoDeImagen = ""
  
  method image() = ((("camara-" + orientacion.comoCadena()) + "-") + estadoDeImagen) + ".png"
  
  method manejarEstado(nuevoEstado) {
    nuevoEstado.afectar(self)
  }
  
  method manejarSigilo() {
    estadoDeImagen = "sigilo"
  }
  
  method manejarAlarma() {
    estadoDeImagen = "alarma"
  }
  
  method manejarReinicio() {
    estadoDeImagen = "reinicio"
  }
}

object inicializadorCamara {
  method inicializar(nivel, x, y) {
    const camara = new Camara(position = game.at(x, y))
    camara.manejarEstado(nivel.estado())
    game.addVisual(camara)
  }
}