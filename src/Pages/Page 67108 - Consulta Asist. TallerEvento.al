page 67108 "Consulta Asist. Taller/Evento"
{
    Caption = 'View Assist. Workshop/Events';
    Editable = false;
    PageType = ListPart;
    SourceTable = 67016;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. Solicitud"; "No. Solicitud")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Tipo Evento"; "Tipo Evento")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Cod. Taller - Evento"; "Cod. Taller - Evento")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Secuencia; Secuencia)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Cod. Promotor"; "Cod. Promotor")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Description Tipo evento"; "Description Tipo evento")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Description Taller"; "Description Taller")
                {
                    Editable = false;
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Nombre Promotor"; "Nombre Promotor")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Fecha inscripcion"; "Fecha inscripcion")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Fecha del Evento"; "Fecha del Evento")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Fecha de realizacion"; "Fecha de realizacion")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Cod. Docente"; "Cod. Docente")
                {
                    Editable = false;
                    TableRelation = Docentes WHERE("Pertenece al CDS" = CONST(true));
                    Visible = false;
                }
                field("Nombre Docente"; "Nombre Docente")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Confirmado; texConfirmado)
                {
                    Caption = 'Confirmado';
                    Style = Strong;
                    StyleExpr = TRUE;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Confirmado := NOT Confirmado;
                        MODIFY;

                        FormatBooleanos;
                    end;
                }
                field(Asistio; texAsistio)
                {
                    Caption = 'Attended';
                    Style = Strong;
                    StyleExpr = TRUE;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Asistio := NOT Asistio;
                        MODIFY;

                        FormatBooleanos;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        FormatBooleanos;
    end;

    var
        CabPlanEvento: Record 67051;
        SelDoc: Page 67103;
        TotDocentes: Integer;
        TotSeleccionados: Integer;
        texAsistio: Text[30];
        texConfirmado: Text[30];

    procedure FormatBooleanos()
    begin
        CLEAR(texAsistio);
        CLEAR(texConfirmado);
        IF Asistio THEN
            texAsistio := FORMAT(Asistio);
        IF Confirmado THEN
            texConfirmado := FORMAT(Confirmado);
    end;
}

