class Pais{
	var conflictosCon = []
	
	method registrarConflicto(pais){conflictosCon.add(pais)}
	
	method tieneConflictoCon(pais)= conflictosCon.any({p => p == pais})
	
	
}
