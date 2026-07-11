page 67105 "Lista Seleccion eventos"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Selection of Events';
    PageType = List;
    SourceTable = 67051;
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
                    Caption = 'Select';

                    trigger OnValidate()
                    var
                        rProgEv: Record 67015;
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
                field("Tipo Evento"; "Tipo Evento")
                {
                    Editable = false;
                }
                field("Cod. Taller - Evento"; "Cod. Taller - Evento")
                {
                    Editable = false;
                }
                field(Expositor; Expositor)
                {
                    Editable = false;
                }
                field(Secuencia; Secuencia)
                {
                    Editable = false;
                }
                field("No. Solicitud"; "No. Solicitud")
                {
                    Editable = false;
                }
                field("Fecha Inicio"; "Fecha Inicio")
                {
                }
                field("Numero de sesiones"; "Numero de sesiones")
                {
                }
                field("Fecha Programada"; "Fecha Programada")
                {
                }
                field("Fecha Realizada"; "Fecha Realizada")
                {
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field("Description Tipo evento"; "Description Tipo evento")
                {
                    Editable = false;
                }
                field("Description Taller"; "Description Taller")
                {
                    Editable = false;
                }
                field("Nombre Expositor"; "Nombre Expositor")
                {
                    Editable = false;
                }
                field("Asistentes esperados"; "Asistentes esperados")
                {
                    Editable = false;
                }
                field("Total registrados"; "Total registrados")
                {
                }
                field(Delegacion; Delegacion)
                {
                }
                field("Descripcion Delegacion"; "Descripcion Delegacion")
                {
                }
                field(Estado; Estado)
                {
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
        AsistEvento: Record 67016;
        Seleccionado: Boolean;
        gCodDocente: Code[20];

    procedure RecibeParametro(CodDocente: Code[20])
    begin
        gCodDocente := CodDocente;
    end;
}

