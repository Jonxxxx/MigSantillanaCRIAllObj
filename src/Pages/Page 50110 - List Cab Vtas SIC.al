page 50110 "List Cab Vtas SIC"
{
    Caption = 'List Cab Vtas SIC';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50111;
    SourceTableView = SORTING(Transferido, Fecha);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo documento"; Rec."Tipo documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo documento';
                }
                field("No. documento"; Rec."No. documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. documento';
                }
                field("Cod. Cliente"; Rec."Cod. Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cliente';
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                }
                field("Cod. Almacen"; Rec."Cod. Almacen")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Almacen';
                }
                field("Cod. Moneda"; Rec."Cod. Moneda")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Moneda';
                }
                field(RNC; Rec.RNC)
                {
                    ApplicationArea = All;
                    ToolTip = 'RNC';
                }
                field("Nombre Cliente"; Rec."Nombre Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Cliente';
                }
                field("No. comprobante"; Rec."No. comprobante")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. comprobante';
                }
                field("Fecha Venc. NCF"; Rec."Fecha Venc. NCF")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Venc. NCF';
                }
                field("NCF Afectado"; Rec."NCF Afectado")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Afectado';
                }
                field("Cod. Cajero"; Rec."Cod. Cajero")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cajero';
                }
                field("Tasa de cambio"; Rec."Tasa de cambio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tasa de cambio';
                }
                field("Nombre asegurado"; Rec."Nombre asegurado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre asegurado';
                }
                field("No. poliza"; Rec."No. poliza")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. poliza';
                }
                field("No. orden"; Rec."No. orden")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. orden';
                }
                field(Aseguradora; Rec.Aseguradora)
                {
                    ApplicationArea = All;
                    ToolTip = 'Aseguradora';
                }
                field("RNC Aseguradora"; Rec."RNC Aseguradora")
                {
                    ApplicationArea = All;
                    ToolTip = 'RNC Aseguradora';
                }
                field("Cod. supervisor"; Rec."Cod. supervisor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. supervisor';
                }
                field(Turno; Rec.Turno)
                {
                    ApplicationArea = All;
                    ToolTip = 'Turno';
                }
                field("Source Counter"; Rec."Source Counter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Source Counter';
                }
                field(Transferido; Rec.Transferido)
                {
                    ApplicationArea = All;
                    ToolTip = 'Transferido';
                }
                field(Errores; Rec.Errores)
                {
                    ApplicationArea = All;
                    ToolTip = 'Errores';
                }
                field(ErroresLineas; Rec.ErroresLineas)
                {
                    ApplicationArea = All;
                    ToolTip = 'ErroresLineas';
                }
                field(Monto; Rec.Monto)
                {
                    ApplicationArea = All;
                    ToolTip = 'Monto';
                }
                field(ITBIS; Rec.ITBIS)
                {
                    ApplicationArea = All;
                    ToolTip = 'ITBIS';
                }
                field(SubTotal; Rec.SubTotal)
                {
                    ApplicationArea = All;
                    ToolTip = 'SubTotal';
                }
                field(Descuento; Rec.Descuento)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descuento';
                }
                field(Observacion; Rec.Observacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Observacion';
                }
                field(Origen; Rec.Origen)
                {
                    ApplicationArea = All;
                    ToolTip = 'Origen';
                }
                field(Hora; Rec.Hora)
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora';
                }
                field(Clave; Rec.Clave)
                {
                    ApplicationArea = All;
                    ToolTip = 'Clave';
                }
                field(Consecutivo; Rec.Consecutivo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Consecutivo';
                }
                field(Colegio; Rec.Colegio)
                {
                    ApplicationArea = All;
                    ToolTip = 'Colegio';
                }
                field(Caja; Rec.Caja)
                {
                    ApplicationArea = All;
                    ToolTip = 'Caja';
                }
                field(Tienda; Rec.Tienda)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tienda';
                }
                field("No. documento SIC"; Rec."No. documento SIC")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. documento SIC';
                }
                field(Establecimiento; Rec.Establecimiento)
                {
                    ApplicationArea = All;
                    ToolTip = 'Establecimiento';
                }
                field(PuntoEmision; Rec.PuntoEmision)
                {
                    ApplicationArea = All;
                    ToolTip = 'PuntoEmision';
                }
                field("Tipo Documento Identidad"; Rec."Tipo Documento Identidad")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Documento Identidad';
                }
                field("No. Telefono"; Rec."No. Telefono")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Telefono';
                }
                field("Correo Electronico"; Rec."Correo Electronico")
                {
                    ApplicationArea = All;
                    ToolTip = 'Correo Electronico';
                }
                field("Serie Documento"; Rec."Serie Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Serie Documento';
                }
                field("Cod. Banco"; Rec."Cod. Banco")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Banco';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}

