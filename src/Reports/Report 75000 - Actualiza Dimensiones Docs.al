report 75000 "Actualiza Dimensiones Docs"
{
    ApplicationArea = Basic, Suite, Service;
    ProcessingOnly = true;
    ShowPrintStatus = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem("Sales Line"; 37)
        {
            DataItemTableView = WHERE(Type = CONST(Item));

            trigger OnAfterGetRecord()
            begin


                CreateDim(
                  DimMgt.TypeToTableID3(Type), "No.",
                  DATABASE::Job, "Job No.",
                  DATABASE::"Responsibility Center", "Responsibility Center");
                MODIFY;
                UpdateDia;
            end;

            trigger OnPreDataItem()
            begin
                wDia.UPDATE(1, 'Ventas');
                wTotal := COUNT;
                wCont := 0;
                wStep := wTotal DIV 100;
                IF wStep = 0 THEN
                    wStep := 1;
            end;
        }
        dataitem("Purchase Line"; 39)
        {
            DataItemTableView = WHERE(Type = CONST(Item));

            trigger OnAfterGetRecord()
            begin
                CreateDim(
                  DimMgt.TypeToTableID3(Type), "No.",
                  DATABASE::Job, "Job No.",
                  DATABASE::"Responsibility Center", "Responsibility Center",
                  DATABASE::"Work Center", "Work Center No.");
                MODIFY;
                UpdateDia;
            end;

            trigger OnPreDataItem()
            begin
                wDia.UPDATE(1, 'Compras');
                wTotal := COUNT;
                wCont := 0;
                wStep := wTotal DIV 100;
                IF wStep = 0 THEN
                    wStep := 1;
                wTotal := COUNT;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        wDia.CLOSE;
        MESSAGE(Text001);
    end;

    trigger OnPreReport()
    begin
        wDia.OPEN('#1###########\@2@@@@@@@@@@@')
    end;

    var
        DimMgt: Codeunit 408;
        Text001: Label 'Proceso Terminado';
        wDia: Dialog;
        wTotal: Integer;
        wCont: Integer;
        wStep: Integer;

    procedure UpdateDia()
    begin
        // UpdateDia
        wCont += 1;
        IF wCont MOD wStep = 0 THEN
            wDia.UPDATE(2, ROUND(wCont / wTotal * 10000, 1));
    end;
}

