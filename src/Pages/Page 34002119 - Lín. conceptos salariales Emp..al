page 34002119 "Lin. conceptos salariales Emp."
{
    Caption = 'Employee profile';
    PageType = ListPart;
    SourceTable = 34002115;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Empresa cotizacion"; "Empresa cotizacion")
                {
                    Visible = false;
                }
                field("No. empleado"; "No. empleado")
                {
                    Visible = false;
                }
                field("Perfil salarial"; "Perfil salarial")
                {
                    Visible = false;
                }
                field("Concepto salarial"; "Concepto salarial")
                {
                }
                field("Salario Base"; "Salario Base")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field(Cantidad; Cantidad)
                {
                }
                field(Importe; Importe)
                {
                    Editable = ImporteEditable;
                }
                field("1ra Quincena"; "1ra Quincena")
                {
                }
                field("2da Quincena"; "2da Quincena")
                {
                }
                field("Tipo concepto"; "Tipo concepto")
                {
                }
                field("Sujeto Cotizacion"; "Sujeto Cotizacion")
                {
                    Visible = false;
                }
                field("% ISR Pago Empleado"; "% ISR Pago Empleado")
                {
                    Visible = false;
                }
                field("Cotiza ISR"; "Cotiza ISR")
                {
                    Visible = false;
                }
                field("Cotiza AFP"; "Cotiza AFP")
                {
                }
                field("Cotiza SFS"; "Cotiza SFS")
                {
                }
                field("Cotiza SRL"; "Cotiza SRL")
                {
                    Visible = false;
                }
                field("Cotiza INFOTEP"; "Cotiza INFOTEP")
                {
                    Visible = false;
                }
                field("Aplica para Regalia"; "Aplica para Regalia")
                {
                    Visible = false;
                }
                field("Texto Informativo"; "Texto Informativo")
                {
                    Visible = false;
                }
                field(Prorratear; Prorratear)
                {
                    Visible = false;
                }
                field("Formula cálculo"; "Formula cálculo")
                {
                    Editable = true;
                }
                field(Imprimir; Imprimir)
                {
                    Visible = false;
                }
                field("Deducir dias"; "Deducir dias")
                {
                    Visible = false;
                }
                field(Status; Status)
                {
                    Visible = false;
                }
                field("Tipo de nomina"; "Tipo de nomina")
                {
                }
                field("% Retencion Ingreso Salario"; "% Retencion Ingreso Salario")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Payroll")
            {
                Caption = '&Payroll';
                action("Dist. by Dimension")
                {
                    Caption = 'Dist. by Dimension';
                    Image = CalculateHierarchy;
                    RunObject = Page 34002215;
                    RunPageLink = "Employee no." = FIELD("No. empleado"),
                                  "Concepto salarial" = FIELD("Concepto salarial");
                }

                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        Dimension;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ImporteEditable := TRUE;
        IF "Formula cálculo" <> '' THEN
            ImporteEditable := FALSE
        ELSE
            IF "Concepto salarial" = ConfNom."Concepto Sal. Base" THEN
                ImporteEditable := NOT ConfNom."Usar Acciones de personal";
    end;

    trigger OnInit()
    begin
        ImporteEditable := TRUE;
    end;

    trigger OnOpenPage()
    begin
        ConfNom.GET();
    end;

    var
        ConfNom: Record 34002103;
        [InDataSet]
        ImporteEditable: Boolean;

    procedure Dimension()
    var
        Dimension: Record 352;
        DefDimension: Page 540;
    begin
        Dimension.RESET;
        Dimension.SETRANGE("Table ID", 34002115);
        Dimension.SETRANGE("No.", "No. empleado" + "Concepto salarial");
        DefDimension.SETTABLEVIEW(Dimension);
        DefDimension.RUNMODAL;
    end;
}

