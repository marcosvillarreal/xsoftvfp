@echo
cls
pkzip -ep -t  J:\Temporal\01031116.ges J:\Temporal\VALOR.tra
if not errorlevel 0 goto Error
pkzip -ep -t  J:\Temporal\01031116.ges J:\Temporal\PLAN.tra
if not errorlevel 0 goto Error
pkzip -ep -t  J:\Temporal\01031116.ges J:\Temporal\PLANCUE.tra
if not errorlevel 0 goto Error
pkzip -ep -t  J:\Temporal\01031116.ges J:\Temporal\PARAMETROS.tra
if not errorlevel 0 goto Error
pkzip -ep -t  J:\Temporal\01031116.ges J:\Temporal\NEGOCIOS.tra
if not errorlevel 0 goto Error
pkzip -ep -t  J:\Temporal\01031116.ges J:\Temporal\DEPOSITO.tra
if not errorlevel 0 goto Error
goto salir
:Error
:Salir
