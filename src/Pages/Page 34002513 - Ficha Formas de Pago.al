page 55907 "Ficha Formas de Pago"
{
    // #70132  03.07.2018  RRT: Creacion de los campos "Tipo compensacion NC". En esta instalacion lo dejo como "NO VISIBLE".

    SourceTable = 55907;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("ID Pago"; Rec."ID Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Pago';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Efectivo Local"; Rec."Efectivo Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Efectivo Local';
                    Caption = 'Cash in Local Currency';
                }
                field("Abre cajon"; Rec."Abre cajon")
                {
                    ApplicationArea = All;
                    ToolTip = 'Abre cajon';
                }
                field("Cod. divisa"; Rec."Cod. divisa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. divisa';
                }
                field("Tipo Tarjeta"; Rec."Tipo Tarjeta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Tarjeta';
                }
                field("Realizar recuento"; Rec."Realizar recuento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Realizar recuento';
                }
                field("Icono Nav"; Rec."Icono Nav")
                {
                    ApplicationArea = All;
                    ToolTip = 'Icono Nav';
                    Caption = 'Icono';
                }
                field("Tipo Compensacion NC"; Rec."Tipo Compensacion NC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Compensacion NC';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    var
        cfComunes: Codeunit 55897;
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
    begin

        // TODO: Manual review - EsCentral is not a compiled procedure because its implementation remains inside a disabled codeunit block.
        // Original code: IF NOT cfComunes.EsCentral() THEN
        ERROR(Error001);
    end;
}

