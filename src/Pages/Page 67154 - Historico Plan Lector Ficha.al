page 55613 "Historico Plan Lector Ficha"
{
    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = 55554;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Campaña; Rec.Campana)
                {
                    ApplicationArea = All;
                    ToolTip = 'Campana';
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
                field("Descripcion Local"; Rec."Descripcion Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Local';
                }
                field("Cod. Turno"; Rec."Cod. Turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Turno';
                }
                field("Descripcion Turno"; Rec."Descripcion Turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Turno';
                }
                field(Distrito; Rec.Distrito)
                {
                    ApplicationArea = All;
                    ToolTip = 'Distrito';
                }
                field("Cod. Delegacion"; Rec."Cod. Delegacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Delegacion';
                    Editable = false;
                }
                field("Descripcion Delegacion"; Rec."Descripcion Delegacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Delegacion';
                    Editable = false;
                }
            }
            part(Detalle; 55614)
            {
                Caption = 'Detalle';
                SubPageLink = Campana = FIELD("Campana"),
                              "Cod. Colegio" = FIELD("Cod. Colegio"),
                              "Cod. Local" = FIELD("Cod. Local"),
                              "Cod. Turno" = FIELD("Cod. Turno");
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    procedure Cargar(CodColegio: Code[20]; CodLocal: Code[20]; CodTurno: Code[20])
    var
        recGrados: Record 55504;
        recPL: Record 55531;
        Texto001: Label 'Si realiza la carga de datos, se borrarán los datos existentes. ¿Desea continuar?';
        recAdop: Record 55520;
    begin
        recPL.RESET;
        recPL.SETRANGE("Cod. Colegio", CodColegio);
        IF CodLocal <> '' THEN recPL.SETRANGE("Cod. Local", CodLocal);
        recPL.SETRANGE("Cod. Turno", CodTurno);
        IF recPL.FINDFIRST THEN
            IF CONFIRM(Texto001) THEN
                recPL.DELETEALL
            ELSE
                EXIT;
        recPL.RESET;
        recGrados.SETRANGE("Cod. Colegio", CodColegio);
        IF CodLocal <> '' THEN recGrados.SETRANGE("Cod. Local", CodLocal);
        recGrados.SETRANGE("Cod. Turno", CodTurno);
        IF recGrados.FINDSET THEN
            REPEAT
                recPL.INIT;
                recPL."Cod. Colegio" := recGrados."Cod. Colegio";
                recPL."Cod. Local" := recGrados."Cod. Local";
                recPL."Cod. Turno" := recGrados."Cod. Turno";
                recPL."Cod. Nivel" := recGrados."Cod. Nivel";
                recPL."Cod. Grado" := recGrados."Cod. Grado";
                recPL."Cantidad Docentes" := recGrados."Cantidad Secciones";
                recPL."Cantidad Alumnos" := recGrados."Cantidad Alumnos";
                recPL."Cantidad Docentes" := recGrados."Cantidad Docentes";

                recAdop.RESET;
                recAdop.SETCURRENTKEY("Cod. Colegio", "Grupo de Negocio", "Cod. Grado", "Cod. Turno", "Cod. Promotor", "Cod. Producto");
                recAdop.SETRANGE("Cod. Colegio", recPL."Cod. Colegio");
                recAdop.SETRANGE("Grupo de Negocio", 'PLAN LECTOR');
                recAdop.SETRANGE("Cod. Turno", recPL."Cod. Turno");
                recAdop.SETFILTER(Adopcion, '%1|%2', recAdop.Adopcion::Conquista, recAdop.Adopcion::Mantener);
                recAdop.SETRANGE("Item - Item Category Code", recPL."Cod. Nivel");
                recAdop.SETRANGE("Item - Grado", recPL."Cod. Grado");
                IF recAdop.FINDSET THEN BEGIN
                    recPL."Edit. 1" := 'S';
                    REPEAT
                        recPL."Cant. x Alum 1" += recAdop."Adopcion Real";
                        recPL."Adopcion real" += recAdop."Adopcion Real";
                    UNTIL recAdop.NEXT = 0;
                    IF recPL."Cantidad Alumnos" <> 0 THEN
                        recPL.VALIDATE("Cant. x Alum 1", ROUND(recPL."Cant. x Alum 1" / recPL."Cantidad Alumnos", 1));
                END;
                recPL.INSERT;
            UNTIL recGrados.NEXT = 0;
    end;
}

