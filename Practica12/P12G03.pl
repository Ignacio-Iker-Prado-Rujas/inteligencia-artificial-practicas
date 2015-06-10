



:- dynamic cita/5 .

frase(Salida) --> accion(Salida).
% gramática 

accion(Salida) --> [A], {es_accion(A, Salida)}.

 es_accion(pon, ponemos).
 es_accion(añade).
 es_accion(borra).
 es_accion("Quita").
 cita(3).
 
 
 
consulta:-  nl, write('Escribe frase entre corchetes separando palabras con comas '), nl, 
 write('o lista vacía para parar '), nl, 
 read(F), 
 trata(F). 
 
trata([]):- write('final'). 
% tratamiento final 
 
trata(F):- frase(Salida, F, []), write(Salida), nl, consulta. 
% tratamiento caso general 


