page 55811 "Hist. acciones de personal"
{
    Caption = 'Historical personnel actions';
    Editable = false;
    PageType = List;
    SourceTable = 55800;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Tipo de accion"; Rec."Tipo de accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de accion';
                }
                field("Cod. accion"; Rec."Cod. accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. accion';
                }
                field("No. empleado"; Rec."No. empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. empleado';
                    Visible = false;
                }
                field("Nombre completo"; Rec."Nombre completo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre completo';
                }
                field("ID Documento"; Rec."ID Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Documento';
                }
                field("Descripcion accion"; Rec."Descripcion accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion accion';
                }
                field("Fecha accion"; Rec."Fecha accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha accion';
                }
                field("Fecha efectividad"; Rec."Fecha efectividad")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha efectividad';
                }
                field(Comentario; Rec.Comentario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario';
                }
                field("Cargo actual"; Rec."Cargo actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cargo actual';
                }
                field("Descripcion cargo actual"; Rec."Descripcion cargo actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion cargo actual';
                }
                field("Nuevo cargo"; Rec."Nuevo cargo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nuevo cargo';
                }
                field("Descripcion cargo nuevo"; Rec."Descripcion cargo nuevo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion cargo nuevo';
                }
                field("Sueldo actual"; Rec."Sueldo actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sueldo actual';
                }
                field("Sueldo Nuevo"; Rec."Sueldo Nuevo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sueldo Nuevo';
                }
                field("Departamento actual"; Rec."Departamento actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Departamento actual';
                }
                field("Nombre  depto. actual"; Rec."Nombre  depto. actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre  depto. actual';
                }
                field("Departamento nuevo"; Rec."Departamento nuevo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Departamento nuevo';
                }
                field("Nombre depto. nuevo"; Rec."Nombre depto. nuevo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre depto. nuevo';
                }
                field("Ubicacion actual"; Rec."Ubicacion actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ubicacion actual';
                }
                field("Ubicacion nueva"; Rec."Ubicacion nueva")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ubicacion nueva';
                }
                field("Empresa nueva"; Rec."Empresa nueva")
                {
                    ApplicationArea = All;
                    ToolTip = 'Empresa nueva';
                }
                field("Numero cuenta actual"; Rec."Numero cuenta actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero cuenta actual';
                }
                field("Numero cuenta nueva"; Rec."Numero cuenta nueva")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero cuenta nueva';
                }
                field("Nivel actual"; Rec."Nivel actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nivel actual';
                }
                field("Nivel nuevo"; Rec."Nivel nuevo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nivel nuevo';
                }
                field("Tipo de contrato"; Rec."Tipo de contrato")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de contrato';
                }
                field("Preparado por"; Rec."Preparado por")
                {
                    ApplicationArea = All;
                    ToolTip = 'Preparado por';
                }
                field("Revisado por"; Rec."Revisado por")
                {
                    ApplicationArea = All;
                    ToolTip = 'Revisado por';
                }
                field("Autorizado por"; Rec."Autorizado por")
                {
                    ApplicationArea = All;
                    ToolTip = 'Autorizado por';
                }
                field("No. serie"; Rec."No. serie")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. serie';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document Type';
                }
                field(Preaviso; Rec.Preaviso)
                {
                    ApplicationArea = All;
                    ToolTip = 'Preaviso';
                }
                field(Cesantia; Rec.Cesantia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cesantia';
                }
                field(Regalia; Rec.Regalia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Regalia';
                }
                field("Duracion contrato"; Rec."Duracion contrato")
                {
                    ApplicationArea = All;
                    ToolTip = 'Duracion contrato';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'First Name';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Middle Name';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Last Name';
                }
                field("Second Last Name"; Rec."Second Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Second Last Name';
                }
                field("Cod. elegible"; Rec."Cod. elegible")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. elegible';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Address';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Address 2';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'City';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Post Code';
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'County';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Country/Region Code';
                }
                field("URL Linkedin"; Rec."URL Linkedin")
                {
                    ApplicationArea = All;
                    ToolTip = 'URL Linkedin';
                }
                field("URL Facebook"; Rec."URL Facebook")
                {
                    ApplicationArea = All;
                    ToolTip = 'URL Facebook';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Gender';
                }
                field("Lugar nacimiento"; Rec."Lugar nacimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Lugar nacimiento';
                }
                field("Estado civil"; Rec."Estado civil")
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado civil';
                }
                field("Comentario 2"; Rec."Comentario 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario 2';
                }
                field("Cod. Banco"; Rec."Cod. Banco")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Banco';
                }
                field("Fecha expiracion"; Rec."Fecha expiracion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha expiracion';
                }
                field("Numero tarjeta"; Rec."Numero tarjeta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero tarjeta';
                }
                field("Importe tarjeta"; Rec."Importe tarjeta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe tarjeta';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Actions")
            {
                Caption = '&Actions';
                action(Print)
                {
                    ApplicationArea = All;
                    Caption = 'Print';
                    ToolTip = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Acciones: Record 55800;
                    // TODO: Manual review - Custom report 55802 is unavailable as the required object type.
                    // Original code: RepAcciones: Report 55802;
                    begin
                        CurrPage.SETSELECTIONFILTER(Acciones);
                        // TODO: Manual review - The custom Hist Acciones de personal report is unavailable in the current repository.
                        // Original code: REPORT.RUN(REPORT::"Hist Acciones de personal", TRUE, TRUE, Acciones);
                    end;
                }

                action(corregir)
                {
                    ApplicationArea = All;
                    Caption = 'corregir';
                    ToolTip = 'corregir';
                    Image = VoidRegister;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Accionesdepersonal: Record 55774;
                    begin
                        Accionesdepersonal.TRANSFERFIELDS(Rec);
                        Accionesdepersonal."Tipo de accion" := Accionesdepersonal."Tipo de accion"::Cambio;
                        Accionesdepersonal."Cod. accion" := '';
                        Accionesdepersonal.INSERT;

                        MESSAGE(Msg001);
                    end;
                }
            }
        }
    }

    var
        Msg001: Label 'The action of a personal has been returned to draft for correction, please verify';
}

