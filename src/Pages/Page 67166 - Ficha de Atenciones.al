page 67166 "Ficha de Atenciones"
{
    PageType = Card;
    SourceTable = 67061;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = wMod;
                field(Codigo; Codigo)
                {
                }
                field("No. Solicitud"; "No. Solicitud")
                {
                }
                field("Grupo de Negocio"; "Grupo de Negocio")
                {
                }
                field("Tipo Evento"; "Tipo Evento")
                {
                }
                field("Fecha registro"; "Fecha registro")
                {
                }
                field("Id. Usuario"; "Id. Usuario")
                {
                }
                field(Estado; Estado)
                {
                }
                field("Tipo documento"; "Tipo documento")
                {
                }
                field(Documento; Documento)
                {
                }
                field("Fecha Recepción Documento"; "Fecha Recepción Documento")
                {
                }
                field(Delegacion; Delegacion)
                {
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                }
                field("Cod. Local"; "Cod. Local")
                {
                }
                field(Distritos; Distritos)
                {
                }
                field(Address; Address)
                {
                }
                field(City; City)
                {
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field(Turno; Turno)
                {
                }
                field(Objetivo; Objetivo)
                {
                }
                field("Descripcion Objetivo"; "Descripcion Objetivo")
                {
                }
            }
            group("Entrega Atenciones")
            {
                Editable = wMod;
                field("Area Responsable"; "Area Responsable")
                {
                }
                field("Cod. Responsable"; "Cod. Responsable")
                {
                }
                field("Nombre responsable"; "Nombre responsable")
                {
                }
                field("Fecha de entrega"; "Fecha de entrega")
                {
                }
                field("Comentarios Entrega"; "Comentarios Entrega")
                {
                }
                field("Comentarios Cancelación"; "Comentarios Cancelación")
                {
                }
            }
            part(; 67168)
            {
                Editable = wMod;
                SubPageLink = Código Cab. Atención=FIELD("Codigo");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Rechazar)
            {
                Caption = 'Rechazar';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = wCambEstado;

                trigger OnAction()
                begin
                    TESTFIELD("Fecha de entrega");
                    TESTFIELD("Comentarios Cancelación");
                    Estado := Estado::Cancelada;

                    ActControles;
                end;
            }
            action(Realizar)
            {
                Caption = 'Realizar';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = wCambEstado;

                trigger OnAction()
                begin

                    TESTFIELD("Fecha de entrega");
                    TESTFIELD("Comentarios Entrega");

                    ValidaDistrCC;

                    Estado := Estado::Realizada;

                    ActControles;
                end;
            }
            action("<Action1000000029>")
            {
                Caption = 'Cargar Ped. Venta';
                Image = CopyDocument;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    fPed: Page 9349;
                    rPed: Record 5107;
                    rLin: Record 5108;
                    rDetAt: Record 67100;
                begin
                    rPed.FILTERGROUP(2);
                    rPed.SETRANGE("Document Type", rPed."Document Type"::Order);
                    rPed.FILTERGROUP(0);
                    fPed.LOOKUPMODE(TRUE);
                    fPed.EDITABLE(FALSE);
                    fPed.SETTABLEVIEW(rPed);
                    IF fPed.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        fPed.GETRECORD(rPed);
                        rLin.SETRANGE(rLin."Document Type", rLin."Document Type"::Order);
                        rLin.SETRANGE("Document No.", rPed."No.");
                        rLin.SETRANGE("Version No.", rPed."Version No.");
                        IF rLin.FINDSET THEN BEGIN
                            REPEAT
                                rDetAt.Tipo := rDetAt.Tipo::Pedido;
                                rDetAt."Código Cab. Atención" := Codigo;
                                rDetAt.Codigo := rLin."No.";
                                rDetAt.Descripción := rLin.Description;
                                rDetAt.Cantidad := rLin.Quantity;
                                rDetAt."Precio Unitario" := rLin."Unit Price";
                                rDetAt."Monto total" := rLin.Quantity * rLin."Unit Price";
                                rDetAt.INSERT(TRUE);
                            UNTIL rLin.NEXT = 0;
                            MESSAGE(Text001);
                        END;
                    END
                    ELSE
                        ERROR(Text002);
                end;
            }
            action("<Action1000000030>")
            {
                Caption = 'Cargar Ped. Transferencia';
                Image = CopyDocument;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    fPed: Page 5752;
                    rPed: Record 5744;
                    rLin: Record 5745;
                    rDetAt: Record 67100;
                    rSalesPrice: Record 7002;
                begin
                    fPed.LOOKUPMODE(TRUE);
                    fPed.EDITABLE(FALSE);
                    fPed.SETTABLEVIEW(rPed);
                    IF fPed.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        fPed.GETRECORD(rPed);
                        rLin.SETRANGE("Document No.", rPed."No.");
                        IF rLin.FINDSET THEN BEGIN
                            REPEAT
                                rDetAt.Tipo := rDetAt.Tipo::Pedido;
                                rDetAt."Código Cab. Atención" := Codigo;
                                rDetAt.Codigo := rLin."Item No.";
                                rDetAt.Descripción := rLin.Description;
                                rDetAt.Cantidad := rLin.Quantity;
                                rSalesPrice.RESET;
                                rSalesPrice.SETRANGE(rSalesPrice."Item No.", rLin."Item No.");
                                IF rSalesPrice.FINDLAST THEN
                                    rDetAt."Precio Unitario" := rSalesPrice."Unit Price";
                                rDetAt."Monto total" := rDetAt.Cantidad * rDetAt."Precio Unitario";
                                rDetAt.INSERT(TRUE);
                            UNTIL rLin.NEXT = 0;
                            MESSAGE(Text001);
                        END;
                    END
                    ELSE
                        ERROR(Text002);
                end;
            }
            action("&Estadística")
            {
                Caption = '&Estadística';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CALCFIELDS(Monto, Atenciones);
                    MESSAGE(STRSUBSTNO(Text003, Monto, Atenciones));
                end;
            }
            action("Distribuc. por Centro de costos")
            {
                Caption = 'Distribuc. por Centro de costos';
                Image = GLAccountBalance;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 67169;
                RunPageLink = No. Atención=FIELD("Codigo");
            }
        }
    }

    trigger OnOpenPage()
    begin
        ActControles;
    end;

    var
        Text001: Label 'Las lineas del pedido han sido cargadas con éxito.';
        Text002: Label 'Accion cancelada por el usuario.';
        Text003: Label 'Monto total: %1.\Atenciones: %2.';
        [InDataSet]
        wMod: Boolean;
        [InDataSet]
        wCambEstado: Boolean;

    procedure ActControles()
    begin

        wMod := TRUE;
        IF Estado = Estado::Realizada THEN
          wMod := FALSE;

        wCambEstado := FALSE;
        IF Estado = Estado::Entregada THEN
          wCambEstado  := TRUE;
    end;

    procedure ValidaDistrCC()
    var
        Distr: Record 67101;
        Err001: Label 'Debe realizar la distribución de los centros de costo';
        Err002: Label 'No se han realizado la distribución de los centros de costo correctamente';
        Porc: Decimal;
    begin

        Distr.SETRANGE(Distr."No. Atención", Codigo);
        IF NOT Distr.FINDSET THEN
          ERROR(Err001);

        REPEAT
          Porc += Distr.Porcentaje;
        UNTIL Distr.NEXT=0;

        IF Porc <> 100 THEN
          ERROR(Err002);
    end;
}

