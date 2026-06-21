import wollok.game.*
import src.enemigoprueba.mapa.mapa.*
import src.enemigoprueba.utils.utils.*

object patrullarAleatorio {
  method mover(enemigo, movimiento, objetivo) {
    const dir = [[1,0],[-1,0],[0,1],[0,-1]].anyOne()
    const nx = enemigo.position().x() + dir.first()
    const ny = enemigo.position().y() + dir.last()
    if (!mapaBuilder.isWallEn(nx, ny)) {
      enemigo.position(game.at(nx, ny))
    }
  }
}

class Patrullar {
  var property dirX = 1
  var property dirY = 1
  var property patrullaVertical = false

  method mover(enemigo, movimiento, objetivo) {
    self.actualizarEje(enemigo)
    self.avanzar(enemigo)
  }

  method actualizarEje(enemigo) {
    const pos = enemigo.position()
    if (patrullaVertical && self.encajonadoEnY(pos)) {
      patrullaVertical = false
    } else if (!patrullaVertical && self.encajonadoEnX(pos)) {
      patrullaVertical = true
    }
  }

  method avanzar(enemigo) {
    if (patrullaVertical) self.avanzarEnY(enemigo)
    else                  self.avanzarEnX(enemigo)
  }

  method avanzarEnX(enemigo) {
    const pos = enemigo.position()
    const nx  = pos.x() + dirX
    if (!mapaBuilder.isWallEn(nx, pos.y())) {
      enemigo.position(game.at(nx, pos.y()))
    } else {
      dirX = 0 - dirX
    }
  }

  method avanzarEnY(enemigo) {
    const pos = enemigo.position()
    const ny  = pos.y() + dirY
    if (!mapaBuilder.isWallEn(pos.x(), ny)) {
      enemigo.position(game.at(pos.x(), ny))
    } else {
      dirY = 0 - dirY
    }
  }

  method encajonadoEnX(pos) {
    return mapaBuilder.isWallEn(pos.x() - 1, pos.y()) && mapaBuilder.isWallEn(pos.x() + 1, pos.y())
  }

  method encajonadoEnY(pos) {
    return mapaBuilder.isWallEn(pos.x(), pos.y() - 1) && mapaBuilder.isWallEn(pos.x(), pos.y() + 1)
  }
}

object perseguir {
  method mover(enemigo, movimiento, objetivo) {
    movimiento.darPasoHacia(enemigo, objetivo.position().x(), objetivo.position().y())
  }
}

class Investigar {
  const property ultimaX
  const property ultimaY

  method mover(enemigo, movimiento, objetivo) {
    if (self.llegoA(enemigo) || !movimiento.darPasoHacia(enemigo, ultimaX, ultimaY)) {
      movimiento.olvidar()
    }
  }

  method llegoA(enemigo) {
    return enemigo.position().x() == ultimaX && enemigo.position().y() == ultimaY
  }
}

class Rotar {
  var ticksRestantes      = 6
  const ticksPorDireccion = 6
  var dx = 1
  var dy = 0

  method mover(enemigo, movimiento, objetivo) {
    ticksRestantes = ticksRestantes - 1
    if (self.esMomentoDeRotar()) {
      self.rotar(enemigo)
    }
  }

  method esMomentoDeRotar() = ticksRestantes <= 0

  method rotar(enemigo) {
    const nuevoDx = 0 - dy
    const nuevoDy = dx
    dx = nuevoDx
    dy = nuevoDy
    enemigo.direccionX(dx)
    enemigo.direccionY(dy)
    ticksRestantes = ticksPorDireccion
  }
}

class Movimiento {
  var property estadoBase = new Patrullar()
  var property estado     = new Patrullar()
  var property ultimaX = -1
  var property ultimaY = -1

  method tieneUltima() = ultimaX >= 0

  method mover(enemigo, objetivo) {
    estado.mover(enemigo, self, objetivo)
  }

  method verObjetivo(pos) {
    ultimaX = pos.x()
    ultimaY = pos.y()
    estado  = perseguir
  }

  method perderObjetivo() {
    if (self.tieneUltima()) {
      estado = new Investigar(ultimaX = ultimaX, ultimaY = ultimaY)
    } else {
      estado = estadoBase
    }
  }

  method olvidar() {
    ultimaX = -1
    ultimaY = -1
    estado  = estadoBase
  }

  method darPasoHacia(enemigo, tx, ty) {
    const pos = enemigo.position()
    const dx  = utils.signo(tx - pos.x())
    const dy  = utils.signo(ty - pos.y())
    return (dx != 0 && self.moverEn(enemigo, pos, dx, 0)) ||
           (dy != 0 && self.moverEn(enemigo, pos, 0, dy))
  }

  method moverEn(enemigo, pos, dx, dy) {
    const destino      = self.calcularDestino(pos, dx, dy)
    const puedeMoverse = self.estaLibre(destino)
    if (puedeMoverse) enemigo.position(destino)
    return puedeMoverse
  }

  method calcularDestino(pos, dx, dy) = game.at(pos.x() + dx, pos.y() + dy)

  method estaLibre(pos) = !mapaBuilder.isWallEn(pos.x(), pos.y())
}
