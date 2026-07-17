pageextension 50092 EXCCRIContactCard extends "Contact Card"
{
    layout
    {
        addlast(General)
        {
            group(EXCCRISantillana)
            {
                Caption = 'Santillana';

                field(EXCCRISamplesLocationCode; Rec."Samples Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Samples Location Code value for the contact.';
                }
                field(EXCCRIDescuentoCupon; Rec."% Descuento Cupon")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the percentage Descuento Cupon value for the contact.';
                }
                field(EXCCRICanalDeCompra; Rec."Canal de compra")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Canal de compra value for the contact.';
                }
                field(EXCCRINombreCanal; Rec."Nombre canal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Nombre canal value for the contact.';
                }
                field(EXCCRIMicroempresario; Rec.Microempresario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Microempresario value for the contact.';
                }
                field(EXCCRIComisionista; Rec.Comisionista)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Comisionista value for the contact.';
                }
                field(EXCCRIOrdenReligiosa; Rec."Orden religiosa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Orden religiosa value for the contact.';
                }
                field(EXCCRIAsociacionEducativa; Rec."Asociacion Educativa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Asociacion Educativa value for the contact.';
                }
                field(EXCCRICodigoModular; Rec."Codigo Modular")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Codigo Modular value for the contact.';
                }
                field(EXCCRIPensionINI; Rec."Pension INI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Pension INI value for the contact.';
                }
                field(EXCCRIPensionPRI; Rec."Pension PRI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Pension PRI value for the contact.';
                }
                field(EXCCRIPensionSEC; Rec."Pension SEC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Pension SEC value for the contact.';
                }
                field(EXCCRIPensionBA; Rec."Pension BA")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Pension BA value for the contact.';
                }
                field(EXCCRITipoDeColegio; Rec."Tipo de colegio")
                {
                    ApplicationArea = All;
                    Caption = 'School Type';
                    ToolTip = 'Specifies the Tipo de colegio value for the contact.';
                }
                field(EXCCRITipoEducacion; Rec."Tipo educacion")
                {
                    ApplicationArea = All;
                    Caption = 'Education Type';
                    ToolTip = 'Specifies the Tipo educacion value for the contact.';
                }
                field(EXCCRIFechaDecision; Rec."Fecha decision")
                {
                    ApplicationArea = All;
                    Caption = 'Decision Date';
                    ToolTip = 'Specifies the Fecha decision value for the contact.';
                }
                field(EXCCRIPeriodo; Rec.Periodo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Periodo value for the contact.';
                }
                field(EXCCRIBilingue; Rec.Bilingue)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Bilingue value for the contact.';
                }
                field(EXCCRIRuta; Rec.Ruta)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Ruta value for the contact.';
                }
                field(EXCCRIGrupo; Rec.Grupo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Grupo value for the contact.';
                }
                field(EXCCRIFechaAniversario; Rec."Fecha Aniversario")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Fecha Aniversario value for the contact.';
                }
                field(EXCCRIImportePensionINI; Rec."Importe Pension INI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Importe Pension INI value for the contact.';
                }
                field(EXCCRIImportePensionPRI; Rec."Importe Pension PRI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Importe Pension PRI value for the contact.';
                }
                field(EXCCRIImportePensionSEC; Rec."Importe Pension SEC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Importe Pension SEC value for the contact.';
                }
                field(EXCCRIImportePensionBA; Rec."Importe Pension BA")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Importe Pension BA value for the contact.';
                }
            }
            group(EXCCRIRequiredFieldsGroup)
            {
                Caption = 'Required Fields Not Completed';
                Editable = false;

                field(EXCCRIGatCampReq; EXCCRIRequiredFields[1])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required field that has not been completed.';
                }
                field(EXCCRIGatCampReq2; EXCCRIRequiredFields[2])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required field that has not been completed.';
                }
                field(EXCCRIGatCampReq3; EXCCRIRequiredFields[3])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required field that has not been completed.';
                }
                field(EXCCRIGatCampReq4; EXCCRIRequiredFields[4])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required field that has not been completed.';
                }
                field(EXCCRIGatCampReq5; EXCCRIRequiredFields[5])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required field that has not been completed.';
                }
                field(EXCCRIGatCampReq6; EXCCRIRequiredFields[6])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required field that has not been completed.';
                }
                field(EXCCRIGatCampReq7; EXCCRIRequiredFields[7])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required field that has not been completed.';
                }
                field(EXCCRIGatCampReq8; EXCCRIRequiredFields[8])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required field that has not been completed.';
                }
                field(EXCCRIGatCampReq9; EXCCRIRequiredFields[9])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required field that has not been completed.';
                }
                field(EXCCRIGatCampReq10; EXCCRIRequiredFields[10])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required field that has not been completed.';
                }
                field(EXCCRIGatCampReq11; EXCCRIRequiredFields[11])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required field that has not been completed.';
                }
                field(EXCCRIGatCampReq12; EXCCRIRequiredFields[12])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required field that has not been completed.';
                }
            }
        }
    }

    actions
    {
        addlast(Navigation)
        {
            group(EXCCRISchool)
            {
                Caption = 'School';
                Image = Departments;

                action(EXCCRIPrices)
                {
                    ApplicationArea = All;
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = Page 7002;
                    RunPageLink =
                        "Sales Type" = const("Customer Price Group"),
                        "Sales Code" = field("No.");
                    RunPageView = sorting("Sales Type", "Sales Code");
                    ToolTip = 'Opens the sales prices associated with the contact.';
                }
                action(EXCCRISalespersons)
                {
                    ApplicationArea = All;
                    Caption = 'Salespersons';
                    Image = SalesPerson;
                    RunObject = Page 51010;
                    RunPageLink = "Cod. Colegio" = field("No.");
                    ToolTip = 'Opens the salespersons associated with the school.';
                }
                action(EXCCRITeachers)
                {
                    ApplicationArea = All;
                    Caption = 'Teachers';
                    Image = EditCustomer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67045;
                    RunPageLink = "Cod. Colegio" = field("No.");
                    ToolTip = 'Opens the teachers associated with the school.';
                }
                action(EXCCRIGrades)
                {
                    ApplicationArea = All;
                    Caption = 'Grades';
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67037;
                    RunPageLink = "Cod. Colegio" = field("No.");
                    ToolTip = 'Opens the grades associated with the school.';
                }
                action(EXCCRILevels)
                {
                    ApplicationArea = All;
                    Caption = 'Levels';
                    Image = Allocations;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Opens the education levels associated with the school.';

                    trigger OnAction()
                    begin
                        Rec.TestField(City);
                        Rec.TestField(County);
                        Rec.TestField("Post Code");
                        EXCCRILevelPage.RecibeParametros(
                            Rec."No.",
                            Rec.City,
                            Rec.County,
                            Rec."Post Code");
                        EXCCRILevelPage.RunModal();
                        Clear(EXCCRILevelPage);
                    end;
                }
                action(EXCCRIRankByLevel)
                {
                    ApplicationArea = All;
                    Caption = 'Rank by Level';
                    Image = CustomerRating;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Calculates and opens the school ranking by level.';

                    trigger OnAction()
                    begin
                        Rec.TestField("No.");
                        EXCCRIRankingPage.CalcularRanking(Rec."No.");
                        EXCCRIRankingPage.Run();
                        Clear(EXCCRIRankingPage);
                    end;
                }
                action(EXCCRIAdoptions)
                {
                    ApplicationArea = All;
                    Caption = 'Adoptions';
                    Image = BankAccountRec;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67026;
                    RunPageLink = "Cod. Colegio" = field("No.");
                    ToolTip = 'Opens the adoptions associated with the school.';
                }
                action(EXCCRIGifts)
                {
                    ApplicationArea = All;
                    Caption = 'Gifts';
                    Image = CreateWarehousePick;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67165;
                    RunPageLink = "Cod. Colegio" = field("No.");
                    ToolTip = 'Opens the gifts associated with the school.';
                }
                action(EXCCRITechnicalAssistance)
                {
                    ApplicationArea = All;
                    Caption = 'Technical Assistance Request';
                    Image = ProfileCalendar;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67090;
                    RunPageLink = "Cod. Colegio" = field("No.");
                    ToolTip = 'Opens the technical assistance requests associated with the school.';
                }
                action(EXCCRIJobStructure)
                {
                    ApplicationArea = All;
                    Caption = 'Job Structure';
                    Image = Hierarchy;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67067;
                    RunPageLink = "Cod. Colegio" = field("No.");
                    ToolTip = 'Opens the job structure associated with the school.';
                }
            }
        }
    }

    var
        EXCCRILevelPage: Page 67036;
        EXCCRIRankingPage: Page 67145;
        EXCCRIRequiredFields: array[12] of Text[100];
}
