page 56004 "Cab. Packing Registrado"
{
    // Proyecto: Implementacion Microsoft Dynamics Nav
    // AMS     : Agustin Mendez
    // GRN     : Guillermo Roman
    // ------------------------------------------------------------------------
    // No.         Firma   Fecha         Descripcion
    // ------------------------------------------------------------------------
    // #854        PLB     05/12/2013    Añadido campo "No. Pedido"
    //                                   Mostrar/ocultar "No. picking" o "No. pedido"

    ApplicationArea = Basic, Suite;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    SourceTable = 56033;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field("Cod. Empleado"; Rec."Cod. Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Empleado';
                }
                field("No. Mesa"; Rec."No. Mesa")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Mesa';
                }
                field("Picking No."; Rec."Picking No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Picking No.';
                    Enabled = TieneGestionAlmacen;
                    Visible = TieneGestionAlmacen;
                }
                field("No. Packing Origen"; Rec."No. Packing Origen")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Packing Origen';
                }
                field("Tipo pedido"; Rec."Tipo pedido")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo pedido';
                }
                field("No. Pedido"; Rec."No. Pedido")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Pedido';
                    Enabled = NOT TieneGestionAlmacen;
                    Visible = NOT TieneGestionAlmacen;
                }
                field("Fecha Apertura"; Rec."Fecha Apertura")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Apertura';
                }
                field("Fecha Registro"; Rec."Fecha Registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Registro';
                }
                field("Hora Finalizacion"; Rec."Hora Finalizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Finalizacion';
                }
            }
            part(PageLin; 56005)
            {
                SubPageLink = "No." = FIELD("No.");
                SubPageView = SORTING("No.", "No. Caja")
                              ORDER(Ascending);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Imprimir etiquetas")
            {
                ApplicationArea = All;
                Caption = 'Imprimir etiquetas';
                ToolTip = 'Imprimir etiquetas';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ConfSant: Record 56001;
                    CabPackReg: Record 56033;
                begin
                    ConfSant.GET;
                    ConfSant.TESTFIELD("ID Reporte Etiqueta de Caja");

                    CabPackReg.RESET;
                    CabPackReg.SETRANGE("No.", "No.");
                    IF CabPackReg.FINDFIRST THEN
                        REPORT.RUNMODAL(ConfSant."ID Reporte Etiqueta de Caja", FALSE, FALSE, CabPackReg);
                    //REPORT.RUNMODAL(ConfSant."ID Reporte Etiqueta de Caja", TRUE, FALSE, CabPackReg);
                end;
            }

            // TODO: Manual review - The disabled action uses DotNet process execution, a Windows batch file, a server path, and RunOnClient, which require a SaaS-compatible printing redesign.
            /*
            action(ejecuta)
            {
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    texComando: Text;
                    texFrom: Text;
                    texTo: Text;
                    ExecuteBat: DotNet ProcessStartInfo;
                    Process: DotNet Process;
                    Command: Text[200];
                    Result: Text[200];
                    ErrorMSg: Text[200];
                    UsrSetUp: Record 91;
                    [RunOnClient]
                    Persona: DotNet Person;
                begin                    

                    UsrSetUp.GET(USERID);
                    texComando := '"C:\Etiqueta\BTC1.bat"';
                    //texComando := 'Copy C:\Etiqueta\'+FORMAT(FormatUser(USERID))+'.txt'+' '+ UsrSetUp."Puerto Impresora Etiquetas";
                    //texComando := 'Copy C:\Etiqueta\BTC1.bat'+' '+ UsrSetUp."Puerto Impresora Etiquetas";
                    ExecuteBat := ExecuteBat.ProcessStartInfo('cmd', '/c "' + texComando + '"');
                    ExecuteBat.RedirectStandardError := TRUE;
                    ExecuteBat.RedirectStandardOutput := TRUE;
                    ExecuteBat.UseShellExecute := FALSE;
                    ExecuteBat.CreateNoWindow := TRUE;
                    Process := Process.Process;
                    Process.StartInfo(ExecuteBat);
                    Process.Start;

                    ErrorMSg := Process.StandardError.ReadToEnd(); // Check Error Exist or Not
                    IF ErrorMSg <> '' THEN
                        ERROR('%1', ErrorMSg)

                    ELSE BEGIN

                        Result := Process.StandardOutput.ReadToEnd();// Display the Query in the Batch File.

                        MESSAGE('%1', Result);
                    END;
                    //UsrSetUp.GET(USERID);
                    //Process.Start('"CMD.exe"','Copy C:\Users\kgutierrez\Downloads\'+'ll'+'.txt'+' '+ UsrSetUp."Puerto Impresora Etiquetas");

                end;
            }
            */
        }
    }

    trigger OnInit()
    begin
        TieneGestionAlmacen := FuncSant.TieneGestionAlmacen;
    end;

    var
        FuncSant: Codeunit 56000;
        [InDataSet]
        TieneGestionAlmacen: Boolean;

    procedure FormatUser(codPrmUsuario: Code[50]): Code[50]
    begin
        EXIT(DELCHR(codPrmUsuario, '=', '\'));
    end;
}

