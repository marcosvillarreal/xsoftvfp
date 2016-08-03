ON ERROR DO errHandler WITH ;
   ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )

LOCAL lcType
lcType = "APP"

* Adjusting paths to access the sources
LOCAL lcSrcPath
lcSrcPath = ADDBS(JUSTPATH(SYS(16))) + "Source\"
SET PATH TO (lcSrcPath) ADDITIVE 
SET PATH TO (ADDBS(JUSTPATH(SYS(16)))) ADDITIVE
SET PROCEDURE TO (lcSrcPath + "FoxyPreviewer." + lcType) ADDITIVE 

LOCAL loReport as "PreviewHelper" OF ("FoxyPreviewer." + lcType)
loReport = CREATEOBJECT("PreviewHelper")

WITH loReport as ReportHelper

SET POINT TO ","
SET DECIMALS TO 2
SET SEPARATOR TO "."

*!*	SET POINT TO "."
*!*	SET DECIMALS TO 2
*!*	SET SEPARATOR TO ","

	* .cLanguage = "DEUTSCH"

	* Available languages:
	* 	ENGLISH
	* 	PORTUGUES
	* 	ESPANIOL
	* 	GERMAN
	* 	TURKISH 
	* 	ITALIANO
	* 	CZECH
	* 	PERSIAN
	* 	GREEK 
	* 	FRENCH
	* 	POLISH
	* 	INDONESIAN

*		.AddReport("Sample.frx")
	*	.AddReport(_Samples + "\Solution\Reports\colors.frx", "range 1,1 NODIALOG")


	*	.AddReport(_Samples + "\Solution\Reports\colors.frx")
	*	.AddReport(_Samples + "\Solution\Reports\wrapping.frx", "NODIALOG FOR title = [S]")
*		.AddReport(_Samples + "\Solution\Reports\percent.frx")

*	.AddReport(_Samples + "\Solution\Reports\wrapping.frx", "NODIALOG FOR title = [S]")


* Below is an HTML to be used as a template in Emails
TEXT TO lcHTML NOSHOW 
<HTML><HEAD>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=#ffffff>
<FONT face=Verdana size=2>
To<BR></FONT>
<BR>
<BR>
<FONT face=Verdana size=2>Sincerely</FONT>
<P></P>
<BR>
<HR><STRONG>
<FONT face=Verdana size=1>FoxyPreviewer team.</FONT></STRONG>
<FONT face=Arial color=black size=1><BR>
<FONT face=Verdana>1818 Super Street&nbsp; -&nbsp; Your Home<BR>05432-030 &nbsp;- &nbsp;Your City&nbsp;- &nbsp;XX</FONT><BR>
<FONT face=Wingdings color=black size=2>(</FONT><STRONG> </STRONG>
<FONT face=Verdana>Phone: 1 11 -&nbsp;3322.2233 <BR></FONT>
<FONT face=Wingdings color=black size=2>(</FONT> 
<FONT face=Verdana>Fax:&nbsp;&nbsp; 2 11 - 3366.6656<BR></FONT>
<FONT face=Wingdings color=black size=2>*</FONT>
<A href="mailto:contact@mycompany.com"><FONT face=Verdana>contact@mycompany.com</FONT></A> </FONT>
<BR>
</HTML>
ENDTEXT

.cEmailBody = lcHTML

*	.cDestFile = "c:\teste1.pdf"

    .AddReport(ADDBS(_Samples) + "Solution\Reports\wrapping.frx")
	.AddReport(_Samples + "\Solution\Reports\colors.frx", "NODIALOG")
	*   .AddReport(_Samples + "\Solution\Reports\invoice.frx")
	*   .AddReport(_Samples + "\Solution\Reports\invoice.frx", "NODIALOG")

	* Optional available parameters
	*   .cTitle = "FoxyPreviewer Report custom title" && The preview window title 
	*	.cTitle = "FoxyPreviewer Informe traducido al espaniol" && The preview window title in spanish
	*	.cDestFile = "c:\Teste1.xls"  && Use to create an output without previewing
	*	.lUseListener = .T. && Using .F. will set ReportBehavior 80 for dot-matrix printers

	*	.lSendToEmail     = .T. && adds the send to email button
	*	.lSaveToFile      = .T. && adds the save to file button
	*	.lShowCopies      = .T. && shows the copies spinner
	*	.lShowMiniatures  = .T. && shows the miniatures page
	*	.nCopies          = 1 && The quantity of copies to be printed
	*	.lPrintVisible    = .T. && shows the print button in the toolbar
	*	.lPrinterPref     = .T.

	*	.nCanvasCount = 1 && initial nr of pages rendered on the preview form. 
			&& Valid values are 1 (default), 2, or 4.

	*	.nZoomLevel = 5 && initial zoom level of the preview window. Possible values are:
			&& 1-10%, 2-25%, 3-50%, 4-75%, 5-100% default, 6-150% ;
			&& 7-200%, 8-300%, 9-500%, 10-whole page

	*	.cEmailPRG = "MySendMail.Prg"

	*	.nShowToolbar = 1
	*	.lShowSetup = .T.

	*	.lQuietMode = .F.
	*	.nThermType = 2 && 1 = Default     2 = Enhanced


	* Output types allowed in the "Save as.." button from the toolbar
	* .lSaveAsImage		= .T.
	* .lSaveAsHTML		= .T.
	* .lSaveAsRTF		= .T.
	* .lSaveAsXLS		= .T.
	* .lSaveAsPDF		= .T.

	* Defining the previewform.WindowState
	* 0 = Normal, 2 = Maximized
	* .nWindowState = 2 && Maximized
	* .nPDFPageMode = 2 && Default = 0, 0 = Normal view, 1 = Show the outlines pane, 2 = Show the thumbnails pane, 3 = Full Screen

	Select "s@s.com" As email,* From (_samples + '\data\customer') ;
		Where .T. Into Cursor Test Readwrite

	.cAdressTable = "Test"
	.cAdressSearch = "Contact"


	.RunReport()
	
	DO CASE
	
	CASE .lPrinted	
		MESSAGEBOX("Report was printed !",64, "Report status")

	CASE .lEmailed
		MESSAGEBOX("Report was sent to email, with the attached file: " + ;
			CHR(13) + .cDestFile,;
			64, "Report status")

	CASE .lSaved
		MESSAGEBOX("Report was saved as file:" + CHR(13) + .cDestFile,;
			64, ;
			"Report status")
*		=OpenFile(.cDestFile)

	OTHERWISE
		MESSAGEBOX("Report Preview was closed without saving or printing",48, "Report status")

	ENDCASE

ENDWITH
*loReport = NULL
*RELEASE loReport

RETURN

PROCEDURE OpenFile(tcFileName)
	DECLARE INTEGER ShellExecute ;
          IN SHELL32.DLL ;
          INTEGER nWinHandle,;
          STRING cOperation,;   
          STRING cFileName,;
          STRING cParameters,;
          STRING cDirectory,;
          INTEGER nShowWindow
	RETURN ShellExecute(0, "open", m.tcFileName, "", "", 1)
ENDPROC


PROCEDURE errHandler
   PARAMETER merror, mess, mess1, mprog, mlineno
   CLEAR
   ? 'Error number: ' + LTRIM(STR(merror))
   ? 'Error message: ' + mess
   ? 'Line of code with error: ' + mess1
   ? 'Line number of error: ' + LTRIM(STR(mlineno))
   ? 'Program with error: ' + mprog
ENDPROC
