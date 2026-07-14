page 56202 "Lista Historial MdE"
{
    // #81969 27/01/2018 PLB: Pagina para el "Historial MdE"

    ApplicationArea = Basic, Suite, Service;
    DataCaptionExpression = STRSUBSTNO('%1-%2', "No.", "Nombre completo");
    Editable = false;
    PageType = List;
    SourceTable = 56202;
    SourceTableView = SORTING("No.", "No. Mov.")
                      ORDER(Descending);
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field("No. Mov."; "No. Mov.")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Tipo envio"; "Tipo envio")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Fecha y hora recepcion"; "Fecha y hora recepcion")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Fecha efectiva"; "Fecha efectiva")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Aplicado; Aplicado)
                {
                }
                field("Fecha y hora aplicado"; "Fecha y hora aplicado")
                {
                    Visible = false;
                }
                field("Aplicado por usuario"; "Aplicado por usuario")
                {
                    Visible = false;
                }
                field("First Name"; "First Name")
                {
                }
                field("Last Name"; "Last Name")
                {
                }
                field("Second Last Name"; "Second Last Name")
                {
                }
                field(Initials; Initials)
                {
                }
                field("Job Title"; "Job Title")
                {
                }
                field(Address; Address)
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
                field("Phone No."; "Phone No.")
                {
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                }
                field("E-Mail"; "E-Mail")
                {
                }
                field("Birth Date"; "Birth Date")
                {
                }
                field("Social Security No."; "Social Security No.")
                {
                }
                field(Gender; Gender)
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field("Emplymt. Contract Code"; "Emplymt. Contract Code")
                {
                }
                field("Statistics Group Code"; "Statistics Group Code")
                {
                }
                field("Employment Date"; "Employment Date")
                {
                }
                field("Inactive Date"; "Inactive Date")
                {
                }
                field("Cause of Inactivity Code"; "Cause of Inactivity Code")
                {
                }
                field("Termination Date"; "Termination Date")
                {
                }
                field("Grounds for Term. Code"; "Grounds for Term. Code")
                {
                }
                field(_Categoria; _Categoria)
                {
                }
                field("Numero de persona"; "Numero de persona")
                {
                }
                field("Cod. Dimension"; "Cod. Dimension")
                {
                }
                field("Valor Dimension"; "Valor Dimension")
                {
                }
                field(Company; Company)
                {
                }
                field("Working Center"; "Working Center")
                {
                }
                field("Document Type"; "Document Type")
                {
                }
                field("Document ID"; "Document ID")
                {
                }
                field("Job Type Code"; "Job Type Code")
                {
                }
                field("Alta contrato"; "Alta contrato")
                {
                }
                field("Fin contrato"; "Fin contrato")
                {
                }
                field(_Nacionalidad; _Nacionalidad)
                {
                }
                field("Lugar nacimiento"; "Lugar nacimiento")
                {
                }
                field("Estado civil"; "Estado civil")
                {
                }
                field("Mes Nacimiento"; "Mes Nacimiento")
                {
                }
                field(_Departamento; _Departamento)
                {
                }
                field("Error proceso"; "Error proceso")
                {
                    Visible = ShowError;
                }
                field("Descripcion error"; "Descripcion error")
                {
                    Visible = ShowError;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Aplicar cambio")
            {
                Caption = 'Aplicar cambio';
                Enabled = NOT Aplicado;
                Image = Apply;
                Promoted = true;

                trigger OnAction()
                begin
                    IF CONFIRM(ConfirmTxt, FALSE) THEN
                        ApplyManualy;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CALCFIELDS("Nombre completo");
    end;

    trigger OnOpenPage()
    begin
        ShowError := (GETFILTER("Error proceso") <> '');
    end;

    var
        ConfirmTxt: Label 'Desea aplicar el cambio al empleado?';
        ShowError: Boolean;
}

