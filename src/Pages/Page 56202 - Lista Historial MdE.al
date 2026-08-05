page 55355 "Lista Historial MdE"
{
    // #81969 27/01/2018 PLB: Pagina para el "Historial MdE"

    ApplicationArea = All;
    DataCaptionExpression = STRSUBSTNO('%1-%2', "No.", "Nombre completo");
    Editable = false;
    PageType = List;
    SourceTable = 55355;
    SourceTableView = SORTING("No.", "No. Mov.")
                      ORDER(Descending);
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field("No. Mov."; Rec."No. Mov.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Mov.';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Tipo envio"; Rec."Tipo envio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo envio';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Fecha y hora recepcion"; Rec."Fecha y hora recepcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha y hora recepcion';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Fecha efectiva"; Rec."Fecha efectiva")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha efectiva';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Aplicado; Rec.Aplicado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Aplicado';
                }
                field("Fecha y hora aplicado"; Rec."Fecha y hora aplicado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha y hora aplicado';
                    Visible = false;
                }
                field("Aplicado por usuario"; Rec."Aplicado por usuario")
                {
                    ApplicationArea = All;
                    ToolTip = 'Aplicado por usuario';
                    Visible = false;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'First Name';
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
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                    ToolTip = 'Initials';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Title';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Address';
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
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Phone No.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Mobile Phone No.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Birth Date';
                }
                field("Social Security No."; Rec."Social Security No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Social Security No.';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Gender';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Country/Region Code';
                }
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Emplymt. Contract Code';
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Statistics Group Code';
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employment Date';
                }
                field("Inactive Date"; Rec."Inactive Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Inactive Date';
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cause of Inactivity Code';
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Termination Date';
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grounds for Term. Code';
                }
                field(_Categoria; Rec._Categoria)
                {
                    ApplicationArea = All;
                    ToolTip = '_Categoria';
                }
                field("Numero de persona"; Rec."Numero de persona")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero de persona';
                }
                field("Cod. Dimension"; Rec."Cod. Dimension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Dimension';
                }
                field("Valor Dimension"; Rec."Valor Dimension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valor Dimension';
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                    ToolTip = 'Company';
                }
                field("Working Center"; Rec."Working Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Working Center';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document Type';
                }
                field("Document ID"; Rec."Document ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document ID';
                }
                field("Job Type Code"; Rec."Job Type Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Type Code';
                }
                field("Alta contrato"; Rec."Alta contrato")
                {
                    ApplicationArea = All;
                    ToolTip = 'Alta contrato';
                }
                field("Fin contrato"; Rec."Fin contrato")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fin contrato';
                }
                field(_Nacionalidad; Rec._Nacionalidad)
                {
                    ApplicationArea = All;
                    ToolTip = '_Nacionalidad';
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
                field("Mes Nacimiento"; Rec."Mes Nacimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Mes Nacimiento';
                }
                field(_Departamento; Rec._Departamento)
                {
                    ApplicationArea = All;
                    ToolTip = '_Departamento';
                }
                field("Error proceso"; Rec."Error proceso")
                {
                    ApplicationArea = All;
                    ToolTip = 'Error proceso';
                    Visible = ShowError;
                }
                field("Descripcion error"; Rec."Descripcion error")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion error';
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
                ApplicationArea = All;
                Caption = 'Aplicar cambio';
                ToolTip = 'Aplicar cambio';
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

