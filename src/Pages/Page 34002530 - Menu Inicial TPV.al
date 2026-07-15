page 34002530 "Menu Inicial TPV"
{
    // 
    // // Mejorar el buscar ventana ADdin inicial (Esta a piñon);
    // // Mejorar el teclado virtual para coger la distribucion local (ya lo hace pero no coinciden los archivos);
    // // Comprobar instalacion y autoregistrar ADDin automáticamente.
    // // Actualizaciones automáticas via FTP por version

    Caption = 'addin';
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    ShowFilter = false;
    SourceTable = 2000000026;

    layout
    {
        area(content)
        {
            //TODO: Ver usercontrol(DSPoS; "DSPoS")
            //TODO: Ver {
            //TODO: Ver }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        //fes mig CurrPage.DSPoS.DatosBD(cFuncDS.ServidorBBDD(1),cFuncDS.ServidorBBDD(0),COMPANYNAME);
    end;

    trigger OnOpenPage()
    begin

        AddInData := text001;
        //TODO: Ver cFuncDS.Comprobaciones_Iniciales;
    end;

    var
        AddInData: Text[1024];
        Err001: Label 'No puede cerrar esta página con el DSPoS iniciado';
        //TODO: Ver cFuncDS: Codeunit 34002502;
        text001: Label 'Copyright: DynaSoft Spain';
}

