import paises.*
import conocimientos.*
import empresa.*

class Persona{
	var property pais
	var property conocimientos = []
	var property commits
	
	method cumpleRequisitosAcceso(commitsEstablecidos){
		return conocimientos.contains(programacionBasica)
	}
	method esCape()
	method realizarActividad(actividad){
		if(not conocimientos.contains(actividad.tema())){
			conocimientos.add(actividad.tema())
		}
		commits += actividad.tema().commitsPorHora() * actividad.cantidadHoras()
	}
}

class Programador inherits Persona{
	var property horasCapacitacion = 0
	override method esCape() {return commits > 500}
	override method cumpleRequisitosAcceso(commitsEstablecidos){
		return super(commitsEstablecidos) and (commits > commitsEstablecidos )
	}
	override method realizarActividad(actividad){
		super(actividad)
		horasCapacitacion += actividad.cantidadHoras()
	}
}

class Especialista inherits Persona{
	override method esCape(){return conocimientos.size() > 2}
	override method cumpleRequisitosAcceso(commitsEstablecidos){
		return super(commitsEstablecidos) and 
				(commits > (commitsEstablecidos -100)) and
				conocimientos.contains(objetos)
	}

}

class Gerente inherits Persona{
	var property empresa
	override method esCape() = empresa.esMultinacional()
	override method cumpleRequisitosAcceso(commitsEstablecidos){
		return super(commitsEstablecidos)and
			conocimientos.any({c => c== manejoDeGrupos})
	}
}