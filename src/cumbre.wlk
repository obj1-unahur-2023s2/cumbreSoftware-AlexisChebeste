import participantes.*
import conocimientos.*
import paises.*


object cumbre {
	var property auspiciantes = []
	var paises = []
	var property conocimientos = []
	var property participantes = []
	var property commitsAcceso = 300
	var actividadesRealizadas = []
	
	method agregarPaisAuspiciante(pais) = auspiciantes.add(pais)
	method agregarConocimiento(conocimiento) = conocimientos.add(conocimiento)
	method agregarParticipante(persona) {
		if(not self.puedeIngresar(persona)){
			self.error("El participante no puede ingresar a la cumbre")
		}
		else{
			participantes.add(persona)
			if(not paises.contains(persona.pais())){
				paises.add(persona.pais())
			}
		}
		
	}
	method tieneAccesoRestringido(persona) {
		return self.esConflictoParaLaCumbre(persona.pais())
	}
	method puedeIngresar(persona){
		return not self.tieneAccesoRestringido(persona) and persona.cumpleRequisitosAcceso(commitsAcceso)
	}
	method esSegura() = participantes.all({p=> self.puedeIngresar(p)})
	method esConflictoParaLaCumbre(pais) = auspiciantes.any({a => a.tieneConflictoCon(pais)})
	method paisesConParticipante() = paises
	method participantesDePais(pais) = participantes.count({p => p.pais() == pais})
	method paisConMasParticipantes() = paises.max({a => self.participantesDePais(a)}) 
	method esPaisAuspiciante(pais) = auspiciantes.any({aus => aus==pais})
	method participantesExtranjeros() = participantes.filter({a=> !self.esPaisAuspiciante(a.pais())})
	method esRevelante() = participantes.all({p => p.esCape()})
	method actividadRealizada(actividad){
		actividadesRealizadas.add(actividad)
		participantes.forEach({p => p.realizarActividad(actividad)})
	}
	method totalHorasActividades(){
		actividadesRealizadas.sum({a => a.cantidadHoras()})
	}
}
