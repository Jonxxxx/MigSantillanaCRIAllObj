table 34002110 "Puestos laborales"
{
    Caption = 'Job type';
    //TODO: Ver DrillDownPageID = 34002109;
    //TODO: Ver LookupPageID = 34002109;

    fields
    {
        field(1; "Codigo"; Code[15])
        {
        }
        field(2; "Descripcion"; Text[50])
        {
        }
        field(3; "Cod. nivel"; Code[20])
        {
            Caption = 'Level code';
            DataClassification = ToBeClassified;
            TableRelation = "Nivel Cargo";
        }
        field(4; "Cod. Supervisor"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            var
                Empl: Record 5200;
            begin
                IF (xRec."Cod. Supervisor" <> "Cod. Supervisor") AND
                   ("Cod. Supervisor" <> '') THEN BEGIN
                    //TODO: Ver 
                    /*
                    Empl.SETCURRENTKEY("Job Type Code");
                    Empl.SETRANGE("Job Type Code", Codigo);
                    IF Empl.FINDSET(TRUE, FALSE) THEN BEGIN
                        Empl."Cod. Supervisor" := "Cod. Supervisor";
                        Empl.MODIFY;
                    END;
                    */
                END;
            end;
        }
        field(5; "Nombre Completo"; Text[150])
        {
            //TODO: Ver CalcFormula = Lookup(Employee."Full Name" WHERE("No." = FIELD("Cod. Supervisor")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Incluye Dias Feriados"; Boolean)
        {
        }
        field(7; Exento; Boolean)
        {
            Description = 'Para Nomina PR';
        }
        field(8; "Total Empleados"; Integer)
        {
            //TODO: Ver CalcFormula = Count(Employee WHERE(Departamento = FIELD("Cod. departamento"),
            //TODO: Ver                                     "Type Code" = FIELD("Codigo"),
            //TODO: Ver                                    Status = CONST(Active)));
            Caption = 'Total Employee';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Método cálculo Ingresos"; Code[10])
        {
            TableRelation = "Parametros Calculo Dias";
        }
        field(10; "Método cálculo Paga Salario"; Option)
        {
            OptionCaption = 'Distributed,By period';
            OptionMembers = Distribuido,"Por periodo";
        }
        field(11; "Cod. departamento"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Departamentos;
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(14; "Maximo de posiciones"; Integer)
        {
            Caption = 'Maximum quantity';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Cod. departamento", "Codigo")
        {
        }
        key(Key2; "Descripcion", "Codigo")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Codigo", "Descripcion")
        {
        }
    }

    trigger OnDelete()
    begin
        /*
        Emp.RESET;
        Emp.SETRANGE(Departamento,"Cod. departamento");
        Emp.SETRANGE("Job Type Code",Codigo);
        IF Emp.FINDFIRST THEN
           ERROR(STRSUBSTNO(Err001,TABLECAPTION,Codigo));
        */

    end;

    trigger OnInsert()
    begin
        Emp.RESET;
        //TODO: Ver Emp.SETRANGE("Calcular Nomina", TRUE);
        Emp.SETRANGE(Status, Emp.Status::Active);
        IF Emp.FINDFIRST THEN BEGIN
            PerfSal.RESET;
            PerfSal.SETRANGE("No. empleado", Emp."No.");
            PerfSal.FINDSET;
            REPEAT
                PerfilSalarioxCargo.INIT;
                PerfilSalarioxCargo."Puesto de Trabajo" := Codigo;
                PerfilSalarioxCargo."Concepto salarial" := PerfSal."Concepto salarial";
                PerfilSalarioxCargo.Descripcion := PerfSal.Descripcion;
                PerfilSalarioxCargo."Tipo concepto" := PerfSal."Tipo concepto";
                PerfilSalarioxCargo."1ra Quincena" := PerfSal."1ra Quincena";
                PerfilSalarioxCargo."2da Quincena" := PerfSal."2da Quincena";
                IF PerfilSalarioxCargo.INSERT THEN;
            UNTIL PerfSal.NEXT = 0;
        END;
    end;

    var
        Emp: Record 5200;
        Err001: Label 'You can not delete %1 %2 because there are employees associated to it';
        PerfSal: Record 34002115;
        PerfilSalarioxCargo: Record 34002113;
        DimMgt: Codeunit 408;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Puestos laborales", Codigo, FieldNumber, ShortcutDimCode);
        MODIFY;
    end;
}

