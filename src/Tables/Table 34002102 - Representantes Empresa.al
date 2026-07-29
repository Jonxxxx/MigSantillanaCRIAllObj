table 34002102 "Representantes Empresa"
{
    Caption = 'Company Representatives';

    fields
    {
        field(1; "Empresa cotizacion"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Empresa cotizacion';
        }
        field(2; "No. Orden"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Orden';
        }
        field(3; Nombre; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre';
        }
        field(4; Address; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(5; "C.P."; Text[5])
        {
            DataClassification = CustomerContent;
            Caption = 'C.P.';
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                IF CodPost.GET("C.P.") THEN BEGIN
                    County := CodPost."Search City";
                END;
            end;
        }
        field(6; "Poblacion"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Poblacion';
        }
        field(7; County; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'County';
        }
        field(8; "Teléfono"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Teléfono';
        }
        field(9; "RNC/CED"; Text[15])
        {
            DataClassification = CustomerContent;
            Caption = 'RNC/CED';

            trigger OnValidate()
            begin
                Emp.RESET;
                Emp.SETRANGE("Document ID", "RNC/CED");
                IF Emp.FINDFIRST THEN BEGIN
                    "Job Title" := Emp."Job Title";
                    Nombre := Emp."Full Name";
                    Address := Emp.Address;
                    "C.P." := Emp."Post Code";
                    Teléfono := Emp."Phone No.";
                    Poblacion := Emp."Country/Region Code";
                    County := Emp.County;
                END;
            end;
        }
        field(10; "Job Title"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Title';
        }
        field(11; Figurar; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Figurar';
            Description = 'Todo tipo documento,Contratos laborales,Mercantil,Responsable Informático';
            OptionCaption = 'All types of documents, Labor contracts, Letters, IT Manager';
            OptionMembers = "Todo tipo documento","Contratos laborales",Mercantil,"Responsable Informático";
        }
    }

    keys
    {
        key(Key1; "Empresa cotizacion", "No. Orden")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Emp: Record 5200;
        CodPost: Record 225;

    procedure "Recoger representantes"(var "Repres.": Record 34002102; "Unidad cotizacion": Code[10]; "Centro de trabajo": Code[10]; Figurar: Integer)
    begin
        "Repres.".RESET;
        "Repres.".SETRANGE("Repres."."Empresa cotizacion", "Empresa cotizacion");
        //"Repres.".SETRANGE("Repres."."Centro de trabajo","Centro de trabajo");
        "Repres.".SETFILTER(Nombre, '<>%1', '');  // 17/12/99
        "Repres.".SETRANGE("Repres.".Figurar, Figurar);
        IF NOT "Repres.".FIND('+') THEN BEGIN
            "Repres.".RESET;
            "Repres.".SETRANGE("Repres."."Empresa cotizacion", "Empresa cotizacion");
            //  "Repres.".SETRANGE("Repres."."Centro de trabajo","Centro de trabajo");
            "Repres.".SETFILTER(Nombre, '<>%1', '');  // 17/12/99
            "Repres.".SETRANGE("Repres.".Figurar, "Repres.".Figurar::"Todo tipo documento");
            IF NOT "Repres.".FIND('+') THEN BEGIN
                "Repres.".RESET;
                "Repres.".SETRANGE("Repres."."Empresa cotizacion", "Empresa cotizacion");
                "Repres.".SETFILTER(Nombre, '<>%1', '');  // 17/12/99
                "Repres.".SETRANGE("Repres.".Figurar, Figurar);
                IF NOT "Repres.".FIND('+') THEN BEGIN
                    "Repres.".RESET;
                    "Repres.".SETRANGE("Repres."."Empresa cotizacion", "Empresa cotizacion");
                    "Repres.".SETFILTER(Nombre, '<>%1', '');  // 17/12/99
                    "Repres.".SETRANGE("Repres.".Figurar, "Repres.".Figurar::"Todo tipo documento");
                    IF NOT "Repres.".FIND('+') THEN BEGIN
                        "Repres.".RESET;
                        "Repres.".SETFILTER(Nombre, '<>%1', '');  // 17/12/99
                        "Repres.".SETRANGE("Repres.".Figurar, Figurar);
                        IF NOT "Repres.".FIND('+') THEN BEGIN
                            "Repres.".RESET;
                            "Repres.".SETFILTER(Nombre, '<>%1', '');  // 17/12/99
                            "Repres.".SETRANGE("Repres.".Figurar, "Repres.".Figurar::"Todo tipo documento");
                            IF NOT "Repres.".FIND('+') THEN "Repres.".INIT
                        END;
                    END;
                END;
            END;
        END;
    end;
}

