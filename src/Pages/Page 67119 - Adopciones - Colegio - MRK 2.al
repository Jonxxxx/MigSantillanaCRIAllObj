page 67119 "Adopciones - Colegio - MRK 2"
{
    // $001 09/06/14 JML : Page basado en el 67111, pero con los grados en vertical.

    Caption = 'School - Adoptions';
    DataCaptionFields = "Cod. Colegio", "Cod. Docente";
    PageType = Card;
    SourceTable = 55545;
    SourceTableView = SORTING("Cod. Docente", "Cod. Colegio", "Cod. Local", "Cod. Producto");

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Producto"; Rec."Cod. Producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Producto';
                    Editable = false;
                }
                field("Descripcion producto"; Rec."Descripcion producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion producto';
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

    trigger OnOpenPage()
    begin
        SETRANGE("Cod. Colegio", gCodColegio);
        SETRANGE("Cod. Docente", gCodDocente);
    end;

    var
        ConfAPS: Record 55467;
        Item: Record 27;
        DefDim: Record 352;
        TextoEncabezado: array[30] of Text[30];
        DimValue: Text[60];
        i: Integer;
        gCodDocente: Code[20];
        gCodColegio: Code[20];

    procedure RecibeParametros(CodDoc: Code[20]; CodCol: Code[20])
    var
        ColAdopDetalle: Record 55520;
        Grados: Record 55469;
    begin
        gCodColegio := CodCol;
        gCodDocente := CodDoc;
        ConfAPS.GET();
        ConfAPS.TESTFIELD("Dim para Estad. Adopciones");
        i := 0;

        DimValue := ' ';
        Grados.RESET;
        Grados.SETRANGE("Tipo registro", Grados."Tipo registro"::Grados);
        Grados.FIND('-');
        REPEAT
            i += 1;
            TextoEncabezado[i] := Grados.Codigo;
        UNTIL Grados.NEXT = 0;


        ColAdopDetalle.RESET;
        ColAdopDetalle.SETCURRENTKEY("Cod. Colegio", "Linea de negocio", Familia, "Sub Familia", Serie, "Grupo de Negocio");
        ColAdopDetalle.SETRANGE("Cod. Colegio", CodCol);
        ColAdopDetalle.SETFILTER(Adopcion, '<>%1', 0);
        //ColAdopDetalle.SETRANGE("Cod. Nivel",CodNivel);
        //ColAdopDetalle.SETRANGE("Cod. Turno",CodTurno);
        //ColAdopDetalle.SETRANGE("Cod. Grado",CodGrado);
        ColAdopDetalle.FINDSET;
        REPEAT
            IF NOT GET(CodDoc, CodCol, ColAdopDetalle."Cod. Local", ColAdopDetalle."Cod. Producto", ColAdopDetalle."Cod. Grado") THEN
                INIT;

            "Cod. Docente" := CodDoc;
            "Cod. Colegio" := ColAdopDetalle."Cod. Colegio";
            "Cod. Nivel" := ColAdopDetalle."Cod. Nivel";
            "Cod. Grado" := ColAdopDetalle."Cod. Grado";
            "Cod. Turno" := ColAdopDetalle."Cod. Turno";
            "Linea de negocio" := ColAdopDetalle."Linea de negocio";
            Familia := ColAdopDetalle.Familia;
            "Sub Familia" := DimValue;
            Serie := ColAdopDetalle.Serie;
            //"Cod. Editorial"   := ColAdopDetalle."Cod. Editorial";
            "Cod. Local" := ColAdopDetalle."Cod. Local";
            "Cod. Promotor" := ColAdopDetalle."Cod. Promotor";
            "Cod. Producto" := ColAdopDetalle."Cod. Producto";
            Alumnado := ColAdopDetalle."Adopcion Real";  //$001
            Adopcion := ColAdopDetalle.Adopcion;
            Item.GET("Cod. Producto");

            DefDim.RESET;
            DefDim.SETRANGE("Table ID", 27);
            DefDim.SETRANGE("No.", "Cod. Producto");
            DefDim.SETRANGE("Dimension Code", 'EDICION_COLECCION');
            IF DefDim.FINDFIRST THEN
                "Edicion Coleccion" := DefDim."Dimension Value Code";

            "Descripcion producto" := Item.Description;

            IF NOT INSERT THEN
                MODIFY;
        UNTIL ColAdopDetalle.NEXT = 0;
    end;
}

