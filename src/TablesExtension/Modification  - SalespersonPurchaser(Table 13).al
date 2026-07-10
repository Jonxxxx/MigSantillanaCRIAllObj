tableextension 70000011 tableextension70000011 extends "Salesperson/Purchaser" 
{
    fields
    {
        modify("Global Dimension 1 Code")
        {
            Caption = 'Global Dimension 1 Code';
        }
        modify("Global Dimension 2 Code")
        {
            Caption = 'Global Dimension 2 Code';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""No vendedor SIC"(Field 50001)".


        //Unsupported feature: Deletion (FieldCollection) on "Collector(Field 56000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Home Page"(Field 62000)".


        //Unsupported feature: Deletion (FieldCollection) on "Twitter(Field 62001)".


        //Unsupported feature: Deletion (FieldCollection) on "Facebook(Field 62002)".


        //Unsupported feature: Deletion (FieldCollection) on ""BB Pin"(Field 62003)".


        //Unsupported feature: Deletion (FieldCollection) on "Vehicle(Field 62004)".


        //Unsupported feature: Deletion (FieldCollection) on "Tipo(Field 62005)".


        //Unsupported feature: Deletion (FieldCollection) on "Ruta(Field 62006)".


        //Unsupported feature: Deletion (FieldCollection) on ""Location code"(Field 67000)".


        //Unsupported feature: Deletion (FieldCollection) on "Status(Field 67001)".

    }

    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        VALIDATE(Code);
        DimMgt.UpdateDefaultDim(
          DATABASE::"Salesperson/Purchaser",Code,
          "Global Dimension 1 Code","Global Dimension 2 Code");

        //001+
        ConfSantillana.GET;
        IF "No vendedor SIC" = '' THEN BEGIN
          "No vendedor SIC":=NoSeriesManagement.GetNextNo(ConfSantillana."Serie Vendedor SIC",WORKDATE,TRUE);
        END;
        //001-
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CreateInteraction(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "GetPrivacyBlockedTransactionText(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "GetPrivacyBlockedGenericText(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "VerifySalesPersonPurchaserPrivacyBlocked(PROCEDURE 1)".



    //Unsupported feature: Property Modification (TextConstString) on "CannotDeleteBecauseActiveTasksErr(Variable 1007)".

    //var
        //>>>> ORIGINAL VALUE:
        //CannotDeleteBecauseActiveTasksErr : @@@="%1 = Salesperson/Purchaser code.";ENU=You cannot delete the salesperson/purchaser with code %1 because it has open tasks.;ESM=No puede eliminar el vendedor o comprador con código %1 porque tiene tareas abiertas.;FRC=Vous ne pouvez pas supprimer le représentant/l'acheteur portant le code %1, car il a des tâches en cours.;ENC=You cannot delete the salesperson/purchaser with code %1 because it has open tasks.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CannotDeleteBecauseActiveTasksErr : @@@="%1 = Salesperson/Purchaser code.";ENU=You cannot delete the salesperson/purchaser with code %1 because it has open tasks.;ESM=No puede eliminar el vendedor o comprador con código %1 porque tiene tareas abiertas.;FRC=Vous ne pouvez pas supprimer le représentant/l'acheteur avec le code %1, car il a des tâches ouvertes.;ENC=You cannot delete the salesperson/purchaser with code %1 because it has open tasks.;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "CannotDeleteBecauseActiveOpportunitiesErr(Variable 1008)".

    //var
        //>>>> ORIGINAL VALUE:
        //CannotDeleteBecauseActiveOpportunitiesErr : @@@="%1 = Salesperson/Purchaser code.";ENU=You cannot delete the salesperson/purchaser with code %1 because it has open opportunities.;ESM=No se puede eliminar el comercial o el comprador con el código %1, ya que tiene oportunidades pendientes.;FRC=Vous ne pouvez pas supprimer le représentant/l'acheteur portant le code %1, car il a des opportunités ouvertes.;ENC=You cannot delete the salesperson/purchaser with code %1 because it has open opportunities.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CannotDeleteBecauseActiveOpportunitiesErr : @@@="%1 = Salesperson/Purchaser code.";ENU=You cannot delete the salesperson/purchaser with code %1 because it has open opportunities.;ESM=No puede eliminar el comercial o el comprador con el código %1, ya que tiene oportunidades pendientes.;FRC=Vous ne pouvez pas supprimer le représentant/l'acheteur portant le code %1, car il a des opportunités ouvertes.;ENC=You cannot delete the salesperson/purchaser with code %1 because it has open opportunities.;
        //Variable type has not been exported.
}

