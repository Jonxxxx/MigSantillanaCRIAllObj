table 55481 "Materiales Talleres y Eventos"
{

    fields
    {
        field(1; "Cod. Taller - Evento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Taller - Evento';
            NotBlank = true;
            TableRelation = Eventos."No.";

            trigger OnValidate()
            begin
                IF Evento.GET("Cod. Taller - Evento") THEN
                    "Description Taller" := Evento.Descripcion;
            end;
        }
        field(2; "Tipo Evento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Evento';
            Editable = false;
            TableRelation = "Tipos de Eventos";
        }
        field(3; "Line no."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line no.';
        }
        field(4; "Tipo de Material"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de Material';
            OptionCaption = 'Item,Other';
            OptionMembers = Producto,Otro;
        }
        field(5; "Codigo Material"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Material';
            NotBlank = true;
            TableRelation = IF ("Tipo de Material" = CONST(Otro)) "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Materiales))
            ELSE IF ("Tipo de Material" = CONST(Producto)) Item;

            trigger OnValidate()
            begin
                CASE "Tipo de Material" OF
                    0:
                        BEGIN
                            Item.GET("Codigo Material");
                            "Description Material" := Item.Description;
                            "Costo Unitario" := Item."Unit Cost";
                        END;
                    1:
                        BEGIN
                            IF "Codigo Material" <> '' THEN BEGIN
                                DA.RESET;
                                DA.SETRANGE("Tipo registro", DA."Tipo registro"::Materiales);
                                DA.SETRANGE(Codigo, "Codigo Material");
                                DA.FINDFIRST;
                                "Description Material" := DA.Descripcion;
                                "Costo Unitario" := DA."Costo Unitario";
                            END;
                        END;
                END;
            end;
        }
        field(6; "Description Taller"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description Taller';
            Editable = false;
        }
        field(7; "Description Material"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description Material';
            Editable = false;
        }
        field(8; Cantidad; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';
        }
        field(9; "Costo Unitario"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Costo Unitario';
        }
        field(10; Secuencia; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Secuencia';
        }
        field(11; Expositor; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Expositor';
            TableRelation = IF ("Tipo de Expositor" = CONST(Docente)) Docentes WHERE("Expositor" = CONST(true))
            ELSE IF ("Tipo de Expositor" = CONST(Proveedor)) Vendor;
        }
        field(12; "Tipo de Expositor"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de Expositor';
            OptionCaption = 'Teacher,Vendor';
            OptionMembers = Docente,Proveedor;
        }
    }

    keys
    {
        key(Key1; "Cod. Taller - Evento", "Tipo Evento", Expositor, Secuencia, "Line no.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Evento: Record 55478;
        DA: Record 55469;
        Item: Record 27;
}

