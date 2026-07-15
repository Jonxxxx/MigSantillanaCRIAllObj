page 34002176 "Payroll Information FactBox"
{
    Caption = 'Payroll Information';
    PageType = CardPart;
    SourceTable = 5200;

    layout
    {
        area(content)
        {
            //TODO: Ver 
            /*
            field(STRSUBSTNO('(%1)',CUNomina.BuscaNominas(Rec));STRSUBSTNO('(%1)',CUNomina.BuscaNominas(Rec)))
            {
                Caption = 'Payroll';
                Editable = false;

                trigger OnDrillDown()
                begin
                    CUNomina.MuestraNominas(Rec);
                end;
            }
            field(STRSUBSTNO('(%1)',CUNomina.BuscaSaldoISRFavor(Rec));STRSUBSTNO('(%1)',CUNomina.BuscaSaldoISRFavor(Rec)))
            {
                Caption = 'Tax balance';

                trigger OnDrillDown()
                begin
                    CUNomina.MuestraSaldoISRFavor(Rec);
                end;
            }*/
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        IF GETFILTER("Date Filter") = '' THEN
            SETRANGE("Date Filter", 0D, DMY2DATE(31, 12, DATE2DMY(TODAY, 3)));
    end;

    var
    //TODO: Ver CUNomina: Codeunit 34002104;
}

