report 56006 "Listado clas. devoluciones"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Listado clas. devoluciones.rdlc';
    Caption = 'Returns classification report';

    dataset
    {
        dataitem("Cab. clas. devolucion"; 56025)
        {
            DataItemTableView = SORTING(No.);
            RequestFilterFields = "No.";
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
            column(GETFILTERS; GETFILTERS)
            {
            }
            column(Cab__pre_devolucion__External_document_no__; "External document no.")
            {
            }
            column(Cab__pre_devolucion__Closing_Datetime_; "Closing Datetime")
            {
            }
            column(Cab__pre_devolucion__User_id_; "User id")
            {
            }
            column(Cab__pre_devolucion_Closed; FORMAT(Closed))
            {
            }
            column(Cab__pre_devolucion__Receipt_date_; "Receipt date")
            {
            }
            column(Cab__pre_devolucion__Customer_name_; "Customer name")
            {
            }
            column(Cab__pre_devolucion__Customer_no__; "Customer no.")
            {
            }
            column(Cab__pre_devolucion__No__; "No.")
            {
            }
            column(Cab__recepcionCaption; Cab__recepcionCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Cab__pre_devolucion__External_document_no__Caption; FIELDCAPTION("External document no."))
            {
            }
            column(Cab__pre_devolucion__Closing_Datetime_Caption; FIELDCAPTION("Closing Datetime"))
            {
            }
            column(Cab__pre_devolucion__User_id_Caption; FIELDCAPTION("User id"))
            {
            }
            column(Cab__pre_devolucion_ClosedCaption; Cab__pre_devolucion_ClosedCaptionLbl)
            {
            }
            column(Cab__pre_devolucion__Receipt_date_Caption; FIELDCAPTION("Receipt date"))
            {
            }
            column(Cab__pre_devolucion__Customer_name_Caption; FIELDCAPTION("Customer name"))
            {
            }
            column(Cab__pre_devolucion__Customer_no__Caption; FIELDCAPTION("Customer no."))
            {
            }
            column(Cab__pre_devolucion__No__Caption; FIELDCAPTION("No."))
            {
            }
            dataitem("Lin. clas. devoluciones"; 56026)
            {
                DataItemLink = No. Documento=FIELD(No.);
                DataItemTableView = SORTING("No. Documento", Line No.);
                column(Lin__pre_Devoluciones__Receiving_date_; "Receiving date")
                {
                }
                column(Lin__pre_Devoluciones__Item_No__; "Item No.")
                {
                }
                column(Lin__pre_Devoluciones_Quantity; Quantity)
                {
                }
                column(Lin__pre_Devoluciones__Unit_of_Measure_Code_; "Unit of Measure Code")
                {
                }
                column(Lin__pre_Devoluciones__Cross_Reference_No__; "Cross-Reference No.")
                {
                }
                column(Lin__pre_Devoluciones_Inventory; Inventory)
                {
                }
                column(Lin__pre_Devoluciones__Inventario_en_Consignacion_; "Inventario en Consignacion")
                {
                }
                column(Lin__pre_Devoluciones__Cod__Almacen_Consignacion_; "Cod. Almacen Consignacion")
                {
                }
                column(Lin__pre_Devoluciones__Item_Description_; "Item Description")
                {
                }
                column(Lin__pre_Devoluciones__Con_defecto_; FORMAT("Con defecto"))
                {
                }
                column(Lin__clas__devoluciones_Recuperable; FORMAT(Recuperable))
                {
                }
                column(Lin__pre_Devoluciones_Comentario; Comentario)
                {
                }
                column(Lin__pre_Devoluciones__Inventario_en_Consignacion__Control1000000007; "Inventario en Consignacion")
                {
                }
                column(Lin__pre_Devoluciones_Inventory_Control1000000008; Inventory)
                {
                }
                column(Lin__pre_Devoluciones_Quantity_Control1000000009; Quantity)
                {
                }
                column(STRSUBSTNO_Totalfor__No__Documento__; STRSUBSTNO(Totalfor, "No. Documento"))
                {
                }
                column(Lin__pre_Devoluciones__Cod__Almacen_Consignacion_Caption; Lin__pre_Devoluciones__Cod__Almacen_Consignacion_CaptionLbl)
                {
                }
                column(Lin__pre_Devoluciones__Inventario_en_Consignacion_Caption; Lin__pre_Devoluciones__Inventario_en_Consignacion_CaptionLbl)
                {
                }
                column(Lin__pre_Devoluciones_InventoryCaption; FIELDCAPTION(Inventory))
                {
                }
                column(Lin__pre_Devoluciones__Cross_Reference_No__Caption; FIELDCAPTION("Cross-Reference No."))
                {
                }
                column(Lin__pre_Devoluciones__Receiving_date_Caption; FIELDCAPTION("Receiving date"))
                {
                }
                column(Lin__pre_Devoluciones_QuantityCaption; Lin__pre_Devoluciones_QuantityCaptionLbl)
                {
                }
                column(Lin__pre_Devoluciones__Unit_of_Measure_Code_Caption; FIELDCAPTION("Unit of Measure Code"))
                {
                }
                column(Lin__pre_Devoluciones__Item_Description_Caption; FIELDCAPTION("Item Description"))
                {
                }
                column(Lin__pre_Devoluciones__Item_No__Caption; FIELDCAPTION("Item No."))
                {
                }
                column(Lin__pre_Devoluciones__Con_defecto_Caption; Lin__pre_Devoluciones__Con_defecto_CaptionLbl)
                {
                }
                column(Lin__clas__devoluciones_RecuperableCaption; Lin__clas__devoluciones_RecuperableCaptionLbl)
                {
                }
                column(Lin__pre_Devoluciones_ComentarioCaption; FIELDCAPTION(Comentario))
                {
                }
                column(Lin__clas__devoluciones_No__Documento; "No. Documento")
                {
                }
                column(Lin__clas__devoluciones_Line_No_; "Line No.")
                {
                }
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("No.");
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

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Totalfor: Label 'Total for document %1:';
        Cab__recepcionCaptionLbl: Label 'Clasificación devolución cerrada';
        CurrReport_PAGENOCaptionLbl: Label 'Pág.';
        Cab__pre_devolucion_ClosedCaptionLbl: Label 'Closed';
        Lin__pre_Devoluciones__Cod__Almacen_Consignacion_CaptionLbl: Label 'Cód. Almacén Consigna.';
        Lin__pre_Devoluciones__Inventario_en_Consignacion_CaptionLbl: Label 'Invent. en Consigna.';
        Lin__pre_Devoluciones_QuantityCaptionLbl: Label 'Quantity';
        Lin__pre_Devoluciones__Con_defecto_CaptionLbl: Label 'Con defecto';
        Lin__clas__devoluciones_RecuperableCaptionLbl: Label 'Recuperable';
}

