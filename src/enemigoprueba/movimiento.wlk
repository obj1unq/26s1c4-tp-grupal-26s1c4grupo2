import wollok.game.*
import src.enemigoprueba.mapa.*

object patrullar {
  method mover(enemigo, movimiento, objetivo) {
    const ex = enemigo.position().x()
    const ey = enemigo.position().y()
    if (movimiento.patrullaVertical()) {
      if (self.encajonado(ex, ey - 1, ex, ey + 1)) {
        movimiento.patrullaVertical(false)        
        self.patrullarHorizontal(enemigo, movimiento)
      } else {
        self.patrullarVertical(enemigo, movimiento)
      }
    } else {
      if (self.encajonado(ex - 1, ey, ex + 1, ey)) {
        movimiento.patrullaVertical(true)         
        self.patrullarVertical(enemigo, movimiento)
      } else {
        self.patrullarHorizontal(enemigo, movimiento)
      }
    }
  }

  method encajonado(ax, ay, bx, by) {
    return mapaBuilder.isWallEn(ax, ay) && mapaBuilder.isWallEn(bx, by)
  }

  method patrullarHorizontal(enemigo, movimiento) {
    const nx = (enemigo.position().x() + movimiento.dirX())
    const ny = enemigo.position().y()
    if (!mapaBuilder.isWallEn(nx, ny)) {
      enemigo.position(game.at(nx, ny))
    } else {
      movimiento.invertirDir()
    }
  }

  method patrullarVertical(enemigo, movimiento) {
    const nx = enemigo.position().x()
    const ny = (enemigo.position().y() + movimiento.dirY())
    if (!mapaBuilder.isWallEn(nx, ny)) {
      enemigo.position(game.at(nx, ny))
    } else {
      movimiento.invertirDirY()
    }
  }
}

object perseguir {
  method mover(enemigo, movimiento, objetivo) {
    movimiento.darPasoHacia(enemigo, objetivo.position().x(), objetivo.position().y())
  }
}

object investigar {
  method mover(enemigo, movimiento, objetivo) {
    const tx = movimiento.ultimaX()
    const ty = movimiento.ultimaY()
    if (movimiento.llegoA(enemigo, tx, ty)||!movimiento.darPasoHacia(enemigo, tx, ty)) {
      movimiento.olvidar()              
    }
  }
}


class Movimiento {
  var property estado = patrullar
  var property dirX   = 1
  var property dirY   = 1  
  var property patrullaVertical = false   
  var property ultimaX     = -1
  var property ultimaY     = -1
  var property tieneUltima = false

  method mover(enemigo, objetivo) {
    estado.mover(enemigo, self, objetivo)
  }

  method verObjetivo(pos) {
    ultimaX     = pos.x()
    ultimaY     = pos.y()
    tieneUltima = true
    estado      = perseguir
  }


  method perderObjetivo() {
    if (tieneUltima) {
      estado = investigar
    } else {
      estado = patrullar
    }
  }

  method olvidar() {
    tieneUltima = false
    estado      = patrullar
  }

  method darPasoHacia(enemigo, tx, ty) {
    const ex = enemigo.position().x()
    const ey = enemigo.position().y()
    const dx = self.signo(tx - ex)
    const dy = self.signo(ty - ey)
    if (dx != 0 && !mapaBuilder.isWallEn(ex + dx, ey)) {
      enemigo.position(game.at(ex + dx, ey))
      return true
    }
    if (dy != 0 && !mapaBuilder.isWallEn(ex, ey + dy)) {
      enemigo.position(game.at(ex, ey + dy))
      return true
    }
    return false
  }

  method llegoA(enemigo, tx, ty) {
    return enemigo.position().x() == tx && enemigo.position().y() == ty
  }

  method invertirDir() {
    dirX = (0 - dirX)
  }

  method invertirDirY() {
    dirY = (0 - dirY)
  }

  method signo(valor) {
    return if (valor > 0) 1 else if (valor < 0) -1 else 0
  }
}
