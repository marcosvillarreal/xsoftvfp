DO LOCFILE("FoxyPreviewer.App")

* To merge reports, the trick is to use the clauses
* NOPAGEEJECT NORESET

REPORT FORM LOCFILE(_Samples + "\Solution\Reports\Colors.frx") ;
	PREVIEW NOPAGEEJECT NORESET

REPORT FORM LOCFILE(_Samples + "\Solution\Reports\Wrapping.frx") ;
	PREVIEW
	