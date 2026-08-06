page 55843 "Employee List - Payroll"
{
    Caption = 'Employee List';
    CardPageID = "Employee Card";
    Editable = false;
    PageType = List;
    SourceTable = 5200;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field(FullName; FullName)
                {
                    ApplicationArea = All;
                    Caption = 'Full Name';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'First Name';
                    Visible = false;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Middle Name';
                    Visible = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Last Name';
                    Visible = false;
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                    ToolTip = 'Initials';
                    Visible = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Title';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Post Code';
                    Visible = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Country/Region Code';
                    Visible = false;
                }
                field(Extension; Rec.Extension)
                {
                    ApplicationArea = All;
                    ToolTip = 'Extension';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Phone No.';
                    Visible = false;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Mobile Phone No.';
                    Visible = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail';
                    Visible = false;
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Birth Date';
                }
                field("Mes Nacimiento"; Rec."Mes Nacimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Mes Nacimiento';
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Statistics Group Code';
                    Visible = false;
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Resource No.';
                    Visible = false;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Search Name';
                }
                field("Incentivos/Puntos"; Rec."Incentivos/Puntos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Incentivos/Puntos';
                }
                field(Departamento; Rec.Departamento)
                {
                    ApplicationArea = All;
                    ToolTip = 'Departamento';
                }
                field("Sub-Departamento"; Rec."Sub-Departamento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sub-Departamento';
                }
                field("Fecha salida empresa"; Rec."Fecha salida empresa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha salida empresa';
                }
                field(Salario; Rec.Salario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Salario';
                }
                field("Total ingresos"; Rec."Total ingresos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total ingresos';
                }
                field("Total deducciones"; Rec."Total deducciones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total deducciones';
                }
                field(Cuenta; Rec.Cuenta)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cuenta';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Comment';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    ToolTip = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 5222;
                    RunPageLink = "Table Name" = CONST(Employee),
                                  "No." = FIELD("No.");
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    action("Dimensions-Single")
                    {
                        ApplicationArea = All;
                        Caption = 'Dimensions-Single';
                        ToolTip = 'Dimensions-Single';
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(5200),
                                      "No." = FIELD("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                    }
                    action("Dimensions-&Multiple")
                    {

                        ApplicationArea = All;
                        Caption = 'Dimensions-&Multiple';
                        ToolTip = 'Dimensions-&Multiple';
                        trigger OnAction()
                        var
                            Employee: Record 5200;
                            DefaultDimMultiple: Page 542;
                        begin
                            CurrPage.SETSELECTIONFILTER(Employee);
                            DefaultDimMultiple.SetMultiEmployee(Employee);
                            DefaultDimMultiple.RUNMODAL;
                        end;
                    }
                }
                action("&Picture")
                {
                    ApplicationArea = All;
                    Caption = '&Picture';
                    ToolTip = '&Picture';
                    RunObject = Page 5202;
                    RunPageLink = "No." = FIELD("No.");
                }
                action("&Alternative Addresses")
                {
                    ApplicationArea = All;
                    Caption = '&Alternative Addresses';
                    ToolTip = '&Alternative Addresses';
                    RunObject = Page 5204;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Relati&ves")
                {
                    ApplicationArea = All;
                    Caption = 'Relati&ves';
                    ToolTip = 'Relati&ves';
                    RunObject = Page 5209;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Mi&sc. Article Information")
                {
                    ApplicationArea = All;
                    Caption = 'Mi&sc. Article Information';
                    ToolTip = 'Mi&sc. Article Information';
                    RunObject = Page 5219;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Con&fidential Information")
                {
                    ApplicationArea = All;
                    Caption = 'Con&fidential Information';
                    ToolTip = 'Con&fidential Information';
                    RunObject = Page 5221;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Q&ualifications")
                {
                    ApplicationArea = All;
                    Caption = 'Q&ualifications';
                    ToolTip = 'Q&ualifications';
                    RunObject = Page 5206;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("A&bsences")
                {
                    ApplicationArea = All;
                    Caption = 'A&bsences';
                    ToolTip = 'A&bsences';
                    RunObject = Page 5211;
                    RunPageLink = "Employee No." = FIELD("No.");
                }

                action("Absences b&y Categories")
                {
                    ApplicationArea = All;
                    Caption = 'Absences b&y Categories';
                    ToolTip = 'Absences b&y Categories';
                    RunObject = Page 5226;
                    RunPageLink = "No." = FIELD("No."),
                                  "Employee No. Filter" = FIELD("No.");
                }
                action("Misc. Articles &Overview")
                {
                    ApplicationArea = All;
                    Caption = 'Misc. Articles &Overview';
                    ToolTip = 'Misc. Articles &Overview';
                    RunObject = Page 5228;
                }
                action("Confidential Info. Overvie&w")
                {
                    ApplicationArea = All;
                    Caption = 'Confidential Info. Overvie&w';
                    ToolTip = 'Confidential Info. Overvie&w';
                    RunObject = Page 5229;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Parametros(GFiltro);
        ParamCompany(Emp);
        IF Emp <> '' THEN
            CHANGECOMPANY(Emp);
    end;

    var
        GFiltro: Date;
        Emp: Text[150];

    procedure Parametros(var Filtro: Date)
    begin
    end;

    procedure ParamCompany(Empresa: Text[150])
    begin
        Emp := Empresa
    end;
}

