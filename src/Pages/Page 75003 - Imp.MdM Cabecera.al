page 55684 "Imp.MdM Cabecera"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = 55684;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Id';
                }
                field(Operacion; Rec.Operacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Operacion';
                }
                field("Fecha Creacion"; Rec."Fecha Creacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Creacion';
                }
                field(id_mensaje; Rec.id_mensaje)
                {
                    ApplicationArea = All;
                    ToolTip = 'id_mensaje';
                }
                field(sistema_origen; Rec.sistema_origen)
                {
                    ApplicationArea = All;
                    ToolTip = 'sistema_origen';
                }
                field(pais_origen; Rec.pais_origen)
                {
                    ApplicationArea = All;
                    ToolTip = 'pais_origen';
                }
                field(fecha_origen; Rec.fecha_origen)
                {
                    ApplicationArea = All;
                    ToolTip = 'fecha_origen';
                }
                field(fecha; Rec.fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'fecha';
                }
                field(tipo; Rec.tipo)
                {
                    ApplicationArea = All;
                    ToolTip = 'tipo';
                }
                field(Entrada; Rec.Entrada)
                {
                    ApplicationArea = All;
                    ToolTip = 'Entrada';
                }
                field(Traspasado; Rec.Traspasado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Traspasado';
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                }
                field("Estado Envio"; Rec."Estado Envio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado Envio';
                }
                field(Attempt; Rec.Attempt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Attempt';
                }
                field("Texto Error"; Rec."Texto Error")
                {
                    ApplicationArea = All;
                    ToolTip = 'Texto Error';
                    ColumnSpan = 2;
                    RowSpan = 2;
                }
                field("No Tablas"; Rec."No Tablas")
                {
                    ApplicationArea = All;
                    ToolTip = 'No Tablas';
                }
                field("No Tablas Procesadas"; Rec."No Tablas Procesadas")
                {
                    ApplicationArea = All;
                    ToolTip = 'No Tablas Procesadas';
                }
            }
            part(PagePart; 55698)
            {
                SubPageLink = "Id Cab." = FIELD("Id");
            }
        }
    }

    actions
    {
    }
}

