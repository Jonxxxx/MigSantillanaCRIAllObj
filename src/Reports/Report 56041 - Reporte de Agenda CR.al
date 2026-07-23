report 56041 "Reporte de Agenda CR"
{
    ApplicationArea = Basic, Suite;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Promotor - Planif. Visita"; 67038)
        {
            RequestFilterFields = Fecha;

            trigger OnAfterGetRecord()
            begin

                SalespersonPurchaser.RESET;
                SalespersonPurchaser.SETRANGE(Code, "Cod. Promotor");
                IF SalespersonPurchaser.FINDFIRST THEN;

                IF PrintToExcel THEN
                    MakeExcelDataBody;
            end;

            trigger OnPreDataItem()
            begin
                MakeExcelDataHeader
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

    trigger OnInitReport()
    begin
        PrintToExcel := TRUE;
    end;

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN
            CreateExcelBook;
    end;

    trigger OnPreReport()
    begin
        ExcelBuffer.DELETEALL;
    end;

    var
        ExcelBuffer: Record 370 temporary;
        PrintToExcel: Boolean;
        CabPlanificacion: Record 67023;
        Text007: Label 'Reporte Agenda CR';
        SalespersonPurchaser: Record 13;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION(Ano), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION(Fecha), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION("Cod. Promotor"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION("Nombre Promotor"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION("Cod. Colegio"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION("Nombre Colegio"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION(Semana), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION("Fecha Visita"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION("Hora Inicial Visita"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION("Hora Final Visita"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION(Nivel), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION("Nombre persona atendio"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION(Cargo), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION("Descripcion Cargo"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION(Objetivo), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION("Descripcion Objetivo"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION("Fecha Proxima Visita"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION(Calificacion), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION(Comentario), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".FIELDCAPTION("Estado Colegio"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody()
    begin
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".Ano, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".Fecha, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita"."Cod. Promotor", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(SalespersonPurchaser.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita"."Cod. Colegio", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita"."Nombre Colegio", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".Semana, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita"."Fecha Visita", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita"."Hora Inicial Visita", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita"."Hora Final Visita", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".Nivel, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita"."Nombre persona atendio", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".Cargo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita"."Descripcion Cargo", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".Objetivo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita"."Descripcion Objetivo", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita"."Fecha Proxima Visita", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".Calificacion, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita".Comentario, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Promotor - Planif. Visita"."Estado Colegio", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;

    local procedure MakeExcelInfo()
    begin
    end;

    procedure CreateExcelBook()
    begin
        ExcelBuffer.CreateNewBook(Text007);
        ExcelBuffer.WriteSheet(Text007, CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(Text007);
        ExcelBuffer.OpenExcel();
    end;
}

