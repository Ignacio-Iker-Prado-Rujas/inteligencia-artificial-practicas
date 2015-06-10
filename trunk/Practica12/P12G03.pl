frase(Salida) --> ... 
% gramática 
 
consulta:- write('Escribe frase entre corchetes separando palabras con comas '), nl, 
 write('o lista vacía para parar '), nl, 
 read(F), 
 trata(F). 
 
trata([]):- write('final'). 
% tratamiento final 
 
trata(F):- frase(Salida, F, []), write(Salida), consulta. 
% tratamiento caso general 