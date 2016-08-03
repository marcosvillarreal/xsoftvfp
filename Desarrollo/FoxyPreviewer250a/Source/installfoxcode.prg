LOCAL lnSelect, loExc AS EXCEPTION, lcFoxCode, lcSystemFoxCode
LOCAL loData AS OBJECT
SET TEXTMERGE ON

LOCAL lcText, lcEndText, lcScript
lcText = "TEXT"
lcEndText = "ENDTEXT"

TEXT TO lcScript TEXTMERGE NOSHOW
LPARAMETERS oFoxcode
LOCAL lcPurpose

IF oFoxcode.Location = 0
   RETURN "FoxyPreview"
ENDIF

oFoxcode.valuetype = "V"

<<lcText>> TO lcScript TEXTMERGE NOSHOW
**********************************************************************
* FoxyPreview sample script
*
SET PROCEDURE TO FoxyPreviewer.prg ADDITIVE

LOCAL loReport AS ReportHelper OF FoxyPreviewer.prg
loReport = CREATEOBJECT("PreviewHelper")

WITH loReport as ReportHelper

	* Add the FRX and clauses here
	.AddReport(_Samples + "\Solution\Reports\colors.frx")
*	.AddReport(_Samples + "\Solution\Reports\wrapping.frx", "NODIALOG FOR title = [S]")


	* Optional available parameters

	.cDestFile       = ""  && the destination file (image, htm, pdf, etc)
			&& if using this property, the preview window will not open, and the 
			&& output file will be automatically generated

	.cTitle = "Report custom title" && The preview window title 

	.lSendToEmail     = .T. && adds the send to email button
	.lSaveToFile      = .T. && adds the save to file button
	.lShowCopies      = .T. && shows the copies spinner
	.lShowMiniatures  = .T. && shows the miniatures page
	.lShowSearch      = .T. && shows the search buttons
	.nCopies          = 3 && The quantity of copies to be printed
	.lPrintVisible    = .T. && shows the print button in the toolbar
	.lPrinterPref     = .T. && shows the Printer preferences button

	.nShowToolBar = 1 && 1 = Visible (default), 2 = Invisible, 3 = Use resource
	.lShowSetup  = .T.
	.lShowPrinters  = .T. && determines if the available printers combo will be shown

	* Output types allowed in the "Save as..." button from the toolbar
	.lSaveAsImage		= .T.
	.lSaveAsHTML		= .T.
	.lSaveAsRTF			= .T.
	.lSaveAsXLS			= .T.
	.lSaveAsPDF			= .T.
	.lSaveAsTXT			= .T.

	.nCanvasCount 	= 1 && initial nr of pages rendered on the preview form. 
			&& Valid values are 1 (default), 2, or 4.

	.nZoomLevel		= 5 && initial zoom level of the preview window. Possible values are:
			&& 1-10%, 2-25%, 3-50%, 4-75%, 5-100% default, 6-150% ;
			&& 7-200%, 8-300%, 9-500%, 10-whole page

	.nDockType		= .F. && Default = False - means to keep the current dock settings from the resource 
			*	–1 Undocks the toolbar or form.
			*	 0 Positions the toolbar or form at the top of the main Visual FoxPro window.
			*	 1 Positions the toolbar or form at the left side of the main Visual FoxPro window.
			*	 2 Positions the toolbar or form at the right side of the main Visual FoxPro window.
			*	 3 Positions the toolbar or form at the bottom of the main Visual FoxPro window.

	.cFormIcon = "" && the icon used in the dialogs
	.lUseListener = .T. && Determines if ReportBehavior80 will be used for printing (dotmatrix)

	.cLanguage = "SPANISH"

	.nButtonSize   = 1 && 1=16x16 pixels (default), 2=32x32 pixels


	* PDF options
	.lPDFasImage     = .F.
	.nPDFPageMode = 0 && Default = 0, 0 = Normal view, 1 = Show the outlines pane, 2 = Show the thumbnails pane


	* Email options
	.lEmailAuto = .T. 		&& Automatically generates the report output file
	.cEmailType = "PDF" 		&& The file type to be used in Emails (PDF, RTF, HTML, XML or XLS)
	.cEmailPRG  = ""
	.nEmailMode = 1          && 1 = MAPI, 2 = CDOSYS, 3 = Custom procedure

	.cSMTPServer   = ""
	.nSMTPPort     = 25
	.lSMTPUseSSL   = .F.
	.cSMTPUserName = ""
	.cSMTPPassword = ""

	.cEmailTo      = ""
	.cEmailSubject = ""
	.cEmailBody    = ""
	.cEmailFrom    = ""

	.cEmailCC 		= ""
	.cEmailBCC 		= ""
	.cEmailReplyTo	= ""

	.lAutoSendMail= .F.		&& Send an email automatically when processing the report





	* Execute the report preview
	.RunReport()
	MESSAGEBOX("Report was " + IIF(.lPrinted, "", "NOT ") + "printed !",64, "Attention !")
	* Check also .lSaved and .lEmailed

ENDWITH
loReport = NULL
RELEASE loReport
**********************************************************************
<<lcEndText>>

RETURN lcScript
ENDTEXT


TRY
	m.lnSelect = SELECT()
	m.lcFoxCode = SYS(2015)
	m.lcSystemFoxCode = SYS(2015)
	SELECT 0
	USE (_FOXCODE) AGAIN SHARED ALIAS (m.lcFoxCode)
	SELECT * FROM (m.lcFoxCode) ;
		WHERE .F. ;
		INTO CURSOR (m.lcSystemFoxCode)	READWRITE

	SCATTER MEMO NAME m.loData
	loData.Abbrev = "FoxyPreview"
	loData.TYPE = "U"
	loData.Cmd = "{}"
	loData.DATA = lcScript
	loData.CASE = "U"
	loData.SAVE = .F.

	SELECT (m.lcFoxCode)
	LOCATE FOR (UPPER(Abbrev) = "FOXYPREVIEW") and not DELETED() 
	IF EOF()
		APPEND BLANK
	ENDIF
	GATHER MEMO NAME m.loData
CATCH TO loExc
	THROW
FINALLY
	USE IN SELECT(m.lcFoxCode)
	USE IN SELECT(m.lcSystemFoxCode)
	SELECT (m.lnSelect)
ENDTRY
RETURN