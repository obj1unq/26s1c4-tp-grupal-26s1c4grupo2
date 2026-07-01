import wollok.game.*
import src.utilidades.direcciones.*
import src.enemigo.comportamiento.utils.utils

class Enemigo {
  const property esAtravesable = true
  var orientacion = arriba
  var property position
  var estadoDeImagen = ""
  var property campoVision
  var property movimiento
  const direcciones = [derecha, arriba, izquierda, abajo]
  
  method prefijoImagen()
  
  method image() = ((((self.prefijoImagen() + "-") + orientacion.comoCadena()) + "-") + estadoDeImagen) + ".png"
  
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
  
  method direccion() = orientacion
  
  method cambiarDireccion(dir) {
    orientacion = dir
  }
  
  method detectarObjetivo(objetivo) {
    if ((!objetivo.estaEscondido()) && campoVision.puedeVerA(self, objetivo))
      movimiento.verObjetivo(objetivo.position())
    else movimiento.perderObjetivo()
  }
  
  method actualizar(objetivo) {
    self.detectarObjetivo(objetivo)
    const posAnterior = position
    self.mover(objetivo)
    self.actualizarMirada(posAnterior)
    self.alContacto(objetivo)
  }
  
  method reaccionar(objetivo) = false
  
  method mover(objetivo) {
    movimiento.mover(self, objetivo)
  }
  
  method alContacto(objetivo) {
    if ((position.x() == objetivo.position().x()) && (position.y() == objetivo.position().y())) {
      game.say(objetivo, "Game Over")
      game.stop()
    }
  }
  
  method actualizarMirada(posAnterior) {
    const ddx = position.x() - posAnterior.x()
    const ddy = position.y() - posAnterior.y()
    if ((ddx != 0) || (ddy != 0)) {
      const dx = utils.signo(ddx)
      const dy = utils.signo(ddy)
      self.cambiarDireccion(
        direcciones.find({ d => (d.dx() == dx) && (d.dy() == dy) })
      )
    }
  }
  
  method manejarColisionConJugador(jugador) {
    
  }
}