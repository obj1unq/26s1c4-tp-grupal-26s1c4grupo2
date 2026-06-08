class Plano {
  const estructura
  
  method alto() = estructura.size()
  
  method ancho() = estructura.anyOne().size()
  
  method coordenada(x, y) = estructura.get(y).get(x)
  
  method coordenadasX() = 0 .. (self.ancho() - 1)
  
  method coordenadasY() = 0 .. (self.alto() - 1)
}