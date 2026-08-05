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
                field("Cod. Editorial"; Rec."Cod. Editorial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Editorial';
                    Visible = false;
                }
                field("Cod. Producto Editora"; Rec."Cod. Producto Editora")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Producto Editora';
                }
                field("Nombre Producto Editora"; Rec."Nombre Producto Editora")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Producto Editora';
                    Editable = false;
                }
                field("Cod. Local"; Rec."Cod. Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Local';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                    Editable = false;
                }
                field("Cod. Promotor"; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
                    Editable = false;
                }
                field("Descripcion producto"; Rec."Descripcion producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion producto';
                    Editable = false;
                }
                field("Cod. Turno"; Rec."Cod. Turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Turno';
                    Editable = false;
                }
                field("Cod. Grado"; Rec."Cod. Grado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Grado';
                }
                field("Grupo de Negocio"; Rec."Grupo de Negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo de Negocio';
                    Editable = false;
                }
                field("Cod. Producto"; Rec."Cod. Producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Producto';
                }
                field(Seccion; Rec.Seccion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Seccion';
                }
                field("Fecha Adopcion"; Rec."Fecha Adopcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Adopcion';
                }
                field("Fecha de entrega acordada"; Rec."Fecha de entrega acordada")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha de entrega acordada';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                    Editable = false;
                    Visible = false;
                }
                field("Descripcion Nivel"; Rec."Descripcion Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Nivel';
                    Editable = false;
                    Visible = false;
                }
                field("Adopcion anterior"; Rec."Adopcion anterior")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion anterior';
                    Editable = false;
                }
                field(Adopcion; Rec.Adopcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion';
                }
                field("Mes de Lectura"; Rec."Mes de Lectura")
                {
                    ApplicationArea = All;
                    ToolTip = 'Mes de Lectura';
                }
                field("Cantidad Alumnos"; Rec."Cantidad Alumnos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Alumnos';
                    Editable = false;
                }
                field("Adopcion Real"; Rec."Adopcion Real")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion Real';
                }
                field("% Dto. Padres"; Rec."% Dto. Padres")
                {
                    ApplicationArea = All;
                    ToolTip = '% Dto. Padres';
                }
                field("Nombre Promotor"; Rec."Nombre Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Promotor';
                    Editable = false;
                    Visible = false;
                }
                field("% Dto. Colegio"; Rec."% Dto. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = '% Dto. Colegio';
                }
                field("% Dto. Docente"; Rec."% Dto. Docente")
                {
                    ApplicationArea = All;
                    ToolTip = '% Dto. Docente';
                }
                field("% Dto. Feria Padres"; Rec."% Dto. Feria Padres")
                {
                    ApplicationArea = All;
                    ToolTip = '% Dto. Feria Padres';
                }
                field("% Dto. Feria Colegio"; Rec."% Dto. Feria Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = '% Dto. Feria Colegio';
                }
                field("Cod. Motivo perdida adopcion"; Rec."Cod. Motivo perdida adopcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Motivo perdida adopcion';
                }
                field("Linea de negocio"; Rec."Linea de negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Linea de negocio';
                    Editable = false;
                }
                field("Sub Familia"; Rec."Sub Familia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sub Familia';
                    Editable = false;
                }
                field(Serie; Rec.Serie)
                {
                    ApplicationArea = All;
                    ToolTip = 'Serie';
                    Editable = false;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Inventory';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unit Price';
                }
                field("Cantidad anterior"; Rec."Cantidad anterior")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad anterior';
                }
                field("Motivo perdida adopcion"; Rec."Motivo perdida adopcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Motivo perdida adopcion';
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
                    ApplicationArea = All;
                    Caption = '&Item Card';
                    ToolTip = '&Item Card';
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
                    ApplicationArea = All;
                    Caption = 'Competency Items';
                    ToolTip = 'Competency Items';
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
        PptoPromotor: Record 55494;
        TempAdopciones: Record 55493 temporary;
        GradosCol: Record 67037;
        Editoriales: Record 55491;
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
        ColAdopCompet: Record 55500;
        fColAdopCompet: Page 67092;
        ColAdopDet: Record 67053;
    begin
        fColAdopCompet.RecibeParametros("Cod. Colegio", "Cod. Promotor", "Cod. Producto", "Cod. Nivel", "Cod. Grado");
        fColAdopCompet.RUN;
        CLEAR(fColAdopCompet);
    end;
}

