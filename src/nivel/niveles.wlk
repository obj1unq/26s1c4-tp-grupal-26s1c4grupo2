import nivel.Nivel
import estado.sigilo.sigilo
import plano.planos.*

const nivel1 = new Nivel(estado = sigilo, plano = planoNivel1, siguiente = nivel2)
const nivel2 = new Nivel(estado = sigilo, plano = planoNivel2, siguiente = nivel3)
const nivel3 = new Nivel(estado = sigilo, plano = planoNivel3)