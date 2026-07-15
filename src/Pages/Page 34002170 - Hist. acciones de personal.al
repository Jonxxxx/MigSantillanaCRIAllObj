page 34002170 "Hist. acciones de personal"
{
    Caption = 'Historical personnel actions';
    Editable = false;
    PageType = List;
    SourceTable = 34002159;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Tipo de accion"; "Tipo de accion")
                {
                }
                field("Cod. accion"; "Cod. accion")
                {
                }
                field("No. empleado"; "No. empleado")
                {
                    Visible = false;
                }
                field("Nombre completo"; "Nombre completo")
                {
                }
                field("ID Documento"; "ID Documento")
                {
                }
                field("Descripcion accion"; "Descripcion accion")
                {
                }
                field("Fecha accion"; "Fecha accion")
                {
                }
                field("Fecha efectividad"; "Fecha efectividad")
                {
                }
                field(Comentario; Comentario)
                {
                }
                field("Cargo actual"; "Cargo actual")
                {
                }
                field("Descripcion cargo actual"; "Descripcion cargo actual")
                {
                }
                field("Nuevo cargo"; "Nuevo cargo")
                {
                }
                field("Descripcion cargo nuevo"; "Descripcion cargo nuevo")
                {
                }
                field("Sueldo actual"; "Sueldo actual")
                {
                }
                field("Sueldo Nuevo"; "Sueldo Nuevo")
                {
                }
                field("Departamento actual"; "Departamento actual")
                {
                }
                field("Nombre  depto. actual"; "Nombre  depto. actual")
                {
                }
                field("Departamento nuevo"; "Departamento nuevo")
                {
                }
                field("Nombre depto. nuevo"; "Nombre depto. nuevo")
                {
                }
                field("Ubicacion actual"; "Ubicacion actual")
                {
                }
                field("Ubicacion nueva"; "Ubicacion nueva")
                {
                }
                field("Empresa nueva"; "Empresa nueva")
                {
                }
                field("Numero cuenta actual"; "Numero cuenta actual")
                {
                }
                field("Numero cuenta nueva"; "Numero cuenta nueva")
                {
                }
                field("Nivel actual"; "Nivel actual")
                {
                }
                field("Nivel nuevo"; "Nivel nuevo")
                {
                }
                field("Tipo de contrato"; "Tipo de contrato")
                {
                }
                field("Preparado por"; "Preparado por")
                {
                }
                field("Revisado por"; "Revisado por")
                {
                }
                field("Autorizado por"; "Autorizado por")
                {
                }
                field("No. serie"; "No. serie")
                {
                }
                field("No."; "No.")
                {
                }
                field("Document Type"; "Document Type")
                {
                }
                field(Preaviso; Preaviso)
                {
                }
                field(Cesantia; Cesantia)
                {
                }
                field(Regalia; Regalia)
                {
                }
                field("Duracion contrato"; "Duracion contrato")
                {
                }
                field("First Name"; "First Name")
                {
                }
                field("Middle Name"; "Middle Name")
                {
                }
                field("Last Name"; "Last Name")
                {
                }
                field("Second Last Name"; "Second Last Name")
                {
                }
                field("Cod. elegible"; "Cod. elegible")
                {
                }
                field(Address; Address)
                {
                }
                field("Address 2"; "Address 2")
                {
                }
                field(City; City)
                {
                }
                field("Post Code"; "Post Code")
                {
                }
                field(County; County)
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field("URL Linkedin"; "URL Linkedin")
                {
                }
                field("URL Facebook"; "URL Facebook")
                {
                }
                field(Gender; Gender)
                {
                }
                field("Lugar nacimiento"; "Lugar nacimiento")
                {
                }
                field("Estado civil"; "Estado civil")
                {
                }
                field("Comentario 2"; "Comentario 2")
                {
                }
                field("Cod. Banco"; "Cod. Banco")
                {
                }
                field("Fecha expiracion"; "Fecha expiracion")
                {
                }
                field("Numero tarjeta"; "Numero tarjeta")
                {
                }
                field("Importe tarjeta"; "Importe tarjeta")
                {
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
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Acciones: Record 34002159;
                    //TODO: Ver RepAcciones: Report 34002161;
                    begin
                        CurrPage.SETSELECTIONFILTER(Acciones);
                        //TODO: Ver REPORT.RUN(REPORT::"Hist Acciones de personal", TRUE, TRUE, Acciones);
                    end;
                }

                action(corregir)
                {
                    Image = VoidRegister;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Accionesdepersonal: Record 34002133;
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

