import wollok.game.*
import src.utilidades.direcciones.*

class Dron {
  const property esAtravesable = true
  var orientacion = arriba
  const property position
  var estadoDeImagen = ""
  
  method image() = ((("dron-" + orientacion.comoCadena()) + "-") + estadoDeImagen) + ".png"
  
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

object inicializadorDron {
  method inicializar(nivel, x, y) {
    const dron = new Dron(position = game.at(x, y))
    dron.manejarEstado(nivel.estado())
    game.addVisual(dron)
  }
}