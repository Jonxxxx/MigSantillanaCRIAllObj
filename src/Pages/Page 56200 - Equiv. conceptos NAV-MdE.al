page 56200 "Equiv. conceptos NAV-MdE"
{
    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Show';
    SourceTable = Table34002111;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            fixed("Tipo dato MdE")
            {
                Caption = 'Tipo dato MdE';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                field(GetMdEEquiv; GetMdEEquiv)
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
            }
            repeater(Group)
            {
                FreezeColumn = "Descripción";
                field(Código; Código)
                {
                    Editable = false;
                }
                field(Descripción; Descripción)
                {
                    Editable = false;
                }
                field(BooleanArray[1];BooleanArray[1])
                {
                    CaptionClass = ColumnNameArray[1];
                    Visible = NoColumns > 0;

                    trigger OnValidate()
                    begin
                        ValidateColumn(1);
                    end;
                }
                field(BooleanArray[2];BooleanArray[2])
                {
                    CaptionClass = ColumnNameArray[2];
                    Visible = NoColumns > 1;

                    trigger OnValidate()
                    begin
                        ValidateColumn(2);
                    end;
                }
                field(BooleanArray[3];BooleanArray[3])
                {
                    CaptionClass = ColumnNameArray[3];
                    Visible = NoColumns > 2;

                    trigger OnValidate()
                    begin
                        ValidateColumn(3);
                    end;
                }
                field(BooleanArray[4];BooleanArray[4])
                {
                    CaptionClass = ColumnNameArray[4];
                    Visible = NoColumns > 3;

                    trigger OnValidate()
                    begin
                        ValidateColumn(4);
                    end;
                }
                field(BooleanArray[5];BooleanArray[5])
                {
                    CaptionClass = ColumnNameArray[5];
                    Visible = NoColumns > 4;

                    trigger OnValidate()
                    begin
                        ValidateColumn(5);
                    end;
                }
                field(BooleanArray[6];BooleanArray[6])
                {
                    CaptionClass = ColumnNameArray[6];
                    Visible = NoColumns > 5;

                    trigger OnValidate()
                    begin
                        ValidateColumn(6);
                    end;
                }
                field(BooleanArray[7];BooleanArray[7])
                {
                    CaptionClass = ColumnNameArray[7];
                    Visible = NoColumns > 6;

                    trigger OnValidate()
                    begin
                        ValidateColumn(7);
                    end;
                }
                field(BooleanArray[8];BooleanArray[8])
                {
                    CaptionClass = ColumnNameArray[8];
                    Visible = NoColumns > 7;

                    trigger OnValidate()
                    begin
                        ValidateColumn(8);
                    end;
                }
                field(BooleanArray[9];BooleanArray[9])
                {
                    CaptionClass = ColumnNameArray[9];
                    Visible = NoColumns > 8;

                    trigger OnValidate()
                    begin
                        ValidateColumn(9);
                    end;
                }
                field(BooleanArray[10];BooleanArray[10])
                {
                    CaptionClass = ColumnNameArray[10];
                    Visible = NoColumns > 9;

                    trigger OnValidate()
                    begin
                        ValidateColumn(10);
                    end;
                }
                field(BooleanArray[11];BooleanArray[11])
                {
                    CaptionClass = ColumnNameArray[11];
                    Visible = NoColumns > 10;

                    trigger OnValidate()
                    begin
                        ValidateColumn(11);
                    end;
                }
                field(BooleanArray[12];BooleanArray[12])
                {
                    CaptionClass = ColumnNameArray[12];
                    Visible = NoColumns > 11;

                    trigger OnValidate()
                    begin
                        ValidateColumn(12);
                    end;
                }
                field(BooleanArray[13];BooleanArray[13])
                {
                    CaptionClass = ColumnNameArray[13];
                    Visible = NoColumns > 12;

                    trigger OnValidate()
                    begin
                        ValidateColumn(13);
                    end;
                }
                field(BooleanArray[14];BooleanArray[14])
                {
                    CaptionClass = ColumnNameArray[14];
                    Visible = NoColumns > 13;

                    trigger OnValidate()
                    begin
                        ValidateColumn(14);
                    end;
                }
                field(BooleanArray[15];BooleanArray[15])
                {
                    CaptionClass = ColumnNameArray[15];
                    Visible = NoColumns > 14;

                    trigger OnValidate()
                    begin
                        ValidateColumn(15);
                    end;
                }
                field(BooleanArray[16];BooleanArray[16])
                {
                    CaptionClass = ColumnNameArray[16];
                    Visible = NoColumns > 15;

                    trigger OnValidate()
                    begin
                        ValidateColumn(16);
                    end;
                }
                field(BooleanArray[17];BooleanArray[17])
                {
                    CaptionClass = ColumnNameArray[17];
                    Visible = NoColumns > 16;

                    trigger OnValidate()
                    begin
                        ValidateColumn(17);
                    end;
                }
                field(BooleanArray[18];BooleanArray[18])
                {
                    CaptionClass = ColumnNameArray[18];
                    Visible = NoColumns > 17;

                    trigger OnValidate()
                    begin
                        ValidateColumn(18);
                    end;
                }
                field(BooleanArray[19];BooleanArray[19])
                {
                    CaptionClass = ColumnNameArray[19];
                    Visible = NoColumns > 18;

                    trigger OnValidate()
                    begin
                        ValidateColumn(19);
                    end;
                }
                field(BooleanArray[20];BooleanArray[20])
                {
                    CaptionClass = ColumnNameArray[20];
                    Visible = NoColumns > 19;

                    trigger OnValidate()
                    begin
                        ValidateColumn(20);
                    end;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Información Real Mensual")
            {
                Enabled = MdEDataType = 1;
                Image = CompleteLine;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    MdEDataType := MdEDataType::IRM;
                    SetNoColumns;
                end;
            }
            action("Compensación Teórica")
            {
                Enabled = MdEDataType = 0;
                Image = CompleteLine;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    MdEDataType := MdEDataType::CT;
                    SetNoColumns;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        i: Integer;
    begin
        FOR i := 1 TO NoColumns DO BEGIN
          IF MdEDataType = MdEDataType::IRM THEN
            BooleanArray[i] := EquivNavMdE.GET(Código, i, 0) AND (EquivNavMdE.Porcentaje > 0)
          ELSE
            BooleanArray[i] := EquivNavMdE.GET(Código, 0, i) AND (EquivNavMdE.Porcentaje > 0)
        END;
    end;

    trigger OnOpenPage()
    begin
        SetNoColumns;
    end;

    var
        EquivNavMdE Record: 56201;
        BooleanArray: array [20] of Boolean;
        ColumnNameArray: array [20] of Text[20];
        NoColumns: Integer;
        MdEDataType: Option IRM,CT;
        Text000: Label 'Información Real Mensual';
        Text001: Label 'Compensación Teórica';

    procedure SetNoColumns()
    var
        i: Integer;
    begin
        CLEAR(ColumnNameArray);
        NoColumns := EquivNavMdE.GetNoConcepts(MdEDataType);
        FOR i := 1 TO NoColumns DO BEGIN
          IF MdEDataType = MdEDataType::IRM THEN BEGIN
            EquivNavMdE."Concepto IRM" := i;
            ColumnNameArray[i] := STRSUBSTNO('%1', EquivNavMdE."Concepto IRM");
          END
          ELSE BEGIN
            EquivNavMdE."Concepto CT" := i;
            ColumnNameArray[i] := STRSUBSTNO('%1', EquivNavMdE."Concepto CT");
          END;
        END;
        CurrPage.UPDATE(FALSE);
    end;

    procedure ValidateColumn(Column: Integer)
    var
        IrmVal: Integer;
        CtVal: Integer;
    begin
        IF MdEDataType = MdEDataType::IRM THEN
          IrmVal := Column
        ELSE
          CtVal := Column;

        IF BooleanArray[Column] THEN BEGIN
          IF EquivNavMdE.GET(Código, IrmVal, CtVal) THEN BEGIN
            EquivNavMdE.Porcentaje := 1;
            EquivNavMdE.MODIFY;
          END
          ELSE BEGIN
            EquivNavMdE."Concepto NAV" := Código;
            EquivNavMdE."Concepto IRM" := IrmVal;
            EquivNavMdE."Concepto CT" := CtVal;
            EquivNavMdE.Porcentaje := 1;
            EquivNavMdE.INSERT;
          END
        END
        ELSE BEGIN
          IF EquivNavMdE.GET(Código, IrmVal, CtVal) THEN
            EquivNavMdE.DELETE;
        END;
    end;

    procedure GetMdEEquiv(): Text[50]
    begin
        IF MdEDataType = MdEDataType::IRM THEN
          EXIT(Text000)
        ELSE
          EXIT(Text001);
    end;
}

