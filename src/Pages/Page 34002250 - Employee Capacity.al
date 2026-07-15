page 34002250 "Employee Capacity"
{
    Caption = 'Resource Capacity';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = ListPlus;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = 156;

    layout
    {
        area(content)
        {
            group("Matrix Options")
            {
                Caption = 'Matrix Options';
                field(PeriodType; PeriodType)
                {
                    ApplicationArea = Jobs;
                    Caption = 'View by';
                    OptionCaption = 'Day,Week,Month,Quarter,Year,Accounting Period';
                    ToolTip = 'Specifies by which period amounts are displayed.';

                    trigger OnValidate()
                    begin
                        //TODO: Ver SetColumns(SetWanted::Initial);
                        UpdateMatrixSubform;
                    end;
                }
                field(QtyType; QtyType)
                {
                    ApplicationArea = Jobs;
                    Caption = 'View as';
                    OptionCaption = 'Net Change,Balance at Date';
                    ToolTip = 'Specifies how amounts are displayed. Net Change: The net change in the balance for the selected period. Balance at Date: The balance as of the last day in the selected period.';

                    trigger OnValidate()
                    begin
                        UpdateMatrixSubform;
                    end;
                }
            }
            part(MatrixForm; 34002251)
            {
                ApplicationArea = Jobs;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Previous Set")
            {
                ApplicationArea = Jobs;
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the previous set of data.';

                trigger OnAction()
                begin
                    //TODO: Ver SetColumns(SetWanted::Previous);
                    UpdateMatrixSubform;
                end;
            }
            action("Previous Column")
            {
                ApplicationArea = Jobs;
                Caption = 'Previous Column';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the previous column.';

                trigger OnAction()
                begin
                    //TODO: Ver SetColumns(SetWanted::PreviousColumn);
                    UpdateMatrixSubform;
                end;
            }
            action("Next Column")
            {
                ApplicationArea = Jobs;
                Caption = 'Next Column';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the next column.';

                trigger OnAction()
                begin
                    //TODO: Ver SetColumns(SetWanted::NextColumn);
                    UpdateMatrixSubform;
                end;
            }
            action("Next Set")
            {
                ApplicationArea = Jobs;
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the next set of data.';

                trigger OnAction()
                begin
                    //TODO: Ver SetColumns(SetWanted::Next);
                    UpdateMatrixSubform;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //TODO: Ver SetColumns(SetWanted::Initial);
        UpdateMatrixSubform;
    end;

    var
        MatrixRecords: array[32] of Record 2000000007;
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        QtyType: Option "Net Change","Balance at Date";
        MatrixColumnCaptions: array[32] of Text[1024];
        ColumnSet: Text[1024];
        SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        PKFirstRecInCurrSet: Text[100];
        CurrSetLength: Integer;

    [Scope('Internal')]
    procedure SetColumns(SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit 9200;
    begin
        MatrixMgt.GeneratePeriodMatrixData(SetWanted, 12, FALSE, PeriodType, '',
          PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, MatrixRecords);
    end;

    local procedure UpdateMatrixSubform()
    begin
        //TODO: Ver CurrPage.MatrixForm.PAGE.Load(QtyType, MatrixColumnCaptions, MatrixRecords, CurrSetLength);
        CurrPage.UPDATE(FALSE);
    end;
}

