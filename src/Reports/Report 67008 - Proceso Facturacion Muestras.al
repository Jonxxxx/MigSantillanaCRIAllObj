report 67008 "Proceso Facturacion Muestras"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Transfer Receipt Header"; 5746)
        {
            DataItemTableView = SORTING(No.);
            RequestFilterFields = "No.", "Transfer-from Code", "Transfer-to Code", "Cod. Ubicacion Alm. Origen", "Desc. Ubic. Alm. Destino", "External Document No.", "Posting Date";
            dataitem("Transfer Receipt Line"; 5747)
            {
                DataItemLink = Document No.=FIELD(No.);
                DataItemTableView = SORTING(Document No., Line No.);

                trigger OnAfterGetRecord()
                begin

                    ColAdopciones.RESET;
                    ColAdopciones.SETRANGE("Cod. Colegio", "Transfer-To Bin Code");
                    //    ColAdopciones.setrange("Cod. Promotor"
                    ColAdopciones.SETRANGE("Cod. Producto", "Item No.");
                    IF NOT ColAdopciones.FINDFIRST THEN
                        ColAdopciones.INIT;

                    IF TipoAdopcion = 0 THEN BEGIN
                        IF (ColAdopciones.Adopcion < 1) OR (ColAdopciones.Adopcion > 2) THEN // 1 = Mantenimiento, 2 = Conquista
                            CurrReport.SKIP;
                    END
                    ELSE BEGIN
                        IF (ColAdopciones.Adopcion = 1) OR (ColAdopciones.Adopcion = 2) THEN // 1 = Mantenimiento, 2 = Conquista
                            CurrReport.SKIP;
                    END;

                    ProdEquiv.GET("Item No.");

                    /*
                    ELSE
                    IF (ColAdopciones.Adopcion > 0) THEN
                       CurrReport.SKIP;
                    */

                    LineNo += 1000;
                    CLEAR(SL);
                    SL."Document Type" := SH."Document Type";
                    SL."Document No." := SH."No.";
                    SL."Line No." := LineNo;
                    SL.VALIDATE("Sell-to Customer No.", SH."Sell-to Customer No.");
                    SL.Type := SL.Type::Item;
                    SL.VALIDATE("No.", "Item No.");
                    //SL.VALIDATE("No.",ProdEquiv."Cod. Producto Docente");
                    SL.VALIDATE("Location Code", "Transfer-to Code");
                    //SL.VALIDATE("Cantidad Solicitada",Quantity);
                    SL.VALIDATE("Cantidad Solicitada", Quantity);
                    SL.VALIDATE("Bin Code", "Transfer-To Bin Code");
                    SL.INSERT(TRUE);

                end;

                trigger OnPreDataItem()
                begin
                    LineNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                //CLEAR(SH);
                SH.GET(TipoDocumento, NoDocumento);
                //SH."Document Type" := TipoDocumento;
                //SH.INSERT(TRUE);

                IF SH."Sell-to Customer No." = '' THEN BEGIN
                    CteRel.SETRANGE("Contact No.", "Cod. Ubicacion Alm. Destino");
                    CteRel.FINDFIRST;
                    SH.VALIDATE("Sell-to Customer No.", CteRel."No.");
                    SH.MODIFY(TRUE);
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Blanco2)
                {
                    field(TipoFacturacion; TipoFacturacion)
                    {
                        Caption = 'Invoice type';
                    }
                    field(TipoAdopcion; TipoAdopcion)
                    {
                        Caption = 'Adoption type';
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

    procedure RecibeParametros(TipoDoc: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; NoDoc: Code[20])
    begin
        TipoDocumento := TipoDoc;
        NoDocumento := NoDoc;
    end;
}

