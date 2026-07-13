page 67009 "Rutas - Distribucion Geo."
{
    DataCaptionFields = "Cod. Ruta", "Name of route";
    DelayedInsert = true;
    PageType = List;
    SourceTable = 67009;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Ruta"; "Cod. Ruta")
                {
                }
                field("Name of route"; "Name of route")
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field(County; County)
                {
                }
                field("Post Code"; "Post Code")
                {
                }
                field(City; City)
                {
                }
            }
        }
    }

    actions
    {
    }
}

