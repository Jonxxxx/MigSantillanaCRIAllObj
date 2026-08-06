page 55625 "Ficha de Atenciones"
{
    PageType = Card;
    SourceTable = 55528;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = wMod;
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field("No. Solicitud"; Rec."No. Solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Solicitud';
                }
                field("Grupo de Negocio"; Rec."Grupo de Negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo de Negocio';
                }
                field("Tipo Evento"; Rec."Tipo Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Evento';
                }
                field("Fecha registro"; Rec."Fecha registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha registro';
                }
                field("Id. Usuario"; Rec."Id. Usuario")
                {
                    ApplicationArea = All;
                    ToolTip = 'Id. Usuario';
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                }
                field("Tipo documento"; Rec."Tipo documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo documento';
                }
                field(Documento; Rec.Documento)
                {
                    ApplicationArea = All;
                    ToolTip = 'Documento';
                }
                field("Fecha Recepcion Documento"; Rec."Fecha Recepcion Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Recepcion Documento';
                }
                field(Delegacion; Rec.Delegacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Delegacion';
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                }
                field("Cod. Local"; Rec."Cod. Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Local';
                }
                field(Distritos; Rec.Distritos)
                {
                    ApplicationArea = All;
                    ToolTip = 'Distritos';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Address';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'City';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field(Turno; Rec.Turno)
                {
                    ApplicationArea = All;
                    ToolTip = 'Turno';
                }
                field(Objetivo; Rec.Objetivo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Objetivo';
                }
                field("Descripcion Objetivo"; Rec."Descripcion Objetivo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Objetivo';
                }
            }
            group("Entrega Atenciones")
            {
                Editable = wMod;
                field("Area Responsable"; Rec."Area Responsable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Area Responsable';
                }
                field("Cod. Responsable"; Rec."Cod. Responsable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Responsable';
                }
                field("Nombre responsable"; Rec."Nombre responsable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre responsable';
                }
                field("Fecha de entrega"; Rec."Fecha de entrega")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha de entrega';
                }
                field("Comentarios Entrega"; Rec."Comentarios Entrega")
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentarios Entrega';
                }
                field("Comentarios Cancelacion"; Rec."Comentarios Cancelacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentarios Cancelacion';
                }
            }
            part(PagePart; 55627)
            {
                Editable = wMod;
                SubPageLink = "Codigo Cab. Atencion" = FIELD(Codigo);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Rechazar)
            {
                ApplicationArea = All;
                Caption = 'Rechazar';
                ToolTip = 'Rechazar';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = wCambEstado;

                trigger OnAction()
                begin
                    TESTFIELD("Fecha de entrega");
                    TESTFIELD("Comentarios Cancelacion");
                    Estado := Estado::Cancelada;

                    ActControles;
                end;
            }
            action(Realizar)
            {
                ApplicationArea = All;
                Caption = 'Realizar';
                ToolTip = 'Realizar';
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
                ApplicationArea = All;
                Caption = 'Cargar Ped. Venta';
                ToolTip = 'Cargar Ped. Venta';
                Image = CopyDocument;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    fPed: Page 9349;
                    rPed: Record 5107;
                    rLin: Record 5108;
                    rDetAt: Record 55559;
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
                                rDetAt."Codigo Cab. Atencion" := Codigo;
                                rDetAt.Codigo := rLin."No.";
                                rDetAt.Descripcion := rLin.Description;
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
                ApplicationArea = All;
                Caption = 'Cargar Ped. Transferencia';
                ToolTip = 'Cargar Ped. Transferencia';
                Image = CopyDocument;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    fPed: Page 5752;
                    rPed: Record 5744;
                    rLin: Record 5745;
                    rDetAt: Record 55559;
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
                                rDetAt."Codigo Cab. Atencion" := Codigo;
                                rDetAt.Codigo := rLin."Item No.";
                                rDetAt.Descripcion := rLin.Description;
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
            action("&Estadistica")
            {
                ApplicationArea = All;
                Caption = '&Estadistica';
                ToolTip = '&Estadistica';
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
                ApplicationArea = All;
                Caption = 'Distribuc. por Centro de costos';
                ToolTip = 'Distribuc. por Centro de costos';
                Image = GLAccountBalance;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 55628;
                RunPageLink = "No. Atencion" = FIELD("Codigo");
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
            wCambEstado := TRUE;
    end;

    procedure ValidaDistrCC()
    var
        Distr: Record 55560;
        Err001: Label 'Debe realizar la distribucion de los centros de costo';
        Err002: Label 'No se han realizado la distribucion de los centros de costo correctamente';
        Porc: Decimal;
    begin

        Distr.SETRANGE(Distr."No. Atencion", Codigo);
        IF NOT Distr.FINDSET THEN
            ERROR(Err001);

        REPEAT
            Porc += Distr.Porcentaje;
        UNTIL Distr.NEXT = 0;

        IF Porc <> 100 THEN
            ERROR(Err002);
    end;
}

