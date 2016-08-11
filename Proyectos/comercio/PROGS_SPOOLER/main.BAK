Parameters lnIdprograma

lnIdprograma = Iif(Pcount()<1,"2",lnIdprograma)

*===================
*= ARCHIVO PRINCIPAL
*===================
*
*	VER AL PIE alguna consideracion con respecto a campos tablas
*

*clear all
Set Classlib To
l='j:'
Set Talk Off
lldesarrollo=(_vfp.StartMode()#4)

_vfp.AutoYield = .F.

lctituloGestion = "Impresion Fiscal"

lccaption=_Screen.Caption

lcdd=Alltrim(Curdir()) && directorio de arranque
If lldesarrollo
	lcdd    =l+'\xsoftSQL\proyectos\hernan\'
	lcdirdes=l+'\xsoftSQL\desarrollo'
*-- RUTA
	_rutaclases =lcdd+'Clases' &&
	_rutaclased =lcdirdes+'\clases'&&
	_rutabmpd   =lcdirdes+'\graficos'&&
	_rutaprogs  =lcdd+'Progs'&&
	_rutamenu   =lcdd+'Menus'&&
	_rutadatos  =lcdd+'Datos'
	_rutabmps   =lcdd+'graphics'&&
	_rutaforms  =lcdd+'forms'&&
	_rutareports=lcdd+'reports'&&
	
	_rutaforms2 =lcdd+'forms_spooler'&&
	_rutaprogs2  =lcdd+'Progs_spooler'&&
	
	_rutaffc  =lcdirdes+'\clases\ffc'	&&
	_rutaformsDesarrollo =lcdirdes+'\forms'&&
	_rutaFoxyPreviewer = lcdirdes+'\FoxyPreviewer250a'
	
	_rutaincluide   =lcdirdes+'\include'&&
	_rutalibd   =lcdirdes+'\lib'&&

	Set Default To (lcdd) 

	Set Path To &_rutaclases,&_rutaprogs,&_rutaprogs2,&_rutamenu,&_rutadatos,&_rutabmps;
		,&_rutaforms2,&_rutaforms,&_rutareports,&_rutaclased,&_rutalibd;
		,&_rutabmpd,&_rutaformsDesarrollo,&_rutaffc,&_rutainclude,&_rutaFoxyPreviewer;

	*
Endif

*-- CREACION DE OBJETO APLICACION

Set Classlib To aplicacion.vcx Additive && Objeto Aplicacion

*-- APERTURA DE CLASES Y ARCHIVOS DE PROCEDIMIENTOS

Set Procedure To Proc.prg Additive  && Procedimientos generales
Set Procedure To syserror.prg Additive
Set Procedure To procfiscal.prg Additive
Set Procedure To registry.prg Additive
Set Procedure To procvarios Additive
Set Procedure To procdesarrollo Additive
Set Procedure To proc_spooler Additive

Set Classlib  To  reindexer Additive
Set Classlib  To  clasesgenerales Additive
Set Classlib  To  controles Additive
Set Classlib  To  iabm.vcx Additive
Set Classlib  To  Calc.vcx Additive  && Calculadora
Set Classlib  To  icontrolespersonalizados Additive
Set Classlib To odata Additive
Set Classlib To rcscalendar Additive
Set Classlib To _reportlistener.vcx Additive

*clear all
Public OAvisar
OAvisar=Createobject('avisar')

oavisar.proceso('S','Inicializando el sistema, aguarde unos instantes por favor ...')

*!*	Set Procedure To foxypreviewer.App Additive
*!*	Do foxypreviewer.App

_Screen.LockScreen=.T.
_Screen.WindowState=2
_Screen.Caption=lctituloGestion
_Screen.Icon='help.ico'
_Screen.BackColor = Rgb(243,243,243)
*!*	_Screen.Height = 330
*!*	_screen.Width = 625

IF !lldesarrollo
	_Screen.Closable=.F.
	_Screen.Visible=.T.
ENDIF

Public LcConectionString,LcDataSourceType,lcOrigenPublico,PcmsgIU,PcmsgIP,LcWebService,LcLlaveCf,pnsucursal
Public lcConectionODBC,lnconectorODBC,lcConectorShape

Store '' To LcConectionString,LcDataSourceType,lcOrigenPublico,LcWebService,lcConectionODBC,lcConectorShape
Store 0 To pnsucursal,lnconectorODBC


Public goapp,ObjReporter,ObjListaConcetor,GoVariable

goapp=createobject('app',!lldesarrollo,lldesarrollo)
*goapp=Newobject('app','saplicacion.vcx',.Null.,!lldesarrollo,lldesarrollo)

ObjReporter= Createobject("Custom")
ObjReporter.AddProperty('titulo1',"")
ObjReporter.AddProperty('titulo2',"")
ObjReporter.AddProperty('titulo3',"")
ObjReporter.AddProperty('titulo4',"")
ObjReporter.AddProperty('titulo5',"")
ObjReporter.AddProperty('titulo6',"")
ObjReporter.AddProperty('titulo7',"")

GoVariable = Createobject("Custom")
GoVariable.AddProperty('idctacte',0)

If Type('goApp')='O'
*-- CARGAR PROPIEDADES DE RUTA EN OBJETO APLICACION
	If lldesarrollo && Aplicacion en modo desarrollo
		goapp.cdefault=Set('default')
		goapp.cpath=Set('path')
	Else  && Aplicacion en modo ejecución
		If LcDataSourceType = "NATIVE"
			Set Defa To (goapp.cdefault)
			Set Path To (goapp.cpath)
		Endif
	Endif

	goapp.Version = "01.00.00"

	Public  gcicono

	PcmsgIU  = 'Información al Usuario'
	PcmsgIP  = 'Información al Programador'

	gcicono=lcdd+'help.ico'
	LcLlaveCf = Space(8)

	On Error Do errorsys

	Do Setup

	* lo 
	*Set Procedure To foxypreviewer.App Additive
	*Do foxypreviewer.App

	_Screen.LockScreen=.F.

    	WAIT WINDOW "Verificando ActiveX instalados ..." nowait
    	DO Verifica_OCX WITH "Check"

	
	
	Do directivasfiscal    && en procfiscal.prg
	Do directivasHasar
	
	
*	DO directivasvarias		&& en procvarios.prg

	= Fwin32()    && funciones api win32
	
	= ObtenerServidor()
	
	
	
*!*		If Len(Trim(LcConectionString))=0
*!*			Do Form configbd
*!*			=ObtenerServidor()
*!*		Endif

	Public loConnDataSource,lcIdObjCon,lcIdObjneg,lcServidor,ObjNeg

	LeerXMLClassID("objetodll.xml")
	
* en proc.prg
	If LcDataSourceType='ADO'
		If ExisteDSN()
			If !ConeccionADO()
				Cancel
				Clear All
				Return
			Endif
		Else
			Cancel
			Clear All
			Return
		Endif
	Else
		If !ConeccionODBC()
			Cancel
			Clear All
			Return
		Endif
	Endif

	Wait Clear

* en proc.prg

*!*		If !lldesarrollo
*!*			If !LeerVersionExe(1,"",lnIdprograma)
*!*				Cancel
*!*				Clear All
*!*				Return
*!*			Endif
*!*		Endif
	
*!*		If !ControlTerminal() && verifico si la terminal está autorizada a traves del SN del disco
*!*			Cancel
*!*			Clear All
*!*			Return
*!*		Endif

	LeerEmpresa()

	goapp.idusuario    = 0
	goapp.perfilusuario= 0
	goapp.nombreusuario= ""
	goapp.sucursal10   = goapp.sucursal   && si sucursal10#0 en proc almacenado de insert suma 10 y concatena el numero de id obtenido, ver odata
	goapp.hayalertas   = .T.
	
	LeerEjercicioPerfil()
	
	
	*IF !llDesarrollo
		SET SYSMENU TO 
	
	
		_Screen.Visible=.T.
		_Screen.LockScreen=.F.
	
		DO CASE 
		CASE VAL(lnIdprograma )= 2
			DO FORM Impdiferida
		CASE VAL(lnIdprograma )= 3
			DO FORM Fiscal_Imp
		CASE VAL(lnIdprograma )= 4
			*DO FORM Fiscal_Fac
		ENDCASE 
	*ELSE 
	*	goapp.salir()
	*ENDIF 
	
	Read Events
	
Endif

*!*	loConnDataSource = Null
*!*	lnconectorODBC   = Null

*!*	IF TYPE('goApp')='O'
*!*		goApp.salir()
*!*	ENDIF 

IF lldesarrollo
	SET SYSMENU TO DEFAULT 
ENDIF  

*!*	Cancel All
*!*	Clear All

Return

*-----------------------------
Function f_activawin(cCaption)
*-----------------------------

Local nHWD
Declare Integer FindWindow In WIN32API ;
	STRING cNULL,;
	STRING cWinName

Declare SetForegroundWindow In WIN32API ;
	INTEGER nHandle

Declare SetActiveWindow In WIN32API ;
	INTEGER nHandle

Declare ShowWindow In WIN32API ;
	INTEGER nHandle, ;
	INTEGER nState

nHWD = FindWindow(0, cCaption)
If nHWD > 0
* VENTANA YA ACTIVA
* LA "LLAMAMOS":
	ShowWindow(nHWD,9)

* LA PONEMOS ENCIMA
	SetForegroundWindow(nHWD)

* LA ACTIVAMOS
	SetActiveWindow(nHWD)
	Return .T.
Else
* VENTANA NO ACTIVA
	Return .F.
Endif

Function Fwin32
Declare Beep In WIN32API Integer nFrequency, Integer nDuration

Declare _fpreset In msvcrt

* Retorna .T. si hay una conexion a internet activa
Declare Integer InternetCheckConnection In wininet;
	STRING lpszUrl,;
	INTEGER dwFlags,;
	INTEGER dwReserved

Return .T.

Function TreeviewBackColor
Lparameters toTree, tnColor

Local lnhWnd, loNode, lnStyle

Declare Long GetWindowLong In Win32API Long HWnd, Long nIndex
Declare Long SetWindowLong In Win32API Long HWnd, Long nIndex,Long dwNewLong
Declare SendMessage In Win32API Long HWnd, Long Msg, Long wParam, Long Lparam
#Define GWL_STYLE 1641253
#Define TVM_SETBKCOLOR 4381
#Define TVS_HASLINES 0

* Get the TreeView's window handle.

lnhWnd = toTree.HWnd

* Set the BackColor for every node.
For Each loNode In toTree.Nodes
	loNode.BackColor = tnColor
Next loNode

* Set the BackColor for the TreeView's window.

SendMessage(lnhWnd, TVM_SETBKCOLOR, 0, tnColor)

* Get the current style, then temporarily hide lines and redisplay them so
* they'll redraw in the new color.

lnStyle = GetWindowLong(lnhWnd, GWL_STYLE)
SetWindowLong(lnhWnd, GWL_STYLE, Bitxor(lnStyle, TVS_HASLINES))
SetWindowLong(lnhWnd, GWL_STYLE, lnStyle)

Return .T.

Define Class MiImagen As Image
	Procedure ResizeFondo
	With This
		.Left = Int(_Screen.Width  - .Width)/ 2
		.Top = Int(_Screen.Height - .Height)/ 2
	Endwith
	Endproc

	Procedure Destroy
	Unbindevent(This)
	Endproc
Enddefine


