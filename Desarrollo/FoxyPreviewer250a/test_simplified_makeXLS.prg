DO LOCFILE("FoxyPreviewer.Prg")

* Make XLS
REPORT FORM ;
	(_Samples + "\Solution\Reports\Colors.frx") ;
	OBJECT TYPE 13 ; && OBJTYPE 10 = PDF , 11 = PDF AS IMAGE, 12 = RTF, 13 = XLS
	TO FILE "c:\TestReport.Xls" ; && Destination
	PREVIEW && Open the default XLS viewer	
	
*!*	* Make PDF
*!*	REPORT FORM ;
*!*		(_Samples + "\Solution\Reports\Wrapping.frx") ;
*!*		OBJECT TYPE 10 ; && OBJTYPE 10 = PDF , 11 = PDF AS IMAGE
*!*		TO FILE "c:\TestReport.Pdf" ; && Destination
*!*		PREVIEW && Open the default PDF viewer

*!*	* Make RTF
*!*	REPORT FORM ;
*!*		(_Samples + "\Solution\Reports\Wrapping.frx") ;
*!*		OBJECT TYPE 12 ; && OBJTYPE 10 = PDF , 11 = PDF AS IMAGE, 12 = RTF
*!*		TO FILE "c:\TestReport.Rtf" ; && Destination
*!*		PREVIEW && Open the default RTF viewer	
