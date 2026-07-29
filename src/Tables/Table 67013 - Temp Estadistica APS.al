table 67013 "Temp Estadistica APS"
{
    DrillDownPageID = 67027;
    LookupPageID = 67027;

    fields
    {
        field(1; "Cod. Editorial"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Editorial';
            NotBlank = true;
            TableRelation = Editoras;
        }
        field(2; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            NotBlank = true;
            TableRelation = Contact WHERE("Type" = CONST(Company));
        }
        field(3; "Cod. Local"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Local';
            TableRelation = "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(4; "Cod. Nivel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
            NotBlank = true;
            TableRelation = "Colegio - Nivel"."Cod. Nivel" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"));
        }
        field(5; "Cod. Grado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Grado';
            NotBlank = true;
        }
        field(6; "Cod. Turno"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Turno';
        }
        field(7; "Cod. Promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Promotor';
            TableRelation = "Salesperson/Purchaser" WHERE("Tipo" = CONST(Vendedor));
        }
        field(8; "Cod. Producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Producto';
            NotBlank = true;
            TableRelation = Item;
        }
        field(9; "Linea de negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Linea de negocio';
        }
        field(10; Familia; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Familia';
        }
        field(11; "Sub Familia"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sub Familia';
        }
        field(12; Serie; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Serie';
        }
        field(13; "Cantidad - 2INI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 2INI';
            DecimalPlaces = 0 : 0;
        }
        field(14; "Adopcion - 2INI"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 2INI';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(15; "Cantidad - 3INI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 3INI';
            DecimalPlaces = 0 : 0;
        }
        field(16; "Adopcion - 3INI"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 3INI';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(17; "Cantidad - 4INI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 4INI';
            DecimalPlaces = 0 : 0;
        }
        field(18; "Adopcion - 4INI"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 4INI';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(19; "Cantidad - 5INI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 5INI';
            DecimalPlaces = 0 : 0;
        }
        field(20; "Adopcion - 5INI"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 5INI';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(21; "Cantidad - 1PRI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 1PRI';
            DecimalPlaces = 0 : 0;
        }
        field(22; "Adopcion - 1PRI"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 1PRI';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(23; "Cantidad - 2PRI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 2PRI';
            DecimalPlaces = 0 : 0;
        }
        field(24; "Adopcion - 2PRI"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 2PRI';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(25; "Cantidad - 3PRI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 3PRI';
            DecimalPlaces = 0 : 0;
        }
        field(26; "Adopcion - 3PRI"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 3PRI';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(27; "Cantidad - 4PRI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 4PRI';
            DecimalPlaces = 0 : 0;
        }
        field(28; "Adopcion - 4PRI"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 4PRI';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(29; "Cantidad - 5PRI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 5PRI';
            DecimalPlaces = 0 : 0;
        }
        field(30; "Adopcion - 5PRI"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 5PRI';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(31; "Cantidad - 6PRI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 6PRI';
            DecimalPlaces = 0 : 0;
        }
        field(32; "Adopcion - 6PRI"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 6PRI';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(33; "Cantidad - 1SEC"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 1SEC';
            DecimalPlaces = 0 : 0;
        }
        field(34; "Adopcion - 1SEC"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 1SEC';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(35; "Cantidad - 2SEC"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 2SEC';
            DecimalPlaces = 0 : 0;
        }
        field(36; "Adopcion - 2SEC"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 2SEC';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(37; "Cantidad - 3SEC"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 3SEC';
            DecimalPlaces = 0 : 0;
        }
        field(38; "Adopcion - 3SEC"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 3SEC';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(39; "Cantidad - 4SEC"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 4SEC';
            DecimalPlaces = 0 : 0;
        }
        field(40; "Adopcion - 4SEC"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 4SEC';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(41; "Cantidad - 5SEC"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 5SEC';
            DecimalPlaces = 0 : 0;
        }
        field(42; "Adopcion - 5SEC"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 5SEC';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(43; "Cantidad - 1SEI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 1SEI';
            DecimalPlaces = 0 : 0;
        }
        field(44; "Adopcion - 1SEI"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 1SEI';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(45; "Cantidad - 2SEI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 2SEI';
            DecimalPlaces = 0 : 0;
        }
        field(46; "Adopcion - 2SEI"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 2SEI';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(47; "Cantidad - 3SEI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 3SEI';
            DecimalPlaces = 0 : 0;
        }
        field(48; "Adopcion - 3SEI"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 3SEI';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(49; "Cantidad - 4SEI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 4SEI';
            DecimalPlaces = 0 : 0;
        }
        field(50; "Adopcion - 4SEI"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 4SEI';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(51; "Cantidad - 1VA"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 1VA';
            DecimalPlaces = 0 : 0;
        }
        field(52; "Adopcion - 1VA"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 1VA';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(53; "Cantidad - 2VA"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 2VA';
            DecimalPlaces = 0 : 0;
        }
        field(54; "Adopcion - 2VA"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 2VA';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(55; "Cantidad - 3VA"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 3VA';
            DecimalPlaces = 0 : 0;
        }
        field(56; "Adopcion - 3VA"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 3VA';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(57; "Cantidad - 4VA"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 4VA';
            DecimalPlaces = 0 : 0;
        }
        field(58; "Adopcion - 4VA"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 4VA';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(59; "Cantidad - 5VA"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad - 5VA';
            DecimalPlaces = 0 : 0;
        }
        field(60; "Adopcion - 5VA"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion - 5VA';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(61; "Grupo de negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo de negocio';
        }
        field(62; "Cant. Presupuestada"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. Presupuestada';
        }
    }

    keys
    {
        key(Key1; "Sub Familia")
        {
        }
    }

    fieldgroups
    {
    }
}

