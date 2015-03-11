package recomendador;

/* Ejemplo de programa java que invoca la ejecución del motor de reglas jess con el programa diet.clp*/
// De esta forma se podría realizar la entrada y salida de datos en Java y el razonamiento en Jess
import java.util.Iterator;

import jess.Deffacts;
import jess.Fact;
import jess.JessException;
import jess.RU;
import jess.Rete;
import jess.Value;

public class Main { 
	
	
	public static void main(String[] args) throws JessException {
		
		
			Rete miRete;		
			miRete = new Rete();

			String ficheroReglas = "practica8.clp";	
			System.out.println("Cargando las reglas");
			try
			{
				Value v = miRete.batch(ficheroReglas);
				System.out.println("Value " + v);
			} catch (JessException je0) {
				System.out.println("Error de lectura en " + ficheroReglas);
				je0.printStackTrace();
			}
					
				
			// Crea un deffacts y añade un hecho siguiendo la template usuario definida en diet.clp
			// En una aplicación real, los datos de usuario se leerían en java y se
			// añadirían así al programa jess
			
			Deffacts deffacts = new Deffacts("DatosJava", null, miRete);
			Fact f = new Fact("persona", miRete);
			f.setSlotValue("nombre", new Value("Rocio", RU.STRING));
			f.setSlotValue("edad", new Value(30, RU.INTEGER));
			f.setSlotValue("presupuesto", new Value(1500, RU.INTEGER));
			f.setSlotValue("intereses", new Value("ocio", RU.STRING));
			f.setSlotValue("dias", new Value(7, RU.INTEGER));
			deffacts.addFact(f);
			miRete.addDeffacts(deffacts);
			
			miRete.reset();
			
			// A continuación se ejecuta el motor jess
			// Si el programa jess no tiene módulos basta con hacer run()
			
			//miRete.run();

			/* Si el programa jess tiene módulos hay que poner el foco sucesivamente en cada uno de ellos, 
			   en el orden adecuado, y a continuación un run() por cada módulo	*/
			  
			 
			   miRete.setFocus("usuario");
			   miRete.run();
			   miRete.setFocus("ciudad");
			   miRete.run();
			   miRete.setFocus("destino");
			   miRete.run();
			   miRete.setFocus("logistica");
			   miRete.run();
			 

			
			// Se listan los hechos que hay en la memoria de trabajo
			
			listaHechos(miRete);
			extraeHechos(miRete);

			// Para parar el motor de reglas
			miRete.halt();
		
	}


	public static void listaHechos(Rete miRete) {
		// Obtiene e imprime la lista de hechos
		Iterator<Fact> iterador; 
		iterador = miRete.listFacts();
		
		System.out.println("Lista de hechos:");
		while (iterador.hasNext()) {
			System.out.println(iterador.next());
		}
	}

	public static void extraeHechos(Rete miRete) {
		// Ejemplo de cómo podemos seleccionar sólo los hechos de la template usuario
		// Y de esos hechos quedarnos sólo con el slot edad e imprimir su valor
		Iterator<Fact> iterador; 
		iterador = miRete.listFacts();
		Fact f;
		Value ed;
		while (iterador.hasNext()) {
			f = iterador.next();
			if (f.getName().equals("MAIN::persona"))
			{
				try {
					ed = f.getSlotValue("edad");
					System.out.println("edad " + ed);
				} catch (JessException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} }                           
		}
	}
	

}
