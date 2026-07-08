import wollok.game.*
import src.nivel.niveles.nivel1
import src.utilidades.tablero.tablero

object juego {
  const nivelInicial = nivel1
  var nivelActual = nivelInicial
  var pantalla = null
  
  method cargarPantalla(_pantalla) {
    pantalla = _pantalla
    pantalla.cargar(self)
  }

  method reemplazarPantalla(_pantalla) {
    pantalla.finalizar()
    self.cargarPantalla(_pantalla)
  }
  
  method cargarPantallaInicial() {
    self.cargarPantalla(inicial)
  }

  method cargarNivel() {
    self.reemplazarPantalla(nivel)
    nivelActual.cargar(self)
  }

  method iniciarEventoDeCargaDeNivel() {
    game.schedule(3000, { self.cargarNivel() })
  }

  method iniciar() {
    self.reemplazarPantalla(cargaDeNivel)
    self.iniciarEventoDeCargaDeNivel()
  }

  method reiniciar() {
    nivelActual = nivelInicial
    self.iniciar()
  }
  
  method cargarSiguienteNivel() {
    nivelActual = nivelActual.siguiente()
    self.iniciar()
  }
  
  method ganarNivel() {
    self.reemplazarPantalla(nivelGanado)
  }
  
  method ganar() {
    self.reemplazarPantalla(juegoGanado)
  }

  method perder() {
    self.reemplazarPantalla(juegoPerdido)
  }
} 

/* CLASES Y OBJETOS ÚTILES */

class Fondo {
  const property position = game.origin()
  const property image
  const property alto = 16
  const property ancho = 16
  
  method renderizar() {
    game.addVisual(self)
  }
} 

/* PANTALLAS */

class Pantalla {
  const fondo
  
  method cargar(juego) {
    fondo.renderizar()
  }
  
  method finalizar() {
    tablero.limpiar()
  }
}

class PantallaJuegoFinalizado inherits Pantalla {
  override method cargar(juego) {
    super(juego)
    self.inicializarEventoDeReinicio(juego)
  }

  method inicializarEventoDeReinicio(juego) {
    keyboard.r().onPressDo({ juego.reiniciar() })
  }
}

object inicial inherits Pantalla (fondo = new Fondo(image = "fondo-inicial.png")) {
  override method cargar(juego) {
    tablero.inicializarFondo(fondo)
    self.inicializarEventoDeInicio(juego)
  }
  
  method inicializarEventoDeInicio(juego) {
    keyboard.i().onPressDo({ juego.iniciar() })
  }
}

object cargaDeNivel inherits Pantalla (fondo = new Fondo(image = "fondo-carga-de-nivel.png")) {}

object nivel inherits Pantalla (fondo = new Fondo(image = "fondo-nivel.png")) {}

object nivelGanado inherits Pantalla (fondo = new Fondo(image = "fondo-nivel-ganado.png")) {  
  override method cargar(juego) {
    super(juego)
    self.inicializarEventoDeSiguienteNivel(juego)
  }
  
  method inicializarEventoDeSiguienteNivel(juego) {
    keyboard.s().onPressDo({ juego.cargarSiguienteNivel() })
  }
}

object juegoGanado inherits PantallaJuegoFinalizado (fondo = new Fondo(image = "fondo-juego-ganado.png")) {}

object juegoPerdido inherits PantallaJuegoFinalizado (fondo = new Fondo(image = "fondo-juego-perdido.png")){}

/* FIN PANTALLAS */