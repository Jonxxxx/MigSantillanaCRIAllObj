report 56019 "Bultos Packing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Bultos Packing.rdlc';

    dataset
    {
        dataitem("Lin. Packing"; 56031)
        {
            DataItemTableView = SORTING("No.", "No. Caja");
            RequestFilterFields = "No.", "No. Caja";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Lin__Packing__No__; "No.")
            {
            }
            column(Lin__Packing__No__Caja_; "No. Caja")
            {
            }
            column(Lin__Packing__Fecha_Apertura_Caja_; "Fecha Apertura Caja")
            {
            }
            column(Lin__Packing__Fecha_Cierre_Caja_; "Fecha Cierre Caja")
            {
            }
            column(Lin__Packing__Estado_Caja_; "Estado Caja")
            {
            }
            column(Lin__Packing__No__Picking_; "No. Picking")
            {
            }
            column(N; N)
            {
            }
            column(CantCajas; CantCajas)
            {
            }
            column(Packing_LineCaption; Packing_LineCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Lin__Packing__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Lin__Packing__No__Caja_Caption; FIELDCAPTION("No. Caja"))
            {
            }
            column(Lin__Packing__Fecha_Apertura_Caja_Caption; FIELDCAPTION("Fecha Apertura Caja"))
            {
            }
            column(Lin__Packing__Fecha_Cierre_Caja_Caption; FIELDCAPTION("Fecha Cierre Caja"))
            {
            }
            column(Lin__Packing__Estado_Caja_Caption; FIELDCAPTION("Estado Caja"))
            {
            }
            column(Lin__Packing__No__Picking_Caption; FIELDCAPTION("No. Picking"))
            {
            }
            column(BULTOCaption; BULTOCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
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

    var
        LP: Record 56031;
        CantCajas: Integer;
        I: Integer;
        N: Integer;
        Packing_LineCaptionLbl: Label 'Packing Line';
        CurrReport_PAGENOCaptionLbl: Label 'Pág.';
        BULTOCaptionLbl: Label 'BULTO';
        EmptyStringCaptionLbl: Label '/';
}

