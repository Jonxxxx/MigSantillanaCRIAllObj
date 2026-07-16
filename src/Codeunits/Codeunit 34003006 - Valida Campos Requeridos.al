codeunit 34003006 "Valida Campos Requeridos"
{

    trigger OnRun()
    begin
    end;

    var
        LCR: Record 34003021;
        Error001: Label '%1 of table %2 Can not be blank';
        I: Integer;
        Error002: Label 'The Dimension %1 is required for the %2 with the Posting Value %3 for the record %4';
        CCR: Record 34003020;
        CDR: Record 34003022;
        Error003: Label 'The Dimension %1 is required for the %2, for the record %3';
        Error004: Label '%1 of table %2 Can not be unmarked.';

    procedure Maestros(TableNo: Integer; Codigo: Code[20])
    var
        RecRef: RecordRef;
        MyRecordRef: RecordRef;
        MyFieldRef: FieldRef;
        FieldRef: array[200] of FieldRef;
        RecID: RecordID;
    begin
        CCR.RESET;
        CCR.SETRANGE("No. Tabla", TableNo);
        CCR.SETRANGE(Activo, TRUE);
        IF CCR.FINDFIRST THEN BEGIN
            LCR.RESET;
            LCR.SETRANGE(LCR."No. Tabla", TableNo);
            IF LCR.FINDSET THEN BEGIN
                MyRecordRef.OPEN(TableNo);
                MyRecordRef.RESET;
                REPEAT
                    I += 1;
                    CLEAR(MyFieldRef);
                    IF I = 1 THEN BEGIN
                        MyFieldRef := MyRecordRef.FIELD(1);
                        MyFieldRef.VALUE := Codigo;
                    END
                    ELSE
                        MyFieldRef := MyRecordRef.FIELD(LCR."No. Campo");
                    IF MyRecordRef.FIND('=') THEN BEGIN
                        FieldRef[I] := MyRecordRef.FIELD(LCR."No. Campo");
                        IF (FORMAT(FieldRef[I].VALUE) = '') THEN
                            ERROR(Error001, FORMAT(FieldRef[I].CAPTION), FORMAT(MyRecordRef.CAPTION));
                        IF (FORMAT(FieldRef[I].TYPE) = 'Boolean') AND (FORMAT(FieldRef[I].VALUE) = FORMAT(FALSE)) THEN //jpg campo boolean
                            ERROR(Error004, FORMAT(FieldRef[I].CAPTION), FORMAT(MyRecordRef.CAPTION));
                    END;
                UNTIL LCR.NEXT = 0;
                MyRecordRef.CLOSE;
            END;
        END;
    end;

    procedure Dimensiones(TableID: Integer; Codigo: Code[20]; TipoTabla: Option Maestro,Documento; TipoDocumento: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order")
    var
        DefDim: Record 352;
        DimReq: Record 34003023;
        Tabla: RecordRef;
        SalesHeader: Record 36;
        SalesLine: Record 37;
        PurchHeader: Record 38;
        PurchLine: Record 39;
        DimSetEntry: Record 480;
        DimSetID: Integer;
    begin
        CDR.RESET;
        CDR.SETRANGE("No. Tabla", TableID);
        CDR.SETRANGE(Activo, TRUE);
        IF CDR.FINDFIRST THEN BEGIN
            Tabla.OPEN(TableID);
            IF TipoTabla = TipoTabla::Maestro THEN BEGIN
                DimReq.RESET;
                DimReq.SETRANGE("No. Tabla", TableID);
                IF DimReq.FINDSET THEN
                    REPEAT
                        DefDim.RESET;
                        DefDim.SETRANGE("Table ID", TableID);
                        DefDim.SETRANGE("No.", Codigo);
                        DefDim.SETRANGE("Dimension Code", DimReq."Cod. Dimension");
                        DefDim.SETRANGE("Value Posting", DimReq."Registro valor");
                        IF NOT DefDim.FINDFIRST THEN
                            ERROR(Error002, DimReq."Cod. Dimension", Tabla.CAPTION, FORMAT(DimReq."Registro valor"), Codigo);
                    UNTIL DimReq.NEXT = 0;
            END
            ELSE BEGIN
                CLEAR(DimSetID);
                IF (TableID IN [36, 37, 38, 39]) THEN BEGIN
                    DimReq.RESET;
                    DimReq.SETRANGE("No. Tabla", TableID);
                    IF DimReq.FINDSET THEN BEGIN
                        CASE TableID OF
                            36:
                                BEGIN
                                    SalesHeader.SETRANGE("Document Type", TipoDocumento);
                                    SalesHeader.SETRANGE("No.", Codigo);
                                    SalesHeader.FINDFIRST;
                                    DimSetID := SalesHeader."Dimension Set ID";
                                END;
                            37:
                                BEGIN
                                    SalesLine.SETRANGE("Document Type", TipoDocumento);
                                    SalesLine.SETRANGE("Document No.", Codigo);
                                    SalesLine.FINDFIRST;
                                    DimSetID := SalesLine."Dimension Set ID";
                                END;
                            38:
                                BEGIN
                                    PurchHeader.SETRANGE("Document Type", TipoDocumento);
                                    PurchHeader.SETRANGE("No.", Codigo);
                                    PurchHeader.FINDFIRST;
                                    DimSetID := PurchHeader."Dimension Set ID";
                                END;
                            39:
                                BEGIN
                                    PurchLine.SETRANGE("Document Type", TipoDocumento);
                                    PurchLine.SETRANGE("Document No.", Codigo);
                                    PurchLine.FINDFIRST;
                                    DimSetID := PurchLine."Dimension Set ID";
                                END;
                        END;
                        IF DimSetID = 0 THEN
                            ERROR(Error003, DimReq."Cod. Dimension", Tabla.CAPTION, Codigo);
                        REPEAT
                            IF NOT DimSetEntry.GET(DimSetID, DimReq."Cod. Dimension") THEN
                                ERROR(Error003, DimReq."Cod. Dimension", Tabla.CAPTION, Codigo);
                        UNTIL DimReq.NEXT = 0;
                    END;
                END;
            END;
        END
    end;

    procedure Documento(TableNo: Integer; TipoDoc: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; NoDoc: Code[20])
    var
        RecRef: RecordRef;
        MyRecordRef: RecordRef;
        MyFieldRef: array[200] of FieldRef;
        FieldRef: array[200] of FieldRef;
        RecID: RecordID;
    begin
        CCR.RESET;
        CCR.SETRANGE("No. Tabla", TableNo);
        IF CCR.FINDFIRST THEN BEGIN
            LCR.RESET;
            LCR.SETRANGE(LCR."No. Tabla", TableNo);
            IF LCR.FINDSET THEN BEGIN
                MyRecordRef.OPEN(TableNo);
                MyRecordRef.RESET;
                REPEAT
                    I += 1;
                    CLEAR(MyFieldRef);
                    IF I = 1 THEN BEGIN
                        MyFieldRef[I] := MyRecordRef.FIELD(1);
                        MyFieldRef[I + 1] := MyRecordRef.FIELD(3);
                        MyFieldRef[I].VALUE := TipoDoc;
                        MyFieldRef[I + 1].VALUE := NoDoc;
                    END
                    ELSE
                        MyFieldRef[I] := MyRecordRef.FIELD(LCR."No. Campo");
                    IF MyRecordRef.FIND('=') THEN BEGIN
                        FieldRef[I] := MyRecordRef.FIELD(LCR."No. Campo");
                        IF FORMAT(FieldRef[I].VALUE) = '' THEN
                            ERROR(Error001, FORMAT(FieldRef[I].CAPTION), FORMAT(MyRecordRef.CAPTION));
                    END;
                UNTIL LCR.NEXT = 0;
                MyRecordRef.CLOSE;
            END;
        END;
    end;
}

