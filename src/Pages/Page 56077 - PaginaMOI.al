page 56077 PaginaMOI
{
    // MOI - 31/12/2014: Se crea la pagina
    // MOI - 13/04/2015: Se añaden los campos Tipo e ID con las funciones correspondientes para hacerlos visibles y obtener los datos.

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            field(TipoObjeto;goTipo)
            {
                Caption = 'Indique el tipo del objeto';
                Editable = isVisibleTipo;
                Enabled = isVisibleTipo;
                Visible = isVisibleTipo;

                trigger OnValidate()
                begin
                    /*
                    lrPermisosLicencia.SETRANGE(lrPermisosLicencia."Object Type",lrPermisosLicencia."Object Type"::TableData);//0
                    lrPermisosLicencia.SETRANGE(lrPermisosLicencia."Object Type",lrPermisosLicencia."Object Type"::Table);//1
                    lrPermisosLicencia.SETRANGE(lrPermisosLicencia."Object Type",lrPermisosLicencia."Object Type"::"2");//2
                    lrPermisosLicencia.SETRANGE(lrPermisosLicencia."Object Type",lrPermisosLicencia."Object Type"::Report);//3
                    lrPermisosLicencia.SETRANGE(lrPermisosLicencia."Object Type",lrPermisosLicencia."Object Type"::"4");//4
                    lrPermisosLicencia.SETRANGE(lrPermisosLicencia."Object Type",lrPermisosLicencia."Object Type"::Codeunit);//5
                    lrPermisosLicencia.SETRANGE(lrPermisosLicencia."Object Type",lrPermisosLicencia."Object Type"::XMLport);//6
                    lrPermisosLicencia.SETRANGE(lrPermisosLicencia."Object Type",lrPermisosLicencia."Object Type"::MenuSuite);//7
                    lrPermisosLicencia.SETRANGE(lrPermisosLicencia."Object Type",lrPermisosLicencia."Object Type"::Page);//8
                    lrPermisosLicencia.SETRANGE(lrPermisosLicencia."Object Type",lrPermisosLicencia."Object Type"::Query);//9
                    lrPermisosLicencia.SETRANGE(lrPermisosLicencia."Object Type",lrPermisosLicencia."Object Type"::System);//10
                    lrPermisosLicencia.SETRANGE(lrPermisosLicencia."Object Type",lrPermisosLicencia."Object Type"::FieldNumber);//11
                    lrPermisosLicencia.SETRANGE(lrPermisosLicencia."Object Type",lrPermisosLicencia."Object Type"::LimitedUsageTableData);//12
                    */

                end;
            }
            field(NumeroObjeto;giID)
            {
                Caption = 'Indique el numero del objeto';
                Editable = isVisibleID;
                Enabled = isVisibleID;
                Visible = isVisibleID;
            }
        }
    }

    actions
    {
    }

    var
        isVisibleTipo: Boolean;
        isVisibleID: Boolean;
        goTipo: Option ,Tabla,,"Report",,"CodeUnit","XMLPort",MenuSuite,"Page","Query";
        giID: Integer;

    procedure GetTipo(): Integer
    begin
        EXIT(goTipo);
    end;

    procedure GetID(): Integer
    begin
        EXIT(giID);
    end;

    procedure SetVisibleTipo(visible: Boolean)
    begin
        isVisibleTipo:=visible;
    end;

    procedure SetVisibleID(visible: Boolean)
    begin
        isVisibleID:=visible;
    end;
}

