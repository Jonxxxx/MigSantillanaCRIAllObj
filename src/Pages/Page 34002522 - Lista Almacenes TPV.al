page 55916 "Lista Almacenes TPV"
{
    Caption = 'Location List';
    CardPageID = "Location Card";
    Editable = false;
    PageType = List;
    SourceTable = 14;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Name';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Location")
            {
                Caption = '&Location';
                Image = Warehouse;
                action("Dimensiones Defecto ")
                {
                    ApplicationArea = All;
                    Caption = '&Dimensiones Defecto';
                    ToolTip = '&Dimensiones Defecto';
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 55913;
                    RunPageLink = "Cod. Almacen" = FIELD(Code);
                }

                action("&Zones")
                {
                    ApplicationArea = All;
                    Caption = '&Zones';
                    ToolTip = '&Zones';
                    Image = Zones;
                    RunObject = Page 7300;
                    RunPageLink = "Location Code" = FIELD(Code);
                }
                action("&Bins")
                {
                    ApplicationArea = All;
                    Caption = '&Bins';
                    ToolTip = '&Bins';
                    Image = Bins;
                    RunObject = Page 7302;
                    RunPageLink = "Location Code" = FIELD(Code);
                }
            }
        }
        area(processing)
        {
            action("Create Warehouse location")
            {
                ApplicationArea = All;
                Caption = 'Create Warehouse location';
                ToolTip = 'Create Warehouse location';
                Image = NewWarehouse;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report 5756;
            }
        }
    }

    trigger OnInit()
    var
        cfComunes: Codeunit 55897;
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
    begin

        // TODO: Manual review - EsCentral is not a compiled procedure because its implementation remains inside a disabled codeunit block.
        // Original code: IF NOT cfComunes.EsCentral() THEN
        ERROR(Error001);
    end;

    procedure GetSelectionFilter(): Text
    var
        Loc: Record 14;
        SelectionFilterManagement: Codeunit 46;
    begin
        CurrPage.SETSELECTIONFILTER(Loc);
        EXIT(SelectionFilterManagement.GetSelectionFilterForLocation(Loc));
    end;
}

