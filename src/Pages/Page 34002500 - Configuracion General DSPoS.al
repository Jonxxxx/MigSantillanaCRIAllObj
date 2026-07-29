page 34002500 "Configuracion General DSPoS"
{
    PageType = Card;
    SourceTable = 34002500;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Nombre libro diario"; Rec."Nombre libro diario")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre libro diario';
                }
                field("Nombre seccion diario"; Rec."Nombre seccion diario")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre seccion diario';
                }
                field(Pais; Rec.Pais)
                {
                    ApplicationArea = All;
                    ToolTip = 'Pais';
                    BlankZero = true;
                }
                field("Nombre Divisa Local"; Rec."Nombre Divisa Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Divisa Local';
                }
            }
            part(PartPage; 50114)
            {
            }
            part(PartPage1; 50113)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    var
        // TODO: Manual review - Codeunit 34002503 exists, but EsCentral is inside a disabled block and is not a compiled public procedure.
        // Original code: cfComunes: Codeunit 34002503;
    begin

        // TODO: Manual review - EsCentral is not a compiled procedure because its implementation remains inside a disabled codeunit block.
        // Original code preserved below.
        // IF NOT cfComunes.EsCentral() THEN
        //     ERROR(error001);
    end;

    trigger OnOpenPage()
    begin
        IF NOT GET THEN
            INSERT;
    end;

    var
        error001: Label 'Funcion Solo Disponible en Servidor Central';
}

