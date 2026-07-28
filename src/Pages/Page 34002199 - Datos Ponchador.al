page 34002199 "Datos Ponchador"
{
    Caption = 'T&A log';
    PageType = List;
    SourceTable = 34002177;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Empleado"; "Cod. Empleado")
                {
                }
                field("Full name"; "Full name")
                {
                }
                field("Job Title"; "Job Title")
                {
                }
                field("Fecha registro"; "Fecha registro")
                {
                }
                field("Hora registro"; "Hora registro")
                {
                }
                field("No. tarjeta"; "No. tarjeta")
                {
                }
                field("ID Equipo"; "ID Equipo")
                {
                }
                field(Procesado; Procesado)
                {
                }
                field("Job No."; "Job No.")
                {
                }
                field("Job Task No."; "Job Task No.")
                {
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
                    Caption = 'Import data from T&A Clock';
                    Image = LinesFromTimesheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        // TODO: Manual review - Codeunit 34002124 and ReadEmp use legacy ADO access that is incompatible with Business Central SaaS.
                        // Original code preserved below.
                        // AdoConn: Codeunit 34002124;
                    begin
                        // AdoConn.ReadEmp
                    end;
                }
            }
        }
    }
}

