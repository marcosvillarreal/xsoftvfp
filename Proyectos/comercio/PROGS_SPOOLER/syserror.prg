
Procedure errorsys

lldesarrollo=(_vfp.StartMode()#4)
Local aFoxErr,nTotErr
Dimension aFoxErr[1]
nTotErr = Aerror(aFoxErr)
nError  = aFoxErr[1,1]

Do Case
	Case nError=1938                  && no parent
		Return
	Case nError=2059      	      &&  corta estructura endtry
		Return
	Case nTotErr>0 And nError = 1420  && Corrupt Ole object in General field.
		Mensaje_error(nError)
		Return
	Case nTotErr>0 And nError = 1429  && error conexion ADO
		=Mensaje_error(nError)
		lcmensaje = 'Error de conexi�n a la Base de Datos Seleccionada'+Chr(13)+;
			'Consulte a su Administrador de Sistemas'
		=Oavisar.usuario(lcmensaje,0)
		If !lldesarrollo
			Quit
		Else
			Cancel All
			Clear All
		Endif
	Case nError=1115  && error GETCURSORADAPTER en obtenercursor, cuando el alias es cursor vfp
		Return
	Case nError=1426  && error com cuando uso excel
		Go Bottom In Alias()
		Return
	Case nError = 5                   && record out of range
		If !Eof()
			Go Bott
			Skip
		Endif
		Return
	Case nError = 4                   && fin de archivo
		Go Bott
		Return
	Case nError = 1884     		  && Uniqueness ID error
	*	IF CURSORGETPROP("buffering")=1
	*		MESSAGEBOX(ERR_UNIQUEKEY_LOC)
	*		RETURN
	*	ENDIF
	*	IF MESSAGEBOX(ERR_UNIQUEKEY_LOC+" "+ERR_UNIQUEKEY2_LOC,36)=6
	*		TABLEREVERT(.T.)
	*	ENDIF
	*	Return
	Case nError = 12 Or nError = 13    		  && variable no found
		=Mensaje_error(nError)
	Case nError = 2203  && recursos insuficiente
		Mensaje_error(nError)
	Otherwise
		=Mensaje_error(nError)
		Clear Classlib onegocioslocal
Endcase
Return

Function Mensaje_error(nError)
Local lclocalprogram,lcmensaje,gnx

*!*	lcmensaje = 'Linea : '+Message(1) +Chr(13)+"Error : "+Str(nError)+Chr(13);
*!*		+'Error '+Message()+Chr(13)+' Alias '+Alias()+' registro '+Str(Recno())+Chr(13);
*!*		+'Control activo '+Sys(18)

oform=Null

lcmensaje = 'Error: '+Message()+' '+'Linea : '+Message(1)+' '+"Error : "+Str(nError)+' ';
	+'Ultimo Alias Activo: '+Alias()+' '+'Ultimo registro: '+Str(Recno())+" "+Sys(14,1)+' ';
	+'DBF: '+Dbf()+' '+'Ultimo Control activo: '+Sys(18)

lclocalprogram = PROGRAM(1)
lcmensaje = lcmensaje +" "+ lclocalprogram

*  =Oavisar.usuario(lcmensaje,0)
Grabar_log(lcmensaje)

Do Form frmerror Name oform Linked With nError,lcmensaje,lclocalprogram To luvalorbuscado

uvalorbuscado=luvalorbuscado
Release oform

If uvalorbuscado=1 && Aceptar
   return
	*Return To Master
Else && cancelar

	_Screen.LockScreen = .F.
  
    && me fijo si hay una transaccion abierta
    
	If Txnlevel()>0
		If !'NATIVE'$LcDataSourceType And Vartype(Oca)="O"
			If LcDataSourceType="ADO"
				Oca.Datasource.ActiveConnection.rollbacktrans()
			Else
				lnOkSql =Sqlrollback(lnConectorODBC)
			Endif
		Endif
		Rollback
	Endif

	If Type('Goapp')='O'
		Goapp.salir()
	Endif
Endif

Return

