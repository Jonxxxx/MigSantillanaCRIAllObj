table 64824 "Replicator Group"
{
    //TODO: Page no existe DrillDownPageID = 64824;
    //TODO: Page no existe LookupPageID = 64824;

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(5; Description; Text[80])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Specification.SETCURRENTKEY("Replicator Group Code");
        Specification.SETRANGE("Replicator Group Code", Code);
        IF Specification.FIND('-') THEN
            ERROR('This %1 is used on %2 %3.',
              FIELDNAME(Code), Specification.TABLENAME, Specification."No.");
        Scheduler.SETRANGE("Replicator Group Code", Code);
        IF Scheduler.FIND('-') THEN
            ERROR('This %1 is used on %2 %3.',
              FIELDNAME(Code), Scheduler.TABLENAME, Scheduler."No.");
    end;

    trigger OnInsert()
    begin
        IF Code = 'DESIGN' THEN
            ERROR('The Name "Design" is a reserved group name.');
        IF Code = 'SCHEDULER' THEN
            ERROR('The Name "Scheduler" is a reserved group name.');
    end;

    var
        Specification: Record 64822;
        Scheduler: Record 64833;
}

