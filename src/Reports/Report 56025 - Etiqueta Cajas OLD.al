report 56025 "Etiqueta Cajas OLD"
{
    ApplicationArea = All;
    Caption = 'Etiqueta Cajas OLD';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Lin. Packing Registrada"; 56034)
        {
            trigger OnAfterGetRecord()
            var
                Barcode: Text[50];
            begin
                CompanyInformation.Get();

                Clear(Customer);
                RegisteredWhseActivityLine.Reset();
                RegisteredWhseActivityLine.SetRange("No.", "No. Picking");

                if RegisteredWhseActivityLine.FindFirst() then
                    Customer.Get(
                        RegisteredWhseActivityLine."Destination No.");

                Clear(CountryRegion);

                if Customer."Country/Region Code" <> '' then
                    if not CountryRegion.Get(
                         Customer."Country/Region Code")
                    then
                        Clear(CountryRegion);

                WriteZplLine('^XA');

                WriteZplLine(
                    '^FO40,20^A0N,35,28^FD' +
                    CompanyInformation.Name +
                    '^FS');

                WriteZplLine(
                    '^FO40,60^A0N,35,20^FD' +
                    CompanyInformation."Address 2" +
                    '^FS');

                WriteZplLine(
                    '^FO40,100^A0N,35,20^FD' +
                    CompanyInformation.Address +
                    '^FS');

                WriteZplLine(
                    '^FO300,100^A0N,45,95^FD' +
                    RegisteredWhseActivityLine."Source No." +
                    '^FS');

                WriteZplLine(
                    '^FO40,140^A0N,35,28^FD--------------------------------^FS');

                WriteZplLine(
                    '^FO40,180^A0N,35,28^FDDestinatario:^FS');

                WriteZplLine(
                    '^FO40,220^A0N,35,28^FD' +
                    Customer.Name +
                    '^FS');

                WriteZplLine(
                    '^FO40,260^A0N,35,28^FD' +
                    Customer."Post Code" +
                    '^FS');

                WriteZplLine(
                    '^FO40,300^A0N,35,28^FD' +
                    Customer.Address +
                    '^FS');

                WriteZplLine(
                    '^FO40,340^A0N,35,28^FD' +
                    Customer."Address 2" +
                    '^FS');

                WriteZplLine(
                    '^FO40,380^A0N,35,28^FD' +
                    Customer.City +
                    '^FS');

                WriteZplLine(
                    '^FO40,420^A0N,35,28^FD' +
                    CountryRegion.Name +
                    '^FS');

                I := 0;
                N := 0;

                RegisteredPackingLine.Reset();
                RegisteredPackingLine.SetRange("No.", "No.");

                PackageCount := RegisteredPackingLine.Count();

                if RegisteredPackingLine.FindSet() then
                    repeat
                        N += 1;

                        if RegisteredPackingLine."No. Caja" =
                           "No. Caja"
                        then
                            I := 1;
                    until
                        (I = 1) or
                        (RegisteredPackingLine.Next() = 0);

                WriteZplLine(
                    '^FO240,480^A0N,45,100^FDBULTO ' +
                    Format(N) +
                    '/' +
                    Format(PackageCount) +
                    '^FS');

                WriteZplLine(
                    '^FO40,560^A0N,35,28^FD--------------------------------^FS');

                CalcFields("Total de Productos");

                WriteZplLine(
                    '^FO240,540^A0N,35,28^FDEste bulto contiene ' +
                    Format("Total de Productos") +
                    ' ej.:^FS');

                Counter := 550;

                RegisteredBoxContent.Reset();
                RegisteredBoxContent.SetRange(
                    "No. Packing",
                    "No.");
                RegisteredBoxContent.SetRange(
                    "No. Caja",
                    "No. Caja");

                if RegisteredBoxContent.FindSet() then
                    repeat
                        Counter += 40;

                        Clear(Barcode);

                        ItemReference.Reset();
                        ItemReference.SetRange(
                            "Item No.",
                            RegisteredBoxContent."No. Producto");
                        ItemReference.SetRange(
                            "Reference Type",
                            ItemReference."Reference Type"::"Bar Code");
                        ItemReference.SetRange(
                            "Reference Type No.",
                            '');

                        if ItemReference.FindFirst() then
                            Barcode := ItemReference."Reference No.";

                        WriteZplLine(
                            '^FO40,' +
                            Format(Counter) +
                            '^A0N,35,22^FD' +
                            Barcode +
                            '^FS');

                        WriteZplLine(
                            '^FO240,' +
                            Format(Counter) +
                            '^A0N,35,22^FD' +
                            Format(RegisteredBoxContent.Descripcion) +
                            '^FS');

                        WriteZplLine(
                            '^FO730,' +
                            Format(Counter) +
                            '^A0N,35,22^FD' +
                            Format(RegisteredBoxContent.Cantidad) +
                            '^FS');
                    until RegisteredBoxContent.Next() = 0;

                WriteZplLine('^XZ');
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

    trigger OnPreReport()
    begin
        TempBlob.CreateOutStream(
            ZplOutStream,
            TextEncoding::Windows);

        HasZplContent := false;
    end;

    trigger OnPostReport()
    var
        ZplInStream: InStream;
        ZplFileName: Text;
    begin
        if not HasZplContent then
            exit;

        TempBlob.CreateInStream(
            ZplInStream,
            TextEncoding::Windows);

        ZplFileName := 'BTC1.zpl';

        DownloadFromStream(
            ZplInStream,
            '',
            '',
            '',
            ZplFileName);
    end;

    var
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        RegisteredWhseActivityLine: Record "Registered Whse. Activity Line";
        RegisteredPackingLine: Record 56034;
        RegisteredBoxContent: Record 56035;
        ItemReference: Record "Item Reference";
        CountryRegion: Record "Country/Region";
        TempBlob: Codeunit "Temp Blob";
        ZplOutStream: OutStream;
        PackageCount: Integer;
        I: Integer;
        N: Integer;
        Counter: Integer;
        HasZplContent: Boolean;

    local procedure WriteZplLine(ZplLine: Text)
    begin
        ZplOutStream.WriteText(ZplLine);
        ZplOutStream.WriteText();

        HasZplContent := true;
    end;
}