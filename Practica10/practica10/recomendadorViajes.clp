(mapclass Mayoristas)
(defrule prueba
	(not (object (is-a Mayoristas) (nombre "Prueba")))
	=>
	(make-instance of Mayoristas (nombre Prueba)(descripci�n "Prueba de uso de Jess") ))
(reset)
(run)
(facts)

