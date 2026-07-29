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
                field("No. Solicitud"; Rec."No. Solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Solicitud';
                    Editable = false;
                    Visible = false;
                }
                field("Tipo Evento"; Rec."Tipo Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Evento';
                    Editable = false;
                    Visible = false;
                }
                field("Cod. Taller - Evento"; Rec."Cod. Taller - Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Taller - Evento';
                    Editable = false;
                    Visible = false;
                }
                field(Secuencia; Rec.Secuencia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Secuencia';
                    Editable = false;
                    Visible = false;
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                    Editable = false;
                    Visible = false;
                }
                field("Cod. Promotor"; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
                    Editable = false;
                    Visible = false;
                }
                field("Description Tipo evento"; Rec."Description Tipo evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description Tipo evento';
                    Editable = false;
                    Visible = false;
                }
                field("Description Taller"; Rec."Description Taller")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description Taller';
                    Editable = false;
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                    Editable = false;
                    Visible = false;
                }
                field("Nombre Promotor"; Rec."Nombre Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Promotor';
                    Editable = false;
                    Visible = false;
                }
                field("Fecha inscripcion"; Rec."Fecha inscripcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha inscripcion';
                    Editable = false;
                    Visible = false;
                }
                field("Fecha del Evento"; Rec."Fecha del Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha del Evento';
                    Editable = false;
                    Visible = false;
                }
                field("Fecha de realizacion"; Rec."Fecha de realizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha de realizacion';
                    Editable = false;
                    Visible = false;
                }
                field("Cod. Docente"; Rec."Cod. Docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Docente';
                    Editable = false;
                    TableRelation = Docentes WHERE("Pertenece al CDS" = CONST(true));
                    Visible = false;
                }
                field("Nombre Docente"; Rec."Nombre Docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Docente';
                    Editable = false;
                    Visible = false;
                }
                field(Confirmado; texConfirmado)
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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

