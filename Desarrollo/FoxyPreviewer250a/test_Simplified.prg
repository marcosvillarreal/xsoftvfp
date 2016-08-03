DO LOCFILE("FoxyPreviewer.Prg")

* After initializing FoxyPreviewer, here are some optional properties that you can set:
*!* WITH _Screen.oFoxyPreviewer
*!*		.cSuccessor = ""
*!*		.lQuietMode  = .F.
*!*		.lShowSearch = .F.
*!*		.lShowSetup  = .F.
*!*		.nThermType  = 2
*!*		.cLocalPath  = ""
*!* ENDWITH 

*_Screen.oFoxyPreviewer.cImgPrint = GETPICT("bmp")

_Screen.oFoxyPreviewer.cTitle     = "Meu titulo customizado"
_Screen.oFoxyPreviewer.cFormicon  = "source\images\pr_mail03.ico"
_Screen.oFoxyPreviewer.nDockType  = 0
_Screen.oFoxyPreviewer.lShowClose = .T.
_Screen.oFoxypreviewer.nShowToolbar = 1 && 1=Visible, 2=Invisible

REPORT FORM LOCFILE(_Samples + "\Solution\Reports\Wrapping.frx") PREVIEW NOWAIT && RANGE 2,4
* REPORT FORM LOCFILE("Sample.frx") PREVIEW

RETURN 



REPORT FORM LOCFILE(_Samples + "\Solution\Reports\Percent.frx")  PREVIEW
REPORT FORM LOCFILE(_Samples + "\Solution\Reports\Invoice.frx")  PREVIEW
REPORT FORM LOCFILE(_Samples + "\Solution\Reports\Colors.frx")   PREVIEW
REPORT FORM LOCFILE(_Samples + "\Solution\Reports\Wrapping.frx") PREVIEW


*!*	DO LOCFILE("FoxyPreviewer.Prg")
*!*	*REPORT FORM (ADDBS(HOME(1)) + "Samples\Solution\Reports\colors.frx") PREVIEW
*!*	REPORT FORM LOCFILE("Sample.frx") FOR RECNO() < 10 PREVIEW

*!*	RETURN