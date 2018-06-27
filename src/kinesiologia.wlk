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
	method realizarSesion(unValor)
	{
		rutina.forEach({unAparato => unAparato.serUsado(self)})
	}
}

class Aparato
{
	var color = "blanco"
	method puedeSerUsadoPor(paciente)
	{
		return 0
	}
	method serUsado(paciente)
	{
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
	method hayAparatoRojo()
	{
		return rutina.any({unAparato => unAparato.color() == "rojo"})
	}
	override method realizarSesion(unValor)
	{
		if(self.hayAparatoRojo())
		{
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
		return pacientes.filter({unPaciente => unPaciente.edad() < 8})
	}
	method noCumplenSesion()
	{
		return pacientes.filter({unPaciente => not unPaciente.puedeHacerSesion()})
						.size()
	}
}