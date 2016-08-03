FOXYPREVIEWER - Report preview utility - Version 2.15 - 2011-02-10
--------------------------------------------------------------------
Created by Cesar Ch
	vfpimaging@hotmail.com
	http://weblogs.foxite.com/vfpimaging


Features

- Preview miniature of pages
- Save to image files (Bmp, Png, Tiff, Emf, Jpeg or Gif)
- Save to HTML, PDF, RTF OR XLS
- Specify the quantity of pages to be printed
- Change the printer on the fly
- Translate all dialogs, captions and tooltips to other languages than English 



This class uses some terrific tools created by other Foxers, that were provided as free and open source. 
These tools have received some tweaks and fixes in order to work in "FoxyPreviewer" and to support its features.

1 - PDFListener (for the PDF output)
	by Luis Navas
	PDFx Update Support for some SP2 Features
	http://weblogs.foxite.com/luisnavas/archive/2008/10/06/7025.aspx

2 - RTFListener (for the RTF output)
	by Vladimir Zhuravlev
	http://www.foxite.com/downloads/default.aspx?id=166

3 - Proof Miniatures sheet
	by Colin Nicholls
        published in the article:
	Exploring and Extending Report Previewing in VFP9
	http://spacefold.com/colin/archive/articles/reportpreview/rp_extend.html

4 - Accessing the Printer settings window
	by Barbara Peisch posted in Foxite forum
	* http://www.foxite.com/archives/0000158197.htm

5 - ExcelListener (for the XLS output)
	by Alejandro Sosa
	http://www.portalfox.com/index.php?name=News&file=article&sid=2322&mode=nested&order=0&thold=0
	http://www.universalthread.com/Report.aspx?Session=34485849353954544C2B4D3D204A377A5466623943753451502B72453358567A7544745843317A333869724B65



6 - License for the PDF Library - used in the PDFListener by Luis Navas

* << Haru Free PDF Library 2.0.8 >>
*
* URL http://libharu.sourceforge.net/
*
* Copyright (c) 1999-2006 Takeshi Kanno
*
* Permission to use, copy, modify, distribute and sell this software
* and its documentation for any purpose is hereby granted without fee,
* provided that the above copyright notice appear in all copies and
* that both that copyright notice and this permission notice appear
* in supporting documentation.
* It is provided "as is" without express or implied warranty.


Update History
===========================================

Version 1.05 -  2010-02-01
-------------------------------------------
•Included translation to German (Tom Knauf)
•Fixed toolbar regeneration when user closed thetoolbar using the "X" button (Bernard)
•Now compatible with VFP9 1st release and SP1 (SP2 strongly recommended) (Everybody :-D)


Version 1.06 -  2010-02-02
-------------------------------------------
•Tweaked German translation (Stefan Wuebbe)
•Fixed GotoPage dialog not working when toolbar was not visible (Vivek Deodhar)
•Fixed Default printer in Combobox (Bernard)


Version 1.07 -  2010-02-03
-------------------------------------------
•Included Turkish translation (Soykan Ozcelik)
•Fixed RTF Listener was omitting 1st page when Range clause was used (Benny Thomas)
•Fixed Property "lSaved" now becomes True when an image file is saved (Benny Thomas)


Version 1.08 -  2010-02-04
-------------------------------------------
•Included Italian translation (Fabio Lenzarini)
•Fixed Network printing (Paco)
•Fixed method RunReport, missing "This" in some lines of code (Benny Thomas)
•Fixed RTFListener colors initialization, thanks to Hector Urrutia
•Removed the "NORESET" clause on merged reports. Users should add it by themselves in case they need.
•Renamed the ReportListener classes 
    (PDFx became PR_PDFX and FRX_RTF became PR_RTFListener), 
    in order to avoid people messing with the original versions from the authors.
    The versions distributed with FoxyPreviewer are tweaked ones
•Included a sample project, for you to create a testing EXE from it. Just double-click the SampleDistrib.Pjx file and compile the EXE.


Version 1.09 -  2010-02-05
-------------------------------------------
•Fixed Network printing again (Paco)
•Tweak for context menu translation
•Added support for TopLevel forms, and when using the "NOWAIT" clause.


Version 1.10 -  2010-02-07
-------------------------------------------
•Fixed forced preview close (Vivek Deodhar)
•Included new "Printer preferences" button (using codes from Barbara Peisch)


Version 1.10a -  2010-02-08
-------------------------------------------
•Fixed "lPrintVisible" property error (Zen Tes)
•Included new "Printer preferences" item in context menu


Version 1.11 -  2010-02-09
-------------------------------------------
•Fix: Automatically setting SET("PATH") AND SET("PROCEDURE") to avoid compiling errors
•Fix: Context menu now works normally when the toolbar is invisible.


Version 1.15 -  2010-02-10
-------------------------------------------
•Fix: Context menu now works normally in Top-Level forms. 
•MAJOR CHANGE: Now distributing a separate APP file that is a library that contains ALL the required files for FoxyPreviewer to run properly, including: LibHaru.dll, _GdiPlus.vcx, _ReportListener.vcx, FoxyPreviewer classes, PDFx, RTFListener, and all support images. This post will be updated soon, with more detailed information about these changes.


Version 1.16 -  2010-02-13
-------------------------------------------
•Fix: TopForm property 
•Fix: Now the _ReportPreview cache will be always cleared to avoid errors during toolbar rebuilding
•Many tweaks in the _ReportPreview factory


Version 1.18 -  2010-02-18
-------------------------------------------
•Fix: RTFListener now works correctly when _PageTotal is used
•Improvement: PDFxListener now works with all kinds of images
•Improvement: PDFxListener now draws transparent shapes


Version 1.18a -  2010-02-19
-------------------------------------------
•Improvement: RTFListener now accepts CMYK Jpeg images


Version 1.20 -  2010-02-21
-------------------------------------------
•Improvement: PDFListener now draws backgrounds for fields and labels
•Improvement: RTFListener now draws backgrounds for fields and labels
•New feature: Basic Excel output available (Using ExcelListener by ALejandro Sosa)

•Important - Excel listener, differently from PDF and RTF listeners is being provided as is.
   I will not support new features or improvements to this listener. As it is open source,
   feel free to add your improvements and fixes. I'll be happy to update the version distributed
   with FoxyPreviewer if you send it to me.
   Using version 1.02 from UT, having disabled the automatic file opening after generation, and also removed the CTL32 Progressbar


Version 1.21 -  2010-02-22
-------------------------------------------
•Fix: Enlarged label size for RTF output
•Fix: Included file "FrxPreview.H" in distribution (needed by ExcelListener)
•Tweak: Removed progress dialogs in spanish. All listeners have all progress dialogs disabled
•New properties:
   * Output types allowed in the "Save as.." button from the toolbar
   * .lSaveAsImage		= .T.
   * .lSaveAsHTML		= .T.
   * .lSaveAsRTF		= .T.
   * .lSaveAsXLS		= .T.
   * .lSaveAsPDF		= .T.

   * Defining the previewform.WindowState
   * 0 = Normal, 2 = Maximized
   * .nWindowState = 2 && Maximized


Version 1.22 -  2010-02-23
-------------------------------------------
•Improvement: New property: nDockType (see description below) 
	nDockType	= .F. && false MEANS TO KEEP THE CURRENT DOCK SETTINGS FROM THE RESOURCE
	*!*		–1 Undocks the toolbar or form.
	*!*	 	 0 Positions the toolbar or form at the top of the main Visual FoxPro window.
	*!*		 1 Positions the toolbar or form at the left side of the main Visual FoxPro window.
	*!*		 2 Positions the toolbar or form at the right side of the main Visual FoxPro window.
	*!*		 3 Positions the toolbar or form at the bottom of the main Visual FoxPro window.

•Improvement: New PRG, FoxyPreviewerCaller.Prg, to be included in the EXE. It allows using embedded reports in the EXE, using the APP file. TO be better documented soon. See sample in downloads file. 
   To use FoxyPreviewer.App, now you need to use the file FoxyPreviewerCaller.Prg, and incude it in your project.
   That's the only file you need to include. Apart from that, distribute the file FoxyPreviewer.App

   The usage is slightly different, but still super easy, instead of using the FoxyPreviewer class from the app, we'll use the one from the helper PRG. See also the TestForm.Scx, in the new button, "From EXE". The samples project now is including a report in the EXE:


	SET PROCEDURE TO FoxyPreviewerCaller.prg ADDITIVE 

	LOCAL loReport as "FoxyPreviewerCaller" OF "FoxyPreviewerCaller.Prg"
	loReport = CREATEOBJECT("FoxyPreviewerCaller")

	WITH loReport as FoxyPreviewerCaller 
		.AddReport("Sample.frx", "RANGE 1,1 NODIALOG")
		.RunReport()
	
		DO CASE
		CASE .lPrinted	
			MESSAGEBOX("Report was printed !",64, "Report status")

		CASE .lSaved
			MESSAGEBOX("Report was saved as file:" + CHR(13) + .cDestFile,;
				64, ;
				"Report status")

		OTHERWISE
			MESSAGEBOX("Report Preview was closed without saving or printing",48, "Report status")
		ENDCASE
	ENDWITH



Version 1.23 -  2010-02-28
-------------------------------------------
•New tweaks for Top-Level forms - now the parent form will have its "Closable" property set as false during report preview, and reset on preview release
•Fixes in RTF and PDF Listeners, now images with Isometric settings correctly rendered.  


Version 1.23a -  2010-02-28
-------------------------------------------
•Fix in PDF Listeners, GIFs were not correctly rendered.  


Version 1.24 -  2010-03-04
-------------------------------------------
•New "Printing Preferences" form, that allows selecting the range of pages to be printed, copies. It is activated by the old "Priting Preferences" button. A button was included in this new form to change the printer preferences.
•New "Send to Email" button available
•New Property : "cFormIcon" the file name of the icon to be used in the preview and other helper forms
•New Property : "lEmailAuto" Automatically generates the report output file
•New Property : "cEmailType" the file type to be used in Emails (PDF, RTF, HTML or XLS)
•New Property : "lEmailed"   Returns TRUE if an email has been sent


Version 1.24b -  2010-03-06
-------------------------------------------
•The "Priting Preferences" button now activates the "PRINTER PROMPT" dialog, that enables users to change the current printer, and all available settings. This provides the maximum customization.
•Included a new file - FoxyPreviewer.H, that contains the localized constants for the strings.
•Included the CZECH and PERSIAN localized strings in FoxyPreviewer.H. Now we have translations for 8 languages available.
•New Property : "cCodePage" && Default = "CP1252", CodePage, to be used by PDF Listener
•Updated FOxyPreviewerCaller.Prg to accept the new properties


Version 1.25 -  2010-03-28
-------------------------------------------
•Fix: HTML output now works correctly in EXE.
•Fix: Turned off SetConsole during PDF generation
•New Property : "lQuietMode" && Default = .T., determines the QuietMode property for the listeners used
•New Property : "lPDFasImage" && Default = .F., the PDF document will be an image document
•Included the GREEK localized strings in FoxyPreviewer.H. Now we have translations for 9 languages available. Thanks to Nick Porfyris
•Enhancement: PDFx received some tweaks in order to generate smaller files when repeated images are used in reports. Thanks to Luis Navas


Version 1.26 -  2010-03-31
-------------------------------------------
•Fix: PDF Listener accepts GIFs
•Fix: "Save As" menu working in Top-Level forms
•Fix: PDF Listener will use Gdi+ to convert a not supported image
•Enhancement: New MAPI function to send emails
•Enhancement: The property "cDestFile" can be filled manually, in order to generate output files without previewing


Version 1.26b -  2010-04-02
-------------------------------------------
•Fix: EXCEL Listener destination output file fixed


Version 1.30 -  2010-04-26
-------------------------------------------
•Fix: "Save As" menu working in all kinds of forms ? Thanks to Tushar


Version 1.31 -  2010-04-28
-------------------------------------------
•Fix: "SET TALK ON" bug in SP2 reporting bypassed. Now PDF and HTML outputs will not dirty the console
http://cathypountney.blogspot.com/2009/04/set-talk-appears-to-be-on-when-running.html


Version 1.35 -  2010-06-10
-------------------------------------------
•Fix: "AddReport()" bug, was not allowing chained reports, thnks to Craig Boyd 
•Feature: New property - "lUseListener", when .F., REPORTBEHAVIOR will be set to 80 (old way), to generate good printings on dot-matrix printers.


Version 1.40 -  2010-06-13
-------------------------------------------
•Improvement: "lUseListener()" tweaked
•Improvement: new internal function to detect if the output printer is Dot-Matrix type; 
   if positive, the report will be sent to the printer using REPORTBEHAVIOR 80
•Improvement: Lots of cool tweaks from Jacques Pepere, specially in the miniatures form, 
   allowing to have all available pages miniatures
•Improvement: French translation from Jacques Pepere   
•Improvement: New property "cEmailPRG"
   Character, receives the nme of a PRG tht will fire your custom email.
   In this PRG, you need to receive one parameter, ec tcFIle, that is the temporary output file
   that you'll send by email.    
   A complete sample, "MYSENDMAIL.PRG" is available, showing you how you can send your emails
   Uses a CDOSYS class, courtesy of Sergey Berezniker
   http://www.berezniker.com/content/pages/visual-foxpro/send-email-msn-email-account
   http://www.berezniker.com/content/pages/visual-foxpro/cdo-2000-class-sending-emails

•Fix: A bug in the ReportListener class was setting TALK ON, in the PDF generation.


Version 1.41 -  2010-06-14
-------------------------------------------
•Fix: ExcelListener now renders "&" characters correctly
•Improvement: New parameter allowed in method "AddReport(tcFRX, tcClauses, tcAlias)", allowing specifying the alias to be selected when the desired report will be executed.
•Tweak: Miniatures form will not show the nvigtion buttons when the quantity of pges will not exceed the existing quantity of pages. (by Jacques Parent)


Version 1.42 -  2010-06-15
-------------------------------------------
•Fix: AddReport() new tweaks, thanks to Carlos Morandin
•Fix: Additional verification in PDF Listener in analyzing "Dynamics" properties
•New property: PDFnPageMode, numeric, Default = 0, 0 = Normal view, 1 = Show the outlines pane, 2 = Show the thumbnails pane, 3 = Full Screen
•Improvement: Included support for labels (LBX) in FoxyPreviewerCaller.prg, thanks to Nick Porfyris


Version 1.43 -  2010-06-16
-------------------------------------------
•Fix: Page# will appear translated in the Preview Form titlebar


Version 1.45 -  2010-06-19
-------------------------------------------
•Fix: Property "lPrinted" now returns the correct value if user selected the "Printer Prompt" dialog (Printer preferences button), thanks to Martin Krivka
•Updated Greek translation
•Improvement: Now the preview title bar displays: "Page - PageTotal" when user selectes 1Page mode i.e.: "Page 5 - 1500" or: "Pages from %FP% to %LP%" when user selectes 2Page or 4Page mode i.e.: "Pages from 5 to 6" or "Pages from 5 to 8", thanks to Nick Porfyris


Version 1.49 -  2010-06-30
-------------------------------------------
•Improvement: Included the "PrinterPreferences" button to the Default Preview Toolbar, the one used without calling FoxyPreviewer.
•New translations, Polish and Indonesian, thanks to Kazimierz Pszenny and Samir H.
•Improvement: Allows using bigger icons, such as 32x32
•Replaced original icons due to some doubts about licensing, now using icons from www.pixel-mixer.com, that are free to use for commercial use.
•New definitions in FoxyPreviewer.H allow you to change the name of the image buttons to be used.


Version 1.51 -  2010-07-07
-------------------------------------------
•New Property: "cLanguage" - Character, the language, may be one of the following: 
   English (default), PORTUGUES, ESPANIOL, GERMAN, TURKISH, ITALIANO, CZECH, PERSIAN, GREEK, FRENCH, POLISH, INDONESIAN
   Notice that I removed all the translations from FoxyPreviewer.H
   There I only kept information about the default language to be selected. This is to be used if you use FoxyPreviewer to set the global variable "_REPORTPREVIEW"



Version 1.52 -  2010-07-08
-------------------------------------------
•Several small fixes in Report title (was showing "TMP_") and FoxyPreviewerCaller.prg



Version 1.53 -  2010-07-09
-------------------------------------------
•Several tweaks in translations
•GoToPage form translations activated
•Removed the exibition of the FRX nme if using the cTitle property
•Changed all buttons to use the property SpecialEffect = 2, in order to keep the same appearance of the original report toolbar
•Updated samples, using translated versions



Version 1.60 -  2010-07-19
-------------------------------------------
•Fix: ExcelListener was raising an error when the report used the _PAGETOTAL variable
•Fix: When the Miniatures form was minimized the miniaturesdid not show 
•Renamed property: Old name: PDFnPageMode; New name: nPDFPageMode


•New Property: "lShowPrinters" - Logical, determines if the available printers combo will be shown
•New Property: "nShowToolbar"  - Numeric, determines the visibility of the toolbar
	&& 1 = Visible (default), 2 = Invisible, 3 = Use resource
•New Property: "lShowSetup" - Logical, determines if the FoxyPreviewer setup button will be shown
•New Property: "nMaxMiniatureDisplay" - Numeric, the number of miniature to display in the miniature form
•New Property: "nShowToolBar" - numeric, determines if the toolbar will be visible or not at startup
               && 1 = Visible (default), 2 = Invisible, 3 = Use resource
•New Property: "lShowSetup" - logical, determines if the setup button will be shown
•New Property: "lShowPrinters" - logical, determines if the available printers combo will be shown


•Other New Properties: for Email sending using CDOSYS
	nEmailMode          && 1 = MAPI, 2 = CDOSYS, 3 = Custom procedure
	cSMTPServer   
	nSMTPPort     
	lSMTPUseSSL   
	cSMTPUserName 
	cSMTPPassword  
	cEmailTo      
	cEmailSubject 
	cEmailBody    
	cEmailFrom

•New dialog forms:
       "Settings", allow user to define most of the available settings for the current and next session of Foxypreviewer
       "Send Email" Form allowing user to pass email information

•When the user chooses to save as "XLS", it will allow saving using the XML extension, because the output file will be able to be opened by other tools, such as OpenOffice.
•Tweaks in the sample distribution project, to adapt it to the new changes.



Version 1.61 -  2010-07-20
-------------------------------------------
•Fix: RTF and PDF Listeners now work with basic rounded shapes
•Fix: FoxyPreviewerCaller.Prg cleanup improved, now PAPERSIZE and ORIENTATION are kept when the EXPRE cleanup is done (Thnaks to Nick Porfyris)



Version 1.70 -  2010-07-22
-------------------------------------------
•Several improvements on the settings form
•New downloads page at CodePlex



Version 1.71 -  2010-07-24
-------------------------------------------
•Updated the Localizations table in order to update the new settings form
•New property: nButtonSize - Numeric, 1 = Small - 16x16 pixels (default), 2 = Big - 32x32 pixels



Version 1.72 -  2010-07-26
-------------------------------------------
•Updated the Localizations table with the German and Indonesian translations, thanks to Stefan Wuebbe and Samir H.
•Fix: the toolbar will be disabled when the Settings form will be called
•Fix: fix in the language assignment and initialization



Version 1.73 -  2010-07-27
-------------------------------------------
•Updated the Localizations table with the Spanish, Czech, Turkish and Arabic translations, Juan Antonio Santana and RIck Castro, MArtin Krivka, Soykan Ozcelik and Dany Eid
•Fix: FoxyPreviewerCaller.Prg adapted to work with the new settings possibilities


Version 1.75 -  2010-07-28
-------------------------------------------
•Updated the Localizations table with the French, Persian, Greek - Thanks to Michel Levy, Ali Hosein Zadeh, Nick Porfyris
•Improvement: Included CodePage in LOCS table to automatically create PDFS according to the local language - by Nick Porfyris.
•Improvement in class initialization.
•New "LocalLanguage" field, storing the local name used for the language


Version 1.77 -  2010-08-09
-------------------------------------------
•Updated Greek localization table
•Fix: Settings form translation was failing in some situations
•Fix: ExcelListener was generating wrong numeric values if SET("POINT")=","



Version 1.80 -  2010-08-26
-------------------------------------------
•New exporting options: TXT, CSV and XL5
•New CDO email options

•New Properties / improvements
* by Mauricio Braga
 - lSaveAsTXT    - logical, allows saving to TXT, CSV or XL5
 - cOutputPath   - character, determines the output path the user wants the reports to be saved

* by Jacques Parent
 - lAutoSendMail - logical, allows to directly send e-mail with no preview display
 - lDirectPrint  - logical, directly send to printer with no preview display
 - lSilent       - logical, makes FoxyPreviewer completely silent for report errors
 - cError        - character, the errors occurred
 - cEmailCC, cEmailBCC, cEmailReplyTo - character, for the CDO email type

 - In CDO email type: Included the auto detection of HTML body or TEXT body (if text begins with <HTML>)
 - In CDO email type: Included the auto detection for the anonymous connection to the e-mail server (No user and password)



Version 1.81 -  2010-08-28
-------------------------------------------
•Fix in ReportPreview initialization
•Several internal tweaks, with small gain of performance


Version 1.83 -  2010-09-01
-------------------------------------------
•New property: lShowSearch  && logical, determines if the Search buttons will be visible



Version 1.85 -  2010-09-04
-------------------------------------------
•Improved search engine, many fixes, new customized search form



Version 1.89 -  2010-09-08
-------------------------------------------
•Improved search engine, updated strings localization table



Version 1.91 -  2010-09-12
-------------------------------------------
•Updated the localizations table
•Improved search engine, included the "search backwards" feature
•Improved Report factory initialization. From now on, to change the appearance of all your reports all you have to do is:
     DO LOCFILE("FOXYPREVIEWER.APP")
•Default reports using the new factory now allow searching texts and sending emails with image attachments



Version 1.92 -  2010-09-14
-------------------------------------------
•Updated the localizations table
•Improved search buttons are now inside a container in the toolbar, to force them to be side by side
•New Property: nPrinterProptype - Numeric, determines the type of Printer option dialog that will be fired.
        1 - The original "PRINTER PROMPT" report dialog
        2 - The Current printer preferences dialog.
    Some users complained that the dialog #1, although very complete, was not behaving as desired, because clicking the "cancel" button
    was closing the preview. The Option #2 was revived to solve this. It will show you only the current printer settings dialog. If you 
    click "Cancel" there the Preview will come back to the scene.
•Updated FoxyPreviewerCaller.prg
•Updated the settings form with a new control for the new property above
•Updated partially the turkish localization table (Ozcelik)
•Renamed the public variable "goHelper" to "_goHelper" (Krivka)
•Updated PDFx Listener (Parent)



Version 1.93 -  2010-09-19
-------------------------------------------
•Updated the localizations table, for the Greek, French and Turkish languages
•New updates to the PDFx Listener (Parent)
•New updates to the ExcelListener allowing non default Set POINT and SEPARATOR options (Jaketon)
•Fix in "lDirectPrint" property
•New Property: cSaveDefName && Character, lets me specify the file name for the SAVE AS instead of taking the report name. (by Jacques Parent)
•Fix in FoxyPreviewerCaller.Prg - by default it will clear the printer specific settings, except ORIENTATION and PAPERSIZE
•cDefaultListener property now will pass a successor listener to be used
•Introduced the new Global object to control certain behaviors in the default report toolbar behavior:
   When you "DO FOXYPREVIEWER.APP", it will add a new property to the _Screen object, with the following properties:
   _Screen.oFoxyPreviewer.lQuietMode && Logical, determines if QuietMode will be used, omitting the ProgressBar during report generation
   _Screen.oFoxyPreviewer.cSuccessor && Character, the name of the Successor Listener class to be used in all reports
   _Screen.oFoxyPreviewer.lShowSetup && Logical, determines if the Settings button will be shown in the toolbar
   _Screen.oFoxyPreviewer.lShowSearch   && Logical, determines if the Search button will be shown in the toolbar



Version 1.94 -  2010-09-20
-------------------------------------------
•Several small tweaks, to avoid some errors, when a dialog was closed



Version 1.96a -  2010-09-25
-------------------------------------------
•Full justify feature enabled for all kinds of reports.
   How to use it:
   1 - Select the desired field
   2 - Right click, select the "Properties" menu
   3 - Select the "Other" tab
   4 - Click "Edit user data..." 
   5 - Include the tag <FJ> in the editbox, click ok
   6 - Run your report 

•Enhancement: Replacement of the progressbar using CTL32 (adapted code from DOrin Vasilescu)
   - New Property: "nThermType" - Numeric, 1 = Default therm (fxTherm); 2 = Enhanced therm (FoxyTherm)
                    The enhanced progressbar is the windows default progressbar, thanks to the CTL32_Progressbar class from Carlos Alloatti (www.ctl32.com.ar)
                    The implemetation is based in Dorin Vasilescu's new ReportOutput.App

•Enhancement: Now you can specify the limit of pages to be "searchable" in your reports. Users will notice a big difference of performance in big reports,
              because internally FoxyPreviewer will be storing information for every single object from the report. So, the bigger the report, the slower 
              this process will be. So, now you have a new property to allow your users to configure manually this situation.
   - New Property: "nSearchPages" - Numeric, determines the quantity of pages that will be scanned during Searches in previews. Default = -1 (all pages)

•Enhancement: The "Setup" form now can be called independently, from your own application, in order to update report settings. Some people don't want to allow
              every user to change the configurations, so now you can copy the "PR_Settings.SCX" to your project and call it directly. In the next release,
              this form will be available as an embedded class in FoxyPreviewer.App, so that you'll be able to access it directly, using "NEWOBJECT()"
              All new properties have been included in the Settings form.
              The current version number and timestamp will be available at the lower left of this dialog.

•Enhancement: New improvements in the international support (Nick Porfyris)

•Updated the localizations table, including some new strings. There are still missing some strings, this time for the new ProgressBar dialogs.

•New Property: "nVersion" - Numeric, the value for the current version
•New Property: "cVersion" - Character, detailed information about the current version
•Fix in Excel Listener, now supporting latin values ans ANSI dates
•LOTS of tweaks and small fixes



Version 1.96b -  2010-09-27
-------------------------------------------
•New progressbar included in PDF, RTF, HTML and XLS listeners
•Fix: PrintJob name fixed with the current report name
•Fix: PDFx now generates satisfactory transparent images (Jacques Parent)
•Fix: PDF output now respects the cOutputPath property (Jacques Parent)



Version 1.96d -  2010-09-28
-------------------------------------------
•Improvement - RTF Listener now supports Full justified texts
•Fix: Search buttons were not at the correct size when selected 32x32 buttons



Version 1.96e -  2010-09-29
-------------------------------------------
•Improvement - Updated localizations table to work with the new progressbar
•Fix: Missing string was included



Version 1.98 -  2010-10-06
-------------------------------------------
•Improvement - Ordinary reports now can export the outputs to PDF, RTF and XLS, apart from Images. 
   These output types are supported also for emails.
•Updated localizations table
•Improved Global initialization



Version 2.00 -  2010-11-22
-------------------------------------------
• Important fix for PDF outputs
• New Form for sending emails, based on an enhanced version of the VFP HTML editor from Frederic Steczicky, published originally at atoutfox.org
    The new the email form allows you to:
    - Generate HTML outputs for the body of your message 
    - Change the formatting, alignments, fonts, adding pictures, hyperlinks, etc... 
    - Preload an HTML 
    - Attach more files
    - Mark message as Priority 
    - Ask for read receipt
    Another cool thing is that after you click on "send", a Continuous progress bar, with the cool Marquee effect 
    (thanks to Carlos Alloatti) will appear, till the message is delivered:

• The old Email form, that could generate only plain text messages is still there, you may select it in the settings form.
• Full justified strings available, just add the tag "<FJ>" to the User field of the report 
• Improved simplified usage: 
    DO FOXYPREVIEWER.APP 
    REPORT FORM YourReport PREVIEW  
  will bring you the most important features of foxypreviewer, including the exporting to PDF, RTF and XLS
  
• To reset the report factory to the original settings:
    DO FOXYPREVIEWER.APP WITH "Release"



Version 2.01 -  2010-12-05
-------------------------------------------
• Important fix for PDF outputs by Jacques Parent
• Updated the languages table, introduced RUSSIAN and SWAHILI
• Updated the new email form with missing translations
• Email form allows removing attachments
• New property: cEmailBodyFile
      there we will save the "file path" of an HTML file...
      So when the user opens the "pr_sendmail2.scx" the "EmailBody" by default will displays the content of this HTML file


Also we can add and a new button with a caption "This body to be the default" if the user likes to change this, with another one!



Version 2.11 -  2011-01-07
-------------------------------------------
• Updated the localizations table, please update "FoxyPreviewer_locs.dbf" and send me your version !
OPENVIEWER - Open default viewer
EMBEDFONTS - Embed fonts
CANPRINT   - Allow printing
CANEDIT    - Allow edit
CANCOPY    - Allow copy
CANADDNOTE - Allow add notes
ENCRYPTDOC - Encrypt document
MASTERPWD  - Master password
USERPWD    - User password
PAGEMODE   - Page mode
PDFOPTIONS - PDF options
NORMALVIEW - Normal view
OUTLINPANE - Show the outlines pane
THUMBSPANE - Show the thumbnails pane
PDFAUTHOR  - PDF Author
PDFTITLE   - PDF Title
SYMBBARCOD - Symbol or bar codes fonts list
MASTANDUSR - Master and User passwords must be different!

BADSMTP    - Invalid SMTP email configurations
CONTINUE   - Continue anyway?
BADSETUP   - Setup inconsistency

• PDF:
- Fixed font embedding
- Convert to image texts that cant be converted or embedded (symbol or barcode fonts)
- Introduced partial error handling in PDFx
- Embed fonts in PDFx (or convert some texts to images, for the fonts determined in property cPDFEmbedFonts


• New properties:
	* PDF properties
	lPDFEmbedFonts      = .F.
	lPDFCanPrint        = .T.
	lPDFCanEdit         = .T.
	lPDFCanCopy         = .T.
	lPDFCanAddNotes     = .T.
	lPDFEncryptDocument = .F.
	cPDFMasterPassword  = ""
	cPDFUserPassword    = ""
	lOpenViewer         = .F.
	nPDFPageMode        = 1 && Default = 1, 1 = Normal view, 2 = Show the outlines pane, 3 = Show the thumbnails pane
	cPdfAuthor
	cPdfTitle
	cPdfSubject
	cPdfKeyWords
	cPdfCreator
	lPDFShowErrors
	cPDFSymbolFontsList - list of fonts that the PDF engine will convert to image. Usually symbolic and barcode fonts. pass the font names separated with a Comma. This is the internal list of fonts that will automatically converted to images:



• Errors:
SET UDFPARMS TO VALUE = OK
cDefaultListener = Ignore

_VFP.AutoYield = .T. && Specifies whether an instance of Visual FoxPro processes pending Windows events between execution of each line of user program code.
SYS(2333,1) && Enables ActiveX dual interface


• Properties that can be set directly in the ordinary mode, using the "_Screen.oFoxyPreviewer" object (their behavior is exactly the same as in the enhanced mode, these can be set using the settings form as well):
cSuccessor
lQuietMode
lShowSearch
lShowSetup
nThermType
lOpenViewer

• Fix in EMail form - BackGround color now works with the selected text
• Fix in XLS generation, now all lines, shapes and images will be ignored

 


Version 2.12 -  2011-01-30
-------------------------------------------
• Several fixes in ExcelListener: FOnt formatting, Background and foreground colors, Lines skipping incorrectly






* 2 - To change the appearance of ALL your reports automatically

* For that we are going to use a system variable new to Visual FoxPro 9.0, _REPORTPREVIEW. 
* This variable identifies a program. VFP uses _REPORTPREVIEW to identify the preview container factory application.
* This program is called by Visual FoxPro when:

* • the report engine is assisted by a ReportListener object, and 
* • the ReportListener has a ListenerType of 1, and 
* • the ReportListener does not already have an object reference assigned to its .PreviewContainer property. 

* You would not believe how much easier this is than it sounds:
DO LOCFILE("FoxyPreviewer.App")



-------------------------------------------------------------------------
TODO LIST:
-------------------------------------------------------------------------
- Allow sending the report to a Fax
- Update the SendEmail form to allow using Copy and BlindCopy emails
- Allow new Send mail form with HTML editor
- Search image big
- Embed fonts in PDFx (or convert some texts to images)


Updates for the Settings form
-------------------------------------------------------------------------
- Allow automatic email, without opening the sendmail form



MISSING TRANSLATIONS
-------------------------------------------------------------------------
1 - Could not locate the property ... in the configuration file. The settings file will be updated.
2 - To, CC and BCC all are Empty
3 - Make sure that the desired language is available in FoxyPreviewer_Locs.dbf




Version 2.15 -  2011-02-10
-------------------------------------------
• Introduced new adress book form allowing users to select presaved emails (Thanks to Soykan Ozcelik, for the idea, and first development)
   - Thanks also to Paul Mrozowsky for his Grid reorder class
• Updated the localizations table



Version 2.18 -  2011-03-01
-------------------------------------------
• Improved the adressbook feature, now working with the simplified mode, and also with tables stored in the disk
• RTF and PDF outputs now render images stored in General fields
• Improved PDF Listener in Simplified mode, allowing to print more types of texts, now we're about 99% of the possibilities.
• Improved the Excel Listener, now values that begin with a "0" are rendered as strings, not values as aoriginal