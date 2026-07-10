page 50110 "List Cab Vtas SIC"
{
    Caption = 'List Cab Vtas SIC';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table50111;
    SourceTableView = SORTING(Transferido,Fecha);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo documento";"Tipo documento")
                {
                }
                field("No. documento";"No. documento")
                {
                }
                field("Cod. Cliente";"Cod. Cliente")
                {
                }
                field(Fecha;Fecha)
                {
                }
                field("Cod. Almacen";"Cod. Almacen")
                {
                }
                field("Cod. Moneda";"Cod. Moneda")
                {
                }
                field(RNC;RNC)
                {
                }
                field("Nombre Cliente";"Nombre Cliente")
                {
                }
                field("No. comprobante";"No. comprobante")
                {
                }
                field("Fecha Venc. NCF";"Fecha Venc. NCF")
                {
                }
                field("NCF Afectado";"NCF Afectado")
                {
                }
                field("Cod. Cajero";"Cod. Cajero")
                {
                }
                field("Tasa de cambio";"Tasa de cambio")
                {
                }
                field("Nombre asegurado";"Nombre asegurado")
                {
                }
                field("No. poliza";"No. poliza")
                {
                }
                field("No. orden";"No. orden")
                {
                }
                field(Aseguradora;Aseguradora)
                {
                }
                field("RNC Aseguradora";"RNC Aseguradora")
                {
                }
                field("Cod. supervisor";"Cod. supervisor")
                {
                }
                field(Turno;Turno)
                {
                }
                field("Source Counter";"Source Counter")
                {
                }
                field(Transferido;Transferido)
                {
                }
                field(Errores;Errores)
                {
                }
                field(ErroresLineas;ErroresLineas)
                {
                }
                field(Monto;Monto)
                {
                }
                field(ITBIS;ITBIS)
                {
                }
                field(SubTotal;SubTotal)
                {
                }
                field(Descuento;Descuento)
                {
                }
                field(Observacion;Observacion)
                {
                }
                field(Origen;Origen)
                {
                }
                field(Hora;Hora)
                {
                }
                field(Clave;Clave)
                {
                }
                field(Consecutivo;Consecutivo)
                {
                }
                field(Colegio;Colegio)
                {
                }
                field(Caja;Caja)
                {
                }
                field(Tienda;Tienda)
                {
                }
                field("No. documento SIC";"No. documento SIC")
                {
                }
                field(Establecimiento;Establecimiento)
                {
                }
                field(PuntoEmision;PuntoEmision)
                {
                }
                field("Tipo Documento Identidad";"Tipo Documento Identidad")
                {
                }
                field("No. Telefono";"No. Telefono")
                {
                }
                field("Correo Electronico";"Correo Electronico")
                {
                }
                field("Serie Documento";"Serie Documento")
                {
                }
                field("Cod. Banco";"Cod. Banco")
                {
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

