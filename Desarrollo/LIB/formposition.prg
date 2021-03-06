FUNCTION DeletePosForm
PARAMETERS cNameForm

do setup.prg

#DEFINE AppName	ALLTRIM(goapp.initcatalo)
#DEFINE HKEY_CURRENT_USER	-2147483647


LOCAL lnKeyExist, lnTop, lnLeft, lnWidth, lnHeight, lcFormKey
lcFormKey = [SOFTWARE] + [\] + AppName + [\] + cNameForm

IF [5] $ VERSION()
	SET PROCEDURE TO HOME()+ [\SAMPLES\CLASSES\REGISTRY.PRG] ADDITIVE
ELSE
	SET PROCEDURE TO HOME(2)+ [CLASSES\REGISTRY.PRG] ADDITIVE
ENDIF

stop()
oReg = CREATEOBJECT([REGISTRY])

*!* Check for the registry key. You will receive a positive 
          *!* number if the key is not present.
lnKeyExist = oReg.OpenKey(lcFormKey, HKEY_CURRENT_USER)
oReg.CloseKey()
	
IF lnKeyExist <> 0 && The values don't exist, so let's make them.
	oReg.OpenKey(lcFormKey,HKEY_CURRENT_USER,.T.)
	lnKeyDelete = oReg.DeleteKey(HKEY_CURRENT_USER, lcFormKey)
	IF lnKeyDelete > 0
		oavisar.usuario("Error a borrar el registro de " + cNameForm)
	ENDIF 
ENDIF

oReg.CloseKey()		


ENDFUNC 