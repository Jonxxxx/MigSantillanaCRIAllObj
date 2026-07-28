report 34002139 "Proceso Carga Gtos. a Nomina"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("G/L Entry"; 17)
        {
            DataItemTableView = SORTING("G/L Account No.", "Posting Date");
            RequestFilterFields = "G/L Account No.", "Posting Date";

            trigger OnAfterGetRecord()
            begin
                Counter := Counter + 1;
                Window.UPDATE(1, "Entry No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                DSE.RESET;
                DSE.SETRANGE("Dimension Set ID", "Dimension Set ID");
                DSE.SETRANGE("Dimension Code", ConfNomina."Dimension Empleado");
                IF DSE.FINDFIRST THEN BEGIN
                    DSE2.RESET;
                    DSE2.SETRANGE("Dimension Set ID", "Dimension Set ID");
                    DSE2.SETRANGE("Dimension Code", CodDimension);
                    IF CodValorDim <> '' THEN
                        DSE2.SETRANGE("Dimension Value Code", CodValorDim)
                    ELSE
                        DSE2.SETRANGE("Dimension Value Code", DSE."Dimension Value Code");
                    IF NOT DSE2.FINDFIRST THEN
                        CurrReport.SKIP;
                END
                ELSE
                    CurrReport.SKIP;

                PF.RESET;
                PF.SETRANGE("No. empleado", DSE2."Dimension Value Code");
                PF.SETRANGE("Concepto salarial", ConceptoSalarial);
                IF PF.FINDFIRST THEN BEGIN
                    PF.Cantidad := 1;
                    PF.Importe := ABS(Amount);
                    PF.MODIFY;
                END;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                ConfNomina.GET();
                ConfNomina.TESTFIELD("Dimension Empleado");
                Window.OPEN(Text001);
                CounterTotal := COUNT;
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
                group(General)
                {
                    field(Dimension; CodDimension)
                    {
                        Caption = 'Dimension Code';

                        TableRelation = Dimension;
                    }
                    field("Valor Dimension"; CodValorDim)
                    {
                        Caption = 'Dimension Value code';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            dimval: Record 349;
                            fDimVal: Page 560;
                        begin
                            dimval.RESET;
                            dimval.SETRANGE("Dimension Code", CodDimension);
                            fDimVal.SETTABLEVIEW(dimval);
                            fDimVal.SETRECORD(dimval);
                            fDimVal.LOOKUPMODE(TRUE);
                            IF fDimVal.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                fDimVal.GETRECORD(dimval);
                                CodValorDim := dimval.Code;
                            END;
                            CLEAR(fDimVal);
                        end;

                        trigger OnValidate()
                        var
                            dimval: Record 349;
                        begin
                            IF CodValorDim <> '' THEN BEGIN
                                dimval.RESET;
                                dimval.SETRANGE("Dimension Code", CodDimension);
                                dimval.SETRANGE(Code, CodValorDim);
                                dimval.FINDFIRST;
                            END;
                        end;
                    }
                    field("Concepto Salarial"; ConceptoSalarial)
                    {
                        Caption = 'Payroll concept';
                        TableRelation = "Conceptos salariales";
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
        ConfNomina: Record 34002103;
        GLE: Record 17;
        PF: Record 34002115;
        DSE: Record 480;
        DSE2: Record 480;
        CodDimension: Code[20];
        CodValorDim: Code[20];
        ConceptoSalarial: Code[20];
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        Text001: Label 'Processing  #1########## @2@@@@@@@@@@@@@';
        Text002: Label 'Transfer of ';
}

