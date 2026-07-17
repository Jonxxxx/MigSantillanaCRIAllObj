pageextension 50013 EXCCRIItemCard extends "Item Card"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRIAdditionalData)
            {
                Caption = 'Additional Data';

                field(EXCCRINo2; Rec."No. 2")
                {
                    ApplicationArea = All;
                    Caption = 'No. 2';
                    Editable = false;
                    ToolTip = 'Specifies the secondary item number.';
                }

                field(EXCCRIDescription2; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Caption = 'Description 2';
                    Editable = EXCCRIMdMEditable;
                    ToolTip = 'Specifies the secondary item description.';
                }

                field(EXCCRIMdMManaged; Rec."Gestionado MdM")
                {
                    ApplicationArea = All;
                    Caption = 'MdM Managed';
                    Editable = false;
                    ToolTip = 'Specifies whether the item is managed by MdM.';
                }

                field(EXCCRIInactive; Rec.Inactivo)
                {
                    ApplicationArea = All;
                    Caption = 'Inactive';
                    ToolTip = 'Specifies whether the item is inactive.';
                }

                field(EXCCRICABYS; Rec.CABYS)
                {
                    ApplicationArea = All;
                    Caption = 'CABYS';
                    ToolTip = 'Specifies the CABYS classification code assigned to the item.';
                }

                field(EXCCRIShare; Rec.Compartir)
                {
                    ApplicationArea = All;
                    Caption = 'Share';
                    ToolTip = 'Specifies whether the item is shared.';
                }

                field(EXCCRITransferredQty; Rec."Transferred (Qty.)")
                {
                    ApplicationArea = All;
                    Caption = 'Transferred Quantity';
                    ToolTip = 'Specifies the transferred quantity for the item.';
                }

                field(EXCCRITransferReceiptQty; Rec."Trans. Ord. Receipt (Qty.)")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer Receipt Quantity';
                    ToolTip = 'Specifies the quantity received through transfer orders.';
                }

                field(EXCCRITransferShipmentQty; Rec."Trans. Ord. Shipment (Qty.)")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer Shipment Quantity';
                    ToolTip = 'Specifies the quantity shipped through transfer orders.';
                }

                field(EXCCRIVATProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Product Posting Group';
                    ToolTip = 'Specifies the VAT product posting group assigned to the item.';
                }
            }

            group(EXCCRIRequiredFieldsGroup)
            {
                Caption = 'Incomplete Required Fields';

                field(EXCCRIRequiredField1; EXCCRIRequiredFields[1])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item field that has not been completed.';
                }

                field(EXCCRIRequiredField2; EXCCRIRequiredFields[2])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item field that has not been completed.';
                }

                field(EXCCRIRequiredField3; EXCCRIRequiredFields[3])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item field that has not been completed.';
                }

                field(EXCCRIRequiredField4; EXCCRIRequiredFields[4])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item field that has not been completed.';
                }

                field(EXCCRIRequiredField5; EXCCRIRequiredFields[5])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item field that has not been completed.';
                }

                field(EXCCRIRequiredField6; EXCCRIRequiredFields[6])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item field that has not been completed.';
                }

                field(EXCCRIRequiredField7; EXCCRIRequiredFields[7])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item field that has not been completed.';
                }

                field(EXCCRIRequiredField8; EXCCRIRequiredFields[8])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item field that has not been completed.';
                }

                field(EXCCRIRequiredField9; EXCCRIRequiredFields[9])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item field that has not been completed.';
                }

                field(EXCCRIRequiredField10; EXCCRIRequiredFields[10])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item field that has not been completed.';
                }

                field(EXCCRIRequiredField11; EXCCRIRequiredFields[11])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item field that has not been completed.';
                }

                field(EXCCRIRequiredField12; EXCCRIRequiredFields[12])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item field that has not been completed.';
                }
            }

            group(EXCCRIRequiredDimensionsGroup)
            {
                Caption = 'Incomplete Required Dimensions';

                field(EXCCRIRequiredDimension1; EXCCRIRequiredDimensions[1])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item dimension that has not been assigned.';
                }

                field(EXCCRIRequiredDimension2; EXCCRIRequiredDimensions[2])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item dimension that has not been assigned.';
                }

                field(EXCCRIRequiredDimension3; EXCCRIRequiredDimensions[3])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item dimension that has not been assigned.';
                }

                field(EXCCRIRequiredDimension4; EXCCRIRequiredDimensions[4])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item dimension that has not been assigned.';
                }

                field(EXCCRIRequiredDimension5; EXCCRIRequiredDimensions[5])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item dimension that has not been assigned.';
                }

                field(EXCCRIRequiredDimension6; EXCCRIRequiredDimensions[6])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item dimension that has not been assigned.';
                }

                field(EXCCRIRequiredDimension7; EXCCRIRequiredDimensions[7])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item dimension that has not been assigned.';
                }

                field(EXCCRIRequiredDimension8; EXCCRIRequiredDimensions[8])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required item dimension that has not been assigned.';
                }
            }

            group(EXCCRIMdM)
            {
                Caption = 'MdM';
                Editable = EXCCRIMdMEditable;

                group(EXCCRIMdMIdentification)
                {
                    Caption = 'Identification';

                    field(EXCCRIISBN; Rec.ISBN)
                    {
                        ApplicationArea = All;
                        Caption = 'ISBN';
                        ToolTip = 'Specifies the ISBN assigned to the item.';
                    }

                    field(EXCCRIEAN; EXCCRIMdMFunctions.GetEAN(Rec))
                    {
                        ApplicationArea = All;
                        Caption = 'EAN';
                        Editable = false;
                        ToolTip = 'Shows the EAN calculated for the item.';
                    }

                    field(EXCCRIPageCount; Rec."No. Paginas")
                    {
                        ApplicationArea = All;
                        Caption = 'Page Count';
                        ToolTip = 'Specifies the number of pages for the item.';
                    }

                    field(EXCCRICopyright; Rec."Derecho de autor")
                    {
                        ApplicationArea = All;
                        Caption = 'Copyright';
                        ToolTip = 'Specifies the copyright information for the item.';
                    }
                }

                group(EXCCRIMdMProductType)
                {
                    Caption = 'Product Type';

                    field(EXCCRIProductType; Rec."Tipo Producto")
                    {
                        ApplicationArea = All;
                        Caption = 'Product Type';
                        ToolTip = 'Specifies the MdM product type.';
                    }

                    field(EXCCRIProductTypeDesc; EXCCRIGetDataDescription(0, Rec."Tipo Producto"))
                    {
                        ApplicationArea = All;
                        Caption = 'Product Type Description';
                        Editable = false;
                        ToolTip = 'Shows the description of the MdM product type.';
                    }
                }

                group(EXCCRIMdMSupport)
                {
                    Caption = 'Support';

                    field(EXCCRISupport; Rec.Soporte)
                    {
                        ApplicationArea = All;
                        Caption = 'Support';
                        ToolTip = 'Specifies the product support type.';
                    }

                    field(EXCCRISupportDesc; EXCCRIGetDataDescription(1, Rec.Soporte))
                    {
                        ApplicationArea = All;
                        Caption = 'Support Description';
                        Editable = false;
                        ToolTip = 'Shows the description of the product support type.';
                    }
                }

                group(EXCCRIMdMBusinessLine)
                {
                    Caption = 'Business Line';

                    field(EXCCRIBusinessLine; Rec.Linea)
                    {
                        ApplicationArea = All;
                        Caption = 'Business Line';
                        ToolTip = 'Specifies the business line assigned to the item.';
                    }

                    field(EXCCRIBusinessLineDesc; EXCCRIGetDataDescription(7, Rec.Linea))
                    {
                        ApplicationArea = All;
                        Caption = 'Business Line Description';
                        Editable = false;
                        ToolTip = 'Shows the description of the business line.';
                    }
                }

                group(EXCCRIMdMBrand)
                {
                    Caption = 'Seal/Brand';

                    field(EXCCRIBrand; Rec.Sello)
                    {
                        ApplicationArea = All;
                        Caption = 'Seal/Brand';
                        ToolTip = 'Specifies the seal or brand assigned to the item.';
                    }

                    field(EXCCRIBrandDesc; EXCCRIGetDataDescription(10, Rec.Sello))
                    {
                        ApplicationArea = All;
                        Caption = 'Seal/Brand Description';
                        Editable = false;
                        ToolTip = 'Shows the description of the seal or brand.';
                    }
                }

                group(EXCCRIMdMLanguage)
                {
                    Caption = 'Language';

                    field(EXCCRILanguage; Rec.Idioma)
                    {
                        ApplicationArea = All;
                        Caption = 'Language';
                        ToolTip = 'Specifies the language assigned to the item.';
                    }

                    field(EXCCRILanguageDesc; EXCCRIMdMFunctions.GetIdiomaDesc(Rec))
                    {
                        ApplicationArea = All;
                        Caption = 'Language Description';
                        Editable = false;
                        ToolTip = 'Shows the language description for the item.';
                    }
                }

                group(EXCCRIMdMSeries)
                {
                    Caption = 'Series';

                    field(EXCCRIMethodSeries; EXCCRIGetDimensionValue(0))
                    {
                        ApplicationArea = All;
                        Caption = 'Series';
                        Editable = false;
                        AssistEdit = true;
                        ToolTip = 'Shows the series dimension value assigned to the item.';

                        trigger OnAssistEdit()
                        begin
                            EXCCRIShowDimension(0);
                            //exit(true);
                        end;
                    }

                    field(EXCCRIMethodSeriesDesc; EXCCRIGetDimensionValueName(0))
                    {
                        ApplicationArea = All;
                        Caption = 'Series Description';
                        Editable = false;
                        ToolTip = 'Shows the description of the series dimension value.';
                    }
                }

                group(EXCCRIMdMAuthor)
                {
                    Caption = 'Author';

                    field(EXCCRIAuthor; Rec.Autor)
                    {
                        ApplicationArea = All;
                        Caption = 'Author';
                        ToolTip = 'Specifies the author assigned to the item.';
                    }

                    field(EXCCRIAuthorDesc; EXCCRIGetDataDescription(5, Rec.Autor))
                    {
                        ApplicationArea = All;
                        Caption = 'Author Description';
                        Editable = false;
                        ToolTip = 'Shows the author description.';
                    }
                }

                group(EXCCRIMdMPublisher)
                {
                    Caption = 'Publishing Company';

                    field(EXCCRIPublishingCompany; Rec."Empresa Editora")
                    {
                        ApplicationArea = All;
                        Caption = 'Publishing Company';
                        ToolTip = 'Specifies the publishing company assigned to the item.';
                    }

                    field(EXCCRIPublishingCompanyDesc; EXCCRIGetDataDescription(2, Rec."Empresa Editora"))
                    {
                        ApplicationArea = All;
                        Caption = 'Publishing Company Description';
                        Editable = false;
                        ToolTip = 'Shows the publishing company description.';
                    }
                }

                group(EXCCRIMdMEditorialPlan)
                {
                    Caption = 'Editorial Plan';

                    field(EXCCRIEditorialPlan; Rec."Plan Editorial")
                    {
                        ApplicationArea = All;
                        Caption = 'Editorial Plan';
                        ToolTip = 'Specifies the editorial plan assigned to the item.';
                    }

                    field(EXCCRIEditorialPlanDesc; EXCCRIGetDataDescription(4, Rec."Plan Editorial"))
                    {
                        ApplicationArea = All;
                        Caption = 'Editorial Plan Description';
                        Editable = false;
                        ToolTip = 'Shows the editorial plan description.';
                    }
                }

                group(EXCCRIMdMEdition)
                {
                    Caption = 'Edition';

                    field(EXCCRIEdition; Rec.Edicion)
                    {
                        ApplicationArea = All;
                        Caption = 'Edition';
                        ToolTip = 'Specifies the edition assigned to the item.';
                    }

                    field(EXCCRIEditionDesc; EXCCRIGetDataDescription(11, Rec.Edicion))
                    {
                        ApplicationArea = All;
                        Caption = 'Edition Description';
                        Editable = false;
                        ToolTip = 'Shows the edition description.';
                    }
                }

                group(EXCCRIMdMCampaign)
                {
                    Caption = 'Campaign';

                    field(EXCCRICampaign; Rec.Campana)
                    {
                        ApplicationArea = All;
                        Caption = 'Campaign';
                        ToolTip = 'Specifies the campaign assigned to the item.';
                    }

                    field(EXCCRICampaignDesc; EXCCRIGetDataDescription(13, Rec.Campana))
                    {
                        ApplicationArea = All;
                        Caption = 'Campaign Description';
                        Editable = false;
                        ToolTip = 'Shows the campaign description.';
                    }
                }

                group(EXCCRIMdMDestination)
                {
                    Caption = 'Destination';

                    field(EXCCRIDestination; EXCCRIGetDimensionValue(1))
                    {
                        ApplicationArea = All;
                        Caption = 'Destination';
                        Editable = false;
                        AssistEdit = true;
                        ToolTip = 'Shows the destination dimension value assigned to the item.';

                        trigger OnAssistEdit()//: Boolean
                        begin
                            EXCCRIShowDimension(1);
                            //exit(true);
                        end;
                    }

                    field(EXCCRIDestinationDesc; EXCCRIGetDimensionValueName(1))
                    {
                        ApplicationArea = All;
                        Caption = 'Destination Description';
                        Editable = false;
                        ToolTip = 'Shows the destination dimension description.';
                    }
                }

                group(EXCCRIMdMAccount)
                {
                    Caption = 'Account';

                    field(EXCCRIAccount; EXCCRIGetDimensionValue(2))
                    {
                        ApplicationArea = All;
                        Caption = 'Account';
                        Editable = false;
                        AssistEdit = true;
                        ToolTip = 'Shows the account dimension value assigned to the item.';

                        trigger OnAssistEdit()//: Boolean
                        begin
                            EXCCRIShowDimension(2);
                            //exit(true);
                        end;
                    }

                    field(EXCCRIAccountDesc; EXCCRIGetDimensionValueName(2))
                    {
                        ApplicationArea = All;
                        Caption = 'Account Description';
                        Editable = false;
                        ToolTip = 'Shows the account dimension description.';
                    }
                }

                group(EXCCRIMdMAnalyticalStructure)
                {
                    Caption = 'Analytical Structure';

                    field(EXCCRIAnalyticalStructure; Rec."Estructura Analitica")
                    {
                        ApplicationArea = All;
                        Caption = 'Analytical Structure';
                        ToolTip = 'Specifies the analytical structure assigned to the item.';
                    }

                    field(EXCCRIAnalyticalStructDesc; EXCCRIMdMFunctions.GetEstrcturaAnaliticaDescr(Rec))
                    {
                        ApplicationArea = All;
                        Caption = 'Analytical Structure Description';
                        Editable = false;
                        ToolTip = 'Shows the analytical structure description.';
                    }
                }

                group(EXCCRIMdMStatus)
                {
                    Caption = 'Status';

                    field(EXCCRIStatus; Rec.Estado)
                    {
                        ApplicationArea = All;
                        Caption = 'Status';
                        ToolTip = 'Specifies the MdM status assigned to the item.';
                    }

                    field(EXCCRIStatusDesc; EXCCRIGetDataDescription(12, Rec.Estado))
                    {
                        ApplicationArea = All;
                        Caption = 'Status Description';
                        Editable = false;
                        ToolTip = 'Shows the MdM status description.';
                    }
                }

                group(EXCCRIMdMTextType)
                {
                    Caption = 'Text Type';

                    field(EXCCRITextType; EXCCRIGetDimensionValue(3))
                    {
                        ApplicationArea = All;
                        Caption = 'Text Type';
                        AssistEdit = true;
                        ToolTip = 'Shows the text type dimension value assigned to the item.';

                        trigger OnAssistEdit()//: Boolean
                        begin
                            EXCCRIShowDimension(3);
                            //exit(true);
                        end;
                    }

                    field(EXCCRITextTypeDesc; EXCCRIGetDimensionValueName(3))
                    {
                        ApplicationArea = All;
                        Caption = 'Text Type Description';
                        Editable = false;
                        ToolTip = 'Shows the text type dimension description.';
                    }
                }

                group(EXCCRIMdMSubject)
                {
                    Caption = 'Subject';

                    field(EXCCRISubject; Rec.Asignatura)
                    {
                        ApplicationArea = All;
                        Caption = 'Subject';
                        ToolTip = 'Specifies the subject assigned to the item.';
                    }

                    field(EXCCRISubjectDesc; EXCCRIGetDataDescription(8, Rec.Asignatura))
                    {
                        ApplicationArea = All;
                        Caption = 'Subject Description';
                        Editable = false;
                        ToolTip = 'Shows the subject description.';
                    }
                }

                group(EXCCRIMdMMatter)
                {
                    Caption = 'Matter';

                    field(EXCCRIMatter; EXCCRIGetDimensionValue(4))
                    {
                        ApplicationArea = All;
                        Caption = 'Matter';
                        AssistEdit = true;
                        ToolTip = 'Shows the matter dimension value assigned to the item.';

                        trigger OnAssistEdit()//: Boolean
                        begin
                            EXCCRIShowDimension(4);
                            //exit(true);
                        end;
                    }

                    field(EXCCRIMatterDesc; EXCCRIGetDimensionValueName(4))
                    {
                        ApplicationArea = All;
                        Caption = 'Matter Description';
                        Editable = false;
                        ToolTip = 'Shows the matter dimension description.';
                    }
                }

                group(EXCCRIMdMLevel)
                {
                    Caption = 'Level';

                    field(EXCCRILevel; EXCCRILevelCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Level';
                        Editable = false;
                        ToolTip = 'Shows the educational level derived from the school grade.';
                    }

                    field(EXCCRILevelDesc; EXCCRIGetDataDescription(3, EXCCRILevelCode))
                    {
                        ApplicationArea = All;
                        Caption = 'Level Description';
                        Editable = false;
                        ToolTip = 'Shows the educational level description.';
                    }
                }

                group(EXCCRIMdMCycle)
                {
                    Caption = 'Cycle';

                    field(EXCCRICycle; EXCCRICycleCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Cycle';
                        Editable = false;
                        ToolTip = 'Shows the educational cycle derived from the school grade.';
                    }

                    field(EXCCRICycleDesc; EXCCRIGetDataDescription(6, EXCCRICycleCode))
                    {
                        ApplicationArea = All;
                        Caption = 'Cycle Description';
                        Editable = false;
                        ToolTip = 'Shows the educational cycle description.';
                    }
                }

                group(EXCCRIMdMGrade)
                {
                    Caption = 'Course';

                    field(EXCCRISchoolGrade; Rec."Nivel Escolar (Grado)")
                    {
                        ApplicationArea = All;
                        Caption = 'School Grade';
                        ToolTip = 'Specifies the school grade assigned to the item.';

                        trigger OnValidate()
                        begin
                            EXCCRIGestGrade();
                        end;
                    }

                    field(EXCCRISchoolGradeDesc; EXCCRIGetDataDescription(9, Rec."Nivel Escolar (Grado)"))
                    {
                        ApplicationArea = All;
                        Caption = 'School Grade Description';
                        Editable = false;
                        ToolTip = 'Shows the school grade description.';
                    }
                }

                group(EXCCRIMdMWorkload)
                {
                    Caption = 'Workload';

                    field(EXCCRIWorkload; EXCCRIGetDimensionValue(5))
                    {
                        ApplicationArea = All;
                        Caption = 'Workload';
                        AssistEdit = true;
                        ToolTip = 'Shows the workload dimension value assigned to the item.';

                        trigger OnAssistEdit()//: Boolean
                        begin
                            EXCCRIShowDimension(5);
                            //exit(true);
                        end;
                    }

                    field(EXCCRIWorkloadDesc; EXCCRIGetDimensionValueName(5))
                    {
                        ApplicationArea = All;
                        Caption = 'Workload Description';
                        Editable = false;
                        ToolTip = 'Shows the workload dimension description.';
                    }
                }

                group(EXCCRIMdMOrigin)
                {
                    Caption = 'Origin';

                    field(EXCCRIOrigin; EXCCRIGetDimensionValue(6))
                    {
                        ApplicationArea = All;
                        Caption = 'Origin';
                        AssistEdit = true;
                        ToolTip = 'Shows the origin dimension value assigned to the item.';

                        trigger OnAssistEdit()//: Boolean
                        begin
                            EXCCRIShowDimension(6);
                            //exit(true);
                        end;
                    }

                    field(EXCCRIOriginDesc; EXCCRIGetDimensionValueName(6))
                    {
                        ApplicationArea = All;
                        Caption = 'Origin Description';
                        Editable = false;
                        ToolTip = 'Shows the origin dimension description.';
                    }
                }

                group(EXCCRIMdMBusinessGroup)
                {
                    Caption = 'Business Group';

                    field(EXCCRIBusinessGroup; Rec."Grupo de Negocio")
                    {
                        ApplicationArea = All;
                        Caption = 'Business Group';
                        ToolTip = 'Specifies the business group assigned to the item.';
                    }

                    field(EXCCRIBusinessGroupDesc; EXCCRIMdMFunctions.GetDatosAuxDesc(23, Rec."Grupo de Negocio"))
                    {
                        ApplicationArea = All;
                        Caption = 'Business Group Description';
                        Editable = false;
                        ToolTip = 'Shows the business group description.';
                    }
                }
            }

            group(EXCCRIMdMValues)
            {
                Caption = 'MdM Values';
                Editable = EXCCRIMdMAuthorized;

                field(EXCCRIStorageDate; Rec."Fecha Almacen")
                {
                    ApplicationArea = All;
                    Caption = 'Storage Date';
                    ToolTip = 'Specifies the storage date controlled by MdM.';

                    trigger OnAssistEdit()//: Boolean
                    begin
                        EXCCRIMdMFunctions.GestContrlFechasProd(Rec, 1, 0);
                        //exit(true);
                    end;
                }

                field(EXCCRICommercializationDate; Rec."Fecha Comercializacion")
                {
                    ApplicationArea = All;
                    Caption = 'Commercialization Date';
                    ToolTip = 'Specifies the commercialization date controlled by MdM.';

                    trigger OnAssistEdit()//: Boolean
                    begin
                        EXCCRIMdMFunctions.GestContrlFechasProd(Rec, 2, 0);
                        //exit(true);
                    end;
                }
            }

            group(EXCCRISantillana)
            {
                Caption = 'Santillana';

                field(EXCCRIEducationLevelAPS; Rec."Nivel Educativo APS")
                {
                    ApplicationArea = All;
                    Caption = 'APS - Educational Level';
                    ToolTip = 'Specifies the APS educational level assigned to the item.';
                }

                field(EXCCRITitle; Rec.Titulo)
                {
                    ApplicationArea = All;
                    Caption = 'Title';
                    ToolTip = 'Specifies the title assigned to the item.';
                }

                field(EXCCRIPrototypeFixedAsset; Rec."Activo Fijo Prototipo")
                {
                    ApplicationArea = All;
                    Caption = 'Prototype Fixed Asset';
                    ToolTip = 'Specifies whether the item is a prototype fixed asset.';
                }

                field(EXCCRIBusinessGroup2; Rec."Grupo de Negocio")
                {
                    ApplicationArea = All;
                    Caption = 'Business Group';
                    ToolTip = 'Specifies the Santillana business group assigned to the item.';
                }

                field(EXCCRIMaintenancePenalty; Rec."% Castigo Mantenimiento")
                {
                    ApplicationArea = All;
                    Caption = 'Maintenance Penalty %';
                    ToolTip = 'Specifies the maintenance penalty percentage.';
                }

                field(EXCCRIConquestPenalty; Rec."% Castigo Conquista")
                {
                    ApplicationArea = All;
                    Caption = 'Conquest Penalty %';
                    ToolTip = 'Specifies the conquest penalty percentage.';
                }

                field(EXCCRILossPenalty; Rec."% Castigo Perdida")
                {
                    ApplicationArea = All;
                    Caption = 'Loss Penalty %';
                    ToolTip = 'Specifies the loss penalty percentage.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        EXCCRIMdMEditable := EXCCRIMdMFunctions.GetEditable();
    end;

    trigger OnAfterGetRecord()
    begin
        EXCCRIRefreshRequiredFields();
        EXCCRIRefreshRequiredDimensions();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        EXCCRIMdMEditable := EXCCRIMdMFunctions.GetEditableP(Rec, false);
        EXCCRIMdMAuthorized := EXCCRIMdMFunctions.GetEditableP(Rec, true);
        EXCCRIGestGrade();
    end;

    trigger OnDeleteRecord(): Boolean
    var
        EXCCRIEditable: Boolean;
    begin
        EXCCRIEditable := EXCCRIMdMFunctions.GetEditableP(Rec, false);
        if not EXCCRIEditable then
            EXCCRIMdMFunctions.SetEditableError(Rec.TableCaption());

        exit(EXCCRIEditable);
    end;

    local procedure EXCCRIRefreshRequiredFields()
    var
        EXCCRIRequiredFieldSetup: Record 34003021;
        EXCCRIRecordRef: RecordRef;
        EXCCRIFieldRef: FieldRef;
        EXCCRIIndex: Integer;
    begin
        Clear(EXCCRIRequiredFields);
        EXCCRIRecordRef.GetTable(Rec);

        EXCCRIRequiredFieldSetup.Reset();
        EXCCRIRequiredFieldSetup.SetRange("No. Tabla", Database::Item);
        if EXCCRIRequiredFieldSetup.FindSet() then
            repeat
                EXCCRIFieldRef := EXCCRIRecordRef.Field(EXCCRIRequiredFieldSetup."No. Campo");
                if Format(EXCCRIFieldRef.Value) = '' then
                    if EXCCRIIndex < ArrayLen(EXCCRIRequiredFields) then begin
                        EXCCRIIndex += 1;
                        EXCCRIRequiredFields[EXCCRIIndex] := EXCCRIRequiredFieldSetup."Nombre Campo";
                    end;
            until EXCCRIRequiredFieldSetup.Next() = 0;
    end;

    local procedure EXCCRIRefreshRequiredDimensions()
    var
        EXCCRIRequiredDimensionSetup: Record 34003023;
        EXCCRIDefaultDimension: Record "Default Dimension";
        EXCCRIIndex: Integer;
    begin
        Clear(EXCCRIRequiredDimensions);

        EXCCRIRequiredDimensionSetup.Reset();
        EXCCRIRequiredDimensionSetup.SetRange("No. Tabla", Database::Item);
        if EXCCRIRequiredDimensionSetup.FindSet() then
            repeat
                EXCCRIDefaultDimension.Reset();
                EXCCRIDefaultDimension.SetRange("Table ID", Database::Item);
                EXCCRIDefaultDimension.SetRange("No.", Rec."No.");
                EXCCRIDefaultDimension.SetRange(
                    "Dimension Code",
                    EXCCRIRequiredDimensionSetup."Cod. Dimension");

                if EXCCRIDefaultDimension.IsEmpty() then
                    if EXCCRIIndex < ArrayLen(EXCCRIRequiredDimensions) then begin
                        EXCCRIIndex += 1;
                        EXCCRIRequiredDimensions[EXCCRIIndex] :=
                            EXCCRIRequiredDimensionSetup."Cod. Dimension";
                    end;
            until EXCCRIRequiredDimensionSetup.Next() = 0;
    end;

    local procedure EXCCRIGestGrade()
    var
        EXCCRIMdMData: Record 75001;
    begin
        Clear(EXCCRICycleCode);
        Clear(EXCCRILevelCode);

        if EXCCRIMdMData.Get(9, Rec."Nivel Escolar (Grado)") then begin
            EXCCRICycleCode := EXCCRIMdMData."Codigo Relacionado";
            if EXCCRIMdMData.Get(6, EXCCRICycleCode) then
                EXCCRILevelCode := EXCCRIMdMData."Codigo Relacionado";
        end;
    end;

    local procedure EXCCRIGetDataDescription(EXCCRIType: Integer; EXCCRICode: Code[20]): Text
    begin
        exit(EXCCRIMdMFunctions.GetDatDescrp(EXCCRIType, EXCCRICode));
    end;

    local procedure EXCCRIGetDimensionValue(EXCCRIDimensionType: Integer): Code[20]
    begin
        exit(EXCCRIMdMFunctions.GetDimValueT(Rec."No.", EXCCRIDimensionType));
    end;

    local procedure EXCCRIGetDimensionValueName(EXCCRIDimensionType: Integer): Text
    begin
        exit(EXCCRIMdMFunctions.GetDimValueName(Rec."No.", EXCCRIDimensionType));
    end;

    local procedure EXCCRIShowDimension(EXCCRIDimensionType: Integer)
    begin
        EXCCRIMdMFunctions.ShowDimT(Rec, EXCCRIDimensionType);
    end;

    var
        EXCCRIMdMFunctions: Codeunit 75000;
        EXCCRIRequiredFields: array[50] of Text[100];
        EXCCRIRequiredDimensions: array[12] of Text[60];
        EXCCRIMdMEditable: Boolean;
        EXCCRIMdMAuthorized: Boolean;
        EXCCRICycleCode: Code[10];
        EXCCRILevelCode: Code[10];
}
