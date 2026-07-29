page 34002100 "Empresas de cotizacion"
{
    // Proyecto: Dynamics 365 Business Central
    // -----------------------------
    // JPG     : John Peralta
    // AMS     : Agustin Mendez
    // FES     : Fausto Serrata
    // ------------------------------------------------------------------
    // No.       Fecha         Firma         Desscripcion
    // ------------------------------------------------------------------
    // 001       07-03-2022    FES           SANTINAV-4392: Configuracion de cuentas de correo para el envio de errores de colas de proyecto y boletas de pago
    //                                       Adicionar campos "Email Envia Errores Colas" y "Password Email Errores Cola"

    PageType = Card;
    SourceTable = 34002100;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Empresa cotizacion"; Rec."Empresa cotizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Empresa cotizacion';
                }
                field("Nombre Empresa cotizacion"; Rec."Nombre Empresa cotizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Empresa cotizacion';
                }
                field(Direccion; Rec.Direccion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Direccion';
                    Caption = 'Direccion';
                }
                field(Numero; Rec.Numero)
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero';
                    Caption = 'Apartamento';
                }
                field(Municipio; Rec.Municipio)
                {
                    ApplicationArea = All;
                    ToolTip = 'Municipio';
                }
                field(Provincia; Rec.Provincia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Provincia';
                }
                field("Cod. pais"; Rec."Cod. pais")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. pais';
                }
                field("Codigo Postal"; Rec."Codigo Postal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Postal';
                    Caption = 'C.P + Poblacion';
                }
                field("Domicilio fiscal"; Rec."Domicilio fiscal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Domicilio fiscal';
                }
                field("Tipo de documento"; Rec."Tipo de documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de documento';
                }
                field("RNC/CED"; Rec."RNC/CED")
                {
                    ApplicationArea = All;
                    ToolTip = 'RNC/CED';
                }
                field(Imagen; Rec.Imagen)
                {
                    ApplicationArea = All;
                    ToolTip = 'Imagen';
                }
                field(Teléfono; Rec.Teléfono)
                {
                    ApplicationArea = All;
                    ToolTip = 'Teléfono';
                }
                field(Fax; Rec.Fax)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fax';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail';
                }
                field("Esquema percepcion"; Rec."Esquema percepcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Esquema percepcion';
                }
                field("Tasa de Riesgo (%)"; Rec."Tasa de Riesgo (%)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tasa de Riesgo (%)';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Global Dimension 1 Code';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Global Dimension 2 Code';
                }
                field("Tipo Empresa de Trabajo"; Rec."Tipo Empresa de Trabajo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Empresa de Trabajo';
                }
            }
            group(Taxes)
            {
                Caption = 'Taxes';
                field("ID RNL"; Rec."ID RNL")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID RNL';
                }
                field("ID TSS"; Rec."ID TSS")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID TSS';
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                field("ID  Volante Pago"; Rec."ID  Volante Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID  Volante Pago';
                }
                field("Forma de Pago"; Rec."Forma de Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Forma de Pago';
                }
                field(Banco; Rec.Banco)
                {
                    ApplicationArea = All;
                    ToolTip = 'Banco';
                }
                field(Cuenta; Rec.Cuenta)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cuenta';
                }
                field("Tipo Pago Nomina"; Rec."Tipo Pago Nomina")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Pago Nomina';
                }
                field("Identificador Empresa"; Rec."Identificador Empresa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Identificador Empresa';
                }
                field("Path archivo Nomina"; Rec."Path archivo Nomina")
                {
                    ApplicationArea = All;
                    ToolTip = 'Path archivo Nomina';
                }
                field("Email Envia Boleta de Pago"; Rec."Email Envia Boleta de Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Email Envia Boleta de Pago';

                    trigger OnValidate()
                    begin
                        //001
                    end;
                }
                field("Password Email Boleta Pago"; Rec."Password Email Boleta Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Password Email Boleta Pago';
                    ExtendedDatatype = Masked;

                    trigger OnValidate()
                    begin
                        //001
                    end;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Empresa Cotizacion")
            {
                Caption = '&Empresa Cotizacion';
                Visible = true;
                action("Employee list")
                {
                    ApplicationArea = All;
                    Caption = 'Employee list';
                    ToolTip = 'Employee list';
                    Image = List;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page 5201;
                    RunPageLink = Company = FIELD("Empresa cotizacion");
                }
                action("Copy from Company Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Copy from Company Setup';
                    ToolTip = 'Copy from Company Setup';
                    Image = Copy;

                    trigger OnAction()
                    var
                        CompanySetup: Record 79;
                    begin
                        IF NOT CONFIRM(Text001, TRUE) THEN
                            EXIT;

                        CompanySetup.GET();
                        "Nombre Empresa cotizacion" := CompanySetup.Name;
                        Direccion := CompanySetup.Address;
                        Teléfono := CompanySetup."Phone No.";
                        Imagen := CompanySetup.Picture;
                        Fax := CompanySetup."Fax No.";
                        "RNC/CED" := CompanySetup."VAT Registration No.";
                        "Codigo Postal" := CompanySetup."Post Code";
                        Municipio := CompanySetup."Address 2";
                        Provincia := CompanySetup.City;
                        CompanySetup.CALCFIELDS(Picture);
                        Imagen := CompanySetup.Picture;
                        IF NOT INSERT THEN
                            MODIFY;
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    ToolTip = 'Comments';
                    Image = ViewComments;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //TODO Ver 
                    /*
                    RunObject = Page 34002156;
                    RunPageLink = Tipo = CONST("Empresa cotizacion"),
                                  Codigo = FIELD("Empresa cotizacion");*/
                }
            }
            group("&Otros datos")
            {
                Caption = '&Otros datos';
                action("Work Centers")
                {
                    ApplicationArea = All;
                    Caption = 'Work Centers';
                    ToolTip = 'Work Centers';
                    Image = WorkCenter;
                    Promoted = true;
                    PromotedCategory = Process;
                    //TODO Ver 
                    /*
                    RunObject = Page 34002108;
                    RunPageLink = "Empresa cotizacion" = FIELD("Empresa cotizacion");*/
                }
                action("Legal representatives")
                {
                    ApplicationArea = All;
                    Caption = 'Legal representatives';
                    ToolTip = 'Legal representatives';
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page 34002102;
                    RunPageLink = "Empresa cotizacion" = FIELD("Empresa cotizacion");
                }
            }
        }
    }

    var
        Text001: Label 'Do you confirm you want to copy the information from the Company setup?';
}

