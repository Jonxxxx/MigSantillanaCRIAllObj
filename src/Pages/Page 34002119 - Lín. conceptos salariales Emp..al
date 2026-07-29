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
                field("Empresa cotizacion"; Rec."Empresa cotizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Empresa cotizacion';
                    Visible = false;
                }
                field("No. empleado"; Rec."No. empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. empleado';
                    Visible = false;
                }
                field("Perfil salarial"; Rec."Perfil salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Perfil salarial';
                    Visible = false;
                }
                field("Concepto salarial"; Rec."Concepto salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Concepto salarial';
                }
                field("Salario Base"; Rec."Salario Base")
                {
                    ApplicationArea = All;
                    ToolTip = 'Salario Base';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Currency Code';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                    Editable = ImporteEditable;
                }
                field("1ra Quincena"; Rec."1ra Quincena")
                {
                    ApplicationArea = All;
                    ToolTip = '1ra Quincena';
                }
                field("2da Quincena"; Rec."2da Quincena")
                {
                    ApplicationArea = All;
                    ToolTip = '2da Quincena';
                }
                field("Tipo concepto"; Rec."Tipo concepto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo concepto';
                }
                field("Sujeto Cotizacion"; Rec."Sujeto Cotizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sujeto Cotizacion';
                    Visible = false;
                }
                field("% ISR Pago Empleado"; Rec."% ISR Pago Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = '% ISR Pago Empleado';
                    Visible = false;
                }
                field("Cotiza ISR"; Rec."Cotiza ISR")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza ISR';
                    Visible = false;
                }
                field("Cotiza AFP"; Rec."Cotiza AFP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza AFP';
                }
                field("Cotiza SFS"; Rec."Cotiza SFS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza SFS';
                }
                field("Cotiza SRL"; Rec."Cotiza SRL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza SRL';
                    Visible = false;
                }
                field("Cotiza INFOTEP"; Rec."Cotiza INFOTEP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza INFOTEP';
                    Visible = false;
                }
                field("Aplica para Regalia"; Rec."Aplica para Regalia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Aplica para Regalia';
                    Visible = false;
                }
                field("Texto Informativo"; Rec."Texto Informativo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Texto Informativo';
                    Visible = false;
                }
                field(Prorratear; Rec.Prorratear)
                {
                    ApplicationArea = All;
                    ToolTip = 'Prorratear';
                    Visible = false;
                }
                field("Formula Calculo"; Rec."Formula Calculo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Formula Calculo';
                    Editable = true;
                }
                field(Imprimir; Rec.Imprimir)
                {
                    ApplicationArea = All;
                    ToolTip = 'Imprimir';
                    Visible = false;
                }
                field("Deducir dias"; Rec."Deducir dias")
                {
                    ApplicationArea = All;
                    ToolTip = 'Deducir dias';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                    Visible = false;
                }
                field("Tipo de nomina"; Rec."Tipo de nomina")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de nomina';
                }
                field("% Retencion Ingreso Salario"; Rec."% Retencion Ingreso Salario")
                {
                    ApplicationArea = All;
                    ToolTip = '% Retencion Ingreso Salario';
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
        IF "Formula Calculo" <> '' THEN
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

