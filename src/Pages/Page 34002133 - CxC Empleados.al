page 55774 "CxC Empleados"
{
    PageType = Card;
    SourceTable = 55786;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No. Prestamo"; Rec."No. Prestamo")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Prestamo';

                    trigger OnAssistEdit()
                    begin
                        IF AsistEdic(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Codigo Empleado"; Rec."Codigo Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Empleado';
                }
                field("Tipo CxC"; Rec."Tipo CxC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo CxC';
                }
                field("Motivo Prestamos"; Rec."Motivo Prestamos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Motivo Prestamos';
                }
                field("Fecha Registro CxC"; Rec."Fecha Registro CxC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Registro CxC';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                }
                field(Documento; Rec."No. Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Documento';
                }
                field(Cuotas; Rec.Cuotas)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cuotas';
                }
                field("Importe Cuota"; Rec."Importe Cuota")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Cuota';
                }
                field("Nro. Solicitud CK"; Rec."Nro. Solicitud CK")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nro. Solicitud CK';
                }
                field("Cta. Contrapartida"; Rec."Cta. Contrapartida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cta. Contrapartida';
                }
                field("Fecha Inicio Deduccion"; Rec."Fecha Inicio Deduccion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicio Deduccion';
                }
                field("Concepto Salarial"; Rec."Concepto Salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Concepto Salarial';
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
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Empleado")
            {
                Caption = '&Empleado';
                action("&Movimientos CxC Empleados")
                {
                    ApplicationArea = All;
                    Caption = '&Movimientos CxC Empleados';
                    ToolTip = '&Movimientos CxC Empleados';
                    // TODO: Manual review - Page 58100 and its destination field Field1 cannot be verified.
                    // Original code preserved below.
                    // RunObject = Page 58100;
                    // RunPageLink = Field1 = FIELD("No. Prestamo");
                    Visible = false;
                }
            }
            group("&Registro")
            {
                Caption = '&Registro';
                action(Post)
                {
                    ApplicationArea = All;
                    Caption = 'Post';
                    ToolTip = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        Answer := CONFIRM(Text001, FALSE);
                        IF Answer = TRUE THEN
                            IF "No. Prestamo" = '' THEN
                                ERROR(STRSUBSTNO(Err001, "No. Prestamo"))
                            ELSE BEGIN
                                TESTFIELD("Fecha Registro CxC");
                                TESTFIELD("Fecha Inicio Deduccion");
                                TESTFIELD("Concepto Salarial");
                                HistCabPrestamo.RESET;
                                HistCabPrestamo.VALIDATE("No. Prestamo");
                                HistCabPrestamo."Employee No." := "Codigo Empleado";
                                HistCabPrestamo."Fecha Registro CxC" := "Fecha Registro CxC";
                                HistCabPrestamo."Fecha Inicio Deduccion" := "Fecha Inicio Deduccion";
                                HistCabPrestamo."Tipo CxC" := "Tipo CxC";
                                HistCabPrestamo.Cuotas := Cuotas;
                                HistCabPrestamo."Tipo Contrapartida" := "Tipo Contrapartida";
                                HistCabPrestamo."Cta. Contrapartida" := "Cta. Contrapartida";
                                HistCabPrestamo."Nro. Solicitud CK" := "Nro. Solicitud CK";
                                HistCabPrestamo."No. Documento" := "No. Documento";
                                HistCabPrestamo.Pendiente := TRUE;
                                HistCabPrestamo."% Cuota" := "% a deducir de Ingresos";
                                HistCabPrestamo."No. Mov. Cliente" := "No. Mov. Cliente";
                                HistCabPrestamo."1ra Quincena" := "1ra Quincena";
                                HistCabPrestamo."2da Quincena" := "2da Quincena";
                                HistCabPrestamo."Importe Cuota" := "Importe Cuota";
                                HistCabPrestamo."Concepto Salarial" := "Concepto Salarial";
                                HistCabPrestamo.INSERT;

                                HistLinPrestamo.RESET;
                                HistLinPrestamo."No. Prestamo" := HistCabPrestamo."No. Prestamo";
                                HistLinPrestamo."No. Linea" += 100;
                                HistLinPrestamo."Tipo CxC" := "Tipo CxC";
                                HistLinPrestamo."No. Cuota" := 0;
                                HistLinPrestamo."Fecha Transaccion" := "Fecha Registro CxC";
                                HistLinPrestamo."Codigo Empleado" := "Codigo Empleado";
                                HistLinPrestamo.Debito := Importe;
                                HistLinPrestamo.VALIDATE(Debito);
                                HistLinPrestamo.INSERT;
                                CLEAR(HistCabPrestamo);
                                CLEAR(HistLinPrestamo);
                                DELETE;
                            END;
                    end;
                }
            }
        }
        area(processing)
        {
            action("Calculate fees")
            {
                ApplicationArea = All;
                Caption = 'Calculate fees';
                ToolTip = 'Calculate fees';
                Image = CalculateDiscount;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    "Importe Cuota" := Importe / Cuotas;
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    var
        rCxCEmpl: Record 55786;
        dCuotas: Decimal;
        HistCabPrestamo: Record 55787;
        HistLinPrestamo: Record 55788;
        Answer: Boolean;
        Text001: Label 'Do you watn to post the loan?';
        Err001: Label 'Th field %1 can not be empty';
}

