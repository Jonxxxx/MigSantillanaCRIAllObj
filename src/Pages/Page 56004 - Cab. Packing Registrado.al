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
                field("No."; "No.")
                {
                }
                field("Cod. Empleado"; "Cod. Empleado")
                {
                }
                field("No. Mesa"; "No. Mesa")
                {
                }
                field("Picking No."; "Picking No.")
                {
                    Enabled = TieneGestionAlmacen;
                    Visible = TieneGestionAlmacen;
                }
                field("No. Packing Origen"; "No. Packing Origen")
                {
                }
                field("Tipo pedido"; "Tipo pedido")
                {
                }
                field("No. Pedido"; "No. Pedido")
                {
                    Enabled = NOT TieneGestionAlmacen;
                    Visible = NOT TieneGestionAlmacen;
                }
                field("Fecha Apertura"; "Fecha Apertura")
                {
                }
                field("Fecha Registro"; "Fecha Registro")
                {
                }
                field("Hora Finalizacion"; "Hora Finalizacion")
                {
                }
            }
            part(; 56005)
            {
                SubPageLink = No.=FIELD("No.");
                    SubPageView = SORTING(No.,No. Caja)
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
                    /*
                    Persona := Persona.Person;
                    Persona.FirstName := 'Agustin';
                    Persona.LasName := 'Mendez';
                    MESSAGE(Persona.FirstName + ' '+Persona.LasName);
                    */
                    /*
                    UsrSetUp.GET(USERID);
                    texComando := 'Copy C:\Users\kgutierrez\Downloads\'+FORMAT(FormatUser(USERID))+'.txt'+' '+ UsrSetUp."Puerto Impresora Etiquetas";
                    //texComando := 'C:\Users\kgutierrez\Downloads\'+FORMAT(FormatUser(USERID))+'.txt';
                    ExecuteBat := ExecuteBat.ProcessStartInfo('"cmd.exe", "/c "' + texComando + '"');
                    ExecuteBat.RedirectStandardError := TRUE;
                    ExecuteBat.RedirectStandardOutput := TRUE;
                    ExecuteBat.UseShellExecute := FALSE;
                    ExecuteBat.CreateNoWindow := TRUE;
                    Process := Process.Process;
                    Process.StartInfo(ExecuteBat);
                    Process.Start;
                    */

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

