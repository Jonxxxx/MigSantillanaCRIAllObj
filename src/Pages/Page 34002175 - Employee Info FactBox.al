page 34002175 "Employee Info FactBox"
{
    Caption = 'Employee data';
    PageType = CardPart;
    SourceTable = 5200;

    layout
    {
        area(content)
        {
            //TODO: Ver 
            /*
            field("Busca Nov"; STRSUBSTNO('(%1)', CUNomina.BuscaNovedades(Rec)))
            {
                Caption = 'Personnel actions';
                Editable = false;

                trigger OnDrillDown()
                begin
                    CUNomina.MuestraNovedades(Rec);
                end;
            }
            field(STRSUBSTNO('(%1)',CUNomina.BuscaCualificaciones("No."));STRSUBSTNO('(%1)',CUNomina.BuscaCualificaciones("No.")))
            {
                Caption = 'Qualifications';
                Editable = false;

                trigger OnDrillDown()
                begin
                    CUNomina.MuestraCualificaciones("No.");
                end;
            }
            field(STRSUBSTNO('(%1)',CUNomina.BuscaDimensiones("No."));STRSUBSTNO('(%1)',CUNomina.BuscaDimensiones("No.")))
            {
                Caption = 'Dimensions';
                Editable = false;

                trigger OnDrillDown()
                begin
                    CUNomina.MuestraDimensiones("No.");
                end;
            }
            field(STRSUBSTNO('(%1)',CUNomina.BuscaActividades(Rec,GETRANGEMIN("Date Filter"),GETRANGEMAX("Date Filter")));STRSUBSTNO('(%1)',CUNomina.BuscaActividades(Rec,GETRANGEMIN("Date Filter"),GETRANGEMAX("Date Filter"))))
            {
                Caption = 'Job entries';
                Editable = false;

                trigger OnDrillDown()
                begin
                    CUNomina.MuestraActividades(Rec,GETRANGEMIN("Date Filter"),GETRANGEMAX("Date Filter"));
                end;
            }
            field(STRSUBSTNO('(%1)',CUNomina.BuscaHistSalario(Rec));STRSUBSTNO('(%1)',CUNomina.BuscaHistSalario(Rec)))
            {
                Caption = 'Salary History';
                Editable = false;

                trigger OnDrillDown()
                begin
                    CUNomina.MuestraHistSalario(Rec);
                end;
            }
            */
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

