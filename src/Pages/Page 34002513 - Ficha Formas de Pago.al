page 34002513 "Ficha Formas de Pago"
{
    // #70132  03.07.2018  RRT: Creacion de los campos "Tipo compensacion NC". En esta instalacion lo dejo como "NO VISIBLE".

    SourceTable = 34002513;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("ID Pago"; "ID Pago")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Efectivo Local"; "Efectivo Local")
                {
                    Caption = 'Cash in Local Currency';
                }
                field("Abre cajon"; "Abre cajon")
                {
                }
                field("Cod. divisa"; "Cod. divisa")
                {
                }
                field("Tipo Tarjeta"; "Tipo Tarjeta")
                {
                }
                field("Realizar recuento"; "Realizar recuento")
                {
                }
                field("Icono Nav"; "Icono Nav")
                {
                    Caption = 'Icono';
                }
                field("Tipo Compensacion NC"; "Tipo Compensacion NC")
                {
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
        //TODO: Ver cfComunes: Codeunit 34002503;
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
    begin

        //TODO: VerIF NOT (cfComunes.EsCentral) THEN
        ERROR(Error001);
    end;
}

