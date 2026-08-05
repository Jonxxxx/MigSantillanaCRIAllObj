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
                field(Campaña; Rec.Campana)
                {
                    ApplicationArea = All;
                    ToolTip = 'Campana';
                }
                field("Cod. Producto"; Rec."Cod. Producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Producto';
                    Editable = false;
                }
                field("Descripcion Producto"; "Descripcion Producto")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Edicion Coleccion"; Rec."Edicion Coleccion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Edicion Coleccion';
                }
                field("Cod. Grado"; Rec."Cod. Grado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Grado';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Cod. Turno"; Rec."Cod. Turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Turno';
                }
                field(Alumnado; Rec.Alumnado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Alumnado';
                }
                field(Adopcion; Rec.Adopcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion';
                }
                field(CDS; Rec.CDS)
                {
                    ApplicationArea = All;
                    ToolTip = 'CDS';
                }
            }
        }
    }

    actions
    {
    }

    var
        ConfAPS: Record 55467;
        Item: Record 27;
        DefDim: Record 352;
        TextoEncabezado: array[30] of Text[30];
        DimValue: Text[60];
        i: Integer;
        gCodDocente: Code[20];
        gCodColegio: Code[20];
}

