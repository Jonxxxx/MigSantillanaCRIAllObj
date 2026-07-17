pageextension 50093 EXCCRIContactList extends "Contact List"
{
    layout
    {
        addafter(Name)
        {
            field(EXCCRIColegioSIC; Rec."Colegio SIC")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Colegio SIC value for the contact.';
            }
            field(EXCCRIAddress2; Rec."Address 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Address 2 value for the contact.';
            }
            field(EXCCRICity; Rec.City)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the City value for the contact.';
            }
            field(EXCCRIFechaDecision; Rec."Fecha decision")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Fecha decision value for the contact.';
            }
            field(EXCCRICounty; Rec.County)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the County value for the contact.';
            }
            field(EXCCRITipoDeColegio; Rec."Tipo de colegio")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Tipo de colegio value for the contact.';
            }
            field(EXCCRISamplesLocationCode; Rec."Samples Location Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Samples Location Code value for the contact.';
            }
            field(EXCCRIRuta; Rec.Ruta)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Ruta value for the contact.';
            }
        }
    }

    actions
    {
        addlast(Navigation)
        {
            group(EXCCRISchool)
            {
                Caption = 'School';

                action(EXCCRILocations)
                {
                    ApplicationArea = All;
                    Caption = 'Locations';
                    RunObject = Page 5056;
                    RunPageLink = "Contact No." = field("No.");
                    ToolTip = 'Opens the location cards associated with the school.';
                }
                action(EXCCRITeachers)
                {
                    ApplicationArea = All;
                    Caption = 'Teachers';
                    RunObject = Page 67045;
                    RunPageLink = "Cod. Colegio" = field("No.");
                    ToolTip = 'Opens the teachers associated with the school.';
                }
                action(EXCCRIGrades)
                {
                    ApplicationArea = All;
                    Caption = 'Grades';
                    RunObject = Page 67037;
                    RunPageLink = "Cod. Colegio" = field("No.");
                    ToolTip = 'Opens the grades associated with the school.';
                }
                action(EXCCRILevels)
                {
                    ApplicationArea = All;
                    Caption = 'Levels';
                    RunObject = Page 67036;
                    RunPageLink =
                        "Cod. Colegio" = field("No."),
                        City = field(City),
                        County = field(County),
                        "Post Code" = field("Post Code");
                    ToolTip = 'Opens the levels associated with the school.';
                }
                action(EXCCRISubjects)
                {
                    ApplicationArea = All;
                    Caption = 'Subjects';
                    RunObject = Page 67046;
                    RunPageLink = "Codigo Colegio" = field("No.");
                    ToolTip = 'Opens the subjects associated with the school.';
                }
                action(EXCCRIAdoptions)
                {
                    ApplicationArea = All;
                    Caption = 'Adoptions';
                    RunObject = Page 67026;
                    RunPageLink = "Cod. Editorial" = field("No.");
                    ToolTip = 'Opens the adoption records associated with the school.';
                }
                action(EXCCRIGifts)
                {
                    ApplicationArea = All;
                    Caption = 'Gifts';
                    RunObject = Page 67030;
                    RunPageLink = "Cod. Colegio" = field("No.");
                    ToolTip = 'Opens the gifts associated with the school.';
                }
                action(EXCCRIParents)
                {
                    ApplicationArea = All;
                    Caption = 'Parents';
                    RunObject = Page 67049;
                    RunPageLink = "Home Page" = field("No.");
                    ToolTip = 'Opens the parent records associated with the school.';
                }
                action(EXCCRIStudents)
                {
                    ApplicationArea = All;
                    Caption = 'Students';
                    RunObject = Page 67020;
                    RunPageLink = "Cod. Colegio" = field("No.");
                    ToolTip = 'Opens the students associated with the school.';
                }
                action(EXCCRIJobStructure)
                {
                    ApplicationArea = All;
                    Caption = 'Job Structure';
                    RunObject = Page 67067;
                    RunPageLink = "Cod. Colegio" = field("No.");
                    ToolTip = 'Opens the job structure associated with the school.';
                }
                action(EXCCRISalespersons)
                {
                    ApplicationArea = All;
                    Caption = 'Salespersons';
                    RunObject = Page 51010;
                    RunPageLink = "Cod. Colegio" = field("No.");
                    ToolTip = 'Opens the salespersons associated with the school.';
                }
            }
        }
    }
}
