import aima.core.search.framework.Problem;
import aima.core.search.framework.Search;
import aima.core.search.framework.SearchAgent;
import aima.core.search.uninformed.BreadthFirstSearch;


public class JarrasDemo {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		JarrasBFSDemo();
	}

	private static void JarrasBFSDemo(){
		System.out.println("\nJarrasBFSDemo-->");
		try{
			// Crear un objeto Problem con la representaci�n de estados y operadores
			Problem problem = new Problem(estadoInicial, 
			EstadoJarras.getActionsFunction(), EstadoJarras.getResultFunction(),
			new EstadoMisionerosGoalTest()); // como no hay funci�n de coste en el constructor se usa el coste por defecto 
			// indicar el tipo de b�squeda
			Search search = new BreadthFirstSearch(); // b�squeda en anchura 
			// crear un agente que realice la b�squeda sobre el problema
			SearchAgent agent = new SearchAgent(problem, search);
			// escribir la soluci�n encontrada (operadores aplicados) e informaci�n sobre los recursos utilizados
			printActions(agent.getActions());
			printInstrumentation(agent.getInstrumentation());
		}catch (Exception exception){
			exception.printStackTrace(); 
		}
	}
	private static EstadoJarras estadoInicial = new EstadoJarras();
}
