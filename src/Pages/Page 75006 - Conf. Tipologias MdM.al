page 75006 "Conf. Tipologias MdM"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Conf. Tipologias MdM';
    DelayedInsert = true;
    PageType = List;
    SourceTable = 75006;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = wEditable;
                field(Tipologia; Tipologia)
                {
                    Style = StandardAccent;
                    StyleExpr = TRUE;

                    trigger OnValidate()
                    var
                        lrItemCat: Record 5722;
                    begin

                        IF lrItemCat.GET(Tipologia) THEN BEGIN
                            //fes mig  "Gen. Prod. Posting Group" := lrItemCat."Def. Gen. Prod. Posting Group";
                            //fes mig  "Inventory Posting Group"  := lrItemCat."Def. Inventory Posting Group";
                            //fes mig  "VAT Prod. Posting Group"  := lrItemCat."Def. VAT Prod. Posting Group";
                            //fes mig  "Costing Method"           := lrItemCat."Def. Costing Method";
                            "Item Disc. Group" := ''; // No existe
                            "No. Series" := ''; // No existe
                        END;
                    end;
                }
                field("Referencia 1"; "Referencia 1")
                {
                    Editable = wRefEnbl1;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                    Visible = wRefEnbl1;
                }
                field("Referencia 2"; "Referencia 2")
                {
                    Editable = wRefEnbl2;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                    Visible = wRefEnbl2;
                }
                field("Referencia 3"; "Referencia 3")
                {
                    Editable = wRefEnbl3;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                    Visible = wRefEnbl3;
                }
                field("Referencia 4"; "Referencia 4")
                {
                    Editable = wRefEnbl4;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                    Visible = wRefEnbl4;
                }
                field("Referencia 5"; "Referencia 5")
                {
                    Editable = wRefEnbl5;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                    Visible = wRefEnbl5;
                }
                field("Referencia 6"; "Referencia 6")
                {
                    Editable = wRefEnbl6;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                    Visible = wRefEnbl6;
                }
                field("Referencia 7"; "Referencia 7")
                {
                    Editable = wRefEnbl7;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                    Visible = wRefEnbl7;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                }
                field("Inventory Posting Group"; "Inventory Posting Group")
                {
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                }
                field("Costing Method"; "Costing Method")
                {
                }
                field("Item Disc. Group"; "Item Disc. Group")
                {
                }
                field("No. Series"; "No. Series")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Configuración Campos")
            {
                Image = SetupList;
                RunObject = Page 75008;
            }
        }
    }

    trigger OnOpenPage()
    var
        lrConfF: Record 75008;
        lwNo: Integer;
    begin
        //TODO: Ver wEditable := cFunMdm.GetEditable;
        CurrPage.EDITABLE := wEditable;

        // Hacemos visibles solo las columnas configuradas
        wRefEnbl1 := lrConfF.GET(1);
        wRefEnbl2 := lrConfF.GET(2);
        wRefEnbl3 := lrConfF.GET(3);
        wRefEnbl4 := lrConfF.GET(4);
        wRefEnbl5 := lrConfF.GET(5);
        wRefEnbl6 := lrConfF.GET(6);
        wRefEnbl7 := lrConfF.GET(7);
    end;

    var
        wEditable: Boolean;
        //TODO: Ver cFunMdm: Codeunit 75000;
        wRefEnbl1: Boolean;
        wRefEnbl2: Boolean;
        wRefEnbl3: Boolean;
        wRefEnbl4: Boolean;
        wRefEnbl5: Boolean;
        wRefEnbl6: Boolean;
        wRefEnbl7: Boolean;
}

