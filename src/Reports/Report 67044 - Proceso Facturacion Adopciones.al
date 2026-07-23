report 67044 "Proceso Facturacion Adopciones"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Colegio - Adopciones Detalle"; 67053)
        {
            DataItemTableView = SORTING("Cod. Colegio", "Grupo de Negocio", Cod. Grado, Cod. Turno, Cod. Promotor, Cod. Producto)
                                WHERE(Adopcion = FILTER(Conquista | Mantener));
            RequestFilterFields = "Cod. Colegio", "Grupo de Negocio", "Cod. Grado", "Cod. Turno", "Cod. Promotor", "Cod. Producto";

            trigger OnAfterGetRecord()
            begin

                LineNo += 1000;
                CLEAR(SL);
                SL."Document Type" := SH."Document Type";
                SL."Document No." := SH."No.";
                SL."Line No." := LineNo;
                SL.VALIDATE("Sell-to Customer No.", SH."Sell-to Customer No.");
                SL.Type := SL.Type::Item;
                SL.VALIDATE("No.", "Cod. Producto");
                SL.VALIDATE("Cod. Colegio", "Cod. Colegio");
                //SL.VALIDATE("Location Code","Transfer-to Code");
                SL.VALIDATE("Cantidad Solicitada", "Adopcion Real");
                SL.VALIDATE("Cod. Vendedor", "Cod. Promotor");
                SL.INSERT(TRUE);
            end;

            trigger OnPreDataItem()
            begin
                IF GETFILTER("Cod. Colegio") = '' THEN
                    ERROR(Err002, FIELDCAPTION("Cod. Colegio"));

                SH.GET(TipoDocumento, NoDocumento);

                IF SH."Sell-to Customer No." = '' THEN
                    ERROR(Err001, SH.FIELDCAPTION("Sell-to Customer No."), SH.TABLECAPTION);


                IF SH."Cod. Colegio" = '' THEN BEGIN
                    SH.VALIDATE("Cod. Colegio", GETRANGEMIN("Cod. Colegio"));
                    SH.MODIFY;
                END;
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

    var
        SH: Record 36;
        SL: Record 37;
        ColAdopciones: Record 67053;
        CteRel: Record 5054;
        ProdEquiv: Record 67005;
        TipoDocumento: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        TipoAdopcion: Option "Con Adopcion","Sin Adopcion";
        NoDocumento: Code[20];
        LineNo: Integer;
        TipoFacturacion: Option "Factura a título gratuito","Factura Comercial";
        Err001: Label 'Specify %1 in %2 to continue';
        Err002: Label 'Specify %1 filter to continue';

    procedure RecibeParametros(TipoDoc: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; NoDoc: Code[20])
    begin
        TipoDocumento := TipoDoc;
        NoDocumento := NoDoc;
    end;
}

