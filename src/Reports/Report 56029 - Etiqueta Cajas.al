report 56029 "Etiqueta Cajas"
{
    ApplicationArea = All;
    Caption = 'Etiqueta Cajas';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Cab. Packing Registrado"; 56033)
        {
            dataitem("Lin. Packing Registrada"; 56034)
            {
                DataItemLink = "No." = field("No.");

                trigger OnAfterGetRecord()
                var
                    Barcode: Text[50];
                begin
                    WriteZplLine('^XA');
                    WriteZplLine('^FO40,45^A0N,35,28^FD' + UpperCase(CompanyInformation.Name) + '^FS');
                    WriteZplLine('^FO590,45^A0N,25,28^FDFecha: ' + Format(WorkDate()) + '^FS');
                    WriteZplLine('^FO40,85^A0N,35,20^FD' + DistributionCenterLbl + '^FS');
                    WriteZplLine('^FO225,125^A0N,45,80^FD' + RegisteredWhseActivityLine."Source No." + '^FS');
                    WriteZplLine('^FO40,155^A0N,35,28^FD--------------------------------^FS');
                    WriteZplLine('^FO40,185^A0N,25,28^FDDestinatario:^FS');
                    WriteZplLine('^FO40,210^A0N,35,28^FD' + RecipientName + '^FS');
                    WriteZplLine('^FO40,245^A0N,25,28^FD' + RecipientAddress + '^FS');
                    WriteZplLine('^FO40,275^A0N,25,28^FD' + RecipientAddress2 + '^FS');
                    WriteZplLine('^FO40,305^A0N,25,28^FD' + RecipientCity + '^FS');

                    CalculatePackagePosition();

                    WriteZplLine(
                        '^FO40,355^A0N,55,100^FDBULTO ' +
                        Format(PackagePosition) + '/' + Format(PackageCount) + '^FS');
                    WriteZplLine('^FO40,440^A0N,35,28^FD--------------------------------^FS');

                    CalcFields("Total de Productos");
                    WriteZplLine(
                        '^FO240,420^A0N,35,28^FDEste bulto contiene ' +
                        Format("Total de Productos") + ' ejemplares^FS');

                    Counter := 440;

                    RegisteredBoxContent.Reset();
                    RegisteredBoxContent.SetRange("No. Packing", "No.");
                    RegisteredBoxContent.SetRange("No. Caja", "No. Caja");

                    if RegisteredBoxContent.FindSet() then
                        repeat
                            Counter += 30;
                            Barcode := GetItemBarcode(RegisteredBoxContent."No. Producto");

                            if Barcode = '' then
                                Barcode := RegisteredBoxContent."No. Producto";

                            WriteZplLine(
                                '^FO40,' + Format(Counter) +
                                '^A0N,25,28^FD' + Barcode + '^FS');
                            WriteZplLine(
                                '^FO240,' + Format(Counter) +
                                '^A0N,25,28^FD' +
                                CopyStr(RegisteredBoxContent.Descripcion, 1, 32) + '^FS');
                            WriteZplLine(
                                '^FO730,' + Format(Counter) +
                                '^A0N,25,28^FD' +
                                Format(RegisteredBoxContent.Cantidad) + '^FS');
                        until RegisteredBoxContent.Next() = 0;

                    WriteZplLine('^XZ');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ClearRecipientData();

                RegisteredWhseActivityLine.Reset();
                RegisteredWhseActivityLine.SetCurrentKey("No.", "No. Packing Registrado");
                RegisteredWhseActivityLine.SetRange("No.", "Picking No.");
                RegisteredWhseActivityLine.SetRange("No. Packing Registrado", "No.");

                if not RegisteredWhseActivityLine.FindFirst() then
                    exit;

                case RegisteredWhseActivityLine."Source Type" of
                    Database::"Sales Line":
                        LoadSalesRecipient();

                    Database::"Transfer Line":
                        LoadTransferRecipient();
                end;
            end;

            trigger OnPreDataItem()
            begin
                if FilterNo <> '' then
                    SetFilter("No.", FilterNo);

                CompanyInformation.Get();
            end;
        }
    }

    trigger OnPreReport()
    begin
        FilterNo := "Cab. Packing Registrado".GetFilter("No.");
        if FilterNo = '' then
            FilterNo := "Lin. Packing Registrada".GetFilter("No.");

        TempBlob.CreateOutStream(ZplOutStream, TextEncoding::Windows);
        HasZplContent := false;
    end;

    trigger OnPostReport()
    var
        ZplInStream: InStream;
        FileName: Text;
    begin
        if not HasZplContent then
            exit;

        TempBlob.CreateInStream(ZplInStream, TextEncoding::Windows);
        FileName := 'EtiquetaBC.txt';

        DownloadFromStream(
            ZplInStream,
            '',
            '',
            'Text files (*.txt)|*.txt|ZPL files (*.zpl)|*.zpl',
            FileName);
    end;

    var
        CompanyInformation: Record "Company Information";
        RegisteredWhseActivityLine: Record "Registered Whse. Activity Line";
        RegisteredPackingLine: Record 56034;
        RegisteredBoxContent: Record 56035;
        ItemReference: Record "Item Reference";
        CountryRegion: Record "Country/Region";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesHeader: Record "Sales Header";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        TransferHeader: Record "Transfer Header";
        PostCode: Record "Post Code";
        EcommerceHeader: Record 50100;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        TempBlob: Codeunit "Temp Blob";
        ZplOutStream: OutStream;
        RecipientName: Text[1024];
        RecipientAddress: Text[100];
        RecipientAddress2: Text[200];
        RecipientCity: Text[200];
        Province: Text[200];
        Department: Text[200];
        FilterNo: Text[250];
        PackageCount: Integer;
        PackagePosition: Integer;
        Counter: Integer;
        HasZplContent: Boolean;
        DistributionCenterLbl: Label 'CENTRO DISTRIBUCION';

    local procedure LoadSalesRecipient()
    begin
        SalesShipmentHeader.Reset();
        SalesShipmentHeader.SetCurrentKey("Order No.");
        SalesShipmentHeader.SetRange("Order No.", RegisteredWhseActivityLine."Source No.");

        if SalesShipmentHeader.FindFirst() then begin
            LoadPostCode(
                SalesShipmentHeader."Sell-to Post Code",
                SalesShipmentHeader."Sell-to City");
            LoadCountryRegion(SalesShipmentHeader."Sell-to Country/Region Code");

            RecipientName := SalesShipmentHeader."Sell-to Customer Name";
            RecipientAddress := SalesShipmentHeader."Ship-to Address";
            RecipientAddress2 := SalesShipmentHeader."Ship-to Address 2";

            SalesInvoiceHeader.Reset();
            SalesInvoiceHeader.SetCurrentKey("Order No.");
            SalesInvoiceHeader.SetRange("Order No.", RegisteredWhseActivityLine."Source No.");

            if SalesInvoiceHeader.FindFirst() then begin
                Clear(EcommerceHeader);
                if not EcommerceHeader.Get(
                     SalesShipmentHeader."External Document No.",
                     SalesShipmentHeader."Sell-to Customer No.")
                then
                    Clear(EcommerceHeader);

                RecipientCity :=
                    SalesShipmentHeader."Ship-to City" + ' - ' +
                    Province + ' - ' +
                    Department + ' - ' +
                    CountryRegion.Name + ' - Tel: ' +
                    SalesInvoiceHeader."No. Telefono" + ' - ' +
                    SalesInvoiceHeader."External Document No.";
            end else
                RecipientCity :=
                    SalesShipmentHeader."Ship-to City" + ' - ' +
                    Province + ' - ' +
                    Department + ' - ' +
                    CountryRegion.Name;
        end else
            LoadOpenSalesRecipient();
    end;

    local procedure LoadOpenSalesRecipient()
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("No.", RegisteredWhseActivityLine."Source No.");

        if not SalesHeader.FindFirst() then
            exit;

        LoadPostCode(SalesHeader."Sell-to Post Code", SalesHeader."Sell-to City");
        LoadCountryRegion(SalesHeader."Sell-to Country/Region Code");

        RecipientName := SalesHeader."Sell-to Customer Name";
        RecipientAddress := SalesHeader."Ship-to Address";
        RecipientAddress2 := SalesHeader."Ship-to Address 2";

        Clear(EcommerceHeader);
        if not EcommerceHeader.Get(
             SalesHeader."External Document No.",
             SalesHeader."Sell-to Customer No.")
        then
            Clear(EcommerceHeader);

        RecipientCity :=
            SalesHeader."Ship-to City" + ' - ' +
            Province + ' - ' +
            Department + ' - ' +
            CountryRegion.Name + ' - Tel: ' +
            SalesHeader."No. Telefono" + ' - ' +
            SalesHeader."External Document No.";
    end;

    local procedure LoadTransferRecipient()
    begin
        TransferShipmentHeader.Reset();
        TransferShipmentHeader.SetCurrentKey("Transfer Order No.");
        TransferShipmentHeader.SetRange(
            "Transfer Order No.",
            RegisteredWhseActivityLine."Source No.");

        if TransferShipmentHeader.FindFirst() then begin
            LoadPostCode(
                TransferShipmentHeader."Transfer-to Post Code",
                TransferShipmentHeader."Transfer-to City");
            LoadCountryRegion(
                TransferShipmentHeader."Trsf.-to Country/Region Code");

            RecipientName := TransferShipmentHeader."Transfer-to Name";
            RecipientAddress := TransferShipmentHeader."Transfer-to Address";
            RecipientAddress2 := TransferShipmentHeader."Transfer-to Address 2";
            RecipientCity :=
                TransferShipmentHeader."Transfer-to City" + ' - ' +
                Province + ' - ' +
                Department + ' - ' +
                CountryRegion.Name;
        end else
            LoadOpenTransferRecipient();
    end;

    local procedure LoadOpenTransferRecipient()
    begin
        TransferHeader.Reset();
        TransferHeader.SetRange("No.", RegisteredWhseActivityLine."Source No.");

        if not TransferHeader.FindFirst() then
            exit;

        LoadPostCode(
            TransferHeader."Transfer-to Post Code",
            TransferHeader."Transfer-to City");
        LoadCountryRegion(TransferHeader."Trsf.-to Country/Region Code");

        RecipientName := TransferHeader."Transfer-to Name";
        RecipientAddress := TransferHeader."Transfer-to Address";
        RecipientAddress2 := TransferHeader."Transfer-to Address 2";
        RecipientCity :=
            TransferHeader."Transfer-to City" + ' - ' +
            Province + ' - ' +
            Department + ' - ' +
            CountryRegion.Name;
    end;

    local procedure LoadPostCode(PostCodeValue: Code[20]; CityValue: Text[30])
    begin
        Clear(PostCode);
        Clear(Province);
        Clear(Department);

        if PostCode.Get(PostCodeValue, CityValue) then begin
            Province := PostCode.County;
            Department := PostCode.Colonia;
        end;
    end;

    local procedure LoadCountryRegion(CountryRegionCode: Code[10])
    begin
        Clear(CountryRegion);

        if CountryRegionCode <> '' then
            if not CountryRegion.Get(CountryRegionCode) then
                Clear(CountryRegion);
    end;

    local procedure ClearRecipientData()
    begin
        Clear(RecipientName);
        Clear(RecipientAddress);
        Clear(RecipientAddress2);
        Clear(RecipientCity);
        Clear(Province);
        Clear(Department);
        Clear(CountryRegion);
        Clear(EcommerceHeader);
    end;

    local procedure CalculatePackagePosition()
    var
        FoundPackage: Boolean;
    begin
        PackagePosition := 0;

        RegisteredPackingLine.Reset();
        RegisteredPackingLine.SetRange("No.", "Lin. Packing Registrada"."No.");
        PackageCount := RegisteredPackingLine.Count();

        if RegisteredPackingLine.FindSet() then
            repeat
                PackagePosition += 1;
                FoundPackage :=
                    RegisteredPackingLine."No. Caja" =
                    "Lin. Packing Registrada"."No. Caja";
            until FoundPackage or (RegisteredPackingLine.Next() = 0);
    end;

    local procedure GetItemBarcode(ItemNo: Code[20]): Text[50]
    begin
        ItemReference.Reset();
        ItemReference.SetRange("Item No.", ItemNo);
        ItemReference.SetRange(
            "Reference Type",
            ItemReference."Reference Type"::"Bar Code");
        ItemReference.SetRange("Reference Type No.", '');

        if ItemReference.FindFirst() then
            exit(ItemReference."Reference No.");

        exit('');
    end;

    local procedure WriteZplLine(ZplLine: Text)
    begin
        ZplOutStream.WriteText(ZplLine);
        ZplOutStream.WriteText();
        HasZplContent := true;
    end;
}
