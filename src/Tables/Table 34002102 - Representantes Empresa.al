table 34002102 "Representantes Empresa"
{
    Caption = 'Company Representatives';

    fields
    {
        field(1; "Empresa cotización"; Code[10])
        {
            Caption = 'Company';
        }
        field(2; "No. Orden"; Integer)
        {
            Caption = 'Line no.';
        }
        field(3; Nombre; Text[30])
        {
            Caption = 'Name';
        }
        field(4; Address; Text[60])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(5; "C.P."; Text[5])
        {
            Caption = 'Post code';
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                IF CodPost.GET("C.P.") THEN BEGIN
                    County := CodPost."Search City";
                END;
            end;
        }
        field(6; "Población"; Text[30])
        {
            Caption = 'Población';
        }
        field(7; County; Text[30])
        {
            Caption = 'State';
            DataClassification = ToBeClassified;
        }
        field(8; "Teléfono"; Text[20])
        {
            Caption = 'Phone no.';
        }
        field(9; "RNC/CED"; Text[15])
        {
            Caption = 'RNC/Cédula';

            trigger OnValidate()
            begin
                Emp.RESET;
                //TODO: Ver Emp.SETRANGE("Document ID", "RNC/CED");
                IF Emp.FINDFIRST THEN BEGIN
                    "Job Title" := Emp."Job Title";
                    //TODO: Ver Nombre := Emp."Full Name";
                    Address := Emp.Address;
                    "C.P." := Emp."Post Code";
                    Teléfono := Emp."Phone No.";
                    Población := Emp."Country/Region Code";
                    County := Emp.County;
                END;
            end;
        }
        field(10; "Job Title"; Text[60])
        {
            Caption = 'Job Title';
            DataClassification = ToBeClassified;
        }
        field(11; Figurar; Option)
        {
            Caption = 'Show';
            Description = 'Todo tipo documento,Contratos laborales,Mercantil,Responsable Informático';
            OptionCaption = 'All types of documents, Labor contracts, Letters, IT Manager';
            OptionMembers = "Todo tipo documento","Contratos laborales",Mercantil,"Responsable Informático";
        }
    }

    keys
    {
        key(Key1; "Empresa cotización", "No. Orden")
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
        "Repres.".SETRANGE("Repres."."Empresa cotización", "Empresa cotización");
        //"Repres.".SETRANGE("Repres."."Centro de trabajo","Centro de trabajo");
        "Repres.".SETFILTER(Nombre, '<>%1', '');  // 17/12/99
        "Repres.".SETRANGE("Repres.".Figurar, Figurar);
        IF NOT "Repres.".FIND('+') THEN BEGIN
            "Repres.".RESET;
            "Repres.".SETRANGE("Repres."."Empresa cotización", "Empresa cotización");
            //  "Repres.".SETRANGE("Repres."."Centro de trabajo","Centro de trabajo");
            "Repres.".SETFILTER(Nombre, '<>%1', '');  // 17/12/99
            "Repres.".SETRANGE("Repres.".Figurar, "Repres.".Figurar::"Todo tipo documento");
            IF NOT "Repres.".FIND('+') THEN BEGIN
                "Repres.".RESET;
                "Repres.".SETRANGE("Repres."."Empresa cotización", "Empresa cotización");
                "Repres.".SETFILTER(Nombre, '<>%1', '');  // 17/12/99
                "Repres.".SETRANGE("Repres.".Figurar, Figurar);
                IF NOT "Repres.".FIND('+') THEN BEGIN
                    "Repres.".RESET;
                    "Repres.".SETRANGE("Repres."."Empresa cotización", "Empresa cotización");
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

