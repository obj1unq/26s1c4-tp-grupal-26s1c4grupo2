import wollok.game.*
import src.enemigoprueba.movimiento.movimiento.*
import src.enemigoprueba.utils.utils.*

object dirDerecha {
  method dx() = 1
  method dy() = 0
  method nombre() = "derecha"
  method siguiente() = dirArriba
}

object dirArriba {
  method dx() = 0
  method dy() = 1
  method nombre() = "arriba"
  method siguiente() = dirIzquierda
}

object dirIzquierda {
  method dx() = -1
  method dy() = 0
  method nombre() = "izquierda"
  method siguiente() = dirAbajo
}

object dirAbajo {
  method dx() = 0
  method dy() = -1
  method nombre() = "abajo"
  method siguiente() = dirDerecha
}

class Enemigo {
  var property position    
  var property campoVision 
  var property movimiento 
  var property direccionX = 1
  var property direccionY = 0

  method image()


  method nombreDireccion() =
    [dirDerecha, dirArriba, dirIzquierda, dirAbajo]
      .find({ d => d.dx() == direccionX && d.dy() == direccionY })
      .nombre()

  method detectarObjetivo(objetivo) {
    if (!objetivo.estaEscondido() && campoVision.puedeVerA(self, objetivo)) {
      movimiento.verObjetivo(objetivo.position())
    } else {
      movimiento.perderObjetivo()
    }
  }

  method actualizar(objetivo) {
    self.detectarObjetivo(objetivo)
    const invoco = self.reaccionar(objetivo)
    const antesX = position.x()
    const antesY = position.y()
    self.mover(objetivo)
    self.actualizarMirada(antesX, antesY)
    self.alContacto(objetivo)
    return invoco
  }

  method reaccionar(objetivo) { return false }

  method mover(objetivo) {
    movimiento.mover(self, objetivo)
  }

  method alContacto(objetivo) {
    if (position.x() == objetivo.position().x() && position.y() == objetivo.position().y()) {
      game.say(self, "Game Over")
      game.stop()
    }
  }

  method actualizarMirada(antesX, antesY) {
    const ddx = (position.x() - antesX)
    const ddy = (position.y() - antesY)
    if (ddx != 0 || ddy != 0) {
      direccionX = utils.signo(ddx)
      direccionY = utils.signo(ddy)
    }
  }

}

class EnemigoDron inherits Enemigo {
  override method image() = "dron-" + self.nombreDireccion() + "-alarma.png"
}

class EnemigoCamara inherits Enemigo {

  override method image() = "camara-" + self.nombreDireccion() + "-alarma.png"

  override method detectarObjetivo(objetivo) { }

  override method reaccionar(objetivo) {
    return !objetivo.estaEscondido() && campoVision.puedeVerA(self, objetivo)
  }

  override method alContacto(objetivo) { }
}

class Sabueso inherits Enemigo {
  override method image() = "sabueso-" + self.nombreDireccion() + "-alarma.png"
}
