

%Crear y eliminar citas
	
:- dynamic cita/6 .
:- dynamic reunion/6 .
:- dynamic evento/6 .

%Cracion de los tres tipos de compromisos que permitimos.

	crear(Salida, cita, Persona, Dia, Mes, Hora, Minuto, Duracion) :- 
			assert(cita( Persona, Dia, Mes, Hora, Minuto, Duracion)),
			salida(cita, crear, Salida).
	crear(Salida, reunion, Persona, Dia, Mes, Hora, Minuto, Duracion) :- 
			assert(reunion( Persona, Dia, Mes, Hora, Minuto, Duracion)),
			salida(reunion, crear, Salida).
	crear(Salida, evento, Persona, Dia, Mes, Hora, Minuto, Duracion) :- 
			assert(evento( Persona, Dia, Mes, Hora, Minuto, Duracion)),
			salida(evento, crear, Salida).

%Eliminacion de los compromisos.
			
	eliminar(Salida, cita, Persona, Dia, Mes, Hora, Minuto, Duracion) :-
			retract(cita( Persona, Dia, Mes, Hora, Minuto, Duracion)),
			salida(cita, eliminar, Salida).
	eliminar(Salida, reunion, Persona, Dia, Mes, Hora, Minuto, Duracion) :-
			retract(reunion(Persona, Dia, Mes, Hora, Minuto, Duracion)),
			salida(reunion, eliminar, Salida).
	eliminar(Salida, evento, Persona, Dia, Mes, Hora, Minuto, Duracion) :-
			retract(evento(Persona, Dia, Mes, Hora, Minuto, Duracion)),
			salida(evento, eliminar, Salida).
		
%Todas las consultas que podemos hacer.
	
	%Consulta de compromisos concretos.
		
		consultar(Salida, Dia, Mes, Hora, Minuto) :-
				 cita( Persona, Dia, Mes, Hora, Minuto, Duracion),
				 mostrar_cita(Salida, Persona, Dia, Mes, Hora, Minuto, Duracion).
				 
		consultar(Salida, Dia, Mes, Hora, Minuto) :-
				 reunion( Persona, Dia, Mes, Hora, Minuto, Duracion),
				 mostrar_reunion(Salida, Persona, Dia, Mes, Hora, Minuto, Duracion).
				 
		consultar(Salida, Dia, Mes, Hora, Minuto) :-
				 evento( Persona, Dia, Mes, Hora, Minuto, Duracion),
				 mostrar_evento(Salida, Persona, Dia, Mes, Hora, Minuto, Duracion).
		
	%Consulta de la duraci�n de un compromiso: mostrar_duracion(Salida, Tipo, Persona, Dia, Mes, Duracion)
	
		consultar_duracion(Salida, cita, Persona, Dia, Mes) :-
				 cita(Persona, Dia, Mes, _, _,Duracion),
				 mostrar_duracion(Salida, cita, Persona, Dia, Mes, Duracion).
		consultar_duracion(Salida, reunion, Persona, Dia, Mes) :-
				 reunion(Persona, Dia, Mes, _, _,Duracion),
				 mostrar_duracion(Salida, reunion, Persona, Dia, Mes, Duracion).
		consultar_duracion(Salida, evento, Persona, Dia, Mes) :-
				 evento(Persona, Dia, Mes, _, _,Duracion),
				 mostrar_duracion(Salida, evento, Persona, Dia, Mes, Duracion).
				 
				 
	%Parte opcional 1			
		consultar_dia(Salida,Dia,Mes) :-
				setof((Persona, Dia, Mes, Hora, Minuto, Duracion),cita(Persona, Dia, Mes, Hora, Minuto, Duracion),Salida).
			
% Gram�tica. Tenemos los cuatro tipos de frase que podemos recibir: crear, eliminar, consultar un compromiso y consultar la duraci�n.

		frase(Salida) --> accion(crear), tipo(Tipo), persona(Persona), fecha(Dia, Mes), hora(Hora, Minuto),
										duracion(Duracion), {crear(Salida, Tipo, Persona, Dia, Mes, Hora, Minuto, Duracion)}.
										
		frase(Salida) --> accion(eliminar), tipo(Tipo), persona(Persona), {eliminar(Salida, Tipo, Persona, _, _, _, _, _)}.

		frase(Salida) --> consulta, fecha(Dia, Mes), hora(Hora, Minuto), {consultar(Salida, Dia, Mes, Hora, Minuto)}.

		frase(Salida) --> consulta, fecha(Dia,Mes),!, {consultar_dia(Salida,Dia,Mes)}.
		
		frase(Salida) --> consulta_duracion, tipo(Tipo), persona(Persona), fecha(Dia, Mes), {consultar_duracion(Salida, Tipo, Persona, Dia, Mes)}.

		

%Gestion de qu� tipo de accion se lleva a cabo(crear o eliminar)

	accion(Tipo) --> [T], {es_accion(Tipo, T)}.

	es_accion(crear, pon).
	es_accion(crear, a�ade).

	es_accion(eliminar, borra).
	es_accion(eliminar, quita).

%Gestionamos qu� tipo de compromiso tenemos, y aseguramos la concordancia con los art�culos

	tipo(Tipo) --> [Articulo, Tipo], { es_articulo(Articulo, Genero), es_tipo_accion(Tipo, Genero)}. 
	%Aprovechamos la pr�ctica anterior para meter concordancia
	tipo(Tipo) --> [Tipo], { es_tipo_accion(Tipo, _)}.

	%Gesti�n de consulta

	es_tipo_accion(cita, femenino).
	es_tipo_accion(reunion, femenino).
	es_tipo_accion(evento, masculino).

	articulo(Genero) --> [A], {es_articulo(A, Genero)}.
	es_articulo(un, masculino).
	es_articulo(el, masculino).
	es_articulo(una, femenino).
	es_articulo(la, femenino).
	
%Preguntas para las consultas.
	consulta --> [que, hay].
	consulta --> [que, tengo].
	consulta_duracion --> [cuanto, durara].

%Persona: Realmente puedes introducir una cita con quien quieras. Si quieres que sea alguien de la agenda, puede a�adirse.

	persona(Persona) --> [con, Persona].
	persona(Persona) --> [de, Persona].
	persona(Persona) --> [Persona].

%Gestion de fechas: de manera alternativa puede ponerse hoy o ma�ana
	fecha(Dia, Mes) --> [ma�ana], {ma�anas(Dia, Mes)}.
	
	fecha(Dia, Mes) --> [hoy], {hoy(Dia, Mes)}.
	fecha(Dia, Mes) --> dias(Dia), mes(Mes, Limite), {Dia =< Limite}.
	
	%Si no especifica mes nos quedamos con el actual.
	fecha(Dia, Mes) --> dias(Dia), {hoy(_, Mes), es_mes(_, Mes, Limite), Dia =< Limite}. 

	%El caso de ma�ana requiere algunas comprobaciones
	
	

	ma�anas(Dia, Mes) :- hoy(DiaActual, Mes), es_mes(_, Mes, Limite), (DiaActual+1) =< Limite, Dia is DiaActual+1.
	
	%Si cambia el mes, o el a�o, debemos tenerlo en cuenta. Si el d�a de hoy iguala el l�mite.
	% Si el mes es el 12 pasamos al 1 (hay que hacer primero el m�dulo si no diciembre ser�a el 0)

	ma�anas(Dia, Mes) :- hoy(DiaActual, MesActual), es_mes(NumeroMes, MesActual, Limite), DiaActual >= Limite, Dia is 1,
																es_mes((NumeroMes mod 12)+1, Mes, _). 
	
	

	dias(Dia) --> [el, dia, Dia].	
	dias(Dia) --> [el, Dia],! .
	dias(Dia) --> [Dia],!.
	
	mes(Mes, Limite) --> [de, Mes], {es_mes(_, Mes, Limite)}.
	mes(Mes, Limite) --> [Mes], {es_mes(_, Mes, Limite)}.

	es_mes(1, enero, 31).
	es_mes(2, febrero, 28).
	es_mes(3, marzo, 31).
	es_mes(4, abril, 30).
	es_mes(5, mayo, 31).
	es_mes(6, junio, 30).
	es_mes(7, julio, 31).
	es_mes(8, agosto, 31).
	es_mes(9, septiembre, 30).
	es_mes(10, octubre, 31).
	es_mes(11, noviembre, 30).
	es_mes(12, diciembre, 31).

%Gesti�n de horas.

	hora(Hora, Minuto) --> hora_hora(Hora), hora_minuto(Minuto).
	hora(Hora, Minuto) --> hora_hora(Hora),{Minuto is 0}.

	hora_hora(Hora) --> [a, las, Hora], {es_hora(Hora)}.
	hora_hora(Hora) --> [a, las, Hora, horas], {es_hora(Hora)}.

	hora_minuto(Minuto) --> [y, Minuto, minutos], {es_minuto(Minuto)}.
	hora_minuto(Minuto) --> [y, Minuto], {es_minuto(Minuto)}.


	es_hora(Hora) :- Hora >= 0, Hora < 24.
	es_minuto(Minuto) :- Minuto >= 0, Minuto < 60.


%Gesti�n de duraci�n.


	duracion(Tiempo) --> [durara, Tiempo, minutos].
	
	%Si no se especifica se ponen 30 minutos.
	duracion(Tiempo) --> {Tiempo is 30}.


%Como hecho inicial tenemos qu� d�a es hoy.
	hoy(10, junio).
 
%Bucle para las consultas.
 
	consulta:-  nl, write('Escribe frase entre corchetes separando palabras con comas '), nl, 
	 write('o lista vac�a para parar '), nl, 
	 read(F), 
	 trata(F). 
	 
	trata([]):- write('final'). 
	% tratamiento final 
	 
	trata(F):- frase(Salida, F, []), write(Salida), nl, consulta. 
	% tratamiento caso general 

%Gestion de la salida ____________________________________________________

	%Salida para las creaciones (puede mejorarse)

		salida(cita, crear, cita_creada).
		salida(reunion, crear, reunion_creada).
		salida(evento, crear, evento_creado).
	
	%Salida para las eliminaciones.
	
		salida(cita, eliminar, cita_eliminada).
		salida(reunion, eliminar, reunion_eliminada).
		salida(evento, eliminar, evento_eliminado).
	
	%Salida de todas las consultas
	
		mostrar_cita(Salida, Persona, Dia, Mes, Hora, Minuto, Duracion):-
			append([tienes, una, cita, con, Persona, el, dia, Dia, de, Mes, a ,las, Hora, y, Minuto, de, Duracion, minutos], [], Salida).
		mostrar_reunion(Salida, Persona, Dia, Mes, Hora, Minuto, Duracion):-
			append([tienes, una, reunion, con, Persona, el, dia, Dia, de, Mes, a ,las, Hora, y, Minuto, de, Duracion, minutos], [], Salida).
		mostrar_evento(Salida, Persona, Dia, Mes, Hora, Minuto, Duracion):-
			append([tienes, un, evento, con, Persona, el, dia, Dia, de, Mes, a ,las, Hora, y, Minuto, de, Duracion, minutos], [], Salida).
			
	%Muestra la duracion. Puede ser un evento, una cita o una reunion.
	
		mostrar_duracion(Salida, Tipo, Persona, Dia, Mes, Duracion):-
			append([tu, Tipo, con, Persona, el, dia, Dia, de, Mes, durara, Duracion, minutos], [], Salida).
			
			
			
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	EJEMPLOS DE EJECUCI�N	%%%%%%%%%%%%%%%%%%%%%%%%

%		Tenemos un programa sencillo. Podemos crear citas, reuniones y eventos. Tambi�n eliminarlos.
%		Funciona como se indica en el enunciado simple. La parte opcional no est� implementada.
%		De la anterior pr�ctica hemos a�adido un peque�o control en la concordancia de los art�culos.
%		Adem�s hemos inclu�do el tratamiento de algunos errores. Sin embargo, muchos se quedan sin tratar.
%		Por ejemplo si es d�a 15 y ponemos una cita para el 7, se pone para el 7 del mes actual, lo que 
%		ser�a un error. Y as� numerosos errores no tratado en caso de introducir datos err�neos.

		%Los nombres raros son porque me daba errores que no entend�a y quer�a evitar cosas raras(luego me daba cuenta que no era eso).
%		El uso es el que se explica: se pone "consulta.", y a continuacion la frase entre [] separada por comas.
%		Ahora pondremos algunos ejemplos de ejecucion que permite el programa. La salida no est� muy cuidada tampoco:
%

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vac�a para parar 
%	|: [a�ade, cita, con, maria, el, 27,de, mayo, a, las, 9].
%	cita_creada

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vac�a para parar 
%	|: [pon, una, reunion , con, carlos, el, 3, de, junio, a, las, 11].
%	reunion_creada

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vac�a para parar 
%	|: [pon, un, evento , con, juan, el, 8, de, julio, a, las, 18].
%	evento_creado

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vac�a para parar 
%	|: [borra, el, evento, de, juan].
%	evento_eliminado

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vac�a para parar 
%	|: [quita, la, reunion, con, carlos].
%	reunion_eliminada

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vac�a para parar 
%	|: [pon, una, cita, con, paqui, ma�ana, a, las, 18].
%	cita_creada

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vac�a para parar 
%	|: [que, tengo, ma�ana, a, las, 18].
%	[tienes,una,cita,con,paqui,el,dia,11,de,junio,a,las,18,y,0,de,30,minutos]

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vac�a para parar 
%	|: [pon, un, evento, con, peter, el, dia, 25, a, las, 11].
%	evento_creado

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vac�a para parar 
%	|: [que, tengo, el, dia, 25, a, las, 11].
%	[tienes,un,evento,con,peter,el,dia,25,de,junio,a,las,11,y,0,de,30,minutos]
%
%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vac�a para parar 
%	|: [pon, una, cita, con, juan, ma�ana, a, las, 18, durara, 21, minutos].
%	cita_creada

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vac�a para parar 
%	|: [pon, una, cita, con, juan, ma�ana, a, las, 18, durara, 21, minutos].
%	cita_creada

%	(Ma�ana es 11 de junio para el programa)
%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vac�a para parar 
%	|: [cuanto, durara, la, cita, con, juan, el, dia, 11].
%	[tu,cita,con,juan,el,dia,11,de,junio,durara,21,minutos]




