//Nota 2 (DOS)
//TODO: test: estalla por todos lados. 
//Muestra una mala metodología al no corregir erores de cálculo simples subestimando la correctitud del programa
//1: Regular: no cumple requerimientos, no realiza validaciones
//2: Regular: no realiza validaciones, recibe un parámetro que es una configuracion que no usa. Ese valor debería ser accedido en el punto 3 desde el objeto que lo requiere 
//3: Mal: El paciente caprichoso está muy mal, no usa super, no sobreescribe lo que debe sobreescribir
//4: Bien


class Paciente
{
	var edad
	var nivelDeFortaleza
	var nivelDeDolor
	var rutina = []
	
	method nivelDeDolor(){
		return nivelDeDolor
	}
	
	method nivelDeFortaleza(){
		return nivelDeFortaleza
	}
	
	method puedeUsar(aparato)
	{
		return aparato.puedeSerUsadoPor(self)
	}
	method usarAparato(aparato)
	{
		aparato.serUsado(self)
	}
	method nivelDeDolor(unNivel)
	{
		nivelDeDolor = unNivel
	}
	method nivelDeFortaleza(unNivel)
	{
		nivelDeFortaleza = unNivel
	}
	method edad()
	{
		return edad
	}
	method puedeHacerSesion()
	{
		return rutina.all({unAparato => unAparato.puedeSerUsadoPor(self)})
		
	}
	//TODO: para que quiere unValor? que es?
	method realizarSesion(unValor)
	{
		//TODO No realiza la validacion
		rutina.forEach({unAparato => unAparato.serUsado(self)})
	}
}

class Aparato
{
	var color = "blanco"
	method puedeSerUsadoPor(paciente)
	{
		//TODO Un valor por default de este metodo debería devolver un booleano!
		return 0
	}
	method serUsado(paciente)
	{
		//TODO: Debería lanzar error si no puede
	}
	method color()
	{
		return color
	}
	method color(unColor)
	{
		color = unColor
	}
}

class Magneto inherits Aparato
{
	override method puedeSerUsadoPor(paciente)
		{
			return true
		}
	override method serUsado(paciente)
	{
		
		//TODO deberías multiplicar por 0.1 para saber el 10%. dividir por 0.1 es como multiplicar por 10!
		//TODO Si vas a usar el setter entonces podés multiplicarlo por 0.9 para asignar el 90%
		//TODO: también conviene tener métodos un poquito más inteligentes en el paciente
		//TODO para tener que evitar llamar a dos mensajes: el getter y el setter. Reemplazandolo por un solo mensaje 
		paciente.nivelDeDolor(paciente.nivelDeDolor()/0.1)
	}
}

class Bicicleta inherits Aparato
{
	override method puedeSerUsadoPor(paciente)
	{
		return paciente.edad() > 8
	}
	
	override method serUsado(paciente)
	{
		paciente.nivelDeDolor(paciente.nivelDeDolor() -4)
		paciente.nivelDeFortaleza(paciente.nivelDeFortaleza() +3)
	}
}

class Minitramp inherits Aparato
{
	override method puedeSerUsadoPor(paciente)
	{
		return paciente.nivelDeDolor()< 20	
	}
	override method serUsado(paciente)
	{
		//TODO: En lugar de aumentar un 10% deja el 10%
		paciente.nivelDeFortaleza(paciente.nivelDeFortaleza()*0.1)
	}
}

class PacienteResistente inherits Paciente
{
	override method realizarSesion(unValor)
	{
		super(unValor)
		
		nivelDeFortaleza += rutina.size()
	}
}
class PacienteCaprichoso inherits Paciente
{
	//TODO: Deberia sobrescribir el puedeSerUsadoPor
	method hayAparatoRojo()
	{
		return rutina.any({unAparato => unAparato.color() == "rojo"})
	}
	override method realizarSesion(unValor)
	{
		//TODO: esto debería ser self.puedeHacerSesion.
		if(self.hayAparatoRojo())
		{
		//TODO: Repite código: esto es super
				rutina.forEach({unAparato => unAparato.serUsado(self)})
				rutina.forEach({unAparato => unAparato.serUsado(self)})
		}
	}
}

class PacienteRapidaRecuperacion inherits Paciente
{
	
	override method realizarSesion(unValor)
	{
		super(unValor)
		//TODO: le habías pasado por paramtro unValor justamente para usarlo acá. Y terminás sacandolo del objeto
		//es inconsistente. Lo que está bien es sacarlo del objeto bien conocido, pero entonces remové el parámetro
		nivelDeDolor -= valorPacienteRapido.valorDeRecuperacion()
	}
}
object valorPacienteRapido
{	var valorDeRecuperacion
	method valorDeRecuperacion()
	{
		return valorDeRecuperacion
	}
	method valorDeRecuperacion(unValor)
	{
		valorDeRecuperacion = unValor
	}
}

class CentroKinesiologia
{
	var aparatos = []
	var pacientes = #{}
	
	method colores()
	{
		return aparatos.map({unAparato => unAparato.color()}).asSet()
	}
	
	method menoresDe8anios()
	{
		//TODO: Repita código por no delegar en el paciente el saber si es pequeño o no
		return pacientes.filter({unPaciente => unPaciente.edad() < 8})
	}
	method noCumplenSesion()
	{
		//TODO: más directo es usar count
		return pacientes.filter({unPaciente => not unPaciente.puedeHacerSesion()})
						.size()
	}
}