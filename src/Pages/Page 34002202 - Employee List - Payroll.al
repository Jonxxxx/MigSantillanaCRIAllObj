page 34002202 "Employee List - Payroll"
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
                field("No."; "No.")
                {
                }
                field(FullName; FullName)
                {
                    Caption = 'Full Name';
                }
                field("First Name"; "First Name")
                {
                    Visible = false;
                }
                field("Middle Name"; "Middle Name")
                {
                    Visible = false;
                }
                field("Last Name"; "Last Name")
                {
                    Visible = false;
                }
                field(Initials; Initials)
                {
                    Visible = false;
                }
                field("Job Title"; "Job Title")
                {
                }
                field("Post Code"; "Post Code")
                {
                    Visible = false;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    Visible = false;
                }
                field(Extension; Extension)
                {
                }
                field("Phone No."; "Phone No.")
                {
                    Visible = false;
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                    Visible = false;
                }
                field("E-Mail"; "E-Mail")
                {
                    Visible = false;
                }
                field("Birth Date"; "Birth Date")
                {
                }
                field("Mes Nacimiento"; "Mes Nacimiento")
                {
                }
                field("Statistics Group Code"; "Statistics Group Code")
                {
                    Visible = false;
                }
                field("Resource No."; "Resource No.")
                {
                    Visible = false;
                }
                field("Search Name"; "Search Name")
                {
                }
                field("Incentivos/Puntos"; "Incentivos/Puntos")
                {
                }
                field(Departamento; Departamento)
                {
                }
                field("Sub-Departamento"; "Sub-Departamento")
                {
                }
                field("Fecha salida empresa"; "Fecha salida empresa")
                {
                }
                field(Salario; Salario)
                {
                }
                field("Total ingresos"; "Total ingresos")
                {
                }
                field("Total deducciones"; "Total deducciones")
                {
                }
                field(Cuenta; Cuenta)
                {
                }
                field(Comment; Comment)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
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
                    Caption = 'Co&mments';
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
                        Caption = 'Dimensions-Single';
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(5200),
                                      "No." = FIELD("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                    }
                    action("Dimensions-&Multiple")
                    {
                        Caption = 'Dimensions-&Multiple';

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
                    Caption = '&Picture';
                    RunObject = Page 5202;
                    RunPageLink = "No." = FIELD("No.");
                }
                action("&Alternative Addresses")
                {
                    Caption = '&Alternative Addresses';
                    RunObject = Page 5204;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Relati&ves")
                {
                    Caption = 'Relati&ves';
                    RunObject = Page 5209;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Mi&sc. Article Information")
                {
                    Caption = 'Mi&sc. Article Information';
                    RunObject = Page 5219;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Con&fidential Information")
                {
                    Caption = 'Con&fidential Information';
                    RunObject = Page 5221;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Q&ualifications")
                {
                    Caption = 'Q&ualifications';
                    RunObject = Page 5206;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("A&bsences")
                {
                    Caption = 'A&bsences';
                    RunObject = Page 5211;
                    RunPageLink = "Employee No." = FIELD("No.");
                }

                action("Absences b&y Categories")
                {
                    Caption = 'Absences b&y Categories';
                    RunObject = Page 5226;
                    RunPageLink = "No." = FIELD("No."),
                                  "Employee No. Filter" = FIELD("No.");
                }
                action("Misc. Articles &Overview")
                {
                    Caption = 'Misc. Articles &Overview';
                    RunObject = Page 5228;
                }
                action("Confidential Info. Overvie&w")
                {
                    Caption = 'Confidential Info. Overvie&w';
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

