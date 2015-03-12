package recomendador;

public enum Intereses {
			OCIO, FIESTA, GASTRONOMIA, TURISMO;
			public static boolean isInterest(String interes){
				if (interes.compareToIgnoreCase("OCIO")==0)
					return true;
				else if (interes.compareToIgnoreCase("FIESTA")==0)
					return true;
				else if (interes.compareToIgnoreCase("GASTRONOMIA")==0)
					return true;
				else if (interes.compareToIgnoreCase("TURISMO")==0)
					return true;
				else return false;				
			}
}
