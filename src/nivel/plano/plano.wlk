class Plano {
  const matriz
  
  method alto() = matriz.size()
  
  method ancho() = matriz.anyOne().size()
  
  method coordenada(x, y) = matriz.get(y).get(x)
  
  method coordenadasX() = 0 .. (self.ancho() - 1)
  
  method coordenadasY() = 0 .. (self.alto() - 1)
}