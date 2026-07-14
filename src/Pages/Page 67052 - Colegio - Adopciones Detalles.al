page 67052 "Colegio - Adopciones Detalles"
{
    PageType = ListPart;
    SourceTable = 67053;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Editorial"; "Cod. Editorial")
                {
                    Visible = false;
                }
                field("Cod. Producto Editora"; "Cod. Producto Editora")
                {
                }
                field("Nombre Producto Editora"; "Nombre Producto Editora")
                {
                    Editable = false;
                }
                field("Cod. Local"; "Cod. Local")
                {
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                    Editable = false;
                }
                field("Cod. Promotor"; "Cod. Promotor")
                {
                    Editable = false;
                }
                field("Descripcion producto"; "Descripcion producto")
                {
                    Editable = false;
                }
                field("Cod. Turno"; "Cod. Turno")
                {
                    Editable = false;
                }
                field("Cod. Grado"; "Cod. Grado")
                {
                }
                field("Grupo de Negocio"; "Grupo de Negocio")
                {
                    Editable = false;
                }
                field("Cod. Producto"; "Cod. Producto")
                {
                }
                field(Seccion; Seccion)
                {
                }
                field("Fecha Adopcion"; "Fecha Adopcion")
                {
                }
                field("Fecha de entrega acordada"; "Fecha de entrega acordada")
                {
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Descripcion Nivel"; "Descripcion Nivel")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Adopcion anterior"; "Adopcion anterior")
                {
                    Editable = false;
                }
                field(Adopcion; Adopcion)
                {
                }
                field("Mes de Lectura"; "Mes de Lectura")
                {
                }
                field("Cantidad Alumnos"; "Cantidad Alumnos")
                {
                    Editable = false;
                }
                field("Adopcion Real"; "Adopcion Real")
                {
                }
                field("% Dto. Padres"; "% Dto. Padres")
                {
                }
                field("Nombre Promotor"; "Nombre Promotor")
                {
                    Editable = false;
                    Visible = false;
                }
                field("% Dto. Colegio"; "% Dto. Colegio")
                {
                }
                field("% Dto. Docente"; "% Dto. Docente")
                {
                }
                field("% Dto. Feria Padres"; "% Dto. Feria Padres")
                {
                }
                field("% Dto. Feria Colegio"; "% Dto. Feria Colegio")
                {
                }
                field("Cod. Motivo perdida adopcion"; "Cod. Motivo perdida adopcion")
                {
                }
                field("Linea de negocio"; "Linea de negocio")
                {
                    Editable = false;
                }
                field("Sub Familia"; "Sub Familia")
                {
                    Editable = false;
                }
                field(Serie; Serie)
                {
                    Editable = false;
                }
                field(Inventory; Inventory)
                {
                }
                field("Unit Price"; "Unit Price")
                {
                }
                field("Cantidad anterior"; "Cantidad anterior")
                {
                }
                field("Motivo perdida adopcion"; "Motivo perdida adopcion")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action1000000016>")
            {
                Caption = '&Actions';
                Image = "Action";
                Visible = false;
                action(FProd)
                {
                    Caption = '&Item Card';
                    Image = Edit;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F5';

                    trigger OnAction()
                    begin
                        FichaProducto;
                    end;
                }

                action(AdopComp)
                {
                    Caption = 'Competency Items';
                    Image = BulletList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        AdopCompetencia;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Precio1: Decimal;
        Precio2: Decimal;
        Precio3: Decimal;
        I: Integer;
    begin
        Precio1 := 0;
        Precio2 := 0;
        Precio3 := 0;

        SP.RESET;
        SP.SETRANGE("Item No.", "Cod. Producto");
        SP.SETRANGE("Sales Type", SP."Sales Type"::Customer);
        SP.SETRANGE("Sales Code", "Cod. Colegio");
        //SP.SETFILTER("Starting Date",'<>%1',0D);
        SP.SETFILTER("Ending Date", '%1|>=%2', 0D, TODAY);
        IF SP.FINDFIRST THEN
            Precio1 := SP."Unit Price";

        SP.RESET;
        SP.SETRANGE("Item No.", "Cod. Producto");
        SP.SETRANGE("Sales Type", SP."Sales Type"::"All Customers");
        //SP.SETFILTER("Starting Date",'<>%1',0D);
        SP.SETFILTER("Ending Date", '%1|>=%2', 0D, TODAY);
        IF SP.FINDFIRST THEN
            Precio2 := SP."Unit Price";

        IF Cust.GET("Cod. Colegio") THEN BEGIN
            SP.RESET;
            SP.SETRANGE("Item No.", "Cod. Producto");
            SP.SETRANGE("Sales Type", SP."Sales Type"::"Customer Price Group");
            SP.SETRANGE("Sales Code", Cust."Customer Price Group");
            SP.SETFILTER("Ending Date", '%1|>=%2', 0D, TODAY);
            IF SP.FINDFIRST THEN
                Precio3 := SP."Unit Price";
        END;


        IF (Precio1 > Precio2) AND (Precio1 > Precio3) THEN
            "Unit Price" := Precio1
        ELSE
            IF (Precio2 > Precio3) AND (Precio2 > Precio1) THEN
                "Unit Price" := Precio2
            ELSE
                IF (Precio3 > Precio2) AND (Precio3 > Precio1) THEN
                    "Unit Price" := Precio3;
    end;

    var
        HAdopciones: Record 67035;
        Item: Record 27;
        PptoPromotor: Record 67027;
        TempAdopciones: Record 67026 temporary;
        GradosCol: Record 67037;
        Editoriales: Record 67024;
        SP: Record 7002;
        Cust: Record 18;
        NoMov: Integer;
        gCodCol: Code[20];
        gCodNivel: Code[20];
        gCodPromotor: Code[20];
        gCodRuta: Code[20];
        gCodTurno: Code[20];
        gCodLocal: Code[20];
        Ano: Integer;

    procedure UpdForm()
    begin
        SETCURRENTKEY("Cod. Colegio", "Grupo de Negocio", Serie, "Cod. Producto");
        CurrPage.UPDATE;
    end;

    procedure RecibeFiltro(FiltroFecha: Date; FiltroLinNeg: Text[250]; FiltroGpoNeg: Text[250]; FiltroNivel: Text[250]; FiltroSerie: Text[250]; FiltroSubFam: Text[250])
    begin
        /*
        if filtrofecha <> 0d then
           setrange
        */

        RESET;

        IF FiltroLinNeg <> '' THEN
            SETFILTER("Linea de negocio", FiltroLinNeg);

        IF FiltroNivel <> '' THEN
            SETFILTER("Cod. Nivel", FiltroNivel);

        IF FiltroGpoNeg <> '' THEN
            SETFILTER("Grupo de Negocio", FiltroGpoNeg);

        IF FiltroSerie <> '' THEN
            SETFILTER(Serie, FiltroSerie);

        IF FiltroSubFam <> '' THEN
            SETFILTER("Sub Familia", FiltroSubFam);
        //MESSAGE('%1',GETFILTERS);

        //UpdForm;

    end;

    procedure FichaProducto()
    var
        ItemCard: Page 30;
    begin
        Rec.OpenItem;
    end;

    procedure AdopCompetencia()
    var
        ColAdopCompet: Record 67033;
        fColAdopCompet: Page 67092;
        ColAdopDet: Record 67053;
    begin
        fColAdopCompet.RecibeParametros("Cod. Colegio", "Cod. Promotor", "Cod. Producto", "Cod. Nivel", "Cod. Grado");
        fColAdopCompet.RUN;
        CLEAR(fColAdopCompet);
    end;
}

