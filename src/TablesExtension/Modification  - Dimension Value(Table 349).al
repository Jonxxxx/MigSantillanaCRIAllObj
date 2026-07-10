tableextension 70000042 tableextension70000042 extends "Dimension Value" 
{
    fields
    {

        //Unsupported feature: Deletion (FieldCollection) on ""Fecha desde recep. devol."(Field 51000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha hasta recep. devol."(Field 51001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha creacion"(Field 56000)".

    }

    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF CheckIfDimValueUsed THEN
          ERROR(Text000,GetCheckDimErr);

        #4..20
        AnalysisSelectedDim.SETRANGE("Dimension Code","Dimension Code");
        AnalysisSelectedDim.SETRANGE("New Dimension Value Code",Code);
        AnalysisSelectedDim.DELETEALL(TRUE);

        InfCompMdE.Ceco(Rec,Rec,InfCompMdE.CeCoTipoDelete()); //+MdE
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..23
        */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD("Dimension Code");
        TESTFIELD(Code);
        "Global Dimension No." := GetGlobalDimensionNo;
        #4..6
          CostAccMgt.UpdateCostObjectFromDim(Rec,Rec,0);
        END;


        InfCompMdE.Ceco(Rec,Rec,InfCompMdE.CeCoTipoInsert()); //+MdE

        SetLastModifiedDateTime;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
        SetLastModifiedDateTime;
        */
    //end;


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Dimension Code" <> xRec."Dimension Code" THEN
          "Global Dimension No." := GetGlobalDimensionNo;
        IF CostAccSetup.GET THEN BEGIN
          CostAccMgt.UpdateCostCenterFromDim(Rec,xRec,1);
          CostAccMgt.UpdateCostObjectFromDim(Rec,xRec,1);
        END;

        InfCompMdE.Ceco(Rec,xRec,InfCompMdE.CeCoTipoModify()); //+MdE

        SetLastModifiedDateTime;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
        SetLastModifiedDateTime;
        */
    //end;


    //Unsupported feature: Code Modification on "OnRename".

    //trigger OnRename()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RenameBudgEntryDim;
        RenameAnalysisViewEntryDim;
        RenameItemBudgEntryDim;
        #4..7
          CostAccMgt.UpdateCostObjectFromDim(Rec,xRec,3);
        END;

        InfCompMdE.Ceco(Rec,xRec,InfCompMdE.CeCoTipoRename()); //+MdE

        SetLastModifiedDateTime;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..10
        SetLastModifiedDateTime;
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CheckIfDimValueUsed(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "LookUpDimFilter(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "LookupDimValue(PROCEDURE 24)".

}

