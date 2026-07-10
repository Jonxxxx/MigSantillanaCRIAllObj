tableextension 70000012 tableextension70000012 extends Location
{
    fields
    {
        modify("Directed Put-away and Pick")
        {
            Caption = 'Directed Put-away and Pick';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Cliente"(Field 50000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Sucursal"(Field 50001)".


        //Unsupported feature: Deletion (FieldCollection) on ""ID Interface SIC"(Field 50003)".


        //Unsupported feature: Deletion (FieldCollection) on ""Packing requerido"(Field 56000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cant. Lineas a Man. Por dia"(Field 56001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Aviso cuando resten"(Field 56002)".


        //Unsupported feature: Deletion (FieldCollection) on "Inactivo(Field 56012)".

        field(27026; "SAT State Code"; Code[10])
        {
            Caption = 'SAT State Code';
            TableRelation = "SAT State";
        }
        field(27027; "SAT Municipality Code"; Code[10])
        {
            Caption = 'SAT Municipality Code';
            TableRelation = "SAT Municipality" WHERE(State = FIELD(SAT State Code));
        }
        field(27028; "SAT Locality Code"; Code[10])
        {
            Caption = 'SAT Locality Code';
            TableRelation = "SAT Locality" WHERE(State = FIELD(SAT State Code));
        }
        field(27029; "SAT Suburb ID"; Integer)
        {
            Caption = 'SAT Suburb ID';
            TableRelation = "SAT Suburb";
        }
        field(27030; "ID Ubicacion"; Integer)
        {
            Caption = 'ID Ubicacion';
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "RequireShipment(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "RequirePicking(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "RequireReceive(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "RequirePutaway(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "GetLocationSetup(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetRequirementText(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "IsBWReceive(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "IsBWShip(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "IsBinBWReceiveOrShip(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "IsInTransit(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "GetLocationsIncludingUnspecifiedLocation(PROCEDURE 14)".


    procedure GetSATAddress() LocationAddress: Text
    var
        SATState Record: 27026;
        SATMunicipality Record: 27027;
        SATLocality Record: 27028;
        SATSuburb Record: 27029;
    begin
        IF SATState.GET("SAT State Code") THEN
            LocationAddress := SATState.Description;
        IF SATMunicipality.GET("SAT Municipality Code") THEN
            LocationAddress += ' ' + SATMunicipality.Description;
        IF SATLocality.GET("SAT Locality Code") THEN
            LocationAddress += ' ' + SATLocality.Description;
        IF SATSuburb.GET("SAT Suburb ID") THEN
            LocationAddress += ' ' + SATSuburb.Description;
    end;
}

