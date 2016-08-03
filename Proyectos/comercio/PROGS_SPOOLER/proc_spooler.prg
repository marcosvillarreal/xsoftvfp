FUNCTION ObtenerServidorRed

LOCAL lsalgo

Goapp.OrigenData	= _Screen.ObjCf.OrigenDato
Goapp.SourceType	= _Screen.ObjCf.SourceType
Goapp.Servidor		= ""
Goapp.InitCatalo	= _Screen.ObjCf.InitCatalogo
Goapp.Usuario		= ""
Goapp.Pwd			= ""
Goapp.sucursal		= _Screen.ObjCf.SucursalCf
Goapp.terminal		= _Screen.ObjCf.TerminalCf
Goapp.PathCf        = _Screen.ObjCf.lcPathCf 
   
LcConectionString	= _Screen.ObjCf.InitCatalogo
LcDataSourceType	= _Screen.ObjCf.SourceType
LcOrigenPublico	    = _Screen.ObjCf.OrigenDato
LcWebService		= ""
lcConectionODBC	    = ""
lcConectorShape     = ""
 	  
lsalgo = IIF(LEN(TRIM(_Screen.ObjCf.InitCatalogo))#0,.t.,.f.)

RETURN  lsalgo

ENDFUNC


FUNCTION ArmaClave
PARAMETERS lcClave
lcclave = ALLTRIM(lcclave)

LOCAL lcpws
*!*	lcpws = SUBSTR(lcclave,3,2)
*!*	lcpws = lcpws + RIGHT(lcclave,1)
*!*	lcpws = lcpws + SUBSTR(lcclave,5,1)

lcpws = lcclave
RETURN lcpws 


FUNCTION CrearCursorAdapterUpdate
PARAMETERS lcaliasCursor,lccmdSelectCursor,cursorbuffermodeoverride

IF USED(lcaliasCursor)
   USE IN (lcaliasCursor)
ENDIF

cursorbuffermodeoverride = IIF(PCOUNT()<3,5,cursorbuffermodeoverride)

lccmdSelectCursor=  CHRTRAN(lccmdSelectCursor,CHR(9)," ")
lccmdSelectCursor= CHRTRAN(lccmdSelectCursor,CHR(13)," ")
lccmdSelectCursor= CHRTRAN(lccmdSelectCursor,CHR(10)," ")

*!*	SET SAFETY OFF 
*!*	lnidfile = STRTOFILE(lccmdSelectCursor,"c:\temp\sql.txt")
*!*	SET SAFETY ON 

Orslista = null 
Ocalista = null

IF LcDataSourceType="ADO"
	Orslista= createobject('ADODB.RecordSet')
	Orslista.CursorLocation   = 3  && adUseClient
	Orslista.LockType         = 3  && adLockOptimistic
	IF TYPE('loConnDataSource')='O' 
	   Orslista.ActiveConnection = loConnDataSource
	ENDIF 
ENDIF
IF LcDataSourceType="ODBC"
   Orslista = lnconectorODBC
ENDIF 

OCAlista = CREATEOBJECT("CursorAdapter")
WITH OCAlista
    .Alias     = lcaliasCursor
    .DataSource = Orslista
    .DataSourceType = LcDataSourceType
    .SelectCmd=lccmdSelectCursor
    .UseDedatasource=.f.
    .BufferModeOverride = cursorbuffermodeoverride 
    .Name = lcaliasCursor
    .UpdateType = 1
ENDWITH 

IF !OCAlista.CursorFill()
	IF AERROR(laError) > 0
		=Oavisar.Usuario("Error al obtener datos:"+laError[2]+" alias "+lcaliasCursor+CHR(13)+lccmdSelectCursor,0)
	ENDIF
	OCalista.CursorDetach()
	Ocalista = null
ENDIF
    
RETURN OCAlista


FUNCTION LeerClaveGln

LOCAL ldim 
ldim = 0
	FOR i=1 TO LEN(ALLTRIM(_Screen.ObjCf.clavecontrol))
		DIMENSION lcClaveControl[i]
		lcClavecontrol[i] = SUBSTR(_Screen.ObjCf.clavecontrol,i,1)
		ldim = i
	NEXT 		

	lcGln      = ALLTRIM(Goapp.EmpresaGln)
	lcClave    = ALLTRIM(Goapp.EmpresaClaveControl)
	
     FOR i=1 TO LEN(lcClave) - 1
          DIMENSION lcVariable[i]
          lcVariable[i] = ASC(SUBSTR(lcClave,i,1))
     NEXT 
     
     lcClave = ""
          
     IF i-1 > ldim
        FOR j=1 TO ldim
            x = ASC(lcClavecontrol[j])
            y = lcVariable[j]
            IF y=32
               y=127
            ENDIF 
            w = (y - x)
            z = ""
            IF w>32
	            z = CHR(w)
	        ENDIF 
            lcClave = lcClave + z
        NEXT 
        FOR h=j TO i-1
            y = lcVariable[h]
            z = CHR(y)
            lcClave = lcClave + z            
        NEXT 
     ELSE
        FOR j=1 TO i-1
            x = ASC(lcClavecontrol[j])
            y = lcVariable[j]
            IF y=32
               y=127
            ENDIF 
            w = (y - x)
            z = ""
            IF w>32
	            z = CHR(w)
	        ENDIF 
            lcClave = lcClave + z
        NEXT 
        FOR h=j TO ldim
            x = lcClavecontrol[h]
            lcClave = lcClave + x
        NEXT 
     ENDIF 
     
     IF ALLTRIM(lcClave) # ALLTRIM(Goapp.empresagln)
        Goapp.empresagln = "0"
     ENDIF 
RETURN .t.


FUNCTION LeerClaveCod
LPARAMETERS lcClaveCod

LOCAL ldim 
ldim = 0
	FOR i=1 TO LEN(ALLTRIM(_Screen.ObjCf.clavecontrol))
		DIMENSION lcClaveControl[i]
		lcClavecontrol[i] = SUBSTR(_Screen.ObjCf.clavecontrol,i,1)
		ldim = i
	NEXT 		

	lcClave  = ALLTRIM(lcClaveCod)
	
     FOR i=1 TO LEN(lcClave) - 1
          DIMENSION lcVariable[i]
          lcVariable[i] = ASC(SUBSTR(lcClave,i,1))
     NEXT 
     
     lcClave = ""
          
     IF i-1 > ldim
        FOR j=1 TO ldim
            x = ASC(lcClavecontrol[j])
            y = lcVariable[j]
            IF y=32
               y=127
            ENDIF 
            w = (y - x)
            z = ""
            IF w>32
	            z = CHR(w)
	        ENDIF 
            lcClave = lcClave + z
        NEXT 
        FOR h=j TO i-1
            y = lcVariable[h]
            z = CHR(y)
            lcClave = lcClave + z            
        NEXT 
     ELSE
        FOR j=1 TO i-1
            x = ASC(lcClavecontrol[j])
            y = lcVariable[j]
            IF y=32
               y=127
            ENDIF 
            w = (y - x)
            z = ""
            IF w>32
	            z = CHR(w)
	        ENDIF 
            lcClave = lcClave + z
        NEXT 
        FOR h=j TO ldim
            x = lcClavecontrol[h]
            lcClave = lcClave + x
        NEXT 
     ENDIF 
     
	RETURN lcClave
RETURN .t.


FUNCTION LeerUltimaActualizacion
LPARAMETERS lnopcion

lnopcion = IIF(PCOUNT()<1,1,lnopcion)

LOCAL lok,lcfecha ,lokF, LokT, lokC
lcfecha = DTOS(DATE())
lok     = .F.
LokT    = .F.

TEXT TO lcCmd TEXTMERGE NOSHOW 
SELECT Csrparavario.* FROM paravario as Csrparavario WHERE RTRIM(nombre)="TERMACTUALIZA"
ENDTEXT
 
lokC = CrearCursorAdapter("CsrCursor",lcCmd)
IF lokC AND RECCOUNT("CsrCursor")>0
   IF Goapp.terminal = CsrCursor.idorigen
      lokT = .t.   
   ENDIF
ELSE 	
   lokT = .t.   && por si no esta configurado en paravario
ENDIF

TEXT TO lcCmd TEXTMERGE NOSHOW 
SELECT Csrftpcf.* FROM ftpcf as Csrftpcf
ENDTEXT 

lokF = CrearCursorAdapter("CsrCursor",lcCmd)

IF lokF	AND lokT
	lok = IIF(CsrCursor.fecha < lcfecha,.t.,.f.)
ENDIF

USE IN CsrCursor

RETURN lok
ENDFUNC 

FUNCTION FechaServer
LOCAL ldfechaserver

TEXT TO lcCmd TEXTMERGE NOSHOW 
Select Getdate() as fecha
ENDTEXT
IF USED("Servidor")
	USE IN Servidor
ENDIF
lok =CrearCursorAdapter("Servidor",lcCmd) 
IF lok
	ldfechaserver = Servidor.fecha
	IF USED("Servidor")
		USE IN Servidor
	ENDIF
ENDIF

RETURN ldfechaserver


FUNCTION ConeccionNATIVE

Local  loCatchErr As Exception
LOCAL lok 
lok = .t.
DEBUG
SUSPEND 
TRY 
	DO case
		CASE LcDataSourceType='NATIVE'
			IF !DBUSED('&LcConectionString')        
				OPEN DATABASE (LcConectionString) SHARED
			ENDIF  
			SET DATABASE TO (LcConectionString)
		OTHERWISE 
			ERROR 1429
		ENDCASE
Catch To loCatchErr
	=Oavisar.proceso('N')	
	=Oavisar.usuario('La conección a la Base de Datos a fallado'+CHR(13);
			+"String coneccion "+LcConectionString+CHR(13)+CHR(13);
			+loCatchErr.LineContents+CHR(13)+loCatchErr.Message,0)
	lok = .f.
ENDTRY 

RETURN lok

FUNCTION NaLetra(tnNro, tnFlag)
   IF EMPTY(tnFlag)
      tnFlag = 0
   ENDIF
   LOCAL lnEntero, lcRetorno, lnTerna, lcMiles, ;
      lcCadena, lnUnidades, lnDecenas, lnCentenas
   lnEntero = INT(tnNro)
   lcRetorno = ''
   lnTerna = 1
   DO WHILE lnEntero > 0
      lcCadena = ''
      lnUnidades = MOD(lnEntero, 10)
      lnEntero = INT(lnEntero / 10)
      lnDecenas = MOD(lnEntero, 10)
      lnEntero = INT(lnEntero / 10)
      lnCentenas = MOD(lnEntero, 10)
      lnEntero = INT(lnEntero / 10)

      *--- Analizo la terna
      DO CASE
         CASE lnTerna = 1
            lcMiles = ''
         CASE lnTerna = 2 AND (lnUnidades + lnDecenas + lnCentenas # 0)
            lcMiles = 'MIL '
         CASE lnTerna = 3 AND (lnUnidades + lnDecenas + lnCentenas # 0)
            lcMiles = IIF(lnUnidades = 1 AND lnDecenas = 0 AND ;
               lnCentenas = 0, 'MI-LLON ', 'MI-LLO-NES ')
         CASE lnTerna = 4 AND (lnUnidades + lnDecenas + lnCentenas # 0)
            lcMiles = 'MIL MI-LLO-NES '
         CASE lnTerna = 5 AND (lnUnidades + lnDecenas + lnCentenas # 0)
            lcMiles = IIF(lnUnidades = 1 AND lnDecenas = 0 AND ;
               lnCentenas = 0, 'BI-LLON ', 'BI-LLO-NES ')
         CASE lnTerna > 5
            lcRetorno = ' ERROR: NUMERO DEMASIADO GRANDE '
            EXIT
      ENDCASE

      *--- Analizo las unidades
      DO CASE
         CASE lnUnidades = 1
            lcCadena = IIF(lnTerna = 1 AND tnFlag = 0, 'U-NO ', 'UN ')
         CASE lnUnidades = 2
            lcCadena = 'DOS '
         CASE lnUnidades = 3
            lcCadena = 'TRES '
         CASE lnUnidades = 4
            lcCadena = 'CUA-TRO '
         CASE lnUnidades = 5
            lcCadena = 'CIN-CO '
         CASE lnUnidades = 6
            lcCadena = 'SEIS '
         CASE lnUnidades = 7
            lcCadena = 'SIE-TE '
         CASE lnUnidades = 8
            lcCadena = 'O-CHO '
         CASE lnUnidades = 9
            lcCadena = 'NUE-VE '
      ENDCASE

      *--- Analizo las decenas
      DO CASE
         CASE lnDecenas = 1
            DO CASE
               CASE lnUnidades = 0
                  lcCadena = 'DIEZ '
               CASE lnUnidades = 1
                  lcCadena = 'ON-CE '
               CASE lnUnidades = 2
                  lcCadena = 'DO-CE '
               CASE lnUnidades = 3
                  lcCadena = 'TRE-CE '
               CASE lnUnidades = 4
                  lcCadena = 'CA-TOR-CE '
               CASE lnUnidades = 5
                  lcCadena = 'QUIN-CE '
               OTHER
                  lcCadena = 'DIE-CI-' + lcCadena
            ENDCASE
         CASE lnDecenas = 2
            lcCadena = IIF(lnUnidades = 0, 'VEIN-TE ', 'VEIN-TI-') + lcCadena
         CASE lnDecenas = 3
            lcCadena = 'TREIN-TA ' + IIF(lnUnidades = 0, '', 'Y ') + lcCadena
         CASE lnDecenas = 4
            lcCadena = 'CUA-REN-TA ' + IIF(lnUnidades = 0, '', 'Y ') + lcCadena
         CASE lnDecenas = 5
            lcCadena = 'CIN-CUEN-TA ' + IIF(lnUnidades = 0, '', 'Y ') + lcCadena
         CASE lnDecenas = 6
            lcCadena = 'SE-SEN-TA ' + IIF(lnUnidades = 0, '', 'Y ') + lcCadena
         CASE lnDecenas = 7
            lcCadena = 'SE-TEN-TA ' + IIF(lnUnidades = 0, '', 'Y ') + lcCadena
         CASE lnDecenas = 8
            lcCadena = 'O-CHEN-TA ' + IIF(lnUnidades = 0, '', 'Y ') + lcCadena
         CASE lnDecenas = 9
            lcCadena = 'NO-VEN-TA ' + IIF(lnUnidades = 0, '', 'Y ') + lcCadena
      ENDCASE

      *--- Analizo las centenas
      DO CASE
         CASE lnCentenas = 1
            lcCadena = IIF(lnUnidades = 0 AND lnDecenas = 0, ;
               'CIEN ', 'CIEN-TO- ') + lcCadena
         CASE lnCentenas = 2
            lcCadena = 'DOS-CIEN-TOS ' + lcCadena
         CASE lnCentenas = 3
            lcCadena = 'TRES-CIEN-TOS ' + lcCadena
         CASE lnCentenas = 4
            lcCadena = 'CUA-TRO-CIEN-TOS ' + lcCadena
         CASE lnCentenas = 5
            lcCadena = 'QUI-NIEN-TOS ' + lcCadena
         CASE lnCentenas = 6
            lcCadena = 'SEIS-CIEN-TOS ' + lcCadena
         CASE lnCentenas = 7
            lcCadena = 'SE-TE-CIEN-TOS ' + lcCadena
         CASE lnCentenas = 8
            lcCadena = 'O-CHO-CIEN-TOS ' + lcCadena
         CASE lnCentenas = 9
            lcCadena = 'NO-VE-CIEN-TOS ' + lcCadena
      ENDCASE

      *--- Armo el retorno terna a terna
      lcRetorno = lcCadena + lcMiles + lcRetorno
      lnTerna = lnTerna + 1
   ENDDO
   IF lnTerna = 1
      lcRetorno = 'CERO '
   ENDIF
   RETURN lcRetorno
ENDFUNC

FUNCTION  DIVIDETEXTO
parameters lcString,loObjCampos,lenCampo,lTotalCampos

lTotalCampos = IIF(PCOUNT()<4,10,lTotalCampos)

if len(strtran(lcString,' ',''))<=lenCampo
   loObjcampos.campo001=strtran(lcString,' ','')
   RETURN .t.
ENDIF
LOCAL j,cadena1,subca,salir

j      = 0
cadena1=RTRIM(lcString)
subca=''
salir = .t.
DO WHILE salir
   i  = AT(" ",cadena1)
   IF i < 1
      subca = cadena1
      EXIT 
   ELSE 
	   subca = LEFT(cadena1,i-1)
  	   cadena1=subs(cadena1,i+1)   
       j = j + 1
       IF j<=lTotalCampos
          lcquecampo = "loObjCampos.campo"+strzero(j,3)
         &lcquecampo = ltrim(subca)
       ENDIF   
       subca=''
   ENDIF 
ENDDO 
j = j + 1
IF j<=lTotalCampos
   lcquecampo = "loObjCampos.campo"+strzero(j,3)
   &lcquecampo = ltrim(subca)
ENDIF    
RETURN 

        
FUNCTION Objetoshape
PARAMETERS lcCmd

lccmd = CHRTRAN(lccmd,CHR(9)," ")
lccmd = CHRTRAN(lccmd,CHR(13)," ")
lccmd = CHRTRAN(lccmd,CHR(10)," ")

#DEFINE adChar	129 
#DEFINE adParamInput	1 

LOCAL loRS as ADODB.Recordset
loRS = CREATEOBJECT("ADODB.Recordset")

LOCAL loCn as ADODB.Connection 
loCn = CREATEOBJECT("ADODB.Connection")
loCn.ConnectionString = lcConectorShape

WITH loCn
	IF .State = 0 
		.Open()
	ENDIF
ENDWITH	

LOCAL loCm as ADODB.Command
loCm = CREATEOBJECT("ADODB.Command")
WITH loCm
	.CommandText = lcCmd
	IF loCm.Parameters.Count = 0
		LOCAL loPr as ADODB.Parameter
		loPr = CREATEOBJECT("ADODB.Parameter")
		WITH loPr
			.Type = adChar
			.Name = "CsrCursorShape"
			.Direction = adParamInput
			.Size = 40
			.Value = ""
		ENDWITH	      
		.Parameters.Append(loPr)
	ENDIF
	.ActiveConnection = loCn
ENDWITH	 

RETURN loCm

PROCEDURE NUEVOIDSQL(TCALIAS,RetValor,LcOriCon)

	local LCALIAS
    RetValor = 0
	if parameters() < 1
	   RETURN 
	ENDIF    
	IF PARAMETERS() < 3
	   lcOriCon = 'ADO'
	ENDIF 
    LCALIAS = upper(TCALIAS)
	lCOriCon = UPPER(lcOriCon)
    IF lcOriCon='ADO'	
       SELECT * FROM Keysid WHERE Tabla=LCALIAS
	   IF !Lcalias$Keysid.tabla
	      INSERT INTO Keysid (Tabla,nextid,ctipocomp) VALUES (lcalias, 0 ,'')		   
       ENDIF           		
       UPDATE Keysid SET NextId = Nextid + 1 WHERE Tabla=lcalias
       RetValor = KeySid.nextid
    ELSE
   	   LNOLDAREA = select()
       lcdatabase = CursorGetProp("DATABASE",LCalias)
       lnrat      = rat('\',lcdatabase)
       lcdatabase = subs(lcdatabase,lnrat+1)        
	   LCOLDREPROCESS = set('REPROCESS')
       set reprocess to automatic	
       Lcids = iif(len(trim(lCdatabase))<>0,lcdatabase+'!KEYSID','KEYSID')        
	   if used("KEYSID")
	      Use in KEYSID
  	   endif

       Use &Lcids in 0 alias KEYSID

	   select KEYSID
       Set order to 1
	   IF !SEEK(alltrim(LCALIAS),"KEYSId", "tabla")
	      INSERT INTO Keysid (Tabla,nextid,ctipocomp) VALUES (lcalias, 0 ,'')		   
	   ENDIF
       if rlock()
	      replace KEYSID.NEXTID with KEYSID.NEXTID + 1
          RetValor = KEYSID.NEXTID
	      unlock
	   endif
       Use in KEYSID
	   select (LNOLDAREA)
	   set reprocess to LCOLDREPROCESS     
    ENDIF   
  	RETURN RetValor
ENDPROC

FUNCTION Xmlparser
PARAMETERS cRes,lObjparser

IF USED("Xmlresult")
	USE IN XmlResult
ENDIF
CREATE CURSOR XmlResult (detalle c(254))

LOCAL lcstring,j
lcstring = UPPER(cRes)

DO WHILE LEN(TRIM(lcstring)) >0
	i= AT(CHR(10),lcstring)
	IF i=0
		EXIT 
	endif
	lclabel  = LEFT(lcstring,i-1)
	lcstring = SUBSTR(lcstring,i+1)
	INSERT INTO XmlResult (detalle) VALUES (lclabel)
ENDDO

lcRowSource = lObjParser.etiquetas
DO WHILE LEN(TRIM(lcRowsource))#0
    j=AT('\',lcRowSource)
    IF j<=0
    	EXIT 
    ENDIF 
    j=IIF(j<=0,LEN(lcRowSource),j-1)    
    lccadena = LEFT(lcRowSource,j)
    lcRowSource = SUBSTR(lcRowSource,AT('\',lcRowSource)+1)   
    lnancho = LEN(lccadena)
    SELECT XmlResult
    LOCATE FOR lcCadena$detalle
    IF lcCadena$detalle
       lclabel = STRTRAN(lcCadena,"<","")
       lclabel = STRTRAN(lcLabel,">","")
	   lclabel = STRTRAN(lclabel,lcCadena,"")
	   lcname  = "lObjParser."+ALLTRIM(lclabel)
	   
	   lcdato  = STRTRAN(detalle,lcCadena,"")
	   lcdato  = STRTRAN(lcdato,"/","")
	   lcdato  = STRTRAN(lcdato,lcCadena,"")
	   &lcname = ALLTRIM(lcdato)
    ENDIF 

ENDDO

RETURN .t.

FUNCTION redondearMas
PARAMETERS precio,lnincremento
lnincremento = IIF(PCOUNT()<2,.05,lnincremento)

LOCAL precioentero,decimales,i

precioentero = int(precio)
decimales    = ABS(precioentero-precio)

FOR i = 0 TO 1 STEP lnincremento
  IF decimales <= i
    EXIT 
  ENDIF 
ENDFOR 

precio = precioentero + i

RETURN precio

FUNCTION TotalPorCuota
PARAMETERS llRedondearMas,LmimporteTotal,LmimporteCta,LmCta,lnDecimal

llRedondearMas = IIF(PCOUNT()<1,.T.,llRedondearMas)
LmCta          = IIF(PCOUNT()<4,3,LmCta)
lnDecimal      = IIF(PCOUNT()<5,2,lnDecimal)
LmimporteCta   = 0

LmimporteCta = red((LmImporteTotal / lmcta),lndecimal)

IF llRedondearMas
	lmImporteCta = RedondearMas(lmImporteCta)
ENDIF

lmImporteTotal = red((lmImporteCta * lmcta),lndecimal)

RETURN .t.

FUNCTION PeriodosEntreFecha
PARAMETERS ldfecha1,ldfecha2

LOCAL lcperiodo1,lcperiodo2,lncuantos,lnanio,lnmes

lcperiodo1 = LEFT(DTOS(ldfecha1),6)
lcperiodo2 = LEFT(DTOS(ldfecha2),6)

lncuantos = 0
DO WHILE lcperiodo1 <= lcperiodo2
	lncuantos = lncuantos + 1
	lnanio = VAL(LEFT(lcperiodo1,4))
	lnmes  = VAL(RIGHT(lcperiodo1,2)) + 1
	IF lnmes > 12
		lnanio = lnanio + 1
		lnmes  = 1
	ENDIF 
    lcperiodo1 = strzero(lnanio,4)+strzero(lnmes,2)	
ENDDO 

RETURN lncuantos

FUNCTION ArmaNroCaja
PARAMETERS lvalorentrada

LOCAL lvalorSalida

IF VARTYPE(lValorEntrada)="N"
   lvalorSalida = CTOD(RIGHT(STR(lvalorentrada,8),2)+"-"+SUBSTR(STR(lvalorentrada,8),5,2)+"-"+LEFT(STR(lvalorEntrada,8),4))
ELSE
   lvalorSalida = DTOS(lvalorentrada)
ENDIF 

RETURN lvalorSalida


FUNCTION FNombreCorto
   *
   * Converts a Win32 long file name to its short file name equivalent
   *
   * passed: long file name, must already exist for this to work
   *
   * returns: fully qualified short file name, or empty string
   * if error is encountered
   *

   PARAMETERS lcInputString

   DECLARE INTEGER GetShortPathName IN Kernel32 STRING @lpszLongPath, ;
      STRING @lpszShortPath, INTEGER cchBuffer
   DECLARE INTEGER GetLastError IN Win32api

   #DEFINE MAX_PATH 255

   * buffer to receive converted file name
   lcOutputString = SPACE(MAX_PATH)

   * length of receiving buffer
   llcbOutputString = LEN(lcOutputString)

   * if successful, llretval will contain the length of the
   * output string
   llretval = GetShortPathName(@lcInputString, @lcOutputString,;
      llcbOutputString)
   IF llretval = 0
   * uncomment for error code
   * wait window "Error occurred, code is: " + ltrim(str(GetLastError()))
      RETURN ""
   ENDIF

   * truncate it at the length the return value indicates
   lcOutputString = LEFT(lcOutputString, llretval)

RETURN lcOutputString

FUNCTION abrevia
parameter lcstring,len_abreviado,cant_palabras

LOCAL lcchar,auxi,i,len_real
DIMENSION pala[1]
auxi=alltrim(lcstring)
lcchar=''
cant_palabras=1
len_real=len(auxi)
if len_real<=len_abreviado
   return ( left(lcstring,len_abreviado) )
endif
atante=1
do while at(' ',auxi)<>0
   pala[cant_palabras]=trim(substr(auxi,atante,at(' ',auxi)-atante))
   if len(alltrim(pala[cant_palabras]))<>0
      cant_palabras=cant_palabras+1
      DIMENSION pala[cant_palabras]
   ENDIF 
   atante=at(' ',auxi)+1
   auxi=strtran(auxi,' ','^',1,1)
ENDDO
pala[cant_palabras]=trim(substr(auxi,atante,len(auxi)-atante+1))
if cant_palabras>1
   restan=len_abreviado
   FOR i=1 TO cant_palabras
       lcchar=lcchar+alltrim(substr(pala[i],1,restan/(cant_palabras-i+1)))+' '
       restan=len_abreviado-len(lcchar)
   NEXT 
   auxi=subs(trim(lcchar)+space(len_real),1,len_abreviado)
ELSE 
   auxi=substr(alltrim(lcstring)+space(len_real),1,len_abreviado)
ENDIF

return(auxi)

FUNCTION LimpiaCmd
PARAMETERS lcCmdSelectCursor
	lccmdSelectCursor=  CHRTRAN(lccmdSelectCursor,CHR(9)," ")
	lccmdSelectCursor= CHRTRAN(lccmdSelectCursor,CHR(13)," ")
	lccmdSelectCursor= CHRTRAN(lccmdSelectCursor,CHR(10)," ")
RETURN lcCmdSelectCursor


FUNCTION createStruct( toReflection, tcTypeName )
  LOCAL loPropertyValue, loTemp
  loPropertyValue = createobject( "relation" )
  toReflection.forName( tcTypeName).createobject(@loPropertyValue)
  return ( loPropertyValue )
ENDPROC 

FUNCTION ConvertToUrl (strFile)
    strFile = STRTRAN(strFile, "\", "/")
    strFile = STRTRAN(strFile, ":", "|")
    strFile = STRTRAN(strFile, "", "20%")
    strFile = "file:///" + strFile 
    RETURN strFile
ENDPROC 


*--------------------------------------------------
* Clase cWord
*--------------------------------------------------
DEFINE CLASS cWord AS CUSTOM
  *--
  * Propiedades
  *--
  oWord = .NULL.   &&   Objeto Word
  cDirApp = ADDBS(SYS(5) + SYS(2003))
  cDirDat = ADDBS(HOME(2) )
  cDataSource = ""

  *--------------------------------------------------
  * Creo el servidor de automatización
  *--------------------------------------------------
  PROCEDURE CrearServidorWord()
    *-- Creo el objeto
    THIS.oWord = CREATEOBJECT('Word.Application')
    RETURN VARTYPE(THIS.oWord) = 'O'
  ENDPROC
  *--------------------------------------------------
  * Cierro el servidor de automatización
  *--------------------------------------------------
  PROCEDURE CerrarServidorWord()
    *-- Cierro Word
    THIS.oWord.QUIT()
    THIS.oWord = .NULL.
    RETURN
  ENDPROC
  *--------------------------------------------------
  * Abro la Carta, si no existe la creo
  *--------------------------------------------------
  PROCEDURE AbrirCartaWord(tcArchivo)
    LOCAL loDoc AS 'Word.Document'
    tcArchivo = FORCEEXT(tcArchivo,'DOC')
    IF NOT FILE(THIS.cDirApp + tcArchivo)
       =Oavisar.usuario("El documento Word "+THIS.cDirApp + tcArchivo+" no existe",0)
       RETURN null 
    ELSE
      *-- Si existe la carta, la abro
      loDoc = THIS.oWord.Documents.OPEN(THIS.cDirApp + tcArchivo)
      *-- y me aseguro que no tiene un documento asociado
      loDoc.MailMerge.MainDocumentType = -1  && wdNotAMergeDocument
    ENDIF
    *-- Retorno un objeto Document
    RETURN loDoc
  ENDPROC

  *--------------------------------------------------
  * Combino la Carta
  *--------------------------------------------------
  PROCEDURE CombinarCartaWord(toDoc)
    WITH toDoc.MailMerge
      .MainDocumentType = 0  && wdFormLetters
      .OpenDataSource(THIS.cDataSource)
      .Execute()
    ENDWITH
    
    WITH THIS.oWord
      *-- Cambio la Carpeta del cuadro de diálogo 'Guardar...'
      .ChangeFileOpenDirectory(THIS.cDirApp)
      *-- Maximizo y hago visible
      .WINDOWSTATE = 1  && wdWindowStateMaximize
      .VISIBLE = .T.  && True
    ENDWITH
    RETURN
  ENDPROC
ENDDEFINE
*--------------------------------------------------
* Fin Clase cWord
*--------------------------------------------------

FUNCTION ExtraerNumero(tcCadena)
RETURN CHRTRAN(tcCadena,CHRTRAN(tcCadena,"1234567890",""),"") 

FUNCTION CuantosCaracteres
PARAMETERS lcString,lcCaracter

LOCAL i,j,k
i=ATC(lcCaracter,lcString)
k = 0
FOR j=i TO LEN(lcString)
	IF SUBSTR(lcString,j,1)=lcCaracter
	   k = k + 1
	ENDIF 
NEXT 
RETURN k

FUNCTION Str2Word
PARAMETERS m.wordstr
   PRIVATE i, m.retval

   m.retval = 0
   FOR i = 0 TO 8 STEP 8
       m.retval = m.retval + (ASC(m.wordstr) * (2^i))
       m.wordstr = RIGHT(m.wordstr, LEN(m.wordstr) - 1)
   NEXT
RETURN m.retval

FUNCTION buf2dword
PARAMETERS cBuffer
RETURN Asc(SUBSTR(cBuffer, 1,1)) + ;
   BitLShift(Asc(SUBSTR(cBuffer, 2,1)),  8) +;
   BitLShift(Asc(SUBSTR(cBuffer, 3,1)), 16) +;
   BitLShift(Asc(SUBSTR(cBuffer, 4,1)), 24)
   

FUNCTION CrearCursorODBC
PARAMETERS lcaliasCursor,lccmdSelectCursor,lnconector

LOCAL lnCiclo

IF USED(lcaliasCursor)
   USE IN (lcaliasCursor)
ENDIF

lccmdSelectCursor=  CHRTRAN(lccmdSelectCursor,CHR(9)," ")
lccmdSelectCursor= CHRTRAN(lccmdSelectCursor,CHR(13)," ")
lccmdSelectCursor= CHRTRAN(lccmdSelectCursor,CHR(10)," ")
lnCiclo = SQLEXEC(lnconector,"&lccmdSelectCursor","&lcaliasCursor")

LOCAL lreturn
lreturn = .t.

RETURN lreturn

FUNCTION GrabarLogs
PARAMETERS lcArchivo,lcClave,lcDato1

IF FILE("&lcarchivo")
	Arc = FOPEN("&lcArchivo",12)    
ELSE 
	Arc = FCREATE("&lcarchivo")
ENDIF 

LenRegistro = 100
IF arc#0
   lclabel= TIME() + " " + lcClave + " " +  lcDato1
   pnSize = FSEEK(Arc,0,2)
   XX= FPUTS(Arc,lclabel,lenregistro)   
ENDIF 
=FCLOSE(Arc)		

RETURN 

FUNCTION substring
LPARAMETERS lcString,lndesde,lnlen
lndesde = IIF(PCOUNT()<2,1,lndesde)
lnlen   = IIF(PCOUNT()<3,LEN(lcString),lnlen)

LOCAL lcVariable

lcVariable = SUBSTR(lcString,lndesde,lnlen)

RETURN lcVariable

Function LeerXML(tcArchivo,oscreen)
   If !File( tcArchivo )
	   CREATE CURSOR temp (top n(12,1),left n(12,1),Height n(12,1),Width n(12,2))
	   INSERT into temp VALUES (_screen.Top,_screen.Left,_screen.Height,_screen.Width)
	   SELECT temp
	   scatter name oscreen
	   SET SAFETY off
	   CURSORTOXML('Temp',  tcArchivo, 1, 512)
	   SET SAFETY ON
	   Use In Temp
   Else
      XmlToCursor( tcArchivo, 'Cur_Temporal',512 )
      SELECT cur_temporal
      SCATTER NAME oscreen
      Use In Cur_Temporal
   EndIf
   Return .T.
ENDFUNC

Function GrabarXML(tcArchivo,oscreen)
   IF USED('temp')
      USE IN temp
   endif
   CREATE CURSOR temp (top n(12,1),left n(12,1),Height n(12,1),Width n(12,2))
   APPEND BLANK IN temp   
   SELECT temp
   gather name oscreen
   SET SAFETY off
   CURSORTOXML('Temp',  tcArchivo, 1, 512)
   SET SAFETY ON
   Use In Temp
   RELEASE oscreen
   Return .T.
   
ENDFUNC

Function IsInterNetActive 
PARAMETERS tcURL
* PARAMETERS: URL, no olvidar pasar la URL completa, con http:// al inicio
* Retorna .T. si hay una conexion a internet activa

tcURL = IIF(TYPE("tcURL")="C" AND !EMPTY(tcURL),tcURL,"http://www.yahoo.com")

RETURN ( InternetCheckConnection(tcURL, 1, 0) == 1)
ENDFUNC


FUNCTION ExisteDll
PARAMETERS lcNameDll

loRegistry = NEWOBJECT("Registry","registry.vcx")

IF loRegistry.Iskey("&lcNameDll")
   RETURN .t.
ELSE
   RETURN .f.
ENDIF 

ENDFUNC 


*!*	FUNCTION LeerFtpWin
*!*	LPARAMETERS Lobjftp

*!*	lcCarpetaOrigen  = IIF(LEN(TRIM(lObjftp.CarpetaOrigen))#0,"/","") + lObjftp.CarpetaOrigen
*!*	lcArchivoOrigen  = lObjFtp.ArchivoOrigen
*!*	lcCarpetaDestino = lObjFtp.CarpetaDestino
*!*	lcArchivoDestino = lObjFtp.ArchivoDestino
*!*	lcFtpServer      = lObjFtp.Server
*!*	lcFtpcuenta      = lObjFtp.cuenta
*!*	lcFtpclave       = lObjFtp.clave

*!*	LOCAL lcStringO,lcStringD,lestadoGet,lcArroba

*!*	lcArroba = CHR(64)

*!*	*FTPGet("FTP://UserName:Password@somedomain.com/directory/Source.zip", "C:\Destination.zip", "MyProgress()", "MyTrace()")

*!*	lcStringO = "FTP://"+ALLTRIM(lcftpcuenta)+":"+ALLTRIM(lcftpclave) + lcArroba + ALLTRIM(lcftpserver)
*!*	lcStringO = lcStringO +ALLTRIM(lcCarpetaOrigen)+"/"+ALLTRIM(lcArchivoOrigen)

*!*	lcStringD = ALLTRIM(lcCarpetaDestino)+ALLTRIM(lcArchivoDestino)

*!*	M.LaRuta = ALLTRIM(lcCarpetaDestino)
*!*	if !Directory(M.LaRuta)
*!*		MD (M.LaRuta)
*!*	ENDIF

*!*	lestadoGet = FTPGet(lcStringO, lcStringD, "", "")

*!*	RETURN lestadoGet

*!*	ENDFUNC 

FUNCTION LeerFtpWin
LPARAMETERS Lobjftp

*** Definición de constantes
#DEFINE INTERNET_OPEN_TYPE_PRECONFIG     0
#define INTERNET_OPEN_TYPE_DIRECT        1
#define INTERNET_OPEN_TYPE_PROXY         3
#DEFINE INTERNET_DEFAULT_FTP_PORT       21
#DEFINE INTERNET_SERVICE_FTP             1
#DEFINE INTERNET_FLAG_PASSIVE     14217728
*** Declaración de funciones del API
DECLARE LONG InternetOpen IN "wininet.dll" ;
	STRING   lpszAgent, ;
	LONG     dwAccessType, ;
	STRING   lpszProxyName, ;
	STRING   lpszProxyBypass, ;
	LONG     dwFlags
DECLARE LONG InternetConnect IN "wininet.dll" ;
	LONG     hInternetSession, ;
	STRING   lpszServerName, ;
	LONG     nServerPort, ;
	STRING   lpszUsername, ;
	STRING   lpszPassword, ;
	LONG     dwService, ;
	LONG     dwFlags, ;
	LONG     dwContext
DECLARE INTEGER InternetCloseHandle IN "wininet.dll" ;
	LONG     hInet
DECLARE LONG GetLastError IN WIN32API

*** Definición de constantes
#DEFINE FILE_ATTRIBUTE_NORMAL         128
#DEFINE FTP_TRANSFER_TYPE_ASCII         1
#DEFINE FTP_TRANSFER_TYPE_BINARY        2
*** Declaración de funciones
DECLARE INTEGER FtpGetFile IN "wininet.dll" ;
	LONG    hFtpSession, ;
	STRING  lpszRemoteFile, ;
	STRING  lpszNewFile, ;
	LONG    fFailIfExist, ;
	LONG    dwFlagsAndAttributes, ;
	LONG    dwFlags,;
	LONG    dwContext

lcCarpetaOrigen  = IIF(LEN(TRIM(lObjftp.CarpetaOrigen))#0,"/","") + lObjftp.CarpetaOrigen
lcArchivoOrigen  = lObjFtp.ArchivoOrigen
lcCarpetaDestino = lObjFtp.CarpetaDestino
lcArchivoDestino = lObjFtp.ArchivoDestino
lcFtpServer      = lObjFtp.Server
lcFtpcuenta      = lObjFtp.cuenta
lcFtpclave       = lObjFtp.clave

LOCAL lcStringO,lcStringD,lestadoGet,lcArroba

*** Apertura del API
nInternet = InternetOpen("vfp",INTERNET_OPEN_TYPE_DIRECT, "", "", 0 )
IF nInternet = 0
	RETURN .f.
ENDIF
*** Conexión con el servicio FTP

nFtp = InternetConnect(	nInternet, lcFtpServer , INTERNET_DEFAULT_FTP_PORT, lcFtpcuenta, lcFtpclave, INTERNET_SERVICE_FTP, INTERNET_FLAG_PASSIVE, 0 )
IF nFtp = 0
	RETURN .f.
ENDIF

lcStringO = "/"+TRIM(lcFtpcuenta)+LOWER(ALLTRIM(lcCarpetaOrigen)+"/"+ALLTRIM(lcArchivoOrigen))

lcStringD = LOWER(ALLTRIM(lcCarpetaDestino)+ALLTRIM(lcArchivoDestino))
lnftpGet  = 0
IF lObjFtp.operacion=1   && lectura
	lnftpGet = FtpGetFile(	nFtp, lcStringo,	lcStringD, 0, FILE_ATTRIBUTE_NORMAL, FTP_TRANSFER_TYPE_ASCII, 0 )
ENDIF 

*** Cierre de la conexión FTP
InternetCloseHandle( nFtp )
*** Cierre del uso del API
InternetCloseHandle( nInternet )

RETURN IIF(lnftpGet=1,.t.,.f.)

ENDFUNC 

FUNCTION GrabarFtpWin
LPARAMETERS Lobjftp

*** Definición de constantes
#DEFINE INTERNET_OPEN_TYPE_PRECONFIG     0
#define INTERNET_OPEN_TYPE_DIRECT        1
#define INTERNET_OPEN_TYPE_PROXY         3
#DEFINE INTERNET_DEFAULT_FTP_PORT       21
#DEFINE INTERNET_SERVICE_FTP             1
#DEFINE INTERNET_FLAG_PASSIVE     14217728
*** Declaración de funciones del API
DECLARE LONG InternetOpen IN "wininet.dll" ;
	STRING   lpszAgent, ;
	LONG     dwAccessType, ;
	STRING   lpszProxyName, ;
	STRING   lpszProxyBypass, ;
	LONG     dwFlags
	
DECLARE LONG InternetConnect IN "wininet.dll" ;
	LONG     hInternetSession, ;
	STRING   lpszServerName, ;
	LONG     nServerPort, ;
	STRING   lpszUsername, ;
	STRING   lpszPassword, ;
	LONG     dwService, ;
	LONG     dwFlags, ;
	LONG     dwContext
	
DECLARE INTEGER InternetCloseHandle IN "wininet.dll" ;
	LONG     hInet
	
DECLARE LONG GetLastError IN WIN32API

*** Definición de constantes
#DEFINE FILE_ATTRIBUTE_NORMAL         128
#DEFINE FTP_TRANSFER_TYPE_ASCII         1
#DEFINE FTP_TRANSFER_TYPE_BINARY        2
*** Declaración de funciones
DECLARE INTEGER FtpPutFile IN "wininet.dll" ;
	LONG     hFtpSession, ;
	STRING   lpszLocalFile, ;
	STRING   lpszNewRemoteFile, ;
	LONG     dwFlags,;
	LONG     dwContext

Declare Integer FtpSetCurrentDirectory IN "wininet.dll" ;
	Long     hFtpSession, ;
	String   lpszDirectory
		
lcCarpetaOrigen  = lObjftp.CarpetaOrigen
lcArchivoOrigen  = lObjFtp.ArchivoOrigen

lcCarpetaDestino = IIF(LEFT(lObjFtp.CarpetaDestino,1)="/",SUBSTR(lObjFtp.CarpetaDestino,2),lObjFtp.CarpetaDestino)
lcArchivoDestino = lObjFtp.ArchivoDestino

lcFtpServer      = lObjFtp.Server
lcFtpcuenta      = lObjFtp.cuenta
lcFtpclave       = lObjFtp.clave

LOCAL lcStringO,lcStringD,lestadoGet,lcArroba

*** Apertura del API
nInternet = InternetOpen("vfp",INTERNET_OPEN_TYPE_DIRECT, "", "", 0 )
IF nInternet = 0
	RETURN .f.
ENDIF
*** Conexión con el servicio FTP

nFtp = InternetConnect(	nInternet, lcFtpServer , INTERNET_DEFAULT_FTP_PORT, lcFtpcuenta, lcFtpclave, INTERNET_SERVICE_FTP, INTERNET_FLAG_PASSIVE, 0 )
IF nFtp = 0
	RETURN .f.
ENDIF

lcStringO = LOWER(ALLTRIM(lcCarpetaOrigen) + IIF(RIGHT(ALLTRIM(lcCarpetaOrigen),1)="\","","\") + ALLTRIM(lcArchivoOrigen))

lcStringD = LOWER(ALLTRIM(lcArchivoDestino))

lcStringCarpeta = LOWER(ALLTRIM(lcCarpetaDestino)) &&+IIF(RIGHT(ALLTRIM(lcCarpetaDestino),1)="/","","/"))

lnftpPut = 0
IF lObjFtp.operacion=2   && grabar
	IF LEN(ALLTRIM(lcCarpetaDestino))#0
		lnftpPut = FtpSetCurrentDirectory( nFtp, lcStringCarpeta )
	ENDIF  		
	IF lnftpPut=1
		lnftpPut = FtpPutFile(	nFtp, lcStringo, lcStringD, FTP_TRANSFER_TYPE_BINARY , 0)
	ENDIF 		
ENDIF 

*** Cierre de la conexión FTP
InternetCloseHandle( nFtp )
*** Cierre del uso del API
InternetCloseHandle( nInternet )

RETURN IIF(lnftpPut=1,.t.,.f.)

ENDFUNC 

Procedure Verifica_OCX
* CHECKOCX.PRG
* Programa para checar si estan registrados los controles OCX necesarios
* Junio, 22, 2004.
*
*
* Necesitamos tener una variable en alguna parte para saber si ya esta registrado o no…
* MOD: 14,Mayo,2008… Agregamos una funcion para detectar primero si el OCX esta registrado.
*       En caso de no estarlo debemos hacerlo.
*
* Checando si los controles ActiveX necesarios para el sistema estan registrados
*
* Listado con todos los con todos los controles OCX necesarios.
* Poner en el array tantos OCX como necesite el sistema. Este numero debera ser pasado
* mas adelante para el proceso.
*
* El array necesita 2 dimensiones o columnas, ya que la segunda correspondera al
* archivo fisico OCX y en donde se encuentra si es que esta en una subcarpeta.
* Ejs.
*  lstOCX(1,1) = "ctdropdate.ctdropdatectrl.2"
*  lstOCX(1,2) = "ctdropdate.ocx"
*   o
*  lstOCX(1,2) = "OCX\ctdropdate.ocx"
*
* Tambien usaremos una variable de parametro para hacer 1 de 3 cosas:
* 1) Check = Checar si el control esta registrado o no y registrarlo en su caso
* 2) RegALL = Registrar el control aunque ya estuviera registrado
* 3) UnRegALL = Desregistrar el control.
*
* La razon de estas opciones es que para aplicaciones portables necesitaremos desregistrar el control
* para que no quede huella en el sistema Host.
*
Parameters cOpcion
If Parameters() = 0
	Return
Endif

Dimension lstOCX(5,3)
lstOCX(1,1) = "SSubTimer6.Gsubclass"
lstOCX(1,2) = "SSubTmr6.dll"
lstOCX(2,1) ="vbalLbar6.cListBarItem"
lstOCX(2,2) ="vbalLbar6.ocx"
lstOCX(3,1) ="MSComctlLib.TreeCtrl.2"
lstOCX(3,2) ="mscomctl.ocx"
*mARCOS
lstOCX(4,1) ="HASAR.Fiscal.1"
lstOCX(4,2) ="Fiscal051122.ocx"
lstOCX(5,1) ="EpsonFPHostControlX.EpsonFPHostControl"
lstOCX(5,2) ="IFEpson.ocx"


* Hacer un ciclo con el ultimo numero que corresponde a la cantidad de OCX necesarios
* No calculamos porque nosotros le damos la cantidad
For i = 1 TO ALEN('lstocx',1)
   Do Case
	Case cOpcion = "Check"

		lCheck = OcxRegistrado( lstOCX( i, 1 ) ) && Llamamos la funcion que checa si esta registrado o no: (.T./.F.)
		If lCheck = .F.
* Si el control necesario no esta registrado en la PC, registremoslo
* Debemos pasarle a esta funcion el archivo OCX a registrar
			lRegistrado = OCXCmdReg( lstOCX( i, 2) )
*  ? "Archivo " + lstOCX( i,2) +" Ya NO ESTABA registrado. Pero ahora si lo esta"
		Else
*  ? "Archivo " + lstOCX( i,2)+ " Ya estaba registrado"
		Endif
	Case cOpcion = "RegALL"
		lRegistrado = OCXCmdReg( lstOCX( i, 2) )
	Case cOpcion = "UnRegALL"
		lRegistrado = OCXCmdUnReg( lstOCX( i, 2) )
	Endcase
Next
Return

Function OcxRegistrado(cClase)
Declare Integer RegOpenKey In Win32API ;
	Integer nHKey, String @cSubKey, Integer @nResult
Declare Integer RegCloseKey In Win32API ;
	Integer nHKey
nPos = 0
lEsta = RegOpenKey(-2147483648, cClase, @nPos) = 0

If lEsta
	RegCloseKey(nPos)
Endif

Return lEsta
Endfunc

Function OCXRegistrar(cActiveX)
Declare Integer DLLSelfRegister In "vb6stkit.DLL" STRING lpDllName
* Debemos de poner una lista de los controles
lcFileOCX = Sys(5) + Curdir() + cActiveX
*lcFileOCX = "C:\DBITECH\Toolbox6\DBITech\Component Toolbox 6.0\Components\ctlist.ocx”
liRet = DLLSelfRegister( lcFileOCX )
If liRet = 0
	SelfRegisterDLL = .T.
* MESSAGEBOX( "Registrado OCX” )
Else
	SelfRegisterDLL = .F.
	Messagebox( 'Error - No registrado OCX' )
Endif
Endfunc

Function OCXCmdReg(cActiveX)
On Error
cRun='REGSVR32 /s ' +Sys(5) + Curdir()+ cActiveX
Run /N &cRun
*=MESSAGEBOX('Se ha registrado la siguiente librería : '+Sys(5) + Curdir()+ cActiveX)
Endfunc

Function OCXCmdUnReg(cActiveX)
cRun='REGSVR32 /u /s ' + cActiveX
Run /N &cRun
Endfunc

Function ControlTerminal  && verifica si la terminal esta autorizada, si no existe, si el rigido existe, etc
Local lcCmd,lok,lcpc
Local lok,lcCursorSchema,lcUpdatablefieldlist,lcUpdateNamelist

lcpc    = Upper(Trim(Left(Sys(0),(At('#',Sys(0))-1))))

If Used("Csrseteotermi")
	Use In CsrSeteoTermi
Endif


*!*	loFSO = Createobject("Scripting.FileSystemObject")
*!*	lcSerialNumber = Ltrim(Str(loFSO.drives("c:").serialnumber ,20))
lcSerialNumber = ALLTRIM(ObtenerSerialDisck())

 
TEXT TO lcCmd TEXTMERGE NOSHOW
SELECT Csrseteotermi.* FROM seteotermi as Csrseteotermi WHERE sucursal = <<Goapp.sucursal>> and serialdisk='<<lcSerialNumber>>'
ENDTEXT
=SaveSQL(lcCmd,"CtrolTerminal")

TEXT TO lcCursorSchema TEXTMERGE NOSHOW
ID I, NUMERO N(4, 0), SUCURSAL N(4, 0), SECTOR N(3, 0), PUESTOCAJA N(4, 0), NOMBRE C(30), MODPVTA N(2, 0), GRAPMOD N(2, 0), FACSSTOCK N(2, 0)
, FACSDTO N(2, 0), FECHAREC N(2, 0), ANUGENTIL N(2, 0), TERMIACTIVA N(2, 0), PUESTOACTIVO N(2, 0), PUESTOSPOOLER N(2, 0), SERIALDISK C(30)
ENDTEXT

TEXT TO lcUpdatableFieldList TEXTMERGE NOSHOW
ID, NUMERO, SUCURSAL, SECTOR, PUESTOCAJA, NOMBRE, MODPVTA, GRAPMOD, FACSSTOCK, FACSDTO, FECHAREC, ANUGENTIL, TERMIACTIVA
, PUESTOACTIVO, PUESTOSPOOLER, SERIALDISK
ENDTEXT

TEXT TO lcUpdateNamelist TEXTMERGE NOSHOW
ID seteotermi.ID, NUMERO seteotermi.NUMERO, SUCURSAL seteotermi.SUCURSAL, SECTOR seteotermi.SECTOR, PUESTOCAJA seteotermi.PUESTOCAJA
, NOMBRE seteotermi.NOMBRE, MODPVTA seteotermi.MODPVTA, GRAPMOD seteotermi.GRAPMOD, FACSSTOCK seteotermi.FACSSTOCK
, FACSDTO seteotermi.FACSDTO, FECHAREC seteotermi.FECHAREC, ANUGENTIL seteotermi.ANUGENTIL, TERMIACTIVA seteotermi.TERMIACTIVA
, PUESTOACTIVO seteotermi.PUESTOACTIVO, PUESTOSPOOLER seteotermi.PUESTOSPOOLER, SERIALDISK seteotermi.SERIALDISK
ENDTEXT


OrsTerminal = Null
OrsTerminal = Createobject('ADODB.RecordSet')
OrsTerminal .CursorLocation   = 3  && adUseClient
OrsTerminal .LockType         = 3  && adLockOptimistic
OrsTerminal .ActiveConnection = loConnDataSource
OCaTerminal  = Createobject("CursorAdapter")


lbok = .F.
With OCaTerminal
	.Alias     = 'CsrSeteotermi'
	.Datasource = OrsTerminal
	.DataSourceType = LcDataSourceType
	.Datasource.CursorLocation   = 3  && adUseClient
	.Datasource.LockType         = 3  && adLockOptimistic
	.CursorSchema = lcCursorSchema
	.UpdatableFieldList = lcUpdatablefieldlist
	.UpdateNameList = lcUpdateNamelist
	.SelectCmd = lcCmd
	.UseDeDataSource=.F.
	.BufferModeOverride = 5
	.Name = 'SeteoTermi'
	.UpdateType = 1
	lbok=.CursorFill()  && crea el cursor y lo llena con datos
Endwith

IF lbok
	Select CsrSeteoTermi

	If Reccount("Csrseteotermi")=0
		oavisar.usuario('La terminal no se encuentra autorizada a ingresar al sistema'+Chr(13)+'Solicite la instalación del producto para la misma')
		Return .F.
	Endif


	Replace nombre With lcpc
	lbok=Tableupdate(1,.T.,"Csrseteotermi")

	If lbok
		Goapp.terminal       = CsrSeteoTermi.numero
		Goapp.nombreterminal = CsrSeteoTermi.nombre
	Endif

	If Used("Csrseteotermi")
		Use In CsrSeteoTermi
	Endif
ELSE
	oavisar.programador('No coincide estructura de la terminal')
ENDIF 
Return lbok


*********************************************************
*
* Funcion: GRABAR_LOG
*
* Graba una linea en el log (en raiz\LOG.TXT)
*
* Parametros:
*
*       tctexto   - texto a grabar
*
* Ejemplos:
*
*       ret = GRABAR_LOG("Inicio de Programa")
*
* Retorno:
*
*        .T.    Grabacion correcta
*        .F.	Error en la grabacion
*
* Nota:
*
**********************************************************
Function GRABAR_LOG

Parameters tcTexto,tcArchivo,tcCarpeta

Private plRet, pnFich, pnFichn, pnFtama, pnTammax, pnLongAc
Private pcChar, pnPos,Lcdirlog,Lcfilelog,Lcnewlog

tcArchivo=IIF(PCOUNT()<2,'Log.txt',tcArchivo)
tcCarpeta=IIF(PCOUNT()<3,'Logs',tcCarpeta)

Lcdirlog=Sys(5)+Sys(2003)+'\'+tcCarpeta
Lcfilelog=Lcdirlog+'\'+tcArchivo
LcNewlog=Lcdirlog+'\'+'New'+ALLTRIM(tcArchivo)

If !Directory(Lcdirlog)
	Md (Lcdirlog)
Endif

plRet    = .T.
pnLongAc = 0
pnTammax = 60000
pnFtama = 0

tcTexto=Dtoc(DATE())+' '+time()+' , '+tcTexto

If File(Lcfilelog)                && ¿Existe el archivo?
	pnFich = Fopen(Lcfilelog,12)  && Sí: abrir lect./escrit.
	pnFtama=Fseek(pnFich, 0, 2)                     && Mueve el puntero a EOF
&& y devuelve el tamaño
Else
	pnFich = Fcreate(Lcfilelog)   && Si no, crearlo
Endif
If pnFich < 0                                       && Comprobar el error
&& abriendo el archivo
	plRet = .F.
	Wait 'No puedo abrir o crear el archivo de salida (fich)' Window Nowait
Else                                                && Si no hay error,
&& escribir en el archivo
	If pnFtama > pnTammax                           && Si el tamaño es mayor que el max
		pnFichn = Fcreate(Lcnewlog)    && Crear nuevo log
		If pnFichn < 0
			Wait 'No puedo abrir o crear el archivo de salida (fichn)' Window Nowait
		Else
			pnPos = Fseek(pnFich, -(pnTammax - 256), 1)
			pcChar = Fread(pnFich, 1)
			Do While pcChar <> Chr(10)
				pcChar = Fread(pnFich, 1)
			Enddo
			pnPos = Fseek(pnFich, 0, 1)
			Do While Not(Feof(pnFich))
				= Fputs(pnFichn,Fgets(pnFich))
			ENDDO
			
			=Fclose(pnFich)
			=Fclose(pnFichn)
			
			Delete File &Lcfilelog
			Rename &Lcnewlog To &Lcfilelog
			pnFich = Fopen(Lcfilelog,12)
			pnFtama=Fseek(pnFich, 0, 2)
		Endif
	Endif
	=Fputs(pnFich, tcTexto)
Endif
=Fclose(pnFich)                                    && Cerrar archivo

Return plRet