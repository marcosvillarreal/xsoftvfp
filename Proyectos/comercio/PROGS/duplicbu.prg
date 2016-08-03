IF USED('CBU')
   USE IN cbu
endif
USE cbu in 0 ALIAS cbu
SET ORDER TO CUIT   && CUIT
GO top
_cuit=cuit
skip
DO WHILE !EOF()
   IF ALLTRIM(_cuit)=ALLTRIM(cuit)
      =MESSAGEBOX(_cuit+" - "+cuit)
      cancel
   ENDIF
   _cuit=cuit
   skip
ENDDO
