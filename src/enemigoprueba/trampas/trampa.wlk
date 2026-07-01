import wollok.game.*

class AlambreDePua {
  const property position
  const property gestor
  const property rangoActivacion = 1

  method image() = "cable.png"

  method verificar(objetivo) {
    const dx = (objetivo.position().x() - position.x()).abs()
    const dy = (objetivo.position().y() - position.y()).abs()
    if (dx <= rangoActivacion && dy <= rangoActivacion) {
      gestor.invocarCerca()
    }
  }
}
