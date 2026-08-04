table 34002550 "DsPOS Event Buffer"
{
    Caption = 'DsPOS Event Buffer';
    DataClassification = SystemMetadata;
    TableType = Temporary;

    fields
    {
        field(1; "Entry No."; Integer) { DataClassification = SystemMetadata; }
        field(2; TipoEvento; Integer) { DataClassification = SystemMetadata; }
        field(3; AccionRespuesta; Text[100]) { DataClassification = SystemMetadata; }
        field(4; TextoRespuesta; Text[2048]) { DataClassification = SystemMetadata; }
        field(10; TextoDato; Text[2048]) { DataClassification = SystemMetadata; }
        field(11; TextoDato2; Text[2048]) { DataClassification = SystemMetadata; }
        field(12; TextoDato3; Text[2048]) { DataClassification = SystemMetadata; }
        field(13; TextoDato4; Text[2048]) { DataClassification = SystemMetadata; }
        field(14; TextoDato5; Text[2048]) { DataClassification = SystemMetadata; }
        field(15; TextoDato6; Text[2048]) { DataClassification = SystemMetadata; }
        field(16; TextoDato7; Text[2048]) { DataClassification = SystemMetadata; }
        field(17; TextoDato8; Text[2048]) { DataClassification = SystemMetadata; }
        field(18; TextoDato9; Text[2048]) { DataClassification = SystemMetadata; }
        field(20; IntDato1; Integer) { DataClassification = SystemMetadata; }
        field(21; IntDato2; Integer) { DataClassification = SystemMetadata; }
        field(22; DatoDecimal; Decimal) { DataClassification = SystemMetadata; }
        field(30; TextoPaisJson; Text[2048]) { DataClassification = SystemMetadata; }
        field(31; ArrayEnterosJson; Text[2048]) { DataClassification = SystemMetadata; }
        field(32; ArrayTotalesJson; Text[2048]) { DataClassification = SystemMetadata; }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
    }

    procedure GetTextoPaisCount(): Integer
    var
        Values: JsonArray;
    begin
        if TextoPaisJson = '' then
            exit(0);
        if not Values.ReadFrom(TextoPaisJson) then
            exit(0);
        exit(Values.Count());
    end;

    procedure GetTextoPaisValue(Index: Integer): Text
    var
        Values: JsonArray;
        Token: JsonToken;
    begin
        if TextoPaisJson = '' then
            exit('');
        if not Values.ReadFrom(TextoPaisJson) then
            exit('');
        if (Index < 0) or (Index >= Values.Count()) then
            exit('');
        Values.Get(Index, Token);
        if Token.IsValue() then
            exit(Token.AsValue().AsText());
    end;

    procedure SetTextoPaisValue(Index: Integer; Value: Text)
    var
        Values: JsonArray;
    begin
        LoadArray(TextoPaisJson, Values);
        EnsureArraySize(Values, Index + 1);
        Values.Set(Index, Value);
        Values.WriteTo(TextoPaisJson);
    end;

    procedure GetIntegerArrayCount(): Integer
    var
        Values: JsonArray;
    begin
        LoadArray(ArrayEnterosJson, Values);
        exit(Values.Count());
    end;

    procedure GetIntegerArrayValue(Index: Integer): Integer
    var
        Values: JsonArray;
        Token: JsonToken;
    begin
        LoadArray(ArrayEnterosJson, Values);
        if (Index < 0) or (Index >= Values.Count()) then
            exit(0);
        Values.Get(Index, Token);
        if Token.IsValue() then
            exit(Token.AsValue().AsInteger());
    end;

    procedure SetIntegerArrayValue(Index: Integer; Value: Integer)
    var
        Values: JsonArray;
    begin
        LoadArray(ArrayEnterosJson, Values);
        EnsureArraySize(Values, Index + 1);
        Values.Set(Index, Value);
        Values.WriteTo(ArrayEnterosJson);
    end;

    procedure ClearDecimalArray()
    begin
        ArrayTotalesJson := '[]';
    end;

    procedure SetDecimalArrayValue(Index: Integer; Value: Decimal)
    var
        Values: JsonArray;
    begin
        LoadArray(ArrayTotalesJson, Values);
        EnsureArraySize(Values, Index + 1);
        Values.Set(Index, Value);
        Values.WriteTo(ArrayTotalesJson);
    end;

    procedure GetDecimalArrayValue(Index: Integer): Decimal
    var
        Values: JsonArray;
        Token: JsonToken;
    begin
        LoadArray(ArrayTotalesJson, Values);
        if (Index < 0) or (Index >= Values.Count()) then
            exit(0);
        Values.Get(Index, Token);
        if Token.IsValue() then
            exit(Token.AsValue().AsDecimal());
    end;

    procedure aXml(): Text
    var
        XmlDoc: XmlDocument;
        Root: XmlElement;
        Declaration: XmlDeclaration;
        Result: Text;
    begin
        XmlDoc := XmlDocument.Create();
        Declaration := XmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDoc.SetDeclaration(Declaration);
        Root := XmlElement.Create('Evento');
        XmlDoc.Add(Root);
        AddElement(Root, 'TipoEvento', Format(TipoEvento, 0, 9));
        AddElement(Root, 'AccionRespuesta', AccionRespuesta);
        AddElement(Root, 'TextoRespuesta', TextoRespuesta);
        AddElement(Root, 'TextoDato', TextoDato);
        AddElement(Root, 'TextoDato2', TextoDato2);
        AddElement(Root, 'TextoDato3', TextoDato3);
        AddElement(Root, 'TextoDato4', TextoDato4);
        AddElement(Root, 'TextoDato5', TextoDato5);
        AddElement(Root, 'TextoDato6', TextoDato6);
        AddElement(Root, 'TextoDato7', TextoDato7);
        AddElement(Root, 'TextoDato8', TextoDato8);
        AddElement(Root, 'TextoDato9', TextoDato9);
        AddElement(Root, 'IntDato1', Format(IntDato1, 0, 9));
        AddElement(Root, 'IntDato2', Format(IntDato2, 0, 9));
        AddElement(Root, 'DatoDecimal', Format(DatoDecimal, 0, 9));
        AddElement(Root, 'TextoPais', TextoPaisJson);
        AddElement(Root, 'ArrayEnteros', ArrayEnterosJson);
        AddElement(Root, 'ArrayTotales', ArrayTotalesJson);
        XmlDoc.WriteTo(Result);
        exit(Result);
    end;


    procedure LoadFromXml(SourceXml: Text)
    var
        XmlDoc: XmlDocument;
        RootNode: XmlNode;
    begin
        Clear(Rec);

        if SourceXml = '' then
            exit;

        if not XmlDocument.ReadFrom(SourceXml, XmlDoc) then
            Error('No se pudo interpretar el evento DsPOS recibido.');

        if not XmlDoc.SelectSingleNode('/Evento', RootNode) then
            Error('El XML recibido no contiene el nodo Evento.');

        TipoEvento := GetXmlInteger(RootNode, 'TipoEvento');
        AccionRespuesta := CopyStr(GetXmlText(RootNode, 'AccionRespuesta'), 1, MaxStrLen(AccionRespuesta));
        TextoRespuesta := CopyStr(GetXmlText(RootNode, 'TextoRespuesta'), 1, MaxStrLen(TextoRespuesta));
        TextoDato := CopyStr(GetXmlText(RootNode, 'TextoDato'), 1, MaxStrLen(TextoDato));
        TextoDato2 := CopyStr(GetXmlText(RootNode, 'TextoDato2'), 1, MaxStrLen(TextoDato2));
        TextoDato3 := CopyStr(GetXmlText(RootNode, 'TextoDato3'), 1, MaxStrLen(TextoDato3));
        TextoDato4 := CopyStr(GetXmlText(RootNode, 'TextoDato4'), 1, MaxStrLen(TextoDato4));
        TextoDato5 := CopyStr(GetXmlText(RootNode, 'TextoDato5'), 1, MaxStrLen(TextoDato5));
        TextoDato6 := CopyStr(GetXmlText(RootNode, 'TextoDato6'), 1, MaxStrLen(TextoDato6));
        TextoDato7 := CopyStr(GetXmlText(RootNode, 'TextoDato7'), 1, MaxStrLen(TextoDato7));
        TextoDato8 := CopyStr(GetXmlText(RootNode, 'TextoDato8'), 1, MaxStrLen(TextoDato8));
        TextoDato9 := CopyStr(GetXmlText(RootNode, 'TextoDato9'), 1, MaxStrLen(TextoDato9));
        IntDato1 := GetXmlInteger(RootNode, 'IntDato1');
        IntDato2 := GetXmlInteger(RootNode, 'IntDato2');
        DatoDecimal := GetXmlDecimal(RootNode, 'DatoDecimal');
        TextoPaisJson := CopyStr(GetXmlText(RootNode, 'TextoPais'), 1, MaxStrLen(TextoPaisJson));
        ArrayEnterosJson := CopyStr(GetXmlText(RootNode, 'ArrayEnteros'), 1, MaxStrLen(ArrayEnterosJson));
        ArrayTotalesJson := CopyStr(GetXmlText(RootNode, 'ArrayTotales'), 1, MaxStrLen(ArrayTotalesJson));
    end;

    local procedure GetXmlText(ParentNode: XmlNode; ElementName: Text): Text
    var
        ChildNode: XmlNode;
    begin
        if ParentNode.SelectSingleNode(ElementName, ChildNode) then
            exit(ChildNode.AsXmlElement().InnerText());
        exit('');
    end;

    local procedure GetXmlInteger(ParentNode: XmlNode; ElementName: Text): Integer
    var
        Value: Integer;
    begin
        if Evaluate(Value, GetXmlText(ParentNode, ElementName)) then
            exit(Value);
        exit(0);
    end;

    local procedure GetXmlDecimal(ParentNode: XmlNode; ElementName: Text): Decimal
    var
        Value: Decimal;
    begin
        if Evaluate(Value, GetXmlText(ParentNode, ElementName), 9) then
            exit(Value);
        exit(0);
    end;

    local procedure LoadArray(Source: Text; var Values: JsonArray)
    begin
        Clear(Values);
        if Source = '' then begin
            Values.ReadFrom('[]');
            exit;
        end;
        if not Values.ReadFrom(Source) then
            Values.ReadFrom('[]');
    end;

    local procedure EnsureArraySize(var Values: JsonArray; RequiredCount: Integer)
    begin
        while Values.Count() < RequiredCount do
            Values.Add(0);
    end;

    local procedure AddElement(var Parent: XmlElement; Name: Text; Value: Text)
    var
        Child: XmlElement;
    begin
        Child := XmlElement.Create(Name, '', Value);
        Parent.Add(Child);
    end;
}