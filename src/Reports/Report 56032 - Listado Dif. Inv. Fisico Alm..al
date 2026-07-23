report 56032 "Listado Dif. Inv. Fisico Alm."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Listado Dif. Inv. Fisico Alm..rdlc';

    dataset
    {
        dataitem("Warehouse Journal Line"; 7311)
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Location Code", "Line No.");
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(GetShorDimCodeCaption2; GetShorDimCodeCaption2)
            {
            }
            column(GetShorDimCodeCaption1; GetShorDimCodeCaption1)
            {
            }
            column(ShowLotSN; ShowLotSN)
            {
            }
            column(Filtros; Filtros)
            {
            }
            column(CodSeccion1; STRSUBSTNO(Text001, CodSeccion1))
            {
            }
            column(CodSeccion2; STRSUBSTNO(Text001, CodSeccion2))
            {
            }
            column(Warehouse_Journal_Line__Posting_Date_; FORMAT("Registering Date"))
            {
            }
            column(Warehouse_Journal_Line__Item_No__; "Item No.")
            {
            }
            column(Warehouse_Journal_Line_Description; Description)
            {
            }
            column(Warehouse_Journall_Line__Location_Code_; "Location Code")
            {
            }
            column(CalcQty1; CalcQty1)
            {
            }
            column(Warehouse_Journal_Line__Bin_Code_; "Bin Code")
            {
            }
            column(CalcQty2; CalcQty2)
            {
            }
            column(DifQty; DifQty)
            {
            }
            column(Phys__Inventory_ListCaption; Phys__Inventory_ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item_Journal_Line__Posting_Date_Caption; Item_Journal_Line__Posting_Date_CaptionLbl)
            {
            }
            column(Item_Journal_Line__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Item_Journal_Line_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Item_Journal_Line__Location_Code_Caption; FIELDCAPTION("Location Code"))
            {
            }
            column(Item_Journal_Line__Bin_Code_Caption; FIELDCAPTION("Bin Code"))
            {
            }
            column(Diff_Caption; Diff_CaptionLbl)
            {
            }
            column(Warehouse_Journal_Line_Journal_Template_Name; "Journal Template Name")
            {
            }
            column(Warehouse_Journal_Line_Journal_Batch_Name; "Journal Batch Name")
            {
            }
            column(Warehouse_Journal_Line_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CalcQty1 := "Qty. (Phys. Inventory)";

                IJL.RESET;
                IJL.SETRANGE("Journal Template Name", CodDiario);
                IJL.SETRANGE("Journal Batch Name", CodSeccion2);
                IJL.SETRANGE("Item No.", "Item No.");
                IJL.SETRANGE("Location Code", "Location Code");
                IJL.SETRANGE("Bin Code", "Bin Code");
                IJL.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                IF IJL.FINDFIRST THEN
                    CalcQty2 := IJL."Qty. (Phys. Inventory)";

                DifQty := CalcQty1 - CalcQty2;

                IF (Traspasar) AND (DifQty <> 0) THEN BEGIN
                    IJL2.TRANSFERFIELDS("Warehouse Journal Line");
                    IJL2."Journal Template Name" := "Journal Template Name";
                    IJL2."Journal Batch Name" := CodSeccion3;
                    IJL2.VALIDATE("Qty. (Phys. Inventory)", "Qty. (Calculated)");
                    IJL2.INSERT(TRUE);
                END
                ELSE
                    IF (Consolidar) AND (DifQty = 0) THEN BEGIN
                        IJL3.RESET;
                        IJL3.SETRANGE("Journal Template Name", CodDiario);
                        IJL3.SETRANGE("Journal Batch Name", CodSeccion4);
                        IF IJL3.FINDLAST THEN
                            NoLin := IJL3."Line No."
                        ELSE
                            NoLin := 0;

                        NoLin += 1000;

                        IJL2.TRANSFERFIELDS("Warehouse Journal Line");
                        IJL2."Journal Template Name" := "Journal Template Name";
                        IJL2."Journal Batch Name" := CodSeccion4;
                        IJL2."Line No." := NoLin;
                        IJL2.VALIDATE("Qty. (Phys. Inventory)", "Qty. (Phys. Inventory)");
                        IJL2.INSERT(TRUE);
                    END
                    ELSE
                        IF (Consolidar) AND (DifQty <> 0) THEN BEGIN
                            IJL3.RESET;
                            IJL3.SETRANGE("Journal Template Name", CodDiario);
                            IJL3.SETRANGE("Journal Batch Name", CodSeccion4);
                            IF IJL3.FINDLAST THEN
                                NoLin := IJL3."Line No."
                            ELSE
                                NoLin := 0;

                            NoLin += 1000;

                            IJL4.RESET;
                            IJL4.SETRANGE("Journal Template Name", CodDiario);
                            IJL4.SETRANGE("Journal Batch Name", CodSeccion3);
                            IJL4.SETRANGE("Item No.", "Item No.");
                            IJL4.FINDFIRST;

                            IJL2.TRANSFERFIELDS("Warehouse Journal Line");
                            IJL2."Journal Template Name" := "Journal Template Name";
                            IJL2."Journal Batch Name" := CodSeccion4;
                            IJL2."Line No." := NoLin;
                            IJL2.VALIDATE("Qty. (Phys. Inventory)", IJL4."Qty. (Phys. Inventory)");
                            IJL2.INSERT(TRUE);
                        END;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Journal Template Name", CodDiario);
                SETRANGE("Journal Batch Name", CodSeccion1);

                Filtros := GETFILTERS + ', ' + STRSUBSTNO(Text002, CodSeccion2)
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(CodDiario; CodDiario)
                    {
                        Caption = 'Phys. Inventory Journal';
                        TableRelation = "Warehouse Journal Batch";
                    }
                    field(CodSeccion1; CodSeccion1)
                    {
                        Caption = 'Batch name 1';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            IJL.RESET;
                            IJL.SETRANGE("Journal Template Name", CodDiario);
                            IJL.SETRANGE("Journal Batch Name", 'GENERAL');
                            "Warehouse Journal Line".LookupName(CodSeccion1, CodAlm, IJL);
                        end;

                        trigger OnValidate()
                        begin
                            IJL.RESET;
                            IJL.SETRANGE("Journal Template Name", CodDiario);
                            IJL.SETRANGE("Journal Batch Name", 'GENERAL');
                            "Warehouse Journal Line".CheckName(CodSeccion1, CodAlm, IJL);
                        end;
                    }
                    field(CodSeccion2; CodSeccion2)
                    {
                        Caption = 'Batch name 2';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            IJL.RESET;
                            IJL.SETRANGE("Journal Template Name", CodDiario);
                            IJL.SETRANGE("Journal Batch Name", 'GENERICO');
                            "Warehouse Journal Line".LookupName(CodSeccion2, CodAlm, IJL);
                        end;

                        trigger OnValidate()
                        begin
                            IJL.RESET;
                            IJL.SETRANGE("Journal Template Name", CodDiario);
                            IJL.SETRANGE("Journal Batch Name", 'GENERICO');
                            "Warehouse Journal Line".CheckName(CodSeccion2, CodAlm, IJL);
                        end;
                    }
                    field(Traspasar; Traspasar)
                    {
                        Caption = 'Transfer differences';

                        trigger OnValidate()
                        begin
                            IF Traspasar THEN
                                Consolidar := FALSE;
                        end;
                    }
                    field(Consolidar; Consolidar)
                    {
                        Caption = 'Consolidate';

                        trigger OnValidate()
                        begin
                            IF Consolidar THEN
                                Traspasar := FALSE;
                        end;
                    }
                    field(CodSeccion3; CodSeccion3)
                    {
                        Caption = 'Difference Batch name';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            IJL.RESET;
                            IJL.SETRANGE("Journal Template Name", CodDiario);
                            IJL.SETRANGE("Journal Batch Name", 'GENERICO');
                            "Warehouse Journal Line".LookupName(CodSeccion3, CodAlm, IJL);
                        end;

                        trigger OnValidate()
                        begin
                            IJL.RESET;
                            IJL.SETRANGE("Journal Template Name", CodDiario);
                            IJL.SETRANGE("Journal Batch Name", 'GENERICO');
                            "Warehouse Journal Line".CheckName(CodSeccion3, CodAlm, IJL);
                        end;
                    }
                    field(CodSeccion4; CodSeccion4)
                    {
                        Caption = 'Consolidate Batch name';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            IJL.RESET;
                            IJL.SETRANGE("Journal Template Name", CodDiario);
                            IJL.SETRANGE("Journal Batch Name", 'GENERICO');
                            "Warehouse Journal Line".LookupName(CodSeccion4, CodAlm, IJL);
                        end;

                        trigger OnValidate()
                        begin
                            IJL.RESET;
                            IJL.SETRANGE("Journal Template Name", CodDiario);
                            IJL.SETRANGE("Journal Batch Name", 'GENERICO');
                            "Warehouse Journal Line".CheckName(CodSeccion4, CodAlm, IJL);
                        end;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        IJL: Record 7311;
        IJL2: Record 7311;
        IJL3: Record 7311;
        IJL4: Record 7311;
        ItemJnlMgt: Codeunit 240;
        CodDiario: Code[20];
        CodSeccion1: Code[20];
        CodSeccion2: Code[20];
        CodSeccion3: Code[20];
        CodSeccion4: Code[10];
        GetShorDimCodeCaption1: Text[30];
        GetShorDimCodeCaption2: Text[30];
        GetLotNoCaption: Text[80];
        GetSerialNoCaption: Text[80];
        GetQuantityBaseCaption: Text[80];
        GetSummaryPerItemCaption: Text[30];
        ShowLotSN: Boolean;
        Filtros: Text[250];
        CalcQty1: Decimal;
        CalcQty2: Decimal;
        DifQty: Decimal;
        Traspasar: Boolean;
        Text001: Label 'Phys. Qty. %1';
        Text002: Label '2nd Jnl Batch %1';
        Consolidar: Boolean;
        NoLin: Integer;
        CodBatch: Code[20];
        CodSecc: Code[20];
        CodAlm: Code[20];
        Phys__Inventory_ListCaptionLbl: Label 'Phys. Whse. Inventory Jnl. Comparative';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Item_Journal_Line__Posting_Date_CaptionLbl: Label 'Posting Date';
        Diff_CaptionLbl: Label 'Difference';

    procedure RecibeParametros(Batch: Code[20]; Secc: Code[20]; Almacen: Code[20])
    begin
        CodBatch := Batch;
        CodSecc := Secc;
        CodAlm := Almacen;
    end;
}

