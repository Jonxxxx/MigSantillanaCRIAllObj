page 67134 "Colegio - Work Flow Programado"
{
    AutoSplitKey = true;
    Caption = 'School - programming Work flow';
    DelayedInsert = true;
    PageType = ListPlus;
    SourceTable = 67062;
    SourceTableView = WHERE("Programado" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Colegio"; "Cod. Colegio")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Programado; Programado)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        [InDataSet]
        wEdit: Boolean;
}

