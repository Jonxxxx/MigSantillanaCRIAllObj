page 67144 "Hist Adopciones-Colegio-Docent"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Hist Adopciones-Colegio-Docente';
    DataCaptionFields = "Cod. Colegio", "Cod. Docente";
    Editable = false;
    PageType = List;
    SourceTable = 67097;
    SourceTableView = SORTING(Campana, "Cod. Docente", "Cod. Colegio", "Cod. Local", "Cod. Producto", "Cod. Grado");
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Campaña; Campana)
                {
                }
                field("Cod. Producto"; "Cod. Producto")
                {
                    Editable = false;
                }
                field("Descripcion Producto"; "Descripcion Producto")
                {
                    Editable = false;
                }
                field("Edicion Coleccion"; "Edicion Coleccion")
                {
                }
                field("Cod. Grado"; "Cod. Grado")
                {
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field("Cod. Turno"; "Cod. Turno")
                {
                }
                field(Alumnado; Alumnado)
                {
                }
                field(Adopcion; Adopcion)
                {
                }
                field(CDS; CDS)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        ConfAPS: Record 67000;
        Item: Record 27;
        DefDim: Record 352;
        TextoEncabezado: array[30] of Text[30];
        DimValue: Text[60];
        i: Integer;
        gCodDocente: Code[20];
        gCodColegio: Code[20];
}

