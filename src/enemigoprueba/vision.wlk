import wollok.game.*
import src.enemigoprueba.mapa.*

class CampoVision {

  method puedeVerA(enemigo, objetivo)

  method orientacion(enemigo, objetivo) {
    const dx = (objetivo.position().x() - enemigo.position().x())
    const dy = (objetivo.position().y() - enemigo.position().y())
    return (dx * enemigo.direccionX()) + (dy * enemigo.direccionY())
  }


  method lineaDespejada(desde, hasta) {
    const dx = (hasta.x() - desde.x())
    const dy = (hasta.y() - desde.y())
    const pasos = dx.abs().max(dy.abs())
    if (pasos <= 1) return true
    var despejado = true
    const dummy = [true]
    (1..(pasos - 1)).forEach({ paso =>
      const cx = (desde.x() + (dx * paso).div(pasos))
      const cy = (desde.y() + (dy * paso).div(pasos))
      if (mapaBuilder.isWallEn(cx, cy)) {
        despejado = false
      }
    })
    return despejado
  }
}


class VisionLineal inherits CampoVision {
  var property rango = 5

  override method puedeVerA(enemigo, objetivo) {
    const ex = enemigo.position().x()
    const ey = enemigo.position().y()
    const ox = objetivo.position().x()
    const oy = objetivo.position().y()
    const dirX = enemigo.direccionX()
    const dirY = enemigo.direccionY()
    const enFila    = (dirY == 0) && (dirX != 0) && (ey == oy) &&
                      ((ox - ex) * dirX > 0) && ((ox - ex).abs() <= rango)
    const enColumna = (dirX == 0) && (dirY != 0) && (ex == ox) &&
                      ((oy - ey) * dirY > 0) && ((oy - ey).abs() <= rango)
    return (enFila || enColumna) && self.lineaDespejada(enemigo.position(), objetivo.position())
  }
}

class VisionSemicircular inherits CampoVision {
  var property radio = 4

  override method puedeVerA(enemigo, objetivo) {
    const dx = (objetivo.position().x() - enemigo.position().x())
    const dy = (objetivo.position().y() - enemigo.position().y())
    const dentroDeRadio = (dx * dx + dy * dy) <= (radio * radio)
    return dentroDeRadio &&
           (self.orientacion(enemigo, objetivo) >= 0) &&
           self.lineaDespejada(enemigo.position(), objetivo.position())
  }
}
