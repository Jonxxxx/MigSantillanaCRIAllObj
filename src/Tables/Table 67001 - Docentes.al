table 67001 Docentes
{
    Caption = 'Teacher';
    DataCaptionFields = "No.", "Full Name";
    DrillDownPageID = 67040;
    LookupPageID = 67040;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    APSSetup.GET;
                    NoSeriesMgt.TestManual(APSSetup."No. Serie Profesores");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "No. 2; Code[20])
        {
        }
        field(3; "Full Name"; Text[70])
        {
            Caption = 'Full Name';

            trigger OnValidate()
            begin
                "Full Name" := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name" + ' ' + "Second Last Name";
            end;
        }
        field(4; "Search Name"; Code[100])
        {
            Caption = 'Search Name';
        }
        field(5; "Name 2; Text[100])
        {
            Caption = 'Name 2';
        }
        field(6; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(7; "Address 2; Text[50])
        {
            Caption = 'Address 2';
        }
        field(8; City; Text[30])
        {
            Caption = 'City';

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(10; "Work No."; Text[30])
        {
            Caption = 'Telex No.';
        }
        field(11; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(12; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(13; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(14; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(15; Comment; Boolean)
        {
            CalcFormula = Exist("Rlshp. Mgt. Comment Line" WHERE(Table Name=CONST(Contact),
                                                                  No.=FIELD(No.),
                                                                  Sub No.=CONST(0)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16;"Last Date Modified";Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(17;"Fax No.";Text[30])
        {
            Caption = 'Fax No.';
        }
        field(18;"Telex Answer Back";Text[20])
        {
            Caption = 'Telex Answer Back';
        }
        field(19;"Document ID";Text[20])
        {
            Caption = 'Document ID';

            trigger OnValidate()
            var
                VATRegNoFormat Record: 381;
            begin
                IF "Document ID" <> '' THEN
                   BEGIN
                    Docente.RESET;
                    Docente.SETFILTER("No.",'<>%1',"No.");
                    Docente.SETRANGE("Tipo documento","Tipo documento");
                    Docente.SETRANGE("Document ID","Document ID");
                    IF Docente.FINDFIRST THEN
                       ERROR(Text034,FIELDCAPTION("Document ID"),"Document ID",TABLECAPTION,Docente."No.");
                   END;
            end;
        }
        field(20;Picture;BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(21;"Post Code";Code[20])
        {
            Caption = 'ZIP Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(22;County;Text[30])
        {
            Caption = 'State';
        }
        field(23;"E-Mail";Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(24;"Home Page";Text[80])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(25;Twitter;Text[30])
        {
            ExtendedDatatype = URL;
        }
        field(26;Facebook;Text[80])
        {
            ExtendedDatatype = URL;
        }
        field(27;"BB Pin";Text[10])
        {
        }
        field(28;"No. Series";Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(29;"Job Title";Text[60])
        {
            Caption = 'Job Title';
        }
        field(30;Initials;Text[30])
        {
            Caption = 'Initials';
        }
        field(31;"Extension No.";Text[30])
        {
            Caption = 'Extension No.';
        }
        field(32;"Mobile Phone No.";Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(33;Pager;Text[30])
        {
            Caption = 'Pager';
        }
        field(34;"Date Filter";Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(35;"External ID";Code[20])
        {
            Caption = 'External ID';
        }
        field(36;"Salesperson Filter";Code[10])
        {
            Caption = 'Salesperson Filter';
            Enabled = false;
            FieldClass = FlowFilter;
            TableRelation = "Salesperson/Purchaser";
        }
        field(37;"Campaign Filter";Code[20])
        {
            Caption = 'Campaign Filter';
            Enabled = false;
            FieldClass = FlowFilter;
            TableRelation = Campaign;
        }
        field(38;"Action Taken Filter";Option)
        {
            Caption = 'Action Taken Filter';
            Enabled = false;
            FieldClass = FlowFilter;
            OptionCaption = ' ,Next,Previous,Updated,Jumped,Won,Lost';
            OptionMembers = " ",Next,Previous,Updated,Jumped,Won,Lost;
        }
        field(39;"Sales Cycle Filter";Code[10])
        {
            Caption = 'Sales Cycle Filter';
            Enabled = false;
            FieldClass = FlowFilter;
            TableRelation = "Sales Cycle";
        }
        field(40;"Sales Cycle Stage Filter";Integer)
        {
            Caption = 'Sales Cycle Stage Filter';
            Enabled = false;
            FieldClass = FlowFilter;
            TableRelation = "Sales Cycle Stage".Stage WHERE (Sales Cycle Code=FIELD(Sales Cycle Filter));
        }
        field(41;"To-do Status Filter";Option)
        {
            Caption = 'To-do Status Filter';
            Enabled = false;
            FieldClass = FlowFilter;
            OptionCaption = 'Not Started,In Progress,Completed,Waiting,Postponed';
            OptionMembers = "Not Started","In Progress",Completed,Waiting,Postponed;
        }
        field(42;"To-do Closed Filter";Boolean)
        {
            Caption = 'To-do Closed Filter';
            Enabled = false;
            FieldClass = FlowFilter;
        }
        field(43;"Priority Filter";Option)
        {
            Caption = 'Priority Filter';
            Enabled = false;
            FieldClass = FlowFilter;
            OptionCaption = 'Low,Normal,High';
            OptionMembers = Low,Normal,High;
        }
        field(44;"Customer no.";Code[20])
        {
            Caption = 'Customer No.';
            FieldClass = FlowFilter;
            TableRelation = Customer;
        }
        field(45;"Correspondence Type";Option)
        {
            Caption = 'Correspondence Type';
            OptionCaption = ' ,Hard Copy,E-Mail,Fax';
            OptionMembers = " ","Hard Copy","E-Mail",Fax;
        }
        field(46;"Salutation Code";Code[10])
        {
            Caption = 'Salutation Code';
            TableRelation = Salutation;
        }
        field(47;"Search E-Mail";Code[100])
        {
            Caption = 'Search E-Mail';
        }
        field(48;"Last Time Modified";Time)
        {
            Caption = 'Last Time Modified';
        }
        field(49;"E-Mail 2;Text[80])
        {
            Caption = 'E-Mail 2';
            ExtendedDatatype = EMail;
        }
        field(50;"% Descuento Cupon";Decimal)
        {
            Caption = 'Coupon Discount %';
        }
        field(51;"Tipo de colegio";Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE ("Tipo registro"=CONST(Tipos de colegios));

            trigger OnValidate()
            begin
                DA.RESET;
                DA.SETRANGE("Tipo registro",DA."Tipo registro"::"Tipos de colegios");
                IF "Tipo de colegio" <> '' THEN
                   DA.SETRANGE(Codigo,"Tipo de colegio");

                DA.FINDFIRST;
            end;
        }
        field(52;"Nivel Escolar";Code[10])
        {
        }
        field(53;"Tipo educacion";Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE ("Tipo registro"=CONST(Tipo de educacion));

            trigger OnValidate()
            begin
                DA.RESET;
                DA.SETRANGE("Tipo registro",DA."Tipo registro"::"Tipo de educacion");
                IF "Tipo de colegio" <> '' THEN
                   DA.SETRANGE(Codigo,"Tipo de colegio");

                DA.FINDFIRST;
            end;
        }
        field(54;"Orden religiosa";Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE ("Tipo registro"=CONST(Orden religiosa));

            trigger OnValidate()
            begin
                DA.RESET;
                DA.SETRANGE("Tipo registro",DA."Tipo registro"::"Orden religiosa");
                IF "Orden religiosa" <> '' THEN
                   DA.SETRANGE(Codigo,"Orden religiosa");

                DA.FINDFIRST;
            end;
        }
        field(55;Bilingue;Boolean)
        {
        }
        field(56;"Sistema educativo";Code[10])
        {
        }
        field(57;Plan;Code[10])
        {
        }
        field(58;Sexo;Option)
        {
            Caption = 'Sex';
            OptionCaption = 'Female,Male';
            OptionMembers = Femenino,Masculino;
        }
        field(59;"Nivel Docente";Code[20])
        {
            Caption = 'Teacher''s level';
            TableRelation = "Nivel Educativo APS";
        }
        field(60;"Usuario Lectores en red";Boolean)
        {
        }
        field(61;"Recibe correos";Boolean)
        {
        }
        field(62;"Recibe llamadas";Boolean)
        {
        }
        field(63;"Recibe email";Boolean)
        {
        }
        field(64;Jubilado;Boolean)
        {
        }
        field(65;"Dia Nacimiento";Integer)
        {
            MaxValue = 31;
            MinValue = 1;
        }
        field(66;"Job Type Code";Code[20])
        {
            Caption = 'Job Type Code';
            TableRelation = "Datos auxiliares".Codigo WHERE ("Tipo registro"=CONST(Puestos de trabajo));

            trigger OnValidate()
            begin
                IF "Job Type Code" <>'' THEN
                   BEGIN
                    JobType.SETRANGE("Tipo registro",JobType."Tipo registro"::"Puestos de trabajo");
                    JobType.SETRANGE(Codigo,"Job Type Code");
                    JobType.FINDFIRST;
                    "Job Title" := JobType.Descripcion;
                   END;
            end;
        }
        field(67;"Pertenece al CDS";Boolean)
        {

            trigger OnValidate()
            begin
                IF "Pertenece al CDS" THEN
                   "Ult. fecha activacion" := TODAY;
            end;
        }
        field(68;"Mes Nacimiento";Integer)
        {
            MaxValue = 12;
            MinValue = 1;
        }
        field(69;"Ano Nacimiento";Integer)
        {
            Caption = 'Born year';
            MaxValue = 2450;
            MinValue = 1950;
        }
        field(70;"Ano inscripcion CDS";Code[4])
        {
            Caption = 'Subscription year CDS';
            Numeric = true;
        }
        field(71;"Cod. CDS";Code[20])
        {
        }
        field(76;Hijos;Boolean)
        {
        }
        field(77;"Frecuencia uso email";Option)
        {
            OptionMembers = Diario,"Fines de semana","Menos de una vez por semana";
        }
        field(78;"Nivel decision";Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE ("Tipo registro"=CONST(Nivel de decisi n));

            trigger OnValidate()
            begin
                IF "Nivel decision" <> '' THEN
                   BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro",DA."Tipo registro"::"Nivel de decisi n");
                    DA.SETRANGE(Codigo,"Nivel decision");
                    DA.FINDFIRST;
                   END;
            end;
        }
        field(79;"Envio correspondencia";Option)
        {
            OptionCaption = 'School,Self';
            OptionMembers = Colegio,Particular;
        }
        field(80;"Situacion general";Option)
        {
            OptionCaption = 'Active,Inactive';
            OptionMembers = Activo,Inactivo;
        }
        field(81;"Tipo documento";Code[20])
        {
            TableRelation = "Tipos de documentos personales";
        }
        field(82;"Tipo de contacto";Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE ("Tipo registro"=CONST(Tipos de contactos));

            trigger OnValidate()
            begin
                DA.RESET;
                DA.SETRANGE("Tipo registro",DA."Tipo registro"::"Tipos de contactos");
                DA.SETRANGE(Codigo,"Tipo de contacto");
                IF DA.FINDFIRST THEN
                   "Desc Tipo de contacto" := DA.Descripcion;
            end;
        }
        field(83;"Ult. fecha activacion";Date)
        {
        }
        field(84;"Se entrego carne";Boolean)
        {
            Caption = 'Carnet delivered';
        }
        field(85;"First Name";Text[30])
        {
            Caption = 'First Name';

            trigger OnValidate()
            begin
                VALIDATE("Full Name");
            end;
        }
        field(86;"Middle Name";Text[30])
        {
            Caption = 'Middle Name';

            trigger OnValidate()
            begin
                VALIDATE("Full Name");
            end;
        }
        field(87;"Last Name";Text[30])
        {
            Caption = 'Last Name';

            trigger OnValidate()
            begin
                VALIDATE("Full Name");
            end;
        }
        field(88;"Second Last Name";Text[30])
        {
            Caption = 'Second Last Name';

            trigger OnValidate()
            begin
                VALIDATE("Full Name");
            end;
        }
        field(89;Status;Option)
        {
            OptionCaption = ' ,Inactive';
            OptionMembers = " ",Inactivo;
        }
        field(90;"Desc Tipo de contacto";Text[60])
        {
            Caption = 'Type of contact description';
            Editable = false;
        }
        field(91;"Referencia Direccion";Text[100])
        {
        }
        field(92;"Cod. Proveedor";Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            var
                Vend Record: 23;
            begin
                IF "Cod. Proveedor" <> '' THEN
                   BEGIN
                    Vend.GET("Cod. Proveedor");
                    "Document ID" := Vend."VAT Registration No.";
                    "Full Name" := Vend.Name;
                    Address := Vend.Address;
                    "Address 2" := Vend."Address 2;
                    City := Vend.City;
                    "Phone No." := Vend."Phone No.";
                //    "Work No." := vend."Work No.";
                    "Territory Code" := Vend."Territory Code";
                    "Language Code" := Vend."Language Code";
                    "Country/Region Code" := Vend."Country/Region Code";
                    "Post Code" := Vend."Post Code";
                    County := Vend.County;
                    "E-Mail" := Vend."E-Mail";
                    "Home Page" := Vend."Home Page";
                //    "Extension No." := vend."Extension No.";
                //    "Mobile Phone No." := vend."Mobile Phone No.";
                    /*
                    VALIDATE("Distrito Code",Vend."Distrito Code");
                    VALIDATE(Departamento,Vend.Departamento);
                    VALIDATE(Distritos,Distritos);
                    VALIDATE(Provincia,Vend.Provincia);
                    */
                   END;

            end;
        }
        field(93;"Cod. Cliente";Code[20])
        {
            TableRelation = Customer;
        }
        field(94;Expositor;Boolean)
        {
        }
        field(95;"Usuario creaci n";Code[50])
        {
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
        key(Key2;"Full Name")
        {
        }
        key(Key3;Initials,"Job Title","No. 2")
        {
        }
        key(Key4;"Document ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"No.","Full Name","Document ID","Pertenece al CDS")
        {
        }
    }

    trigger OnDelete()
    var
        Todo Record: 5080;
        SegLine Record: 5077;
        ContIndustGrp Record: 5058;
        ContactWebSource Record: 5060;
        ContJobResp Record: 5067;
        ContMailingGrp Record: 5056;
        ContProfileAnswer Record: 5089;
        RMCommentLine Record: 5061;
        ContAltAddr Record: 5051;
        ContAltAddrDateRange Record: 5052;
        InteractLogEntry Record: 5065;
        Opp Record: 5092;
        CampaignTargetGrMgt: Codeunit 7030;
    begin
        //CreditCards.DeleteByContact(Rec);
        ColDoc.SETRANGE("Cod. Docente","No.");
        IF ColDoc.FINDFIRST THEN
           ERROR(STRSUBSTNO(Text035,ColDoc.TABLECAPTION));
    end;

    trigger OnInsert()
    begin
        APSSetup.GET;
        IF "No." = '' THEN BEGIN
          APSSetup.TESTFIELD("No. Serie Profesores");
          NoSeriesMgt.InitSeries(APSSetup."No. Serie Profesores",xRec."No. Series",0D,"No.","No. Series");
        END;
        "Ano inscripcion CDS" := FORMAT(APSSetup.Campana);

        "Usuario creaci n" := USERID;
    end;

    trigger OnModify()
    begin
        ColDocente.RESET;
        ColDocente.SETRANGE("Cod. Docente","No.");
        IF ColDocente.FINDSET(TRUE,FALSE) THEN
           REPEAT
            ColDocente."Nombre docente"   := "Full Name";
            ColDocente."Apellido paterno" := "Last Name";
            ColDocente."Pertenece al CDS" := "Pertenece al CDS";
            ColDocente.MODIFY;
           UNTIL ColDocente.NEXT = 0;
    end;

    var
        Text000: Label 'You cannot delete the %2 record of the %1 because there are one or more to-dos open.';
        Text001: Label 'You cannot delete the %2 record of the %1 because the contact is assigned one or more unlogged segments.';
        Text002: Label 'You cannot delete the %2 record of the %1 because one or more opportunities are in not started or progress.';
        Text003: Label '%1 cannot be changed because one or more interaction log entries are linked to the contact.';
        Text005: Label '%1 cannot be changed because one or more to-dos are linked to the contact.';
        Text006: Label '%1 cannot be changed because one or more opportunities are linked to the contact.';
        Text007: Label '%1 cannot be changed because there are one or more related people linked to the contact.';
        Text009: Label 'The %2 record of the %1 has been created.';
        Text010: Label 'The %2 record of the %1 is not linked with any other table.';
        APSSetup Record: 67000;
        Docente Record: 67001;
        JobType Record: 67002;
        PostCode Record: 225;
        ColDoc Record: 67043;
        RecRef: RecordRef;
        xRecRef: RecordRef;
        NoSeriesMgt: Codeunit 396;
        ChangeLogMgt: Codeunit 423;
        Text012: Label 'You cannot change %1 because one or more unlogged segments are assigned to the contact.';
        Text019: Label 'The %2 record of the %1 already has the %3 with %4 %5.';
        Text020: Label 'Do you want to create a contact %1 %2 as a customer using a customer template?';
        Text021: Label 'You have to set up formal and informal salutation formulas in %1  language for the %2 contact.';
        HideValidationDialog: Boolean;
        Text022: Label 'The creation of the customer has been aborted.';
        Text029: Label 'The total length of first name, middle name and surname is %1 character(s)longer than the maximum length allowed for the Name field.';
        Text032: Label 'The length of %1 is %2 character(s)longer than the maximum length allowed for the %1 field.';
        Text033: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        rRec: RecordRef;
        DA Record: 67002;
        Text034: Label 'There is al ready a %1 %2 associated with %3 %45';
        territory Record: 286;
        PostCodeRec Record: 225;
        PostCodeForm: Page367;
                          formTerritory: Page429;
                          RECcOUNTRY Record: 9;
                          ColDocente Record: 67043;
                          Text035: Label 'There are records associated with this Teacher, review them in% 1';

    procedure DisplayMap()
    var
        MapPoint Record: 800;
        MapMgt: Codeunit 802;
    begin
        IF MapPoint.FIND('-') THEN
          MapMgt.MakeSelection(DATABASE::Docentes,GETPOSITION)
        ELSE MESSAGE(Text033);
    end;

    procedure AssistEdit(OldCont Record: 67001"): Boolean
    begin
        WITH Docente DO BEGIN
          Docente := Rec;
          APSSetup.GET;
          APSSetup.TESTFIELD("No. Serie Profesores");
          IF NoSeriesMgt.SelectSeries(APSSetup."No. Serie Profesores",OldCont."No. Series","No. Series") THEN BEGIN
            APSSetup.GET;
            APSSetup.TESTFIELD("No. Serie Profesores");
            NoSeriesMgt.SetSeries("No.");
            Rec := Docente;
            EXIT(TRUE);
          END;
        END;
    end;

    procedure GetApellidosNombre(): Text[250]
    begin
        EXIT("Last Name"+' '+"Second Last Name"+', '+"First Name"+' '+"Middle Name");
    end;
}

