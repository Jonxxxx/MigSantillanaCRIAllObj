page 55840 "Datos Ponchador"
{
    Caption = 'T&A log';
    PageType = List;
    SourceTable = 55818;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Empleado"; Rec."Cod. Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Empleado';
                }
                field("Full name"; Rec."Full name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full name';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Title';
                }
                field("Fecha registro"; Rec."Fecha registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha registro';
                }
                field("Hora registro"; Rec."Hora registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora registro';
                }
                field("No. tarjeta"; Rec."No. tarjeta")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. tarjeta';
                }
                field("ID Equipo"; Rec."ID Equipo")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Equipo';
                }
                field(Procesado; Rec.Procesado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Procesado';
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job No.';
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Task No.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Actions")
            {
                Caption = 'Actions';
                Image = LinesFromTimeSheet;
                action("Import data from T&A Clock")
                {
                    ApplicationArea = All;
                    Caption = 'Import data from T&A Clock';
                    ToolTip = 'Import data from T&A Clock';
                    Image = LinesFromTimesheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                    // TODO: Manual review - Codeunit 55765 and ReadEmp use legacy ADO access that is incompatible with Business Central SaaS.
                    // Original code preserved below.
                    // AdoConn: Codeunit 55765;
                    begin
                        // AdoConn.ReadEmp
                    end;
                }
            }
        }
    }
}

