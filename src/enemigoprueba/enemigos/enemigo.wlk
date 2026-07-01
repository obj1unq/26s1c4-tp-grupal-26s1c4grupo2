import wollok.game.*
import src.enemigoprueba.movimiento.movimiento.*
import src.enemigoprueba.utils.utils.*
import src.enemigoprueba.direccion.direccion.*


class Enemigo {
  var property position
  const campoVision
  const movimiento
  var direccion = dirDerecha

  const direcciones = [dirDerecha, dirArriba, dirIzquierda, dirAbajo]

  method image()

  method nombreDireccion() = direccion.nombre()
  
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
      self.cambiarDireccion(direcciones.find({ d => d.dx() == dx && d.dy() == dy }))
    }
  }

  method cambiarDireccion(dir) {
    direccion = dir
  }

  method direccion() = direccion
}

class EnemigoDron inherits Enemigo {
  override method image() = "dron-" + self.nombreDireccion() + "-alarma.png"
}

class EnemigoCamara inherits Enemigo {
  override method image() = "camara-" + self.nombreDireccion() + "-alarma.png"
  
  override method detectarObjetivo(objetivo) {
    
  }
  
  override method reaccionar(
    objetivo
  ) = (!objetivo.estaEscondido()) && campoVision.puedeVerA(self, objetivo)
  
  override method alContacto(objetivo) {
    
  }
}

class Sabueso inherits Enemigo {
  override method image() = "sabueso-" + self.nombreDireccion() + "-alarma.png"
}