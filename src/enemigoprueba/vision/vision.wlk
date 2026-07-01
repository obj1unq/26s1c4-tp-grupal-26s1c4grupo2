import wollok.game.*
import src.enemigoprueba.mapa.mapa.*
import src.enemigoprueba.utils.utils.*

class CampoVision {
  method puedeVerA(enemigo, objetivo)
  
  method orientacion(enemigo, objetivo) {
    const dx = objetivo.position().x() - enemigo.position().x()
    const dy = objetivo.position().y() - enemigo.position().y()
    const dir = enemigo.direccion()
    return (dx * dir.dx()) + (dy * dir.dy())
  }
  
  method lineaDespejada(desde, hasta) = utils.lineaDespejada(desde, hasta)
}

class VisionLineal inherits CampoVision {
  const rango = 5
  
  override method puedeVerA(enemigo, objetivo) = (self.estaAlineadoCon(
    enemigo,
    objetivo
  ) && self.estaEnRango(enemigo, objetivo)) && self.lineaDespejada(
    enemigo.position(),
    objetivo.position()
  )
  
  method estaAlineadoCon(enemigo, objetivo) = (self.enMismaFila(
    enemigo,
    objetivo
  ) || self.enMismaColumna(enemigo, objetivo)) && self.estaEnFrente(
    enemigo,
    objetivo
  )
  
  method enMismaFila(
    enemigo,
    objetivo
  ) = (enemigo.direccion().dy() == 0) && (enemigo.position().y() == objetivo.position().y())
  
  method enMismaColumna(
    enemigo,
    objetivo
  ) = (enemigo.direccion().dx() == 0) && (enemigo.position().x() == objetivo.position().x())
  
  method estaEnFrente(enemigo, objetivo) = self.orientacion(
    enemigo,
    objetivo
  ) > 0
  
  method estaEnRango(enemigo, objetivo) = enemigo.position().distance(
    objetivo.position()
  ) <= rango
}

class VisionSemicircular inherits CampoVision {
  const property radio = 4 //Define le rango del cono, por ahora solo se define al inicializar
  
  override method puedeVerA(enemigo, objetivo) = (self.estaDentroDeRadio(
    enemigo,
    objetivo
  ) && self.estaEnElAnguloDeVision(enemigo, objetivo)) && self.lineaDespejada(
    enemigo.position(),
    objetivo.position()
  )
  
  method estaDentroDeRadio(enemigo, objetivo) {
    const dx = objetivo.position().x() - enemigo.position().x()
    const dy = objetivo.position().y() - enemigo.position().y()
    return ((dx * dx) + (dy * dy)) <= (radio * radio)
  }
  
  method estaEnElAnguloDeVision(enemigo, objetivo) = self.orientacion(
    enemigo,
    objetivo
  ) >= 0
}