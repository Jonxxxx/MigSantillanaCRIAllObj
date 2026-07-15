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
                field("Empresa cotizacion"; "Empresa cotizacion")
                {
                }
                field("Nombre Empresa cotizacion"; "Nombre Empresa cotizacion")
                {
                }
                field(Direccion; Direccion)
                {
                    Caption = 'Direccion';
                }
                field(Número; Número)
                {
                    Caption = 'Apartamento';
                }
                field(Municipio; Municipio)
                {
                }
                field(Provincia; Provincia)
                {
                }
                field("Cod. pais"; "Cod. pais")
                {
                }
                field("Codigo Postal"; "Codigo Postal")
                {
                    Caption = 'C.P + Poblacion';
                }
                field("Domicilio fiscal"; "Domicilio fiscal")
                {
                }
                field("Tipo de documento"; "Tipo de documento")
                {
                }
                field("RNC/CED"; "RNC/CED")
                {
                }
                field(Imagen; Imagen)
                {
                }
                field(Teléfono; Teléfono)
                {
                }
                field(Fax; Fax)
                {
                }
                field("E-Mail"; "E-Mail")
                {
                }
                field("Esquema percepcion"; "Esquema percepcion")
                {
                }
                field("Tasa de Riesgo (%)"; "Tasa de Riesgo (%)")
                {
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                }
                field("Tipo Empresa de Trabajo"; "Tipo Empresa de Trabajo")
                {
                }
            }
            group(Taxes)
            {
                Caption = 'Taxes';
                field("ID RNL"; "ID RNL")
                {
                }
                field("ID TSS"; "ID TSS")
                {
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                field("ID  Volante Pago"; "ID  Volante Pago")
                {
                }
                field("Forma de Pago"; "Forma de Pago")
                {
                }
                field(Banco; Banco)
                {
                }
                field(Cuenta; Cuenta)
                {
                }
                field("Tipo Pago Nomina"; "Tipo Pago Nomina")
                {
                }
                field("Identificador Empresa"; "Identificador Empresa")
                {
                }
                field("Path archivo Nomina"; "Path archivo Nomina")
                {
                }
                field("Email Envia Boleta de Pago"; "Email Envia Boleta de Pago")
                {

                    trigger OnValidate()
                    begin
                        //001
                    end;
                }
                field("Password Email Boleta Pago"; "Password Email Boleta Pago")
                {
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
                    Caption = 'Employee list';
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
                    Caption = 'Copy from Company Setup';
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
                    Caption = 'Comments';
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
                    Caption = 'Work Centers';
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
                    Caption = 'Legal representatives';
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

