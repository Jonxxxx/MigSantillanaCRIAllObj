tableextension 70000043 tableextension70000043 extends "Default Dimension" 
{
    fields
    {
        modify("Dimension Value Code")
        {
            TableRelation = "Dimension Value".Code WHERE (Dimension Code=FIELD(Dimension Code));
        }
    }

    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GLSetup.GET;
        IF "Dimension Code" = GLSetup."Global Dimension 1 Code" THEN
          UpdateGlobalDimCode(1,"Table ID","No.",'');
        IF "Dimension Code" = GLSetup."Global Dimension 2 Code" THEN
          UpdateGlobalDimCode(2,"Table ID","No.",'');
        DimMgt.DefaultDimOnDelete(Rec);

        cFunMdm.GetDimEditable(Rec, TRUE); // MdM
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GLSetup.GET;
        IF "Dimension Code" = GLSetup."Global Dimension 1 Code" THEN
          UpdateGlobalDimCode(1,"Table ID","No.","Dimension Value Code");
        IF "Dimension Code" = GLSetup."Global Dimension 2 Code" THEN
          UpdateGlobalDimCode(2,"Table ID","No.","Dimension Value Code");
        DimMgt.DefaultDimOnInsert(Rec);
        UpdateParentId;

        //+MdE
        IF NOT FromMdE THEN
          InfCompMdE.HorariosCeco(Rec);
        //-MdE

        cFunMdm.GetDimEditable(Rec, TRUE); // MdM
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
        */
    //end;


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GLSetup.GET;
        IF "Dimension Code" = GLSetup."Global Dimension 1 Code" THEN
          UpdateGlobalDimCode(1,"Table ID","No.","Dimension Value Code");
        IF "Dimension Code" = GLSetup."Global Dimension 2 Code" THEN
          UpdateGlobalDimCode(2,"Table ID","No.","Dimension Value Code");
        DimMgt.DefaultDimOnModify(Rec);

        //+MdE
        IF NOT FromMdE THEN
          IF "Dimension Value Code" <> xRec."Dimension Value Code" THEN
            InfCompMdE.HorariosCeco(Rec);
        //-MdE

        cFunMdm.GetDimEditable(Rec, TRUE); // MdM
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetCaption(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateGlobalDimCode(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateReferencedIds(PROCEDURE 13)".

}

