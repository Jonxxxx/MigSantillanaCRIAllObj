table 55800 "Hist. Acciones de personal"
{
    Caption = 'Posted Personnel activities';
    DrillDownPageID = 55811;
    LookupPageID = 55811;

    fields
    {
        field(1; "Tipo de accion"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de accion';
            OptionCaption = ' ,Ingreso,Cambio,Salida';
            OptionMembers = " ",Ingreso,Cambio,Salida;
        }
        field(2; "Cod. accion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. accion';
            TableRelation = "Tipos de acciones personal".Codigo WHERE("Tipo de accion" = FIELD("Tipo de accion"));
        }
        field(3; "No. empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. empleado';
        }
        field(4; "Nombre completo"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre completo';
            Editable = false;
        }
        field(5; "ID Documento"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'ID Documento';

            trigger OnValidate()
            var
                Empresas: Record 2000000006;
            begin
            end;
        }
        field(6; "Descripcion accion"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion accion';
            Editable = false;
        }
        field(7; "Fecha accion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha accion';
            Editable = false;
        }
        field(8; "Fecha efectividad"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha efectividad';
        }
        field(9; Comentario; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentario';
        }
        field(10; "Cargo actual"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cargo actual';
            Editable = false;
            TableRelation = "Puestos laborales".Codigo WHERE("Cod. departamento" = FIELD("Departamento actual"));
        }
        field(11; "Descripcion cargo actual"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion cargo actual';
            Editable = false;
        }
        field(12; "Nuevo cargo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Nuevo cargo';
            TableRelation = "Puestos laborales".Codigo WHERE("Cod. departamento" = FIELD("Departamento nuevo"));
        }
        field(13; "Descripcion cargo nuevo"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion cargo nuevo';
            Editable = false;
        }
        field(14; "Sueldo actual"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Sueldo actual';
            Editable = false;
        }
        field(15; "Sueldo Nuevo"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Sueldo Nuevo';
        }
        field(16; "Departamento actual"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Departamento actual';
            Editable = false;
        }
        field(17; "Nombre  depto. actual"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre  depto. actual';
            Editable = false;
        }
        field(18; "Departamento nuevo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Departamento nuevo';
            TableRelation = Departamentos WHERE(Inhabilitado = CONST(False));
        }
        field(19; "Nombre depto. nuevo"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre depto. nuevo';
            Editable = false;
        }
        field(20; "Ubicacion actual"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ubicacion actual';
            Editable = false;
            TableRelation = "Centros de Trabajo"."Centro de trabajo";
        }
        field(21; "Ubicacion nueva"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ubicacion nueva';
            TableRelation = "Centros de Trabajo"."Centro de trabajo";
        }
        field(22; "Empresa nueva"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Empresa nueva';
            TableRelation = Company;
        }
        field(23; "Numero cuenta actual"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Numero cuenta actual';
            Editable = false;
        }
        field(24; "Numero cuenta nueva"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Numero cuenta nueva';
        }
        field(25; "Nivel actual"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Nivel actual';
            Editable = false;
        }
        field(26; "Nivel nuevo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Nivel nuevo';
            Editable = false;
        }
        field(27; "Tipo de contrato"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de contrato';
            TableRelation = "Employment Contract";
        }
        field(28; "Preparado por"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparado por';
            Editable = false;
            TableRelation = "User Setup";
        }
        field(29; "Revisado por"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Revisado por';
            Editable = false;
            TableRelation = "User Setup";
        }
        field(30; "Autorizado por"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Autorizado por';
            Editable = false;
            TableRelation = "User Setup";
        }
        field(31; "No. serie"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie';
        }
        field(32; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(33; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
            OptionCaption = 'SS,Passport,Residence ID,Work Permission';
            OptionMembers = "Cédula",Pasaporte,"Tarj.residen.comunitario","Perm.Trabajo",,"N.I.Extranjero","N.I.F.";
        }
        field(34; Preaviso; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Preaviso';
        }
        field(35; Cesantia; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cesantia';
        }
        field(36; Regalia; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Regalia';
        }
        field(37; "Duracion contrato"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Duracion contrato';
        }
        field(38; "First Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';
        }
        field(39; "Middle Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Middle Name';
        }
        field(40; "Last Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name';
        }
        field(41; "Second Last Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Second Last Name';
        }
        field(42; "Cod. elegible"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. elegible';
        }
        field(43; Address; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(44; "Address 2"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Address 2';
        }
        field(45; City; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';
        }
        field(46; "Post Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(47; County; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'County';
        }
        field(48; "Country/Region Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(49; "URL Linkedin"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'URL Linkedin';
        }
        field(50; "URL Facebook"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'URL Facebook';
        }
        field(51; Gender; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Gender';
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(52; "Lugar nacimiento"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Lugar nacimiento';
        }
        field(53; "Estado civil"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Estado civil';
            Description = 'Soltero/a,Casado/a,Viudo/a,Separado/a,Divorciado/a';
            OptionMembers = "Soltero/a","Casado/a","Viudo/a","Separado/a","Divorciado/a";
        }
        field(54; "Comentario 2"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentario 2';
        }
        field(56; "Cod. Banco"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Banco';
            TableRelation = "Bancos ACH Nomina";
        }
        field(57; "Fecha expiracion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha expiracion';
        }
        field(58; "Numero tarjeta"; Code[16])
        {
            DataClassification = CustomerContent;
            Caption = 'Numero tarjeta';
        }
        field(59; "Importe tarjeta"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe tarjeta';
        }
        field(60; "Banco tarjeta"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Banco tarjeta';
            TableRelation = "Bancos ACH Nomina";
        }
        field(61; "Cod. Supervisor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Supervisor';
            TableRelation = Employee;
        }
        field(62; "Nombre Supervisor"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Supervisor';
        }
        field(63; "Fecha de inicio"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha de inicio';
        }
        field(64; "Fecha final"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha final';
        }
        field(65; "Cause of Inactivity Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Cause of Inactivity";
        }
        field(66; "Tipo de miembro"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de miembro';
            Description = 'Cooperativa';
            OptionCaption = 'Member, Partner';
            OptionMembers = Miembro,Socio;
        }
        field(67; "1ra Quincena"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '1ra Quincena';
            Description = 'Cooperativa';
        }
        field(68; "2da Quincena"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '2da Quincena';
            Description = 'Cooperativa';
        }
        field(69; "Fecha inscripcion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha inscripcion';
            Description = 'Cooperativa';
        }
        field(70; "Tipo de aporte"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de aporte';
            Description = 'Cooperativa';
            OptionCaption = 'Fix,Percentage';
            OptionMembers = Fijo,Porcentual;
        }
        field(71; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
            Description = 'Cooperativa';
        }
        field(72; "Proximo no. empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Proximo no. empleado';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Tipo de accion", "Cod. accion")
        {
        }
    }

    trigger OnDelete()
    begin
        ERROR(Err002);
    end;

    var
        HumanResSetup: Record 5218;
        Contrato: Record 55750;
        Err001: Label 'You can''t void/delete a type of contract assigned to an employee';
        Emp: Record 5200;
        Cand: Record 55805;
        AccP: Record 55755;
        Cargos: Record 55751;
        NivelesCargos: Record 55761;
        NivelCargo: Page 55807;
        Depto: Record 55776;
        Empresas: Record 2000000006;
        Autorizacion: Record 55795;
        Err002: Label 'Document can not be deleted';
        NoSeriesMgt: Codeunit "No. Series";
        Err003: Label 'The %1 already exist for the %2 %3 in %4 %5';
        FuncNominas: Codeunit 55745;
        Err004: Label '$1 is invalid, please verify';
}

