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
	
	public void llenarJarra3(){
		jarra3 = TAM_JARRA_3;
	}	
	public void vaciarJarra3(){
		jarra3 = 0;
	}
	public void verterJarra3(){
		//Vertemos lo que quepa en jarra4
		if(jarra4 + jarra3 <= TAM_JARRA_4){
			//En este caso cabe jarra3 entera en jarra4
			jarra4 = jarra4 + jarra3;
			jarra3 = 0;
		}else{
			//En este caso no cabe jarra3 entera.
			//
			jarra3 = jarra3 - (TAM_JARRA_4 - jarra3); 
			jarra4 = TAM_JARRA_4;
		}
	}
	
	public void llenarJarra4(){
		jarra4 = TAM_JARRA_4;
	}
	public void vaciarJarra4(){
		jarra4 = 0;
	}
	public void verterJarra4(){
		if(jarra4 + jarra3 <= TAM_JARRA_3){
			jarra3 = jarra4 + jarra3;
			jarra4 = 0;
		}else{
			jarra4 = jarra4 - (TAM_JARRA_3 - jarra3);
			jarra3 = TAM_JARRA_3;
		}
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
	
	private static int TAM_JARRA_3 = 3;
	private static int TAM_JARRA_4 = 4;
}
