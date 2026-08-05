page 67105 "Lista Seleccion eventos"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Selection of Events';
    PageType = List;
    SourceTable = 55518;
    SourceTableView = WHERE("Estado" = CONST(" "));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Seleccionado; Seleccionado)
                {
                    ApplicationArea = All;
                    Caption = 'Select';

                    trigger OnValidate()
                    var
                        rProgEv: Record 55482;
                    begin
                        IF Seleccionado THEN BEGIN
                            rProgEv.RESET;
                            rProgEv.SETRANGE(rProgEv."Cod. Taller - Evento", "Cod. Taller - Evento");
                            rProgEv.SETRANGE(rProgEv.Expositor, Expositor);
                            rProgEv.SETRANGE(rProgEv.Secuencia, Secuencia);
                            rProgEv.SETRANGE(rProgEv."Tipo Evento", "Tipo Evento");
                            IF rProgEv.FINDFIRST THEN
                                REPEAT
                                    AsistEvento.RESET;
                                    AsistEvento.VALIDATE("Tipo Evento", "Tipo Evento");
                                    AsistEvento.VALIDATE("Cod. Taller - Evento", "Cod. Taller - Evento");
                                    AsistEvento."Tipo de Expositor" := "Tipo de Expositor";
                                    AsistEvento.VALIDATE("Cod. Expositor", Expositor);
                                    AsistEvento.VALIDATE("No Linea Programac.", rProgEv."No. Linea");
                                    AsistEvento.VALIDATE(Secuencia, Secuencia);
                                    AsistEvento.VALIDATE("Cod. Docente", gCodDocente);
                                    IF AsistEvento.INSERT(TRUE) THEN;
                                UNTIL rProgEv.NEXT = 0;
                        END
                        ELSE BEGIN
                            AsistEvento.RESET;
                            AsistEvento.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
                            AsistEvento.SETRANGE("Cod. Expositor", Expositor);
                            AsistEvento.SETRANGE(Secuencia, Secuencia);
                            AsistEvento.SETRANGE("Tipo Evento", "Tipo Evento");
                            AsistEvento.SETRANGE("Cod. Docente", gCodDocente);
                            IF AsistEvento.FINDFIRST THEN
                                REPEAT
                                    AsistEvento.DELETE(TRUE);
                                UNTIL AsistEvento.NEXT = 0;
                        END
                    end;
                }
                field("Tipo Evento"; Rec."Tipo Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Evento';
                    Editable = false;
                }
                field("Cod. Taller - Evento"; Rec."Cod. Taller - Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Taller - Evento';
                    Editable = false;
                }
                field(Expositor; Rec.Expositor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Expositor';
                    Editable = false;
                }
                field(Secuencia; Rec.Secuencia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Secuencia';
                    Editable = false;
                }
                field("No. Solicitud"; Rec."No. Solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Solicitud';
                    Editable = false;
                }
                field("Fecha Inicio"; Rec."Fecha Inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicio';
                }
                field("Numero de sesiones"; Rec."Numero de sesiones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero de sesiones';
                }
                field("Fecha Programada"; Rec."Fecha Programada")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Programada';
                }
                field("Fecha Realizada"; Rec."Fecha Realizada")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Realizada';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Description Tipo evento"; Rec."Description Tipo evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description Tipo evento';
                    Editable = false;
                }
                field("Description Taller"; Rec."Description Taller")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description Taller';
                    Editable = false;
                }
                field("Nombre Expositor"; Rec."Nombre Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Expositor';
                    Editable = false;
                }
                field("Asistentes esperados"; Rec."Asistentes esperados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Asistentes esperados';
                    Editable = false;
                }
                field("Total registrados"; Rec."Total registrados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total registrados';
                }
                field(Delegacion; Rec.Delegacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Delegacion';
                }
                field("Descripcion Delegacion"; Rec."Descripcion Delegacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Delegacion';
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Seleccionado := FALSE;
        AsistEvento.RESET;
        AsistEvento.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
        AsistEvento.SETRANGE("Cod. Expositor", Expositor);
        AsistEvento.SETRANGE(Secuencia, Secuencia);
        AsistEvento.SETRANGE("Tipo Evento", "Tipo Evento");
        AsistEvento.SETRANGE("Cod. Docente", gCodDocente);
        IF AsistEvento.FINDFIRST THEN
            Seleccionado := TRUE;
    end;

    trigger OnOpenPage()
    begin
        SETRANGE("No. Solicitud", '');
    end;

    var
        AsistEvento: Record 55483;
        Seleccionado: Boolean;
        gCodDocente: Code[20];

    procedure RecibeParametro(CodDocente: Code[20])
    begin
        gCodDocente := CodDocente;
    end;
}

