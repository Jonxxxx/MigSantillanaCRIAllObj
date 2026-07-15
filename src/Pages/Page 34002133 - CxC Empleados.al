page 34002133 "CxC Empleados"
{
    PageType = Card;
    SourceTable = 34002145;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No. Préstamo"; "No. Préstamo")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AsistEdic(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Codigo Empleado"; "Codigo Empleado")
                {
                }
                field("Tipo CxC"; "Tipo CxC")
                {
                }
                field("Motivo Prestamos"; "Motivo Prestamos")
                {
                }
                field("Fecha Registro CxC"; "Fecha Registro CxC")
                {
                }
                field(Importe; Importe)
                {
                }
                field(Documento; "No. Documento")
                {
                }
                field(Cuotas; Cuotas)
                {
                }
                field("Importe Cuota"; "Importe Cuota")
                {
                }
                field("Nro. Solicitud CK"; "Nro. Solicitud CK")
                {
                }
                field("Cta. Contrapartida"; "Cta. Contrapartida")
                {
                }
                field("Fecha Inicio Deduccion"; "Fecha Inicio Deduccion")
                {
                }
                field("Concepto Salarial"; "Concepto Salarial")
                {
                }
                field("1ra Quincena"; "1ra Quincena")
                {
                }
                field("2da Quincena"; "2da Quincena")
                {
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
                    Caption = '&Movimientos CxC Empleados';
                    //TODO: Ver RunObject = Page 58100;
                    //TODO: Ver RunPageLink = Field1 = FIELD("No. Préstamo");
                    Visible = false;
                }
            }
            group("&Registro")
            {
                Caption = '&Registro';
                action(Post)
                {
                    Caption = 'Post';
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
                            IF "No. Préstamo" = '' THEN
                                ERROR(STRSUBSTNO(Err001, "No. Préstamo"))
                            ELSE BEGIN
                                TESTFIELD("Fecha Registro CxC");
                                TESTFIELD("Fecha Inicio Deduccion");
                                TESTFIELD("Concepto Salarial");
                                HistCabPrestamo.RESET;
                                HistCabPrestamo.VALIDATE("No. Préstamo");
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
                                HistLinPrestamo."No. Préstamo" := HistCabPrestamo."No. Préstamo";
                                HistLinPrestamo."No. Linea" += 100;
                                HistLinPrestamo."Tipo CxC" := "Tipo CxC";
                                HistLinPrestamo."No. Cuota" := 0;
                                HistLinPrestamo."Fecha Transaccion" := "Fecha Registro CxC";
                                HistLinPrestamo."Codigo Empleado" := "Codigo Empleado";
                                HistLinPrestamo.Débito := Importe;
                                HistLinPrestamo.VALIDATE(Débito);
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
                Caption = 'Calculate fees';
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
        rCxCEmpl: Record 34002145;
        dCuotas: Decimal;
        HistCabPrestamo: Record 34002146;
        HistLinPrestamo: Record 34002147;
        Answer: Boolean;
        Text001: Label 'Do you watn to post the loan?';
        Err001: Label 'Th field %1 can not be empty';
}

