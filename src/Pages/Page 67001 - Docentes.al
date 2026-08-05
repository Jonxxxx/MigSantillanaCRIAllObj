page 55468 Docentes
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Teachers';
    PageType = Card;
    SourceTable = 55468;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                    Editable = false;
                }
                field("No. 2"; Rec."No. 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. 2';
                }
                field("Salutation Code"; Rec."Salutation Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Salutation Code';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full Name';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'First Name';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Middle Name';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Last Name';
                }
                field("Second Last Name"; Rec."Second Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Second Last Name';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Address';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Address 2';
                }
                field("Referencia Direccion"; Rec."Referencia Direccion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Referencia Direccion';
                }
                field("<Cod. pais/region>"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Country/Region Code';
                }
                field("Cod. Departamento"; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'County';
                    Caption = 'State';
                    Editable = true;
                }
                field("Cod Provincia"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Post Code';
                    Caption = 'Cod Provincia';
                }
                field("Cod Distrito"; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'City';
                    Caption = 'City';
                }
                field("Tipo documento"; Rec."Tipo documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo documento';
                }
                field("Document ID"; Rec."Document ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document ID';
                }
                field(Sexo; Rec.Sexo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sexo';
                }
                field(Hijos; Rec.Hijos)
                {
                    ApplicationArea = All;
                    ToolTip = 'Hijos';
                }
                field("Ano inscripcion CDS"; Rec."Ano inscripcion CDS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ano inscripcion CDS';
                }
                field("Dia Nacimiento"; Rec."Dia Nacimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dia Nacimiento';
                }
                field("Mes Nacimiento"; Rec."Mes Nacimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Mes Nacimiento';
                }
                field("Ano Nacimiento"; Rec."Ano Nacimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ano Nacimiento';
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                    ToolTip = 'Picture';
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                    ToolTip = 'Initials';
                }
                field("External ID"; Rec."External ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'External ID';
                }
                field("Customer no."; Rec."Customer no.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Customer no.';
                }
                field(Bilingue; Rec.Bilingue)
                {
                    ApplicationArea = All;
                    ToolTip = 'Bilingue';
                }
                field(Plan; Rec.Plan)
                {
                    ApplicationArea = All;
                    ToolTip = 'Plan';
                }
                field("Usuario Lectores en red"; Rec."Usuario Lectores en red")
                {
                    ApplicationArea = All;
                    ToolTip = 'Usuario Lectores en red';
                }
                field(Jubilado; Rec.Jubilado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Jubilado';
                }
                field("Nivel Docente"; Rec."Nivel Docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nivel Docente';
                }
                field("Pertenece al CDS"; Rec."Pertenece al CDS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pertenece al CDS';
                }
                field("Situacion general"; Rec."Situacion general")
                {
                    ApplicationArea = All;
                    ToolTip = 'Situacion general';
                }
                field("Tipo de contacto"; Rec."Tipo de contacto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de contacto';
                }
                field("Ult. fecha activacion"; Rec."Ult. fecha activacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ult. fecha activacion';
                }
                field("Se entrego carne"; Rec."Se entrego carne")
                {
                    ApplicationArea = All;
                    ToolTip = 'Se entrego carne';
                }
                field("Desc Tipo de contacto"; Rec."Desc Tipo de contacto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Desc Tipo de contacto';
                }
                field("Cod. Proveedor"; Rec."Cod. Proveedor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Proveedor';
                }
                field("Cod. Cliente"; Rec."Cod. Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cliente';
                }
                field(Expositor; Rec.Expositor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Expositor';
                }
                field("Usuario creacion"; Rec."Usuario creacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Usuario creacion';
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Recibe correos"; Rec."Recibe correos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Recibe correos';
                }
                field("Recibe llamadas"; Rec."Recibe llamadas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Recibe llamadas';
                }
                field("Recibe email"; Rec."Recibe email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Recibe email';
                }
                field("Correspondence Type"; Rec."Correspondence Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Correspondence Type';
                }
                field("Frecuencia uso email"; Rec."Frecuencia uso email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Frecuencia uso email';
                }
                field("Envio correspondencia"; Rec."Envio correspondencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Envio correspondencia';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Phone No.';
                    Importance = Promoted;
                }
                field("Work No."; Rec."Work No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Work No.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Mobile Phone No.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail';
                    Importance = Promoted;
                }
                field("E-Mail 2"; Rec."E-Mail 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail 2';
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = All;
                    ToolTip = 'Home Page';
                }
                field(Facebook; Rec.Facebook)
                {
                    ApplicationArea = All;
                    ToolTip = 'Facebook';
                }
                field(Twitter; Rec.Twitter)
                {
                    ApplicationArea = All;
                    ToolTip = 'Twitter';
                }
                field("BB Pin"; Rec."BB Pin")
                {
                    ApplicationArea = All;
                    ToolTip = 'BB Pin';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Teacher")
            {
                Caption = '&Teacher';
                action("&Customer's Card")
                {
                    ApplicationArea = All;
                    Caption = '&Customer''s Card';
                    ToolTip = '&Customer''s Card';
                    Image = EditCustomer;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 21;
                    RunPageLink = "No." = FIELD("No.");
                }
                action("&Vendor Card")
                {
                    ApplicationArea = All;
                    Caption = '&Vendor Card';
                    ToolTip = '&Vendor Card';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 26;
                    RunPageLink = "No." = FIELD("Cod. Proveedor");
                }

                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    ToolTip = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 124;
                    RunPageLink = "Table Name" = CONST(15),
                                  "No." = FIELD("No.");
                }

                action("&Schools")
                {
                    ApplicationArea = All;
                    Caption = '&Schools';
                    ToolTip = '&Schools';
                    Image = AddToHome;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55512;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
                action(Hobbies)
                {
                    ApplicationArea = All;
                    Caption = 'Hobbies';
                    ToolTip = 'Hobbies';
                    Image = BusinessRelation;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55525;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }

                action("&Specialities")
                {
                    ApplicationArea = All;
                    Caption = '&Specialities';
                    ToolTip = '&Specialities';
                    Image = Certificate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55530;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
                action("Workshop - Event")
                {
                    ApplicationArea = All;
                    Caption = 'Workshop - Event';
                    ToolTip = 'Workshop - Event';
                    Image = Workdays;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55567;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
            }
            action("&Exponent")
            {
                ApplicationArea = All;
                Caption = '&Exponent';
                ToolTip = '&Exponent';
                Image = ContactReference;
                RunObject = Page 55559;
                RunPageLink = "Cod. Expositor" = FIELD("Cod. Proveedor");
            }
            group("&Historics")
            {
                Caption = '&Historics';
                action("CDS History")
                {
                    ApplicationArea = All;
                    Caption = 'CDS History';
                    ToolTip = 'CDS History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 55572;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
                action("Teacher - Hobbies History")
                {
                    ApplicationArea = All;
                    Caption = 'Teacher - Hobbies History';
                    ToolTip = 'Teacher - Hobbies History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 55573;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
                action("Teacher - Specialties History")
                {
                    ApplicationArea = All;
                    Caption = 'Teacher - Specialties History';
                    ToolTip = 'Teacher - Specialties History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 55574;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
                action("School - Teacher History")
                {
                    ApplicationArea = All;
                    Caption = 'School - Teacher History';
                    ToolTip = 'School - Teacher History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 55575;
                }
            }
        }
        area(processing)
        {
            group("&Actions")
            {
                Caption = '&Actions';
                action("&Create as Customer")
                {
                    ApplicationArea = All;
                    Caption = '&Create as Customer';
                    ToolTip = '&Create as Customer';
                    Image = AddContacts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        IF Cust.GET("Customer no.") THEN
                            ERROR(Err001);

                        CLEAR(Cust);
                        Cust.INSERT(TRUE);
                        "Customer no." := Cust."No.";
                        Cust.VALIDATE(Name, "Full Name");
                        /*Peru
                        Cust.VALIDATE(Nombres,"First Name" + ' ' + "Name 2");
                        Cust.VALIDATE("Apellido Paterno","Last Name");
                        Cust.VALIDATE("Apellido Materno","Second Last Name");
                        */
                        Cust.Address := Address;
                        Cust."Address 2" := "Address 2";
                        Cust.City := City;
                        Cust."Territory Code" := "Territory Code";
                        Cust.Blocked := Cust.Blocked::All;
                        Cust."Phone No." := "Phone No.";
                        //Peru Cust.VALIDATE(DNI,"Document ID");
                        Cust.VALIDATE("Post Code", "Post Code");
                        Cust.County := County;
                        Cust."E-Mail" := "E-Mail";
                        Cust."Home Page" := "Home Page";
                        Cust.INSERT;

                        MESSAGE(Msg001);

                    end;
                }
            }
        }
    }

    var
        Err001: Label 'This Teacher is already created as Customer';
        Msg001: Label 'Teacher created as Customer, please, go to Customer''s card and complete the needed information';
        Cust: Record 18;
}

