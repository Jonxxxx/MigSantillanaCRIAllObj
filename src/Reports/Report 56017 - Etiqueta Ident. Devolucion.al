report 56017 "Etiqueta Ident. Devolucion"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Etiqueta Ident. Devolucion.rdlc';

    dataset
    {
        dataitem("Lin. Ident. Devolucion Reg."; 56019)
        {
            column(CI_Name; CI.Name)
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI__Address_2________CI_City; CI."Address 2" + ' ' + CI.City)
            {
            }
            column(Cust__No__; Cust."No.")
            {
            }
            column(Cust_Name; Cust.Name)
            {
            }
            column(Cust_Address; Cust.Address)
            {
            }
            column(Cust__Address_2_; Cust."Address 2")
            {
            }
            column(Cust_City; Cust.City)
            {
            }
            column(Cust_County; Cust.County)
            {
            }
            column(FORMAT__No__Bulto_______FORMAT_CID__Cantidad_de_Bultos__; FORMAT("No. Bulto") + '/' + FORMAT(CID."Cantidad de Bultos"))
            {
            }
            column(Lin__Ident__Devolucion_Reg__Ubicacion; Ubicacion)
            {
            }
            column(No__Ident__Devolucion_____; '*' + "No. Ident. Devolucion" + '*')
            {
            }
            column(Lin__Ident__Devolucion_Reg___No__Ident__Devolucion_; "No. Ident. Devolucion")
            {
            }
            column(CID__Fecha_Recepcion_; CID."Fecha Recepcion")
            {
            }
            column(Destinatario_Caption; Destinatario_CaptionLbl)
            {
            }
            column(Orden_de_Recogida__Caption; Orden_de_Recogida__CaptionLbl)
            {
            }
            column(Fecha_de_Recepcion__Caption; Fecha_de_Recepcion__CaptionLbl)
            {
            }
            column(No__Cliente__Caption; No__Cliente__CaptionLbl)
            {
            }
            column(BultoCaption; BultoCaptionLbl)
            {
            }
            column(UbicacionCaption; UbicacionCaptionLbl)
            {
            }
            column(Lin__Ident__Devolucion_Reg__No__Bulto; "No. Bulto")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CID.GET("No. Ident. Devolucion");
                Cust.GET(CID."Cod. Cliente");
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

    trigger OnPreReport()
    begin
        CI.GET;
    end;

    var
        CI: Record 79;
        Cust: Record 18;
        CID: Record 56018;
        Destinatario_CaptionLbl: Label 'Destinatario:';
        Orden_de_Recogida__CaptionLbl: Label 'Orden de Recogida :';
        "Fecha_de_Recepcion__CaptionLbl": Label 'Fecha de Recepcion :';
        No__Cliente__CaptionLbl: Label 'No. Cliente :';
        BultoCaptionLbl: Label 'Bulto';
        "UbicacionCaptionLbl": Label 'Ubicacion';
}

