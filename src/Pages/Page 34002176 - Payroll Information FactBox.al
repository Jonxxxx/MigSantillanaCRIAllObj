page 55817 "Payroll Information FactBox"
{
    Caption = 'Payroll Information';
    PageType = CardPart;
    SourceTable = 5200;

    layout
    {
        area(content)
        {
            field(JXPayrollCount; STRSUBSTNO('(%1)', CUNomina.BuscaNominas(Rec)))
            {
                ApplicationArea = All;
                Caption = 'Payroll';
                Editable = false;

                trigger OnDrillDown()
                begin
                    CUNomina.MuestraNominas(Rec);
                end;
            }
            field(JXTaxBalance; STRSUBSTNO('(%1)', CUNomina.BuscaSaldoISRFavor(Rec)))
            {
                ApplicationArea = All;
                Caption = 'Tax balance';

                trigger OnDrillDown()
                begin
                    CUNomina.MuestraSaldoISRFavor(Rec);
                end;
            }
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
        CUNomina: Codeunit 55745;
}

