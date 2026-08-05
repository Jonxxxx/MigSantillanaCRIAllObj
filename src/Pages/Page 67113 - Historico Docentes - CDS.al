page 55572 "Historico Docentes - CDS"
{
    ApplicationArea = Basic, Suite, Service;
    Editable = false;
    PageType = List;
    SourceTable = 55539;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Docente"; Rec."Cod. Docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Docente';
                    Visible = false;
                }
                field(Campana; Rec.Campana)
                {
                    ApplicationArea = All;
                    ToolTip = 'Campana';
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Pertenece al CDS"; Rec."Pertenece al CDS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pertenece al CDS';
                }
                field("Cod. CDS"; Rec."Cod. CDS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. CDS';
                }
                field("Ult. fecha activacion"; Rec."Ult. fecha activacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ult. fecha activacion';
                }
            }
        }
    }

    actions
    {
    }
}

