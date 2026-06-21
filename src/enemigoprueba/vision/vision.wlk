import wollok.game.*
import src.enemigoprueba.mapa.mapa.*

class CampoVision {

  method puedeVerA(enemigo, objetivo)

  method orientacion(enemigo, objetivo) {
    const dx = objetivo.position().x() - enemigo.position().x()
    const dy = objetivo.position().y() - enemigo.position().y()
    return (dx * enemigo.direccionX()) + (dy * enemigo.direccionY())
  }

  method lineaDespejada(desde, hasta) {
    const dx = hasta.x() - desde.x()
    const dy = hasta.y() - desde.y()
    const pasos = dx.abs().max(dy.abs())

    if (pasos <= 1) return true

    return (1..(pasos - 1)).all({ paso =>
      const cx = desde.x() + (dx * paso).div(pasos)
      const cy = desde.y() + (dy * paso).div(pasos)
      !mapaBuilder.isWallEn(cx, cy)
    })
  }
}


class VisionLineal inherits CampoVision {
  var property rango = 5

  override method puedeVerA(enemigo, objetivo) {
    return self.estaAlineadoCon(enemigo, objetivo) && 
           self.estaEnRango(enemigo, objetivo) &&
           self.lineaDespejada(enemigo.position(), objetivo.position())
  }

  method estaAlineadoCon(enemigo, objetivo) {
    const posE = enemigo.position()
    const posO = objetivo.position()
    
    return (enemigo.direccionY() == 0 && posE.y() == posO.y() && (posO.x() - posE.x()) * enemigo.direccionX() > 0) ||
           (enemigo.direccionX() == 0 && posE.x() == posO.x() && (posO.y() - posE.y()) * enemigo.direccionY() > 0)
  }

  method estaEnRango(enemigo, objetivo) {
    return enemigo.position().distance(objetivo.position()) <= rango
  }
}

class VisionSemicircular inherits CampoVision {
  var property radio = 4

  override method puedeVerA(enemigo, objetivo) {
    return self.estaDentroDeRadio(enemigo, objetivo) &&
           self.estaEnElAnguloDeVision(enemigo, objetivo) &&
           self.lineaDespejada(enemigo.position(), objetivo.position())
  }

  method estaDentroDeRadio(enemigo, objetivo) {
    const dx = objetivo.position().x() - enemigo.position().x()
    const dy = objetivo.position().y() - enemigo.position().y()
    return (dx * dx + dy * dy) <= (radio * radio)
  }

  method estaEnElAnguloDeVision(enemigo, objetivo) {
    return self.orientacion(enemigo, objetivo) >= 0
  }
}
