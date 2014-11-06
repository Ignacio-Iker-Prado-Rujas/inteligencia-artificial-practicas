import aima.core.agent.Action;
import aima.core.agent.impl.DynamicAction;


public class EstadoJarras {
	public EstadoJarras(){
		jarra3 = 0;
		jarra4 = 0;
	}
	public EstadoJarras(EstadoJarras estadoJarras){
		jarra3 = estadoJarras.getJarra3();
		jarra4 = estadoJarras.getJarra4();		
	}
	
	public EstadoJarras(int jarra3, int jarra4){
		this.jarra3 = jarra3;
		this.jarra4 = jarra4;
	}	
	
	public int getJarra3(){
		return jarra3;
	}
	
	public int getJarra4(){
		return jarra4;
	}
	
	private int jarra3;
	private int jarra4;

	
	public static Action LL3 = new DynamicAction("Llenar jarra 3"); 
	public static Action VA3 = new DynamicAction("Vaciar jarra 3"); 
	public static Action VE3 = new DynamicAction("Verter jarra 3"); 
	public static Action LL4 = new DynamicAction("Llenar jarra 4"); 
	public static Action VA4 = new DynamicAction("Vaciar jarra 4"); 
	public static Action VE4 = new DynamicAction("Verter jarra 4"); 
	
}
