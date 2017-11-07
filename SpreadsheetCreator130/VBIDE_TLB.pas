unit VBIDE_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 17-04-2006 11:08:44 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files\Common Files\Microsoft Shared\VBA\VBA6\VBE6EXT.OLB (1)
// LIBID: {0002E157-0000-0000-C000-000000000046}
// LCID: 0
// Helpfile: C:\Program Files\Common Files\Microsoft Shared\VBA\VBA6\vbob6.chm
// HelpString: Microsoft Visual Basic for Applications Extensibility 5.3
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\System32\STDOLE2.TLB)
//   (2) v2.3 Office, (C:\Program Files\Common Files\Microsoft Shared\OFFICE11\MSO.DLL)
// Parent TypeLibrary:
//   (0) v1.5 Excel, (C:\Program Files\Microsoft Office\OFFICE11\EXCEL.EXE)
// Errors:
//   Hint: TypeInfo 'Property' changed to 'Property_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of _VBProjects.Add changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Member 'Object' of 'Property' changed to 'Object_'
//   Hint: Member 'Object' of 'AddIn' changed to 'Object_'
//   Hint: Parameter 'String' of _CodeModule.AddFromString changed to 'String_'
//   Hint: Parameter 'String' of _CodeModule.Lines changed to 'String_'
//   Hint: Parameter 'String' of _CodeModule.InsertLines changed to 'String_'
//   Hint: Parameter 'String' of _CodeModule.ReplaceLine changed to 'String_'
//   Hint: Symbol 'Type' renamed to 'type_'
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, Office_TLB, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  VBIDEMajorVersion = 5;
  VBIDEMinorVersion = 3;

  LIBID_VBIDE: TGUID = '{0002E157-0000-0000-C000-000000000046}';

  IID_Application: TGUID = '{0002E158-0000-0000-C000-000000000046}';
  IID_VBE: TGUID = '{0002E166-0000-0000-C000-000000000046}';
  IID_Window: TGUID = '{0002E16B-0000-0000-C000-000000000046}';
  IID__Windows_old: TGUID = '{0002E16A-0000-0000-C000-000000000046}';
  IID__Windows: TGUID = '{F57B7ED0-D8AB-11D1-85DF-00C04F98F42C}';
  CLASS_Windows: TGUID = '{0002E185-0000-0000-C000-000000000046}';
  IID__LinkedWindows: TGUID = '{0002E16C-0000-0000-C000-000000000046}';
  CLASS_LinkedWindows: TGUID = '{0002E187-0000-0000-C000-000000000046}';
  IID_Events: TGUID = '{0002E167-0000-0000-C000-000000000046}';
  IID__VBProjectsEvents: TGUID = '{0002E113-0000-0000-C000-000000000046}';
  DIID__dispVBProjectsEvents: TGUID = '{0002E103-0000-0000-C000-000000000046}';
  IID__VBComponentsEvents: TGUID = '{0002E115-0000-0000-C000-000000000046}';
  DIID__dispVBComponentsEvents: TGUID = '{0002E116-0000-0000-C000-000000000046}';
  IID__ReferencesEvents: TGUID = '{0002E11A-0000-0000-C000-000000000046}';
  DIID__dispReferencesEvents: TGUID = '{0002E118-0000-0000-C000-000000000046}';
  CLASS_ReferencesEvents: TGUID = '{0002E119-0000-0000-C000-000000000046}';
  IID__CommandBarControlEvents: TGUID = '{0002E130-0000-0000-C000-000000000046}';
  DIID__dispCommandBarControlEvents: TGUID = '{0002E131-0000-0000-C000-000000000046}';
  CLASS_CommandBarEvents: TGUID = '{0002E132-0000-0000-C000-000000000046}';
  IID__ProjectTemplate: TGUID = '{0002E159-0000-0000-C000-000000000046}';
  CLASS_ProjectTemplate: TGUID = '{32CDF9E0-1602-11CE-BFDC-08002B2B8CDA}';
  IID__VBProject_Old: TGUID = '{0002E160-0000-0000-C000-000000000046}';
  IID__VBProject: TGUID = '{EEE00915-E393-11D1-BB03-00C04FB6C4A6}';
  CLASS_VBProject: TGUID = '{0002E169-0000-0000-C000-000000000046}';
  IID__VBProjects_Old: TGUID = '{0002E165-0000-0000-C000-000000000046}';
  IID__VBProjects: TGUID = '{EEE00919-E393-11D1-BB03-00C04FB6C4A6}';
  CLASS_VBProjects: TGUID = '{0002E101-0000-0000-C000-000000000046}';
  IID_SelectedComponents: TGUID = '{BE39F3D4-1B13-11D0-887F-00A0C90F2744}';
  IID__Components: TGUID = '{0002E161-0000-0000-C000-000000000046}';
  CLASS_Components: TGUID = '{BE39F3D6-1B13-11D0-887F-00A0C90F2744}';
  IID__VBComponents_Old: TGUID = '{0002E162-0000-0000-C000-000000000046}';
  IID__VBComponents: TGUID = '{EEE0091C-E393-11D1-BB03-00C04FB6C4A6}';
  CLASS_VBComponents: TGUID = '{BE39F3D7-1B13-11D0-887F-00A0C90F2744}';
  IID__Component: TGUID = '{0002E163-0000-0000-C000-000000000046}';
  CLASS_Component: TGUID = '{BE39F3D8-1B13-11D0-887F-00A0C90F2744}';
  IID__VBComponent_Old: TGUID = '{0002E164-0000-0000-C000-000000000046}';
  IID__VBComponent: TGUID = '{EEE00921-E393-11D1-BB03-00C04FB6C4A6}';
  CLASS_VBComponent: TGUID = '{BE39F3DA-1B13-11D0-887F-00A0C90F2744}';
  IID_Property_: TGUID = '{0002E18C-0000-0000-C000-000000000046}';
  IID__Properties: TGUID = '{0002E188-0000-0000-C000-000000000046}';
  CLASS_Properties: TGUID = '{0002E18B-0000-0000-C000-000000000046}';
  IID__AddIns: TGUID = '{DA936B62-AC8B-11D1-B6E5-00A0C90F2744}';
  CLASS_Addins: TGUID = '{DA936B63-AC8B-11D1-B6E5-00A0C90F2744}';
  IID_AddIn: TGUID = '{DA936B64-AC8B-11D1-B6E5-00A0C90F2744}';
  IID__CodeModule: TGUID = '{0002E16E-0000-0000-C000-000000000046}';
  CLASS_CodeModule: TGUID = '{0002E170-0000-0000-C000-000000000046}';
  IID__CodePanes: TGUID = '{0002E172-0000-0000-C000-000000000046}';
  CLASS_CodePanes: TGUID = '{0002E174-0000-0000-C000-000000000046}';
  IID__CodePane: TGUID = '{0002E176-0000-0000-C000-000000000046}';
  CLASS_CodePane: TGUID = '{0002E178-0000-0000-C000-000000000046}';
  IID__References: TGUID = '{0002E17A-0000-0000-C000-000000000046}';
  IID_Reference: TGUID = '{0002E17E-0000-0000-C000-000000000046}';
  DIID__dispReferences_Events: TGUID = '{CDDE3804-2064-11CF-867F-00AA005FF34A}';
  CLASS_References: TGUID = '{0002E17C-0000-0000-C000-000000000046}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum vbextFileTypes
type
  vbextFileTypes = TOleEnum;
const
  vbextFileTypeForm = $00000000;
  vbextFileTypeModule = $00000001;
  vbextFileTypeClass = $00000002;
  vbextFileTypeProject = $00000003;
  vbextFileTypeExe = $00000004;
  vbextFileTypeFrx = $00000005;
  vbextFileTypeRes = $00000006;
  vbextFileTypeUserControl = $00000007;
  vbextFileTypePropertyPage = $00000008;
  vbextFileTypeDocObject = $00000009;
  vbextFileTypeBinary = $0000000A;
  vbextFileTypeGroupProject = $0000000B;
  vbextFileTypeDesigners = $0000000C;

// Constants for enum vbext_WindowType
type
  vbext_WindowType = TOleEnum;
const
  vbext_wt_CodeWindow = $00000000;
  vbext_wt_Designer = $00000001;
  vbext_wt_Browser = $00000002;
  vbext_wt_Watch = $00000003;
  vbext_wt_Locals = $00000004;
  vbext_wt_Immediate = $00000005;
  vbext_wt_ProjectWindow = $00000006;
  vbext_wt_PropertyWindow = $00000007;
  vbext_wt_Find = $00000008;
  vbext_wt_FindReplace = $00000009;
  vbext_wt_Toolbox = $0000000A;
  vbext_wt_LinkedWindowFrame = $0000000B;
  vbext_wt_MainWindow = $0000000C;
  vbext_wt_ToolWindow = $0000000F;

// Constants for enum vbext_WindowState
type
  vbext_WindowState = TOleEnum;
const
  vbext_ws_Normal = $00000000;
  vbext_ws_Minimize = $00000001;
  vbext_ws_Maximize = $00000002;

// Constants for enum vbext_ProjectType
type
  vbext_ProjectType = TOleEnum;
const
  vbext_pt_HostProject = $00000064;
  vbext_pt_StandAlone = $00000065;

// Constants for enum vbext_ProjectProtection
type
  vbext_ProjectProtection = TOleEnum;
const
  vbext_pp_none = $00000000;
  vbext_pp_locked = $00000001;

// Constants for enum vbext_VBAMode
type
  vbext_VBAMode = TOleEnum;
const
  vbext_vm_Run = $00000000;
  vbext_vm_Break = $00000001;
  vbext_vm_Design = $00000002;

// Constants for enum vbext_ComponentType
type
  vbext_ComponentType = TOleEnum;
const
  vbext_ct_StdModule = $00000001;
  vbext_ct_ClassModule = $00000002;
  vbext_ct_MSForm = $00000003;
  vbext_ct_ActiveXDesigner = $0000000B;
  vbext_ct_Document = $00000064;

// Constants for enum vbext_ProcKind
type
  vbext_ProcKind = TOleEnum;
const
  vbext_pk_Proc = $00000000;
  vbext_pk_Let = $00000001;
  vbext_pk_Set = $00000002;
  vbext_pk_Get = $00000003;

// Constants for enum vbext_CodePaneview
type
  vbext_CodePaneview = TOleEnum;
const
  vbext_cv_ProcedureView = $00000000;
  vbext_cv_FullModuleView = $00000001;

// Constants for enum vbext_RefKind
type
  vbext_RefKind = TOleEnum;
const
  vbext_rk_TypeLib = $00000000;
  vbext_rk_Project = $00000001;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  Application = interface;
  ApplicationDisp = dispinterface;
  VBE = interface;
  VBEDisp = dispinterface;
  Window = interface;
  WindowDisp = dispinterface;
  _Windows_old = interface;
  _Windows_oldDisp = dispinterface;
  _Windows = interface;
  _WindowsDisp = dispinterface;
  _LinkedWindows = interface;
  _LinkedWindowsDisp = dispinterface;
  Events = interface;
  EventsDisp = dispinterface;
  _VBProjectsEvents = interface;
  _dispVBProjectsEvents = dispinterface;
  _VBComponentsEvents = interface;
  _dispVBComponentsEvents = dispinterface;
  _ReferencesEvents = interface;
  _dispReferencesEvents = dispinterface;
  _CommandBarControlEvents = interface;
  _dispCommandBarControlEvents = dispinterface;
  _ProjectTemplate = interface;
  _ProjectTemplateDisp = dispinterface;
  _VBProject_Old = interface;
  _VBProject_OldDisp = dispinterface;
  _VBProject = interface;
  _VBProjectDisp = dispinterface;
  _VBProjects_Old = interface;
  _VBProjects_OldDisp = dispinterface;
  _VBProjects = interface;
  _VBProjectsDisp = dispinterface;
  SelectedComponents = interface;
  SelectedComponentsDisp = dispinterface;
  _Components = interface;
  _ComponentsDisp = dispinterface;
  _VBComponents_Old = interface;
  _VBComponents_OldDisp = dispinterface;
  _VBComponents = interface;
  _VBComponentsDisp = dispinterface;
  _Component = interface;
  _ComponentDisp = dispinterface;
  _VBComponent_Old = interface;
  _VBComponent_OldDisp = dispinterface;
  _VBComponent = interface;
  _VBComponentDisp = dispinterface;
  Property_ = interface;
  Property_Disp = dispinterface;
  _Properties = interface;
  _PropertiesDisp = dispinterface;
  _AddIns = interface;
  _AddInsDisp = dispinterface;
  AddIn = interface;
  AddInDisp = dispinterface;
  _CodeModule = interface;
  _CodeModuleDisp = dispinterface;
  _CodePanes = interface;
  _CodePanesDisp = dispinterface;
  _CodePane = interface;
  _CodePaneDisp = dispinterface;
  _References = interface;
  _ReferencesDisp = dispinterface;
  Reference = interface;
  ReferenceDisp = dispinterface;
  _dispReferences_Events = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Windows = _Windows;
  LinkedWindows = _LinkedWindows;
  ReferencesEvents = _ReferencesEvents;
  CommandBarEvents = _CommandBarControlEvents;
  ProjectTemplate = _ProjectTemplate;
  VBProject = _VBProject;
  VBProjects = _VBProjects;
  Components = _Components;
  VBComponents = _VBComponents;
  Component = _Component;
  VBComponent = _VBComponent;
  Properties = _Properties;
  Addins = _AddIns;
  CodeModule = _CodeModule;
  CodePanes = _CodePanes;
  CodePane = _CodePane;
  References = _References;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PWordBool1 = ^WordBool; {*}


// *********************************************************************//
// Interface: Application
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E158-0000-0000-C000-000000000046}
// *********************************************************************//
  Application = interface(IDispatch)
    ['{0002E158-0000-0000-C000-000000000046}']
    function Get_Version: WideString; safecall;
    property Version: WideString read Get_Version;
  end;

// *********************************************************************//
// DispIntf:  ApplicationDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E158-0000-0000-C000-000000000046}
// *********************************************************************//
  ApplicationDisp = dispinterface
    ['{0002E158-0000-0000-C000-000000000046}']
    property Version: WideString readonly dispid 100;
  end;

// *********************************************************************//
// Interface: VBE
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0002E166-0000-0000-C000-000000000046}
// *********************************************************************//
  VBE = interface(Application)
    ['{0002E166-0000-0000-C000-000000000046}']
    function Get_VBProjects: VBProjects; safecall;
    function Get_CommandBars: CommandBars; safecall;
    function Get_CodePanes: CodePanes; safecall;
    function Get_Windows: Windows; safecall;
    function Get_Events: Events; safecall;
    function Get_ActiveVBProject: VBProject; safecall;
    procedure _Set_ActiveVBProject(const lppptReturn: VBProject); safecall;
    function Get_SelectedVBComponent: VBComponent; safecall;
    function Get_MainWindow: Window; safecall;
    function Get_ActiveWindow: Window; safecall;
    function Get_ActiveCodePane: CodePane; safecall;
    procedure _Set_ActiveCodePane(const ppCodePane: CodePane); safecall;
    function Get_Addins: Addins; safecall;
    property VBProjects: VBProjects read Get_VBProjects;
    property CommandBars: CommandBars read Get_CommandBars;
    property CodePanes: CodePanes read Get_CodePanes;
    property Windows: Windows read Get_Windows;
    property Events: Events read Get_Events;
    property ActiveVBProject: VBProject read Get_ActiveVBProject write _Set_ActiveVBProject;
    property SelectedVBComponent: VBComponent read Get_SelectedVBComponent;
    property MainWindow: Window read Get_MainWindow;
    property ActiveWindow: Window read Get_ActiveWindow;
    property ActiveCodePane: CodePane read Get_ActiveCodePane write _Set_ActiveCodePane;
    property Addins: Addins read Get_Addins;
  end;

// *********************************************************************//
// DispIntf:  VBEDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0002E166-0000-0000-C000-000000000046}
// *********************************************************************//
  VBEDisp = dispinterface
    ['{0002E166-0000-0000-C000-000000000046}']
    property VBProjects: VBProjects readonly dispid 107;
    property CommandBars: CommandBars readonly dispid 108;
    property CodePanes: CodePanes readonly dispid 109;
    property Windows: Windows readonly dispid 110;
    property Events: Events readonly dispid 111;
    property ActiveVBProject: VBProject dispid 201;
    property SelectedVBComponent: VBComponent readonly dispid 202;
    property MainWindow: Window readonly dispid 204;
    property ActiveWindow: Window readonly dispid 205;
    property ActiveCodePane: CodePane dispid 206;
    property Addins: Addins readonly dispid 209;
    property Version: WideString readonly dispid 100;
  end;

// *********************************************************************//
// Interface: Window
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0002E16B-0000-0000-C000-000000000046}
// *********************************************************************//
  Window = interface(IDispatch)
    ['{0002E16B-0000-0000-C000-000000000046}']
    function Get_VBE: VBE; safecall;
    function Get_Collection: Windows; safecall;
    procedure Close; safecall;
    function Get_Caption: WideString; safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pfVisible: WordBool); safecall;
    function Get_Left: Integer; safecall;
    procedure Set_Left(plLeft: Integer); safecall;
    function Get_Top: Integer; safecall;
    procedure Set_Top(plTop: Integer); safecall;
    function Get_Width: Integer; safecall;
    procedure Set_Width(plWidth: Integer); safecall;
    function Get_Height: Integer; safecall;
    procedure Set_Height(plHeight: Integer); safecall;
    function Get_WindowState: vbext_WindowState; safecall;
    procedure Set_WindowState(plWindowState: vbext_WindowState); safecall;
    procedure SetFocus; safecall;
    function Get_type_: vbext_WindowType; safecall;
    procedure SetKind(eKind: vbext_WindowType); safecall;
    function Get_LinkedWindows: LinkedWindows; safecall;
    function Get_LinkedWindowFrame: Window; safecall;
    procedure Detach; safecall;
    procedure Attach(lWindowHandle: Integer); safecall;
    function Get_HWnd: Integer; safecall;
    property VBE: VBE read Get_VBE;
    property Collection: Windows read Get_Collection;
    property Caption: WideString read Get_Caption;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property Left: Integer read Get_Left write Set_Left;
    property Top: Integer read Get_Top write Set_Top;
    property Width: Integer read Get_Width write Set_Width;
    property Height: Integer read Get_Height write Set_Height;
    property WindowState: vbext_WindowState read Get_WindowState write Set_WindowState;
    property type_: vbext_WindowType read Get_type_;
    property LinkedWindows: LinkedWindows read Get_LinkedWindows;
    property LinkedWindowFrame: Window read Get_LinkedWindowFrame;
    property HWnd: Integer read Get_HWnd;
  end;

// *********************************************************************//
// DispIntf:  WindowDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0002E16B-0000-0000-C000-000000000046}
// *********************************************************************//
  WindowDisp = dispinterface
    ['{0002E16B-0000-0000-C000-000000000046}']
    property VBE: VBE readonly dispid 1;
    property Collection: Windows readonly dispid 2;
    procedure Close; dispid 99;
    property Caption: WideString readonly dispid 100;
    property Visible: WordBool dispid 106;
    property Left: Integer dispid 101;
    property Top: Integer dispid 103;
    property Width: Integer dispid 105;
    property Height: Integer dispid 107;
    property WindowState: vbext_WindowState dispid 109;
    procedure SetFocus; dispid 111;
    property type_: vbext_WindowType readonly dispid 112;
    procedure SetKind(eKind: vbext_WindowType); dispid 113;
    property LinkedWindows: LinkedWindows readonly dispid 116;
    property LinkedWindowFrame: Window readonly dispid 117;
    procedure Detach; dispid 118;
    procedure Attach(lWindowHandle: Integer); dispid 119;
    property HWnd: Integer readonly dispid 120;
  end;

// *********************************************************************//
// Interface: _Windows_old
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E16A-0000-0000-C000-000000000046}
// *********************************************************************//
  _Windows_old = interface(IDispatch)
    ['{0002E16A-0000-0000-C000-000000000046}']
    function Get_VBE: VBE; safecall;
    function Get_Parent: Application; safecall;
    function Item(index: OleVariant): Window; safecall;
    function Get_Count: Integer; safecall;
    function _NewEnum: IUnknown; safecall;
    property VBE: VBE read Get_VBE;
    property Parent: Application read Get_Parent;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  _Windows_oldDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E16A-0000-0000-C000-000000000046}
// *********************************************************************//
  _Windows_oldDisp = dispinterface
    ['{0002E16A-0000-0000-C000-000000000046}']
    property VBE: VBE readonly dispid 1;
    property Parent: Application readonly dispid 2;
    function Item(index: OleVariant): Window; dispid 0;
    property Count: Integer readonly dispid 201;
    function _NewEnum: IUnknown; dispid -4;
  end;

// *********************************************************************//
// Interface: _Windows
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F57B7ED0-D8AB-11D1-85DF-00C04F98F42C}
// *********************************************************************//
  _Windows = interface(_Windows_old)
    ['{F57B7ED0-D8AB-11D1-85DF-00C04F98F42C}']
    function CreateToolWindow(const AddInInst: AddIn; const ProgId: WideString; 
                              const Caption: WideString; const GuidPosition: WideString; 
                              var DocObj: IDispatch): Window; safecall;
  end;

// *********************************************************************//
// DispIntf:  _WindowsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F57B7ED0-D8AB-11D1-85DF-00C04F98F42C}
// *********************************************************************//
  _WindowsDisp = dispinterface
    ['{F57B7ED0-D8AB-11D1-85DF-00C04F98F42C}']
    function CreateToolWindow(const AddInInst: AddIn; const ProgId: WideString; 
                              const Caption: WideString; const GuidPosition: WideString; 
                              var DocObj: IDispatch): Window; dispid 300;
    property VBE: VBE readonly dispid 1;
    property Parent: Application readonly dispid 2;
    function Item(index: OleVariant): Window; dispid 0;
    property Count: Integer readonly dispid 201;
    function _NewEnum: IUnknown; dispid -4;
  end;

// *********************************************************************//
// Interface: _LinkedWindows
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0002E16C-0000-0000-C000-000000000046}
// *********************************************************************//
  _LinkedWindows = interface(IDispatch)
    ['{0002E16C-0000-0000-C000-000000000046}']
    function Get_VBE: VBE; safecall;
    function Get_Parent: Window; safecall;
    function Item(index: OleVariant): Window; safecall;
    function Get_Count: Integer; safecall;
    function _NewEnum: IUnknown; safecall;
    procedure Remove(const Window: Window); safecall;
    procedure Add(const Window: Window); safecall;
    property VBE: VBE read Get_VBE;
    property Parent: Window read Get_Parent;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  _LinkedWindowsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0002E16C-0000-0000-C000-000000000046}
// *********************************************************************//
  _LinkedWindowsDisp = dispinterface
    ['{0002E16C-0000-0000-C000-000000000046}']
    property VBE: VBE readonly dispid 1;
    property Parent: Window readonly dispid 2;
    function Item(index: OleVariant): Window; dispid 0;
    property Count: Integer readonly dispid 201;
    function _NewEnum: IUnknown; dispid -4;
    procedure Remove(const Window: Window); dispid 202;
    procedure Add(const Window: Window); dispid 203;
  end;

// *********************************************************************//
// Interface: Events
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0002E167-0000-0000-C000-000000000046}
// *********************************************************************//
  Events = interface(IDispatch)
    ['{0002E167-0000-0000-C000-000000000046}']
    function Get_ReferencesEvents(const VBProject: VBProject): ReferencesEvents; safecall;
    function Get_CommandBarEvents(const CommandBarControl: IDispatch): CommandBarEvents; safecall;
    property ReferencesEvents[const VBProject: VBProject]: ReferencesEvents read Get_ReferencesEvents;
    property CommandBarEvents[const CommandBarControl: IDispatch]: CommandBarEvents read Get_CommandBarEvents;
  end;

// *********************************************************************//
// DispIntf:  EventsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0002E167-0000-0000-C000-000000000046}
// *********************************************************************//
  EventsDisp = dispinterface
    ['{0002E167-0000-0000-C000-000000000046}']
    property ReferencesEvents[const VBProject: VBProject]: ReferencesEvents readonly dispid 202;
    property CommandBarEvents[const CommandBarControl: IDispatch]: CommandBarEvents readonly dispid 205;
  end;

// *********************************************************************//
// Interface: _VBProjectsEvents
// Flags:     (256) OleAutomation
// GUID:      {0002E113-0000-0000-C000-000000000046}
// *********************************************************************//
  _VBProjectsEvents = interface(IUnknown)
    ['{0002E113-0000-0000-C000-000000000046}']
  end;

// *********************************************************************//
// DispIntf:  _dispVBProjectsEvents
// Flags:     (4096) Dispatchable
// GUID:      {0002E103-0000-0000-C000-000000000046}
// *********************************************************************//
  _dispVBProjectsEvents = dispinterface
    ['{0002E103-0000-0000-C000-000000000046}']
    procedure ItemAdded(const VBProject: VBProject); dispid 1;
    procedure ItemRemoved(const VBProject: VBProject); dispid 2;
    procedure ItemRenamed(const VBProject: VBProject; const OldName: WideString); dispid 3;
    procedure ItemActivated(const VBProject: VBProject); dispid 4;
  end;

// *********************************************************************//
// Interface: _VBComponentsEvents
// Flags:     (256) OleAutomation
// GUID:      {0002E115-0000-0000-C000-000000000046}
// *********************************************************************//
  _VBComponentsEvents = interface(IUnknown)
    ['{0002E115-0000-0000-C000-000000000046}']
  end;

// *********************************************************************//
// DispIntf:  _dispVBComponentsEvents
// Flags:     (4096) Dispatchable
// GUID:      {0002E116-0000-0000-C000-000000000046}
// *********************************************************************//
  _dispVBComponentsEvents = dispinterface
    ['{0002E116-0000-0000-C000-000000000046}']
    procedure ItemAdded(const VBComponent: VBComponent); dispid 1;
    procedure ItemRemoved(const VBComponent: VBComponent); dispid 2;
    procedure ItemRenamed(const VBComponent: VBComponent; const OldName: WideString); dispid 3;
    procedure ItemSelected(const VBComponent: VBComponent); dispid 4;
    procedure ItemActivated(const VBComponent: VBComponent); dispid 5;
    procedure ItemReloaded(const VBComponent: VBComponent); dispid 6;
  end;

// *********************************************************************//
// Interface: _ReferencesEvents
// Flags:     (256) OleAutomation
// GUID:      {0002E11A-0000-0000-C000-000000000046}
// *********************************************************************//
  _ReferencesEvents = interface(IUnknown)
    ['{0002E11A-0000-0000-C000-000000000046}']
  end;

// *********************************************************************//
// DispIntf:  _dispReferencesEvents
// Flags:     (4096) Dispatchable
// GUID:      {0002E118-0000-0000-C000-000000000046}
// *********************************************************************//
  _dispReferencesEvents = dispinterface
    ['{0002E118-0000-0000-C000-000000000046}']
    procedure ItemAdded(const Reference: Reference); dispid 1;
    procedure ItemRemoved(const Reference: Reference); dispid 2;
  end;

// *********************************************************************//
// Interface: _CommandBarControlEvents
// Flags:     (256) OleAutomation
// GUID:      {0002E130-0000-0000-C000-000000000046}
// *********************************************************************//
  _CommandBarControlEvents = interface(IUnknown)
    ['{0002E130-0000-0000-C000-000000000046}']
  end;

// *********************************************************************//
// DispIntf:  _dispCommandBarControlEvents
// Flags:     (4096) Dispatchable
// GUID:      {0002E131-0000-0000-C000-000000000046}
// *********************************************************************//
  _dispCommandBarControlEvents = dispinterface
    ['{0002E131-0000-0000-C000-000000000046}']
    procedure Click(const CommandBarControl: IDispatch; var handled: WordBool; 
                    var CancelDefault: WordBool); dispid 1;
  end;

// *********************************************************************//
// Interface: _ProjectTemplate
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E159-0000-0000-C000-000000000046}
// *********************************************************************//
  _ProjectTemplate = interface(IDispatch)
    ['{0002E159-0000-0000-C000-000000000046}']
    function Get_Application: Application; safecall;
    function Get_Parent: Application; safecall;
    property Application: Application read Get_Application;
    property Parent: Application read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  _ProjectTemplateDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E159-0000-0000-C000-000000000046}
// *********************************************************************//
  _ProjectTemplateDisp = dispinterface
    ['{0002E159-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: Application readonly dispid 2;
  end;

// *********************************************************************//
// Interface: _VBProject_Old
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E160-0000-0000-C000-000000000046}
// *********************************************************************//
  _VBProject_Old = interface(_ProjectTemplate)
    ['{0002E160-0000-0000-C000-000000000046}']
    function Get_HelpFile: WideString; safecall;
    procedure Set_HelpFile(const lpbstrHelpFile: WideString); safecall;
    function Get_HelpContextID: Integer; safecall;
    procedure Set_HelpContextID(lpdwContextID: Integer); safecall;
    function Get_Description: WideString; safecall;
    procedure Set_Description(const lpbstrDescription: WideString); safecall;
    function Get_Mode: vbext_VBAMode; safecall;
    function Get_References: References; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const lpbstrName: WideString); safecall;
    function Get_VBE: VBE; safecall;
    function Get_Collection: VBProjects; safecall;
    function Get_Protection: vbext_ProjectProtection; safecall;
    function Get_Saved: WordBool; safecall;
    function Get_VBComponents: VBComponents; safecall;
    property HelpFile: WideString read Get_HelpFile write Set_HelpFile;
    property HelpContextID: Integer read Get_HelpContextID write Set_HelpContextID;
    property Description: WideString read Get_Description write Set_Description;
    property Mode: vbext_VBAMode read Get_Mode;
    property References: References read Get_References;
    property Name: WideString read Get_Name write Set_Name;
    property VBE: VBE read Get_VBE;
    property Collection: VBProjects read Get_Collection;
    property Protection: vbext_ProjectProtection read Get_Protection;
    property Saved: WordBool read Get_Saved;
    property VBComponents: VBComponents read Get_VBComponents;
  end;

// *********************************************************************//
// DispIntf:  _VBProject_OldDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E160-0000-0000-C000-000000000046}
// *********************************************************************//
  _VBProject_OldDisp = dispinterface
    ['{0002E160-0000-0000-C000-000000000046}']
    property HelpFile: WideString dispid 116;
    property HelpContextID: Integer dispid 117;
    property Description: WideString dispid 118;
    property Mode: vbext_VBAMode readonly dispid 119;
    property References: References readonly dispid 120;
    property Name: WideString dispid 121;
    property VBE: VBE readonly dispid 122;
    property Collection: VBProjects readonly dispid 123;
    property Protection: vbext_ProjectProtection readonly dispid 131;
    property Saved: WordBool readonly dispid 133;
    property VBComponents: VBComponents readonly dispid 135;
    property Application: Application readonly dispid 1;
    property Parent: Application readonly dispid 2;
  end;

// *********************************************************************//
// Interface: _VBProject
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {EEE00915-E393-11D1-BB03-00C04FB6C4A6}
// *********************************************************************//
  _VBProject = interface(_VBProject_Old)
    ['{EEE00915-E393-11D1-BB03-00C04FB6C4A6}']
    procedure SaveAs(const FileName: WideString); safecall;
    procedure MakeCompiledFile; safecall;
    function Get_type_: vbext_ProjectType; safecall;
    function Get_FileName: WideString; safecall;
    function Get_BuildFileName: WideString; safecall;
    procedure Set_BuildFileName(const lpbstrBldFName: WideString); safecall;
    property type_: vbext_ProjectType read Get_type_;
    property FileName: WideString read Get_FileName;
    property BuildFileName: WideString read Get_BuildFileName write Set_BuildFileName;
  end;

// *********************************************************************//
// DispIntf:  _VBProjectDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {EEE00915-E393-11D1-BB03-00C04FB6C4A6}
// *********************************************************************//
  _VBProjectDisp = dispinterface
    ['{EEE00915-E393-11D1-BB03-00C04FB6C4A6}']
    procedure SaveAs(const FileName: WideString); dispid 138;
    procedure MakeCompiledFile; dispid 139;
    property type_: vbext_ProjectType readonly dispid 140;
    property FileName: WideString readonly dispid 141;
    property BuildFileName: WideString dispid 142;
    property HelpFile: WideString dispid 116;
    property HelpContextID: Integer dispid 117;
    property Description: WideString dispid 118;
    property Mode: vbext_VBAMode readonly dispid 119;
    property References: References readonly dispid 120;
    property Name: WideString dispid 121;
    property VBE: VBE readonly dispid 122;
    property Collection: VBProjects readonly dispid 123;
    property Protection: vbext_ProjectProtection readonly dispid 131;
    property Saved: WordBool readonly dispid 133;
    property VBComponents: VBComponents readonly dispid 135;
    property Application: Application readonly dispid 1;
    property Parent: Application readonly dispid 2;
  end;

// *********************************************************************//
// Interface: _VBProjects_Old
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E165-0000-0000-C000-000000000046}
// *********************************************************************//
  _VBProjects_Old = interface(IDispatch)
    ['{0002E165-0000-0000-C000-000000000046}']
    function Item(index: OleVariant): VBProject; safecall;
    function Get_VBE: VBE; safecall;
    function Get_Parent: VBE; safecall;
    function Get_Count: Integer; safecall;
    function _NewEnum: IUnknown; safecall;
    property VBE: VBE read Get_VBE;
    property Parent: VBE read Get_Parent;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  _VBProjects_OldDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E165-0000-0000-C000-000000000046}
// *********************************************************************//
  _VBProjects_OldDisp = dispinterface
    ['{0002E165-0000-0000-C000-000000000046}']
    function Item(index: OleVariant): VBProject; dispid 0;
    property VBE: VBE readonly dispid 20;
    property Parent: VBE readonly dispid 2;
    property Count: Integer readonly dispid 10;
    function _NewEnum: IUnknown; dispid -4;
  end;

// *********************************************************************//
// Interface: _VBProjects
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EEE00919-E393-11D1-BB03-00C04FB6C4A6}
// *********************************************************************//
  _VBProjects = interface(_VBProjects_Old)
    ['{EEE00919-E393-11D1-BB03-00C04FB6C4A6}']
    function Add(Type_: vbext_ProjectType): VBProject; safecall;
    procedure Remove(const lpc: VBProject); safecall;
    function Open(const bstrPath: WideString): VBProject; safecall;
  end;

// *********************************************************************//
// DispIntf:  _VBProjectsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EEE00919-E393-11D1-BB03-00C04FB6C4A6}
// *********************************************************************//
  _VBProjectsDisp = dispinterface
    ['{EEE00919-E393-11D1-BB03-00C04FB6C4A6}']
    function Add(Type_: vbext_ProjectType): VBProject; dispid 137;
    procedure Remove(const lpc: VBProject); dispid 138;
    function Open(const bstrPath: WideString): VBProject; dispid 139;
    function Item(index: OleVariant): VBProject; dispid 0;
    property VBE: VBE readonly dispid 20;
    property Parent: VBE readonly dispid 2;
    property Count: Integer readonly dispid 10;
    function _NewEnum: IUnknown; dispid -4;
  end;

// *********************************************************************//
// Interface: SelectedComponents
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {BE39F3D4-1B13-11D0-887F-00A0C90F2744}
// *********************************************************************//
  SelectedComponents = interface(IDispatch)
    ['{BE39F3D4-1B13-11D0-887F-00A0C90F2744}']
    function Item(index: SYSINT): Component; safecall;
    function Get_Application: Application; safecall;
    function Get_Parent: VBProject; safecall;
    function Get_Count: Integer; safecall;
    function _NewEnum: IUnknown; safecall;
    property Application: Application read Get_Application;
    property Parent: VBProject read Get_Parent;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  SelectedComponentsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {BE39F3D4-1B13-11D0-887F-00A0C90F2744}
// *********************************************************************//
  SelectedComponentsDisp = dispinterface
    ['{BE39F3D4-1B13-11D0-887F-00A0C90F2744}']
    function Item(index: SYSINT): Component; dispid 0;
    property Application: Application readonly dispid 1;
    property Parent: VBProject readonly dispid 2;
    property Count: Integer readonly dispid 10;
    function _NewEnum: IUnknown; dispid -4;
  end;

// *********************************************************************//
// Interface: _Components
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E161-0000-0000-C000-000000000046}
// *********************************************************************//
  _Components = interface(IDispatch)
    ['{0002E161-0000-0000-C000-000000000046}']
    function Item(index: OleVariant): Component; safecall;
    function Get_Application: Application; safecall;
    function Get_Parent: VBProject; safecall;
    function Get_Count: Integer; safecall;
    function _NewEnum: IUnknown; safecall;
    procedure Remove(const Component: Component); safecall;
    function Add(ComponentType: vbext_ComponentType): Component; safecall;
    function Import(const FileName: WideString): Component; safecall;
    function Get_VBE: VBE; safecall;
    property Application: Application read Get_Application;
    property Parent: VBProject read Get_Parent;
    property Count: Integer read Get_Count;
    property VBE: VBE read Get_VBE;
  end;

// *********************************************************************//
// DispIntf:  _ComponentsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E161-0000-0000-C000-000000000046}
// *********************************************************************//
  _ComponentsDisp = dispinterface
    ['{0002E161-0000-0000-C000-000000000046}']
    function Item(index: OleVariant): Component; dispid 0;
    property Application: Application readonly dispid 1;
    property Parent: VBProject readonly dispid 2;
    property Count: Integer readonly dispid 10;
    function _NewEnum: IUnknown; dispid -4;
    procedure Remove(const Component: Component); dispid 11;
    function Add(ComponentType: vbext_ComponentType): Component; dispid 12;
    function Import(const FileName: WideString): Component; dispid 13;
    property VBE: VBE readonly dispid 20;
  end;

// *********************************************************************//
// Interface: _VBComponents_Old
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E162-0000-0000-C000-000000000046}
// *********************************************************************//
  _VBComponents_Old = interface(IDispatch)
    ['{0002E162-0000-0000-C000-000000000046}']
    function Item(index: OleVariant): VBComponent; safecall;
    function Get_Parent: VBProject; safecall;
    function Get_Count: Integer; safecall;
    function _NewEnum: IUnknown; safecall;
    procedure Remove(const VBComponent: VBComponent); safecall;
    function Add(ComponentType: vbext_ComponentType): VBComponent; safecall;
    function Import(const FileName: WideString): VBComponent; safecall;
    function Get_VBE: VBE; safecall;
    property Parent: VBProject read Get_Parent;
    property Count: Integer read Get_Count;
    property VBE: VBE read Get_VBE;
  end;

// *********************************************************************//
// DispIntf:  _VBComponents_OldDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E162-0000-0000-C000-000000000046}
// *********************************************************************//
  _VBComponents_OldDisp = dispinterface
    ['{0002E162-0000-0000-C000-000000000046}']
    function Item(index: OleVariant): VBComponent; dispid 0;
    property Parent: VBProject readonly dispid 2;
    property Count: Integer readonly dispid 10;
    function _NewEnum: IUnknown; dispid -4;
    procedure Remove(const VBComponent: VBComponent); dispid 11;
    function Add(ComponentType: vbext_ComponentType): VBComponent; dispid 12;
    function Import(const FileName: WideString): VBComponent; dispid 13;
    property VBE: VBE readonly dispid 20;
  end;

// *********************************************************************//
// Interface: _VBComponents
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EEE0091C-E393-11D1-BB03-00C04FB6C4A6}
// *********************************************************************//
  _VBComponents = interface(_VBComponents_Old)
    ['{EEE0091C-E393-11D1-BB03-00C04FB6C4A6}']
    function AddCustom(const ProgId: WideString): VBComponent; safecall;
    function AddMTDesigner(index: Integer): VBComponent; safecall;
  end;

// *********************************************************************//
// DispIntf:  _VBComponentsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EEE0091C-E393-11D1-BB03-00C04FB6C4A6}
// *********************************************************************//
  _VBComponentsDisp = dispinterface
    ['{EEE0091C-E393-11D1-BB03-00C04FB6C4A6}']
    function AddCustom(const ProgId: WideString): VBComponent; dispid 25;
    function AddMTDesigner(index: Integer): VBComponent; dispid 26;
    function Item(index: OleVariant): VBComponent; dispid 0;
    property Parent: VBProject readonly dispid 2;
    property Count: Integer readonly dispid 10;
    function _NewEnum: IUnknown; dispid -4;
    procedure Remove(const VBComponent: VBComponent); dispid 11;
    function Add(ComponentType: vbext_ComponentType): VBComponent; dispid 12;
    function Import(const FileName: WideString): VBComponent; dispid 13;
    property VBE: VBE readonly dispid 20;
  end;

// *********************************************************************//
// Interface: _Component
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E163-0000-0000-C000-000000000046}
// *********************************************************************//
  _Component = interface(IDispatch)
    ['{0002E163-0000-0000-C000-000000000046}']
    function Get_Application: Application; safecall;
    function Get_Parent: Components; safecall;
    function Get_IsDirty: WordBool; safecall;
    procedure Set_IsDirty(lpfReturn: WordBool); safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const pbstrReturn: WideString); safecall;
    property Application: Application read Get_Application;
    property Parent: Components read Get_Parent;
    property IsDirty: WordBool read Get_IsDirty write Set_IsDirty;
    property Name: WideString read Get_Name write Set_Name;
  end;

// *********************************************************************//
// DispIntf:  _ComponentDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E163-0000-0000-C000-000000000046}
// *********************************************************************//
  _ComponentDisp = dispinterface
    ['{0002E163-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: Components readonly dispid 2;
    property IsDirty: WordBool dispid 10;
    property Name: WideString dispid 48;
  end;

// *********************************************************************//
// Interface: _VBComponent_Old
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E164-0000-0000-C000-000000000046}
// *********************************************************************//
  _VBComponent_Old = interface(IDispatch)
    ['{0002E164-0000-0000-C000-000000000046}']
    function Get_Saved: WordBool; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const pbstrReturn: WideString); safecall;
    function Get_Designer: IDispatch; safecall;
    function Get_CodeModule: CodeModule; safecall;
    function Get_type_: vbext_ComponentType; safecall;
    procedure Export(const FileName: WideString); safecall;
    function Get_VBE: VBE; safecall;
    function Get_Collection: VBComponents; safecall;
    function Get_HasOpenDesigner: WordBool; safecall;
    function Get_Properties: Properties; safecall;
    function DesignerWindow: Window; safecall;
    procedure Activate; safecall;
    property Saved: WordBool read Get_Saved;
    property Name: WideString read Get_Name write Set_Name;
    property Designer: IDispatch read Get_Designer;
    property CodeModule: CodeModule read Get_CodeModule;
    property type_: vbext_ComponentType read Get_type_;
    property VBE: VBE read Get_VBE;
    property Collection: VBComponents read Get_Collection;
    property HasOpenDesigner: WordBool read Get_HasOpenDesigner;
    property Properties: Properties read Get_Properties;
  end;

// *********************************************************************//
// DispIntf:  _VBComponent_OldDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002E164-0000-0000-C000-000000000046}
// *********************************************************************//
  _VBComponent_OldDisp = dispinterface
    ['{0002E164-0000-0000-C000-000000000046}']
    property Saved: WordBool readonly dispid 10;
    property Name: WideString dispid 48;
    property Designer: IDispatch readonly dispid 49;
    property CodeModule: CodeModule readonly dispid 50;
    property type_: vbext_ComponentType readonly dispid 51;
    procedure Export(const FileName: WideString); dispid 52;
    property VBE: VBE readonly dispid 53;
    property Collection: VBComponents readonly dispid 54;
    property HasOpenDesigner: WordBool readonly dispid 55;
    property Properties: Properties readonly dispid 56;
    function DesignerWindow: Window; dispid 57;
    procedure Activate; dispid 60;
  end;

// *********************************************************************//
// Interface: _VBComponent
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EEE00921-E393-11D1-BB03-00C04FB6C4A6}
// *********************************************************************//
  _VBComponent = interface(_VBComponent_Old)
    ['{EEE00921-E393-11D1-BB03-00C04FB6C4A6}']
    function Get_DesignerID: WideString; safecall;
    property DesignerID: WideString read Get_DesignerID;
  end;

// *********************************************************************//
// DispIntf:  _VBComponentDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EEE00921-E393-11D1-BB03-00C04FB6C4A6}
// *********************************************************************//
  _VBComponentDisp = dispinterface
    ['{EEE00921-E393-11D1-BB03-00C04FB6C4A6}']
    property DesignerID: WideString readonly dispid 64;
    property Saved: WordBool readonly dispid 10;
    property Name: WideString dispid 48;
    property Designer: IDispatch readonly dispid 49;
    property CodeModule: CodeModule readonly dispid 50;
    property type_: vbext_ComponentType readonly dispid 51;
    procedure Export(const FileName: WideString); dispid 52;
    property VBE: VBE readonly dispid 53;
    property Collection: VBComponents readonly dispid 54;
    property HasOpenDesigner: WordBool readonly dispid 55;
    property Properties: Properties readonly dispid 56;
    function DesignerWindow: Window; dispid 57;
    procedure Activate; dispid 60;
  end;

// *********************************************************************//
// Interface: Property_
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0002E18C-0000-0000-C000-000000000046}
// *********************************************************************//
  Property_ = interface(IDispatch)
    ['{0002E18C-0000-0000-C000-000000000046}']
    function Get_Value: OleVariant; safecall;
    procedure Set_Value(lppvReturn: OleVariant); safecall;
    function Get_IndexedValue(Index1: OleVariant; Index2: OleVariant; Index3: OleVariant; 
                              Index4: OleVariant): OleVariant; safecall;
    procedure Set_IndexedValue(Index1: OleVariant; Index2: OleVariant; Index3: OleVariant; 
                               Index4: OleVariant; lppvReturn: OleVariant); safecall;
    function Get_NumIndices: Smallint; safecall;
    function Get_Application: Application; safecall;
    function Get_Parent: Properties; safecall;
    function Get_Name: WideString; safecall;
    function Get_VBE: VBE; safecall;
    function Get_Collection: Properties; safecall;
    function Get_Object_: IUnknown; safecall;
    procedure _Set_Object_(const lppunk: IUnknown); safecall;
    property Value: OleVariant read Get_Value write Set_Value;
    property IndexedValue[Index1: OleVariant; Index2: OleVariant; Index3: OleVariant; 
                          Index4: OleVariant]: OleVariant read Get_IndexedValue write Set_IndexedValue;
    property NumIndices: Smallint read Get_NumIndices;
    property Application: Application read Get_Application;
    property Parent: Properties read Get_Parent;
    property Name: WideString read Get_Name;
    property VBE: VBE read Get_VBE;
    property Collection: Properties read Get_Collection;
    property Object_: IUnknown read Get_Object_ write _Set_Object_;
  end;

// *********************************************************************//
// DispIntf:  Property_Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0002E18C-0000-0000-C000-000000000046}
// *********************************************************************//
  Property_Disp = dispinterface
    ['{0002E18C-0000-0000-C000-000000000046}']
    property Value: OleVariant dispid 0;
    property IndexedValue[Index1: OleVariant; Index2: OleVariant; Index3: OleVariant; 
                          Index4: OleVariant]: OleVariant dispid 3;
    property NumIndices: Smallint readonly dispid 4;
    property Application: Application readonly dispid 1;
    property Parent: Properties readonly dispid 2;
    property Name: WideString readonly dispid 40;
    property VBE: VBE readonly dispid 41;
    property Collection: Properties readonly dispid 42;
    property Object_: IUnknown dispid 45;
  end;

// *********************************************************************//
// Interface: _Properties
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0002E188-0000-0000-C000-000000000046}
// *********************************************************************//
  _Properties = interface(IDispatch)
    ['{0002E188-0000-0000-C000-000000000046}']
    function Item(index: OleVariant): Property_; safecall;
    function Get_Application: Application; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Count: Integer; safecall;
    function _NewEnum: IUnknown; safecall;
    function Get_VBE: VBE; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
    property VBE: VBE read Get_VBE;
  end;

// *********************************************************************//
// DispIntf:  _PropertiesDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0002E188-0000-0000-C000-000000000046}
// *********************************************************************//
  _PropertiesDisp = dispinterface
    ['{0002E188-0000-0000-C000-000000000046}']
    function Item(index: OleVariant): Property_; dispid 0;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 40;
    function _NewEnum: IUnknown; dispid -4;
    property VBE: VBE readonly dispid 10;
  end;

// *********************************************************************//
// Interface: _AddIns
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DA936B62-AC8B-11D1-B6E5-00A0C90F2744}
// *********************************************************************//
  _AddIns = interface(IDispatch)
    ['{DA936B62-AC8B-11D1-B6E5-00A0C90F2744}']
    function Item(index: OleVariant): AddIn; safecall;
    function Get_VBE: VBE; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Count: Integer; safecall;
    function _NewEnum: IUnknown; safecall;
    procedure Update; safecall;
    property VBE: VBE read Get_VBE;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  _AddInsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DA936B62-AC8B-11D1-B6E5-00A0C90F2744}
// *********************************************************************//
  _AddInsDisp = dispinterface
    ['{DA936B62-AC8B-11D1-B6E5-00A0C90F2744}']
    function Item(index: OleVariant): AddIn; dispid 0;
    property VBE: VBE readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 40;
    function _NewEnum: IUnknown; dispid -4;
    procedure Update; dispid 41;
  end;

// *********************************************************************//
// Interface: AddIn
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DA936B64-AC8B-11D1-B6E5-00A0C90F2744}
// *********************************************************************//
  AddIn = interface(IDispatch)
    ['{DA936B64-AC8B-11D1-B6E5-00A0C90F2744}']
    function Get_Description: WideString; safecall;
    procedure Set_Description(const lpbstr: WideString); safecall;
    function Get_VBE: VBE; safecall;
    function Get_Collection: Addins; safecall;
    function Get_ProgId: WideString; safecall;
    function Get_Guid: WideString; safecall;
    function Get_Connect: WordBool; safecall;
    procedure Set_Connect(lpfConnect: WordBool); safecall;
    function Get_Object_: IDispatch; safecall;
    procedure Set_Object_(const lppdisp: IDispatch); safecall;
    property Description: WideString read Get_Description write Set_Description;
    property VBE: VBE read Get_VBE;
    property Collection: Addins read Get_Collection;
    property ProgId: WideString read Get_ProgId;
    property Guid: WideString read Get_Guid;
    property Connect: WordBool read Get_Connect write Set_Connect;
    property Object_: IDispatch read Get_Object_ write Set_Object_;
  end;

// *********************************************************************//
// DispIntf:  AddInDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DA936B64-AC8B-11D1-B6E5-00A0C90F2744}
// *********************************************************************//
  AddInDisp = dispinterface
    ['{DA936B64-AC8B-11D1-B6E5-00A0C90F2744}']
    property Description: WideString dispid 0;
    property VBE: VBE readonly dispid 1;
    property Collection: Addins readonly dispid 2;
    property ProgId: WideString readonly dispid 3;
    property Guid: WideString readonly dispid 4;
    property Connect: WordBool dispid 6;
    property Object_: IDispatch dispid 7;
  end;

// *********************************************************************//
// Interface: _CodeModule
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002E16E-0000-0000-C000-000000000046}
// *********************************************************************//
  _CodeModule = interface(IDispatch)
    ['{0002E16E-0000-0000-C000-000000000046}']
    function Get_Parent: VBComponent; safecall;
    function Get_VBE: VBE; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const pbstrName: WideString); safecall;
    procedure AddFromString(const String_: WideString); safecall;
    procedure AddFromFile(const FileName: WideString); safecall;
    function Get_Lines(StartLine: Integer; Count: Integer): WideString; safecall;
    function Get_CountOfLines: Integer; safecall;
    procedure InsertLines(Line: Integer; const String_: WideString); safecall;
    procedure DeleteLines(StartLine: Integer; Count: Integer); safecall;
    procedure ReplaceLine(Line: Integer; const String_: WideString); safecall;
    function Get_ProcStartLine(const ProcName: WideString; ProcKind: vbext_ProcKind): Integer; safecall;
    function Get_ProcCountLines(const ProcName: WideString; ProcKind: vbext_ProcKind): Integer; safecall;
    function Get_ProcBodyLine(const ProcName: WideString; ProcKind: vbext_ProcKind): Integer; safecall;
    function Get_ProcOfLine(Line: Integer; out ProcKind: vbext_ProcKind): WideString; safecall;
    function Get_CountOfDeclarationLines: Integer; safecall;
    function CreateEventProc(const EventName: WideString; const ObjectName: WideString): Integer; safecall;
    function Find(const Target: WideString; var StartLine: Integer; var StartColumn: Integer; 
                  var EndLine: Integer; var EndColumn: Integer; WholeWord: WordBool; 
                  MatchCase: WordBool; PatternSearch: WordBool): WordBool; safecall;
    function Get_CodePane: CodePane; safecall;
    property Parent: VBComponent read Get_Parent;
    property VBE: VBE read Get_VBE;
    property Name: WideString read Get_Name write Set_Name;
    property Lines[StartLine: Integer; Count: Integer]: WideString read Get_Lines;
    property CountOfLines: Integer read Get_CountOfLines;
    property ProcStartLine[const ProcName: WideString; ProcKind: vbext_ProcKind]: Integer read Get_ProcStartLine;
    property ProcCountLines[const ProcName: WideString; ProcKind: vbext_ProcKind]: Integer read Get_ProcCountLines;
    property ProcBodyLine[const ProcName: WideString; ProcKind: vbext_ProcKind]: Integer read Get_ProcBodyLine;
    property ProcOfLine[Line: Integer; out ProcKind: vbext_ProcKind]: WideString read Get_ProcOfLine;
    property CountOfDeclarationLines: Integer read Get_CountOfDeclarationLines;
    property CodePane: CodePane read Get_CodePane;
  end;

// *********************************************************************//
// DispIntf:  _CodeModuleDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002E16E-0000-0000-C000-000000000046}
// *********************************************************************//
  _CodeModuleDisp = dispinterface
    ['{0002E16E-0000-0000-C000-000000000046}']
    property Parent: VBComponent readonly dispid 1610743808;
    property VBE: VBE readonly dispid 1610743809;
    property Name: WideString dispid 0;
    procedure AddFromString(const String_: WideString); dispid 1610743812;
    procedure AddFromFile(const FileName: WideString); dispid 1610743813;
    property Lines[StartLine: Integer; Count: Integer]: WideString readonly dispid 1610743814;
    property CountOfLines: Integer readonly dispid 1610743815;
    procedure InsertLines(Line: Integer; const String_: WideString); dispid 1610743816;
    procedure DeleteLines(StartLine: Integer; Count: Integer); dispid 1610743817;
    procedure ReplaceLine(Line: Integer; const String_: WideString); dispid 1610743818;
    property ProcStartLine[const ProcName: WideString; ProcKind: vbext_ProcKind]: Integer readonly dispid 1610743819;
    property ProcCountLines[const ProcName: WideString; ProcKind: vbext_ProcKind]: Integer readonly dispid 1610743820;
    property ProcBodyLine[const ProcName: WideString; ProcKind: vbext_ProcKind]: Integer readonly dispid 1610743821;
    property ProcOfLine[Line: Integer; out ProcKind: vbext_ProcKind]: WideString readonly dispid 1610743822;
    property CountOfDeclarationLines: Integer readonly dispid 1610743823;
    function CreateEventProc(const EventName: WideString; const ObjectName: WideString): Integer; dispid 1610743824;
    function Find(const Target: WideString; var StartLine: Integer; var StartColumn: Integer; 
                  var EndLine: Integer; var EndColumn: Integer; WholeWord: WordBool; 
                  MatchCase: WordBool; PatternSearch: WordBool): WordBool; dispid 1610743825;
    property CodePane: CodePane readonly dispid 1610743826;
  end;

// *********************************************************************//
// Interface: _CodePanes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002E172-0000-0000-C000-000000000046}
// *********************************************************************//
  _CodePanes = interface(IDispatch)
    ['{0002E172-0000-0000-C000-000000000046}']
    function Get_Parent: VBE; safecall;
    function Get_VBE: VBE; safecall;
    function Item(index: OleVariant): CodePane; safecall;
    function Get_Count: Integer; safecall;
    function _NewEnum: IUnknown; safecall;
    function Get_Current: CodePane; safecall;
    procedure Set_Current(const CodePane: CodePane); safecall;
    property Parent: VBE read Get_Parent;
    property VBE: VBE read Get_VBE;
    property Count: Integer read Get_Count;
    property Current: CodePane read Get_Current write Set_Current;
  end;

// *********************************************************************//
// DispIntf:  _CodePanesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002E172-0000-0000-C000-000000000046}
// *********************************************************************//
  _CodePanesDisp = dispinterface
    ['{0002E172-0000-0000-C000-000000000046}']
    property Parent: VBE readonly dispid 1610743808;
    property VBE: VBE readonly dispid 1610743809;
    function Item(index: OleVariant): CodePane; dispid 0;
    property Count: Integer readonly dispid 1610743811;
    function _NewEnum: IUnknown; dispid -4;
    property Current: CodePane dispid 1610743813;
  end;

// *********************************************************************//
// Interface: _CodePane
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002E176-0000-0000-C000-000000000046}
// *********************************************************************//
  _CodePane = interface(IDispatch)
    ['{0002E176-0000-0000-C000-000000000046}']
    function Get_Collection: CodePanes; safecall;
    function Get_VBE: VBE; safecall;
    function Get_Window: Window; safecall;
    procedure GetSelection(out StartLine: Integer; out StartColumn: Integer; out EndLine: Integer; 
                           out EndColumn: Integer); safecall;
    procedure SetSelection(StartLine: Integer; StartColumn: Integer; EndLine: Integer; 
                           EndColumn: Integer); safecall;
    function Get_TopLine: Integer; safecall;
    procedure Set_TopLine(TopLine: Integer); safecall;
    function Get_CountOfVisibleLines: Integer; safecall;
    function Get_CodeModule: CodeModule; safecall;
    procedure Show; safecall;
    function Get_CodePaneView: vbext_CodePaneview; safecall;
    property Collection: CodePanes read Get_Collection;
    property VBE: VBE read Get_VBE;
    property Window: Window read Get_Window;
    property TopLine: Integer read Get_TopLine write Set_TopLine;
    property CountOfVisibleLines: Integer read Get_CountOfVisibleLines;
    property CodeModule: CodeModule read Get_CodeModule;
    property CodePaneView: vbext_CodePaneview read Get_CodePaneView;
  end;

// *********************************************************************//
// DispIntf:  _CodePaneDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002E176-0000-0000-C000-000000000046}
// *********************************************************************//
  _CodePaneDisp = dispinterface
    ['{0002E176-0000-0000-C000-000000000046}']
    property Collection: CodePanes readonly dispid 1610743808;
    property VBE: VBE readonly dispid 1610743809;
    property Window: Window readonly dispid 1610743810;
    procedure GetSelection(out StartLine: Integer; out StartColumn: Integer; out EndLine: Integer; 
                           out EndColumn: Integer); dispid 1610743811;
    procedure SetSelection(StartLine: Integer; StartColumn: Integer; EndLine: Integer; 
                           EndColumn: Integer); dispid 1610743812;
    property TopLine: Integer dispid 1610743813;
    property CountOfVisibleLines: Integer readonly dispid 1610743815;
    property CodeModule: CodeModule readonly dispid 1610743816;
    procedure Show; dispid 1610743817;
    property CodePaneView: vbext_CodePaneview readonly dispid 1610743818;
  end;

// *********************************************************************//
// Interface: _References
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002E17A-0000-0000-C000-000000000046}
// *********************************************************************//
  _References = interface(IDispatch)
    ['{0002E17A-0000-0000-C000-000000000046}']
    function Get_Parent: VBProject; safecall;
    function Get_VBE: VBE; safecall;
    function Item(index: OleVariant): Reference; safecall;
    function Get_Count: Integer; safecall;
    function _NewEnum: IUnknown; safecall;
    function AddFromGuid(const Guid: WideString; Major: Integer; Minor: Integer): Reference; safecall;
    function AddFromFile(const FileName: WideString): Reference; safecall;
    procedure Remove(const Reference: Reference); safecall;
    property Parent: VBProject read Get_Parent;
    property VBE: VBE read Get_VBE;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  _ReferencesDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002E17A-0000-0000-C000-000000000046}
// *********************************************************************//
  _ReferencesDisp = dispinterface
    ['{0002E17A-0000-0000-C000-000000000046}']
    property Parent: VBProject readonly dispid 1610743808;
    property VBE: VBE readonly dispid 1610743809;
    function Item(index: OleVariant): Reference; dispid 0;
    property Count: Integer readonly dispid 1610743811;
    function _NewEnum: IUnknown; dispid -4;
    function AddFromGuid(const Guid: WideString; Major: Integer; Minor: Integer): Reference; dispid 1610743813;
    function AddFromFile(const FileName: WideString): Reference; dispid 1610743814;
    procedure Remove(const Reference: Reference); dispid 1610743815;
  end;

// *********************************************************************//
// Interface: Reference
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002E17E-0000-0000-C000-000000000046}
// *********************************************************************//
  Reference = interface(IDispatch)
    ['{0002E17E-0000-0000-C000-000000000046}']
    function Get_Collection: References; safecall;
    function Get_VBE: VBE; safecall;
    function Get_Name: WideString; safecall;
    function Get_Guid: WideString; safecall;
    function Get_Major: Integer; safecall;
    function Get_Minor: Integer; safecall;
    function Get_FullPath: WideString; safecall;
    function Get_BuiltIn: WordBool; safecall;
    function Get_IsBroken: WordBool; safecall;
    function Get_type_: vbext_RefKind; safecall;
    function Get_Description: WideString; safecall;
    property Collection: References read Get_Collection;
    property VBE: VBE read Get_VBE;
    property Name: WideString read Get_Name;
    property Guid: WideString read Get_Guid;
    property Major: Integer read Get_Major;
    property Minor: Integer read Get_Minor;
    property FullPath: WideString read Get_FullPath;
    property BuiltIn: WordBool read Get_BuiltIn;
    property IsBroken: WordBool read Get_IsBroken;
    property type_: vbext_RefKind read Get_type_;
    property Description: WideString read Get_Description;
  end;

// *********************************************************************//
// DispIntf:  ReferenceDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002E17E-0000-0000-C000-000000000046}
// *********************************************************************//
  ReferenceDisp = dispinterface
    ['{0002E17E-0000-0000-C000-000000000046}']
    property Collection: References readonly dispid 1610743808;
    property VBE: VBE readonly dispid 1610743809;
    property Name: WideString readonly dispid 1610743810;
    property Guid: WideString readonly dispid 1610743811;
    property Major: Integer readonly dispid 1610743812;
    property Minor: Integer readonly dispid 1610743813;
    property FullPath: WideString readonly dispid 1610743814;
    property BuiltIn: WordBool readonly dispid 1610743815;
    property IsBroken: WordBool readonly dispid 1610743816;
    property type_: vbext_RefKind readonly dispid 1610743817;
    property Description: WideString readonly dispid 1610743818;
  end;

// *********************************************************************//
// DispIntf:  _dispReferences_Events
// Flags:     (4240) Hidden NonExtensible Dispatchable
// GUID:      {CDDE3804-2064-11CF-867F-00AA005FF34A}
// *********************************************************************//
  _dispReferences_Events = dispinterface
    ['{CDDE3804-2064-11CF-867F-00AA005FF34A}']
    procedure ItemAdded(const Reference: Reference); dispid 0;
    procedure ItemRemoved(const Reference: Reference); dispid 1;
  end;

// *********************************************************************//
// The Class CoWindows provides a Create and CreateRemote method to          
// create instances of the default interface _Windows exposed by              
// the CoClass Windows. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoWindows = class
    class function Create: _Windows;
    class function CreateRemote(const MachineName: string): _Windows;
  end;

// *********************************************************************//
// The Class CoLinkedWindows provides a Create and CreateRemote method to          
// create instances of the default interface _LinkedWindows exposed by              
// the CoClass LinkedWindows. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLinkedWindows = class
    class function Create: _LinkedWindows;
    class function CreateRemote(const MachineName: string): _LinkedWindows;
  end;

// *********************************************************************//
// The Class CoReferencesEvents provides a Create and CreateRemote method to          
// create instances of the default interface _ReferencesEvents exposed by              
// the CoClass ReferencesEvents. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoReferencesEvents = class
    class function Create: _ReferencesEvents;
    class function CreateRemote(const MachineName: string): _ReferencesEvents;
  end;

// *********************************************************************//
// The Class CoCommandBarEvents provides a Create and CreateRemote method to          
// create instances of the default interface _CommandBarControlEvents exposed by              
// the CoClass CommandBarEvents. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCommandBarEvents = class
    class function Create: _CommandBarControlEvents;
    class function CreateRemote(const MachineName: string): _CommandBarControlEvents;
  end;

// *********************************************************************//
// The Class CoProjectTemplate provides a Create and CreateRemote method to          
// create instances of the default interface _ProjectTemplate exposed by              
// the CoClass ProjectTemplate. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoProjectTemplate = class
    class function Create: _ProjectTemplate;
    class function CreateRemote(const MachineName: string): _ProjectTemplate;
  end;

// *********************************************************************//
// The Class CoVBProject provides a Create and CreateRemote method to          
// create instances of the default interface _VBProject exposed by              
// the CoClass VBProject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoVBProject = class
    class function Create: _VBProject;
    class function CreateRemote(const MachineName: string): _VBProject;
  end;

// *********************************************************************//
// The Class CoVBProjects provides a Create and CreateRemote method to          
// create instances of the default interface _VBProjects exposed by              
// the CoClass VBProjects. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoVBProjects = class
    class function Create: _VBProjects;
    class function CreateRemote(const MachineName: string): _VBProjects;
  end;

// *********************************************************************//
// The Class CoComponents provides a Create and CreateRemote method to          
// create instances of the default interface _Components exposed by              
// the CoClass Components. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoComponents = class
    class function Create: _Components;
    class function CreateRemote(const MachineName: string): _Components;
  end;

// *********************************************************************//
// The Class CoVBComponents provides a Create and CreateRemote method to          
// create instances of the default interface _VBComponents exposed by              
// the CoClass VBComponents. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoVBComponents = class
    class function Create: _VBComponents;
    class function CreateRemote(const MachineName: string): _VBComponents;
  end;

// *********************************************************************//
// The Class CoComponent provides a Create and CreateRemote method to          
// create instances of the default interface _Component exposed by              
// the CoClass Component. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoComponent = class
    class function Create: _Component;
    class function CreateRemote(const MachineName: string): _Component;
  end;

// *********************************************************************//
// The Class CoVBComponent provides a Create and CreateRemote method to          
// create instances of the default interface _VBComponent exposed by              
// the CoClass VBComponent. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoVBComponent = class
    class function Create: _VBComponent;
    class function CreateRemote(const MachineName: string): _VBComponent;
  end;

// *********************************************************************//
// The Class CoProperties provides a Create and CreateRemote method to          
// create instances of the default interface _Properties exposed by              
// the CoClass Properties. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoProperties = class
    class function Create: _Properties;
    class function CreateRemote(const MachineName: string): _Properties;
  end;

// *********************************************************************//
// The Class CoAddins provides a Create and CreateRemote method to          
// create instances of the default interface _AddIns exposed by              
// the CoClass Addins. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAddins = class
    class function Create: _AddIns;
    class function CreateRemote(const MachineName: string): _AddIns;
  end;

// *********************************************************************//
// The Class CoCodeModule provides a Create and CreateRemote method to          
// create instances of the default interface _CodeModule exposed by              
// the CoClass CodeModule. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCodeModule = class
    class function Create: _CodeModule;
    class function CreateRemote(const MachineName: string): _CodeModule;
  end;

// *********************************************************************//
// The Class CoCodePanes provides a Create and CreateRemote method to          
// create instances of the default interface _CodePanes exposed by              
// the CoClass CodePanes. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCodePanes = class
    class function Create: _CodePanes;
    class function CreateRemote(const MachineName: string): _CodePanes;
  end;

// *********************************************************************//
// The Class CoCodePane provides a Create and CreateRemote method to          
// create instances of the default interface _CodePane exposed by              
// the CoClass CodePane. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCodePane = class
    class function Create: _CodePane;
    class function CreateRemote(const MachineName: string): _CodePane;
  end;

// *********************************************************************//
// The Class CoReferences provides a Create and CreateRemote method to          
// create instances of the default interface _References exposed by              
// the CoClass References. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoReferences = class
    class function Create: _References;
    class function CreateRemote(const MachineName: string): _References;
  end;

implementation

uses ComObj;

class function CoWindows.Create: _Windows;
begin
  Result := CreateComObject(CLASS_Windows) as _Windows;
end;

class function CoWindows.CreateRemote(const MachineName: string): _Windows;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Windows) as _Windows;
end;

class function CoLinkedWindows.Create: _LinkedWindows;
begin
  Result := CreateComObject(CLASS_LinkedWindows) as _LinkedWindows;
end;

class function CoLinkedWindows.CreateRemote(const MachineName: string): _LinkedWindows;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LinkedWindows) as _LinkedWindows;
end;

class function CoReferencesEvents.Create: _ReferencesEvents;
begin
  Result := CreateComObject(CLASS_ReferencesEvents) as _ReferencesEvents;
end;

class function CoReferencesEvents.CreateRemote(const MachineName: string): _ReferencesEvents;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ReferencesEvents) as _ReferencesEvents;
end;

class function CoCommandBarEvents.Create: _CommandBarControlEvents;
begin
  Result := CreateComObject(CLASS_CommandBarEvents) as _CommandBarControlEvents;
end;

class function CoCommandBarEvents.CreateRemote(const MachineName: string): _CommandBarControlEvents;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CommandBarEvents) as _CommandBarControlEvents;
end;

class function CoProjectTemplate.Create: _ProjectTemplate;
begin
  Result := CreateComObject(CLASS_ProjectTemplate) as _ProjectTemplate;
end;

class function CoProjectTemplate.CreateRemote(const MachineName: string): _ProjectTemplate;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ProjectTemplate) as _ProjectTemplate;
end;

class function CoVBProject.Create: _VBProject;
begin
  Result := CreateComObject(CLASS_VBProject) as _VBProject;
end;

class function CoVBProject.CreateRemote(const MachineName: string): _VBProject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_VBProject) as _VBProject;
end;

class function CoVBProjects.Create: _VBProjects;
begin
  Result := CreateComObject(CLASS_VBProjects) as _VBProjects;
end;

class function CoVBProjects.CreateRemote(const MachineName: string): _VBProjects;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_VBProjects) as _VBProjects;
end;

class function CoComponents.Create: _Components;
begin
  Result := CreateComObject(CLASS_Components) as _Components;
end;

class function CoComponents.CreateRemote(const MachineName: string): _Components;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Components) as _Components;
end;

class function CoVBComponents.Create: _VBComponents;
begin
  Result := CreateComObject(CLASS_VBComponents) as _VBComponents;
end;

class function CoVBComponents.CreateRemote(const MachineName: string): _VBComponents;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_VBComponents) as _VBComponents;
end;

class function CoComponent.Create: _Component;
begin
  Result := CreateComObject(CLASS_Component) as _Component;
end;

class function CoComponent.CreateRemote(const MachineName: string): _Component;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Component) as _Component;
end;

class function CoVBComponent.Create: _VBComponent;
begin
  Result := CreateComObject(CLASS_VBComponent) as _VBComponent;
end;

class function CoVBComponent.CreateRemote(const MachineName: string): _VBComponent;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_VBComponent) as _VBComponent;
end;

class function CoProperties.Create: _Properties;
begin
  Result := CreateComObject(CLASS_Properties) as _Properties;
end;

class function CoProperties.CreateRemote(const MachineName: string): _Properties;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Properties) as _Properties;
end;

class function CoAddins.Create: _AddIns;
begin
  Result := CreateComObject(CLASS_Addins) as _AddIns;
end;

class function CoAddins.CreateRemote(const MachineName: string): _AddIns;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Addins) as _AddIns;
end;

class function CoCodeModule.Create: _CodeModule;
begin
  Result := CreateComObject(CLASS_CodeModule) as _CodeModule;
end;

class function CoCodeModule.CreateRemote(const MachineName: string): _CodeModule;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CodeModule) as _CodeModule;
end;

class function CoCodePanes.Create: _CodePanes;
begin
  Result := CreateComObject(CLASS_CodePanes) as _CodePanes;
end;

class function CoCodePanes.CreateRemote(const MachineName: string): _CodePanes;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CodePanes) as _CodePanes;
end;

class function CoCodePane.Create: _CodePane;
begin
  Result := CreateComObject(CLASS_CodePane) as _CodePane;
end;

class function CoCodePane.CreateRemote(const MachineName: string): _CodePane;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CodePane) as _CodePane;
end;

class function CoReferences.Create: _References;
begin
  Result := CreateComObject(CLASS_References) as _References;
end;

class function CoReferences.CreateRemote(const MachineName: string): _References;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_References) as _References;
end;

end.
