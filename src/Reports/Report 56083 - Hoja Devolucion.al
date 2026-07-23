report 56083 "Hoja Devolucion"
{
    // ------------------------------------------------------------------------
    // No.         Fecha           Firma         Descripcion
    // ------------------------------------------------------------------------
    // 139         03/12/2013      RRT           Adaptacion informes a RTC.
    DefaultLayout = RDLC;
    RDLCLayout = './Hoja Devolucion.rdlc';

    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Transfer Header"; 5740)
        {
            RequestFilterFields = "No.";
            column(Transfer_Header__Transfer_from_Name_; "Transfer-from Name")
            {
            }
            column(Transfer_Header__Transfer_from_Code_; "Transfer-from Code")
            {
            }
            column(Transfer_from_Address___________Transfer_from_Address_2_; "Transfer-from Address" + ' ' + "Transfer-from Address 2")
            {
            }
            column(rCliente__Phone_No__; rCliente."Phone No.")
            {
            }
            column(Transfer_Header__No__; "No.")
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(PAG_____FORMAT_CurrReport_PAGENO_; 'PAG.: ' + FORMAT(CurrReport.PAGENO))
            {
            }
            column(RNC_______rEmpresa__VAT_Registration_No__; 'RNC : ' + rEmpresa."VAT Registration No.")
            {
            }
            column(P_gina_Web_______rEmpresa__Home_Page_; 'Página Web : ' + rEmpresa."Home Page")
            {
            }
            column(E_Mail_______rEmpresa__E_Mail_; 'E-Mail : ' + rEmpresa."E-Mail")
            {
            }
            column(Tels______rEmpresa__Phone_No____________Fax______rEmpresa__Fax_No__; 'Tels. ' + rEmpresa."Phone No." + ' - ' + 'Fax. ' + rEmpresa."Fax No.")
            {
            }
            column(rEmpresa_County; rEmpresa.County)
            {
            }
            column(rEmpresa_Address; rEmpresa.Address)
            {
            }
            column(rEmpresa_Name; rEmpresa.Name)
            {
            }
            column(HOJA_DE_DEVOLUCION_; 'HOJA DE DEVOLUCION')
            {
            }
            column(rCliente_Contact; rCliente.Contact)
            {
            }
            column(rCliente_City; rCliente.City)
            {
            }
            column(CLIENTE_Caption; CLIENTE_CaptionLbl)
            {
            }
            column(CODIGOCaption; CODIGOCaptionLbl)
            {
            }
            column(DESCRIPCIONCaption; DESCRIPCIONCaptionLbl)
            {
            }
            column(CANTIDAD_DEVUELTACaption; CANTIDAD_DEVUELTACaptionLbl)
            {
            }
            dataitem("Transfer Line"; 5741)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING(Description, "Item No.")
                                    ORDER(Ascending);
                column(Transfer_Line__Item_No__; "Item No.")
                {
                }
                column(Transfer_Line_Description; Description)
                {
                }
                column(Transfer_Line__Transfer_Line___Qty__to_Ship_; "Transfer Line"."Qty. to Ship")
                {
                }
                column(Transfer_Line__Transfer_Line___Qty__to_Ship__Control1000000003; "Transfer Line"."Qty. to Ship")
                {
                }
                column(txtComentario_1_; txtComentario[1])
                {
                }
                column(txtComentario_2_; txtComentario[2])
                {
                }
                column(txtComentario_3_; txtComentario[3])
                {
                }
                column(txtComentario_4_; txtComentario[4])
                {
                }
                column(TOTAL_BULTOSCaption; TOTAL_BULTOSCaptionLbl)
                {
                }
                column(TOTAL_EJEMPLARES_DEVUELTOSCaption; TOTAL_EJEMPLARES_DEVUELTOSCaptionLbl)
                {
                }
                column(Comentario_Caption; Comentario_CaptionLbl)
                {
                }
                column(SELLO_Y_NOMBRE_DEL_CLIENTECaption; SELLO_Y_NOMBRE_DEL_CLIENTECaptionLbl)
                {
                }
                column(FECHACaption; FECHACaptionLbl)
                {
                }
                column(NOMBRE_DE_QUIEN_RECOGECaption; NOMBRE_DE_QUIEN_RECOGECaptionLbl)
                {
                }
                column(Transfer_Line_Document_No_; "Document No.")
                {
                }
                column(Transfer_Line_Line_No_; "Line No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                lrTransferLine: Record 5741;
            begin
                //+139
                CLEAR(txtComentario);
                //-139

                //+139
                //... Si solo tuviera cabecera, lo saltamos.
                lrTransferLine.RESET;
                lrTransferLine.SETRANGE("Document No.", "No.");
                IF NOT lrTransferLine.FIND('-') THEN
                    CurrReport.SKIP;
                //-139

                //+139
                I := 0;
                //-139

                rComentario.RESET;
                rComentario.SETRANGE("Document Type", rComentario."Document Type"::"Transfer Order");
                rComentario.SETRANGE("No.", "No.");
                IF rComentario.FINDSET THEN
                    REPEAT
                        I += 1;
                        txtComentario[I] := rComentario.Comment;
                        rComentario.NEXT(1);
                    UNTIL I = rComentario.COUNT;

                //+139
                //rCliente.GET("Transfer-from Code");
                IF NOT rCliente.GET("Transfer-from Code") THEN
                    CLEAR(rCliente);
                //-139
            end;

            trigger OnPreDataItem()
            begin
                rEmpresa.GET;
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
        rCliente: Record 18;
        rComentario: Record 5748;
        txtComentario: array[15] of Text[200];
        I: Integer;
        rEmpresa: Record 79;
        CLIENTE_CaptionLbl: Label 'CLIENTE:';
        CODIGOCaptionLbl: Label 'CODIGO';
        DESCRIPCIONCaptionLbl: Label 'DESCRIPCION';
        CANTIDAD_DEVUELTACaptionLbl: Label 'CANTIDAD DEVUELTA';
        TOTAL_BULTOSCaptionLbl: Label 'TOTAL BULTOS';
        TOTAL_EJEMPLARES_DEVUELTOSCaptionLbl: Label 'TOTAL EJEMPLARES DEVUELTOS';
        Comentario_CaptionLbl: Label 'Comentario:';
        SELLO_Y_NOMBRE_DEL_CLIENTECaptionLbl: Label 'SELLO Y NOMBRE DEL CLIENTE';
        FECHACaptionLbl: Label 'FECHA';
        NOMBRE_DE_QUIEN_RECOGECaptionLbl: Label 'NOMBRE DE QUIEN RECOGE';
}

