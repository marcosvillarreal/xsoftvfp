PARAMETERS ldVACIO,lcpath,lcBase
LOCAL lcfecha,lnid,lcData
ldvacio = IIF(PCOUNT()< 1,"01-01-1900",DTOC(ldvacio))
lcpath = IIF(PCOUNT()<2,"C:\temporal\cpostal","")
lcData = IIF(PCOUNT()<3,"Data",lcBase)

DO setup
SET PROCEDURE  TO  proc.prg ADDITIVE  && Procedimientos generales
SET PROCEDURE  TO  syserror.prg ADDITIVE  

SET SAFETY OFF

Oavisar.proceso('S','Vaciando archivos') 

SET CPCOMPILE TO 1252
codepage = 1252
SET CPDIALOG ON

OPEN DATABASE ? EXCLUSIVE
IF !DBUSED(lcData)
	oavisar.usuario("No se encontro la base de datos "+UPPER(lcData))
	EXIT 
ENDIF 

SET DATABASE TO &lcData
	
llok = .t.
llok = CargarTabla(lcData,'Provincia')
llok = CargarTabla(lcData,'Localidad',.t.)

CREATE CURSOR CsrAuxLocalidad (nombre c(30), cpostal c(30),detalle c(20))
CREATE CURSOR CsrAux (DETALLE c(80))

fso = CREATEOBJECT("Scripting.FileSystemObject")
lcnuevo = ALLTRIM(lcpath)+ALLTRIM("\Prov.txt")	
SET SAFETY ON 
IF !llok
	RETURN .f.
ENDIF

lnArchivos = ADIR(laProvincias,ALLTRIM(lcpath)+ALLTRIM("\*.txt"))
lnid	= RecuperarId('CsrLocalidad',goapp.sucursal10)

IF lnArchivos>0
	FOR i=1 TO lnArchivos
		lcarchivo = ALLTRIM(lcpath)+ALLTRIM("\"+laProvincias[i,1])
		SET SAFETY OFF 
		SELECT CsrAuxLocalidad
		ZAP 
		SELECT CsrAux
		ZAP 
		SET SAFETY ON 
		IF !fso.FileExists(lcarchivo)
			oavisar.usuario('Nose Encontro el archivo en '+lcarchivo)
		ELSE
			fso.CopyFile(lcarchivo,lcnuevo)
			SELECT CsrAux
			append from &lcnuevo SDF 
			replace ALL detalle WITH STRTRAN(detalle,'"','')
			SET SAFETY OFF 
			COPY TO &lcnuevo SDF 
			SET SAFETY ON 
    		sele CsrAuxLocalidad
    		append from &lcnuevo DELIMITED WITH TAB FIELDS nombre,cpostal,detalle
    		filede = fso.GetFile(lcnuevo)
    		filede.delete   
		ENDIF
		IF RECCOUNT('CsrAuxLocalidad')#0
			oavisar.proceso('S','Procesando localidades de '+STRTRAN(laProvincias[i,1],'.TXT',''))
			lnidprovincia = 0			
			SELECT CsrProvincia
			LOCATE FOR STRTRAN(laProvincias[i,1],'.TXT','')$UPPER(CsrProvincia.nombre)
			IF STRTRAN(laProvincias[i,1],'.TXT','')$UPPER(CsrProvincia.nombre)	
				lnidprovincia = CsrProvincia.id
			ENDIF 
			IF lnidprovincia#0
				SELECT CsrAuxLocalidad
				GO TOP 
				SCAN 
					lccpostal = STR(VAL(CsrAuxLocalidad.cpostal),5)
					lcnombre = ALLTRIM(CsrAuxLocalidad.nombre)
*!*						IF 'CUARTEL'$lcnombre
*!*							oavisar.proceso('N')
*!*							DEBUG
*!*							SUSPEND 
*!*						ENDIF 
					IF STRTRAN(laProvincias[i,1],'.TXT','')$'CAPITAL' 
						lccpostal = STR(VAL(CsrAuxLocalidad.NOMBRE),5)
						lcnombre = ALLTRIM(CsrAuxLocalidad.cpostal)
					ENDIF 
					IF VAL(lccpostal)=0 AND VAL(CsrAuxLocalidad.detalle)#0
						lccpostal = STR(VAL(CsrAuxLocalidad.detalle),5)
					ENDIF 
					SELECT CsrLocalidad
					LOCATE FOR ALLTRIM(cpostal)=ALLTRIM(lccpostal) AND ALLTRIM(nombre)=ALLTRIM(lcnombre)
					IF ALLTRIM(cpostal)=ALLTRIM(lccpostal) AND ALLTRIM(nombre)=ALLTRIM(lcnombre)
						SELECT CsrAuxLocalidad
						LOOP 
					ENDIF 	
					INSERT INTO Csrlocalidad (id,cpostal,nombre,idprovincia);
					VALUES (lnid,lccpostal,lcnombre,lnidprovincia)
					lnid = lnid +1
				ENDSCAN 
			ENDIF 
		ENDIF 
	ENDFOR 
ENDIF 
SELECT CsrLocalidad

Oavisar.proceso('N') 
=MESSAGEBOX('Proceso terminado! ')
CLOSE tables
CLOSE INDEXES
CLOSE DATABASES