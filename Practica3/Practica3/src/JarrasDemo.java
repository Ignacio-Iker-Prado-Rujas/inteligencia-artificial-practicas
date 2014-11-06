import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import aima.core.agent.Action;
import aima.core.search.framework.Problem;
import aima.core.search.framework.Search;
import aima.core.search.framework.SearchAgent;
import aima.core.search.uninformed.BreadthFirstSearch;


public class JarrasDemo {

	public static void main(String[] args) {
		JarrasBFSDemo();
	}

	private static void JarrasBFSDemo(){
		System.out.println("\nJarrasBFSDemo-->");
		try{
			// Crear un objeto Problem con la representación de estados y operadores
			Problem problem = new Problem(estadoInicial, 
				JarrasFunctionFactory.getActionsFunction(), 
				JarrasFunctionFactory.getResultFunction(),
				new JarrasGoalTest(), 
				new DefaultStepCostFunction());
			
			// Búsqueda en anchura
			Search search = new BreadthFirstSearch();
			
			// Creamos el agente de búsqueda
			SearchAgent agent = new SearchAgent(problem, search);
			
			// Escribimos la solución encontrada (operadores aplicados).
			printActions(agent.getActions());
			
			// Informamos sobre los recursos utilizados.
			printInstrumentation(agent.getInstrumentation());
		}catch (Exception exception){
			exception.printStackTrace(); 
		}
	}
	
	private static void printActions(List<Action> actions) {
		for (int i = 0; i < actions.size(); i++) {
			String action = actions.get(i).toString();
			System.out.println(action);
		}
	}
	
	private static void printInstrumentation(Properties properties) {
		Iterator<Object> keys = properties.keySet().iterator();
		while (keys.hasNext()) {
			String key = (String) keys.next();
			String property = properties.getProperty(key);
			System.out.println(key + " : " + property);
		}

	}
	private static EstadoJarras estadoInicial = new EstadoJarras();
}
