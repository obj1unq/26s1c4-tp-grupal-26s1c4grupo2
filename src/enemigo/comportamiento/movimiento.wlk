import wollok.game.*
import src.utilidades.tablero.tablero
import src.utilidades.direcciones.*
import utils.utils

class EstadoMovimiento {
  method mover(enemigo, movimiento, objetivo)
}

object patrullarAleatorio inherits EstadoMovimiento {
  const direcciones = [derecha, izquierda, arriba, abajo]
  
  override method mover(enemigo, movimiento, objetivo) {
    const dir = direcciones.anyOne()
    if (movimiento.puedeMoverse(enemigo, dir.dx(), dir.dy()))
      movimiento.moverEn(enemigo, dir.dx(), dir.dy())
  }
}

class Patrullar inherits EstadoMovimiento {
  var dx = 1
  var dy = 0
  
  override method mover(enemigo, movimiento, objetivo) {
    if (!movimiento.puedeMoverse(enemigo, dx, dy)) self.alChocar(
        enemigo,
        movimiento
      )
    movimiento.moverEn(enemigo, dx, dy)
  }
  
  method alChocar(enemigo, movimiento) {
    dx = 0 - dx
    dy = 0 - dy
    if (!movimiento.puedeMoverse(enemigo, dx, dy)) self.girarEje()
  }
  
  method girarEje() {
    const temp = dx
    dx = dy
    dy = temp
  }
}

object perseguir inherits EstadoMovimiento {
  override method mover(enemigo, movimiento, objetivo) {
    movimiento.darPasoHacia(enemigo, objetivo.position())
  }
}

class Investigar inherits EstadoMovimiento {
  const ultimaPos
  
  override method mover(enemigo, movimiento, objetivo) {
    if (self.llegoA(enemigo) || (!movimiento.darPasoHacia(enemigo, ultimaPos)))
      movimiento.olvidar()
  }
  
  method llegoA(enemigo) = enemigo.position() == ultimaPos
}

class Rotar inherits EstadoMovimiento {
  const ticksPorDireccion = 6
  var ticks = 0
  
  override method mover(enemigo, movimiento, objetivo) {
    ticks += 1
    if ((ticks % ticksPorDireccion) == 0) self.rotar(enemigo)
  }
  
  method rotar(enemigo) {
    enemigo.cambiarDireccion(enemigo.direccion().rotar())
  }
}

class Movimiento {
  const estadoBase = new Patrullar()
  var estado = null
  var ultimaVista = null
  
  method initialize() {
    estado = estadoBase
  }
  
  method tieneUltima() = ultimaVista !== null
  
  method mover(enemigo, objetivo) {
    estado.mover(enemigo, self, objetivo)
  }
  
  method verObjetivo(pos) {
    ultimaVista = pos
    estado = perseguir
  }
  
  method perderObjetivo() {
    if (self.tieneUltima()) {
      estado = new Investigar(ultimaPos = ultimaVista)
    } else {
      estado = estadoBase
    }
  }
  
  method olvidar() {
    ultimaVista = null
    estado = estadoBase
  }
  
  method darPasoHacia(enemigo, pos) = self.darPasoEnX(
    enemigo,
    pos.x()
  ) || self.darPasoEnY(enemigo, pos.y())
  
  method darPasoEnX(enemigo, tx) {
    const dx = utils.signo(tx - enemigo.position().x())
    return (dx != 0) && self.moverSiPuede(enemigo, dx, 0)
  }
  
  method darPasoEnY(enemigo, ty) {
    const dy = utils.signo(ty - enemigo.position().y())
    return (dy != 0) && self.moverSiPuede(enemigo, 0, dy)
  }
  
  method moverSiPuede(enemigo, dx, dy) {
    const puede = self.puedeMoverse(enemigo, dx, dy)
    if (puede) self.moverEn(enemigo, dx, dy)
    return puede
  }
  
  method moverEn(enemigo, dx, dy) {
    enemigo.position(self.calcularDestino(enemigo.position(), dx, dy))
  }
  
  method puedeMoverse(enemigo, dx, dy) = self.estaLibre(
    self.calcularDestino(enemigo.position(), dx, dy)
  )
  
  method calcularDestino(pos, dx, dy) = game.at(pos.x() + dx, pos.y() + dy)
  
  method estaLibre(pos) = tablero.elementosEnCelda(pos).all(
    { e => e.esAtravesable() }
  )
}