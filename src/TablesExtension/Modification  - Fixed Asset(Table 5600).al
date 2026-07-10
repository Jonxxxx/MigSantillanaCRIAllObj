tableextension 70000071 tableextension70000071 extends "Fixed Asset" 
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Description 2"(Field 4)".

        modify("Global Dimension 1 Code")
        {
            Caption = 'Global Dimension 1 Code';
        }
        modify("Global Dimension 2 Code")
        {
            Caption = 'Global Dimension 2 Code';
        }

        //Unsupported feature: Deletion on ""Responsible Employee"(Field 16).OnValidate".


        //Unsupported feature: Deletion on "Blocked(Field 21).OnValidate".


        //Unsupported feature: Property Deletion (Description) on "Blocked(Field 21)".


        //Unsupported feature: Deletion on "Inactive(Field 26).OnValidate".


        //Unsupported feature: Deletion (FieldCollection) on "Producto(Field 50000)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Placa"(Field 50001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Total Costo"(Field 50002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Total Amortizacion"(Field 50003)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nombre Responsable"(Field 50005)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha Inicio Amortizacion"(Field 50006)".


        //Unsupported feature: Deletion (FieldCollection) on ""Descripción Producto Ref."(Field 50007)".

        field(10001;"Vehicle Licence Plate";Code[10])
        {
            Caption = 'Vehicle License Plate';
        }
        field(10002;"Vehicle Year";Integer)
        {
            Caption = 'Vehicle Year';
        }
        field(10004;"SAT Federal Autotransport";Code[10])
        {
            Caption = 'SAT Federal Autotransport';
            TableRelation = "SAT Federal Motor Transport";
        }
        field(10005;"SAT Trailer Type";Code[10])
        {
            Caption = 'SAT Trailer Type';
            TableRelation = "SAT Trailer Type";
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "FieldsForAcquitionInGeneralGroupAreCompleted(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "ShowAcquireWizardNotification(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetNotificationID(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "SetNotificationDefaultState(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "DontNotifyCurrentUserAgain(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "RecallNotificationForCurrentUser(PROCEDURE 9)".

}

