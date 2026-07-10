page 67001 Docentes
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Teachers';
    PageType = Card;
    SourceTable = Table67001;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Editable = false;
                }
                field("No. 2; "No. 2")
                {
                }
                field("Salutation Code"; "Salutation Code")
                {
                }
                field("Full Name"; "Full Name")
                {
                }
                field("First Name"; "First Name")
                {
                }
                field("Middle Name"; "Middle Name")
                {
                }
                field("Last Name"; "Last Name")
                {
                }
                field("Second Last Name"; "Second Last Name")
                {
                }
                field(Address; Address)
                {
                }
                field("Address 2; "Address 2")
                {
                }
                field("Referencia Direccion"; "Referencia Direccion")
                {
                }
                field("<Cód. país/región>"; "Country/Region Code")
                {
                }
                field("Cód. Departamento"; County)
                {
                    Caption = 'State';
                    Editable = true;
                }
                field("Cód Provincia"; "Post Code")
                {
                    Caption = 'Cód Provincia';
                }
                field("Cód Distrito"; City)
                {
                    Caption = 'City';
                }
                field("Tipo documento"; "Tipo documento")
                {
                }
                field("Document ID"; "Document ID")
                {
                }
                field(Sexo; Sexo)
                {
                }
                field(Hijos; Hijos)
                {
                }
                field("Ano inscripcion CDS"; "Ano inscripcion CDS")
                {
                }
                field("Dia Nacimiento"; "Dia Nacimiento")
                {
                }
                field("Mes Nacimiento"; "Mes Nacimiento")
                {
                }
                field("Ano Nacimiento"; "Ano Nacimiento")
                {
                }
                field(Picture; Picture)
                {
                }
                field(Initials; Initials)
                {
                }
                field("External ID"; "External ID")
                {
                }
                field("Customer no."; "Customer no.")
                {
                }
                field(Bilingue; Bilingue)
                {
                }
                field(Plan; Plan)
                {
                }
                field("Usuario Lectores en red"; "Usuario Lectores en red")
                {
                }
                field(Jubilado; Jubilado)
                {
                }
                field("Nivel Docente"; "Nivel Docente")
                {
                }
                field("Pertenece al CDS"; "Pertenece al CDS")
                {
                }
                field("Situacion general"; "Situacion general")
                {
                }
                field("Tipo de contacto"; "Tipo de contacto")
                {
                }
                field("Ult. fecha activacion"; "Ult. fecha activacion")
                {
                }
                field("Se entrego carne"; "Se entrego carne")
                {
                }
                field("Desc Tipo de contacto"; "Desc Tipo de contacto")
                {
                }
                field("Cod. Proveedor"; "Cod. Proveedor")
                {
                }
                field("Cod. Cliente"; "Cod. Cliente")
                {
                }
                field(Expositor; Expositor)
                {
                }
                field("Usuario creación"; "Usuario creación")
                {
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Recibe correos"; "Recibe correos")
                {
                }
                field("Recibe llamadas"; "Recibe llamadas")
                {
                }
                field("Recibe email"; "Recibe email")
                {
                }
                field("Correspondence Type"; "Correspondence Type")
                {
                }
                field("Frecuencia uso email"; "Frecuencia uso email")
                {
                }
                field("Envio correspondencia"; "Envio correspondencia")
                {
                }
                field("Phone No."; "Phone No.")
                {
                    Importance = Promoted;
                }
                field("Work No."; "Work No.")
                {
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                }
                field("E-Mail"; "E-Mail")
                {
                    Importance = Promoted;
                }
                field("E-Mail 2; "E-Mail 2")
                {
                }
                field("Home Page"; "Home Page")
                {
                }
                field(Facebook; Facebook)
                {
                }
                field(Twitter; Twitter)
                {
                }
                field("BB Pin"; "BB Pin")
                {
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
                    Caption = '&Customer''s Card';
                    Image = EditCustomer;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 21;
                                    RunPageLink = No.=FIELD(No.);
                }
                action("&Vendor Card")
                {
                    Caption = '&Vendor Card';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 26;
                                    RunPageLink = No.=FIELD(Cod. Proveedor);
                }
                separator()
                {
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 124;
                                    RunPageLink = Table Name=CONST(15),
                                  No.=FIELD(No.);
                }
                separator()
                {
                }
                action("&Schools")
                {
                    Caption = '&Schools';
                    Image = AddToHome;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67045;
                                    RunPageLink = Cod. Docente=FIELD(No.);
                }
                action(Hobbies)
                {
                    Caption = 'Hobbies';
                    Image = BusinessRelation;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67058;
                                    RunPageLink = Cod. Docente=FIELD(No.);
                }
                separator()
                {
                }
                action("&Specialities")
                {
                    Caption = '&Specialities';
                    Image = Certificate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67063;
                                    RunPageLink = Cod. Docente=FIELD(No.);
                }
                action("Workshop - Event")
                {
                    Caption = 'Workshop - Event';
                    Image = Workdays;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67108;
                                    RunPageLink = Cod. Docente=FIELD(No.);
                }
            }
            action("&Exponent")
            {
                Caption = '&Exponent';
                Image = ContactReference;
                RunObject = Page 67100;
                                RunPageLink = Cod. Expositor=FIELD(Cod. Proveedor);
            }
            group("&Historics")
            {
                Caption = '&Historics';
                action("CDS History")
                {
                    Caption = 'CDS History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67113;
                                    RunPageLink = Cod. Docente=FIELD(No.);
                }
                action("Teacher - Hobbies History")
                {
                    Caption = 'Teacher - Hobbies History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67114;
                                    RunPageLink = Cod. Docente=FIELD(No.);
                }
                action("Teacher - Specialties History")
                {
                    Caption = 'Teacher - Specialties History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67115;
                                    RunPageLink = Cod. Docente=FIELD(No.);
                }
                action("School - Teacher History")
                {
                    Caption = 'School - Teacher History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67116;
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
                    Caption = '&Create as Customer';
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
                        Cust.VALIDATE(Name,"Full Name");
                        /*Peru
                        Cust.VALIDATE(Nombres,"First Name" + ' ' + "Name 2");
                        Cust.VALIDATE("Apellido Paterno","Last Name");
                        Cust.VALIDATE("Apellido Materno","Second Last Name");
                        */
                        Cust.Address := Address;
                        Cust."Address 2" := "Address 2;
                        Cust.City := City;
                        Cust."Territory Code" := "Territory Code";
                        Cust.Blocked := Cust.Blocked::All;
                        Cust."Phone No." := "Phone No.";
                        //Peru Cust.VALIDATE(DNI,"Document ID");
                        Cust.VALIDATE("Post Code","Post Code");
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

