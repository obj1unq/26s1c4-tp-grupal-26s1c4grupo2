import wollok.game.*
import src.enemigoprueba.movimiento.*

class Enemigo {
  var property position
  var property campoVision
  var property movimiento = new Movimiento()
  var property direccionX = 1
  var property direccionY = 0

  method image() = "dron-abajo-alarma.png"

  method actualizar(objetivo) {
    if (campoVision.puedeVerA(self, objetivo)) {
      movimiento.verObjetivo(objetivo.position())
    } else {
      movimiento.perderObjetivo()
    }
    const antesX = position.x()
    const antesY = position.y()
    movimiento.mover(self, objetivo)
    self.actualizarMirada(antesX, antesY)
  }

  method actualizarMirada(antesX, antesY) {
    const ddx = (position.x() - antesX)
    const ddy = (position.y() - antesY)
    if (ddx != 0 || ddy != 0) {
      direccionX = self.signo(ddx)
      direccionY = self.signo(ddy)
    }
  }

  method signo(valor) {
    if (valor > 0) return 1
    if (valor < 0) return -1
    return 0
  }
}
