report 50000 "Modificar Pedidos E-commerce"
{
    // YFC     : Yefrecis Francisco Cruz
    // ------------------------------------------------------------------------
    // No.         Firma     Fecha            Descripcion
    // ------------------------------------------------------------------------
    // 001         YFC      02/17/2021       SANTINAV-2130: mejoras en desarrollo para E-Commerce

    ApplicationArea = Basic, Suite, Service;
    Caption = 'Modificar Pedidos E-commerce';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Cab. Venta NopCommerce"; 50100)
        {
            RequestFilterFields = "No. documento";

            trigger OnAfterGetRecord()
            begin
                // ++ 001-YFC

                IF NuevaCedula <> '' THEN
                    "Cab. Venta NopCommerce"."RNC/Cedula" := NuevaCedula;

                IF NuevoCorreo <> '' THEN
                    "Cab. Venta NopCommerce"."E-Mail" := NuevoCorreo;

                "Cab. Venta NopCommerce".Error := FALSE;
                "Cab. Venta NopCommerce".MODIFY;
                MESSAGE(Message01);

                // -- 001-YFC
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Nuevos Datos")
                {
                    Caption = 'Nuevos Datos';
                    field("Nueva Cedula"; NuevaCedula)
                    {
                        Caption = 'Nueva Cedula';
                    }
                    field("Nuevo Correo"; NuevoCorreo)
                    {
                        Caption = 'Nuevo Correo';
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

    trigger OnInitReport()
    begin
        // ++ 001-YFC

        IF UserSetup.GET(USERID) THEN;
        IF NOT UserSetup."Modificar Ped E-commerce" THEN
            ERROR(Error02);

        // -- 001-YFC
    end;

    trigger OnPreReport()
    begin
        // ++ 001-YFC

        IF (NuevaCedula = '') AND (NuevoCorreo = '') THEN
            ERROR(Error01);
        // -- 001-YFC
    end;

    var
        NuevaCedula: Text[30];
        Error01: Label 'El campo Nueva Cedula o Nuevo Correo debe tener un valor';
        UserSetup: Record 91;
        Error02: Label 'No tiene permiso en Conf Usuario para ejecutar este reporte';
        Message01: Label 'Proceso finalizado';
        NuevoCorreo: Text[30];
}

