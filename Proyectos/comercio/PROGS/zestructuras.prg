x=ADIR(larrayname,"c:\xsoftsql\proyectos\compufar\datos\*.DBF")
FOR I=1 TO X
    B="c:\xsoftsql\proyectos\compufar\datos\"+LARRAYNAME[I,1]
    USE &B 
    LIST STRUCTURE TO FILE C:\TMPCF\COMPUFAR.TXT ADDITIVE
    USE 
NEXT 

*!*	 datos tablas
 
*!*	 MAOPERA.switch				1	0 = fac s/patron carga 1=fac c/patron carga
*!*								2
*!*								3 	0= sin interes 1= por interes
*!*								4
*!*								5
*!*	 MAOPERA.estado		= 1 anulado
*!*	 MAOPERA.origen			FAC   = facturacion
*!*								FPE  = facturacion notas de pedido
*!*								PAG  = registracion pagos
*!*								COB  = registracion cobros
*!*								RFL  = rendicion fletero
*!*								MPU = movimiento publico
*!*								ICA   = ingreso caja 
*!*								ECA = egreso caja
*!*								BCO = registra bancos
*!*								CAR = registra cartera

*!*	 MOVCTACTE.switch		1	1= factura pasada a ctacte en rend.fletero
*!*							2	1= factura con retencion pagada

						    
*!*	NMAOPERA.switch			1	0 = sin facturar 1 = facturado
*!*								2
*!*								3 	0 = sin cargar	1 = cargada
*!*								4 	1= mercaderia comprometida
*!*								5
*!*	NMAOPERA.estado 		= 1 anulado

* en LEON NO se rinden planillas o cargas, sino facturas						   																													
*!*	 CABEFAC.switch			1	F= factura normal N=nota pedido P=premio
*!*							2	N= comprobante originado por facturacion nota pedido (form facpedido)
*!*							3 	0= normal 1=vale 2= canje
*!*							4	1=capitalizacion de intereses 
*!*								5	
*!*	cabefac.rendida			0 = no rendida, 1=rendida

*!*	 FLETEPLANILLA.switch	1	
*!*								2
*!*								3 1 = por notas de pedido
*!*								4
*!*								5

*!*	 FLETECARGA.switch		1	1= operacion pasada a cta cte
*!*								2
*!*								3
*!*								4
*!*								5
 							   
*!*	 MOVBCOCAR.switch		1	3RO 1=entregado / depositado
*!*							2   1 = cheque rechazado
*!*								3
*!*								4
*!*								5
 							   						 

*!*	 MOVSTOCK.switch		1	1= es envase
*!*								2     0=stock real   1=stock disponible
*!*								3
*!*								4
*!*								5	
 							  						  							   						 
*!*	tabla IDASOCIADO		permite asociar 2 o mas registros dentro de una misma tabla, por ej. en fac.compras el neto gravado y el iva
*!*								al consultar un comprobante me permite armar el cursor de cuentas contables							
 							  						  							   						 
*!*	MOVCAJA.clase    			D  =  debita (suma)     H=haber (resta)
*!*	MOVCAJA.tablaori			MOCT  =  movctacte
*!*								CAFA  =  cabefac
*!*								FACP  =  cabecpra
*!*								MBCO =  movbcocar (reg.banco)

*!*	TABLAASI.origen				CAFA  = cabefac
*!*								CAJA  = movcaja
*!*								CH3R = movbcocar  (ch.3ro)
*!*								CHPR = movbcocar  (ch.pro)
*!*								CHVA = movbcocar  (ch.3ro valor negociado)
*!*								BPAG  = movbcocar (retiro 3ro pagos)
*!*								BDEP = movbcocar (retiro 3ro deposito)
*!*								BRET = movbcocar (retiro 3ro retiro cartera)
*!*								FACP = cabecpra
*!*								MAOP = maopera  (ing./egr. caja)
*!*								MBCO = movbcocar (REG.BANCO)
*!*								MCAR = movbcocar (REG.CARTERA)


*!*	 RENMAOPE.switch	       1	0= cobranza cta cte anterior   1= rendicion de valores 2=operaciones afectadas en la rendicion (fac / rem)
*!*								2	0 = facturas 1 = recibos cobro
*!*								3
*!*								4
*!*								5

*!*	 PARACONFIG.switch	       1	0= no permite cambiar plan pago   1= permite cambiar plan pago   en facturacion venta
*!*								2
*!*								3
*!*								4
*!*								5

*!*	MOVPUB.origen			CCTE  = ctacte

*!*	 DETANROCAJA.switch	1	0= activa   1= cerrada
*!*								2
*!*								3
*!*								4
*!*								5
*!*								6
*!*								7
*!*								8
*!*								9
*!*								10

*!*	 CABEASI.tipo   			A= Apertura
*!*								C= registracion
*!*								E= inflacion
*!*								G= cierre resultado
*!*								I= cierre patrimonial
*!*								K= reversa resultado
*!*								M= reversa patrimonial
*!*								O= Ajustes
*!*								Q= Inflacion
*!*								S= cierre resultado
*!*								U= cierre patrimonial

*!*	PROVINCIA.ALICUOTA1 		= percepcion de articulos q perciben.analcolicos
*!*			ALICUOTA2 			= percepcion general
*!*			ALICUOTA3 			= percepcion general monitributista
*!*			ALICUOTA4 			= retencion  general. ah esta se le aplica convenio.
*!*			ALICUOTA5 = 

*!*	PRODUCTO.switch				1  0=actualiza lista2, 1= no actualiza lista2
*!*								2  0=actualiza lista3, 1= no actualiza lista3
