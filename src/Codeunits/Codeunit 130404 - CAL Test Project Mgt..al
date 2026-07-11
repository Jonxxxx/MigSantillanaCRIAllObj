codeunit 130404 "CAL Test Project Mgt."
{

    trigger OnRun()
    begin
    end;

    var
        FileMgt: Codeunit 419;
        FileDialogFilterTxt: Label 'Test Project file (*.xml)|*.xml|All Files (*.*)|*.*', Locked = true;
        XMLDOMMgt: Codeunit 6224;

    procedure Export(CALTestSuiteName: Code[10]): Boolean
    var
        CALTestSuite: Record 130400;
        CALTestLine: Record 130401;
        ProjectXML: DotNet XmlDocument;
        DocumentElement: DotNet XmlNode;
        TestNode: DotNet XmlNode;
        XMLDataFile: Text;
        FileFilter: Text;
        ToFile: Text;
    begin
        XMLDOMMgt.LoadXMLDocumentFromText(
          STRSUBSTNO(
            '<?xml version="1.0" encoding="UTF-16" standalone="yes"?><%1></%1>', 'CALTests'),
          ProjectXML);

        CALTestSuite.GET(CALTestSuiteName);
        DocumentElement := ProjectXML.DocumentElement;
        XMLDOMMgt.AddAttribute(DocumentElement, CALTestSuite.FIELDNAME(Name), CALTestSuite.Name);
        XMLDOMMgt.AddAttribute(DocumentElement, CALTestSuite.FIELDNAME(Description), CALTestSuite.Description);

        CALTestLine.SETRANGE("Test Suite", CALTestSuite.Name);
        CALTestLine.SETRANGE("Line Type", CALTestLine."Line Type"::Codeunit);
        IF CALTestLine.FINDSET THEN
            REPEAT
                TestNode := ProjectXML.CreateElement('Codeunit');
                XMLDOMMgt.AddAttribute(TestNode, 'ID', FORMAT(CALTestLine."Test Codeunit"));
                DocumentElement.AppendChild(TestNode);
            UNTIL CALTestLine.NEXT = 0;

        XMLDataFile := FileMgt.ServerTempFileName('');
        FileMgt.IsAllowedPath(XMLDataFile, FALSE);
        FileFilter := GetFileDialogFilter;
        ToFile := 'PROJECT.xml';
        ProjectXML.Save(XMLDataFile);

        FileMgt.DownloadHandler(XMLDataFile, 'Download', '', FileFilter, ToFile);

        EXIT(TRUE);
    end;

    procedure Import()
    var
        CALTestSuite: Record 130400;
        AllObjWithCaption: Record 2000000058;
        CALTestManagement: Codeunit 130401;
        ProjectXML: DotNet XmlDocument;
        DocumentElement: DotNet XmlNode;
        TestNode: DotNet XmlNode;
        TestNodes: DotNet XmlNodeList;
        ServerFileName: Text;
        NodeCount: Integer;
        TestID: Integer;
    begin
        ServerFileName := FileMgt.ServerTempFileName('.xml');
        FileMgt.IsAllowedPath(ServerFileName, FALSE);
        IF UploadXMLPackage(ServerFileName) THEN BEGIN
            XMLDOMMgt.LoadXMLDocumentFromFile(ServerFileName, ProjectXML);
            DocumentElement := ProjectXML.DocumentElement;

            CALTestSuite.Name :=
              COPYSTR(
                GetAttribute(GetElementName(CALTestSuite.FIELDNAME(Name)), DocumentElement), 1,
                MAXSTRLEN(CALTestSuite.Name));
            CALTestSuite.Description :=
              COPYSTR(
                GetAttribute(GetElementName(CALTestSuite.FIELDNAME(Description)), DocumentElement), 1,
                MAXSTRLEN(CALTestSuite.Description));
            IF NOT CALTestSuite.GET(CALTestSuite.Name) THEN
                CALTestSuite.INSERT;

            TestNodes := DocumentElement.ChildNodes;
            FOR NodeCount := 0 TO (TestNodes.Count - 1) DO BEGIN
                TestNode := TestNodes.Item(NodeCount);
                IF EVALUATE(TestID, FORMAT(GetAttribute('ID', TestNode))) THEN BEGIN
                    AllObjWithCaption.SETRANGE("Object Type", AllObjWithCaption."Object Type"::Codeunit);
                    AllObjWithCaption.SETRANGE("Object ID", TestID);
                    CALTestManagement.AddTestCodeunits(CALTestSuite, AllObjWithCaption);
                END;
            END;
        END;
    end;

    local procedure GetAttribute(AttributeName: Text; var XMLNode: DotNet XmlNode): Text
    var
        XMLAttributes: DotNet XmlNamedNodeMap;
        XMLAttributeNode: DotNet XmlNode;
    begin
        XMLAttributes := XMLNode.Attributes;
        XMLAttributeNode := XMLAttributes.GetNamedItem(AttributeName);
        IF ISNULL(XMLAttributeNode) THEN
            EXIT('');
        EXIT(FORMAT(XMLAttributeNode.InnerText));
    end;

    local procedure GetElementName(NameIn: Text): Text
    begin
        NameIn := DELCHR(NameIn, '=', 'Ž»''`');
        NameIn := CONVERTSTR(NameIn, '<>,./\+&()%:', '            ');
        NameIn := CONVERTSTR(NameIn, '-', '_');
        NameIn := DELCHR(NameIn, '=', ' ');
        IF NameIn[1] IN ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'] THEN
            NameIn := '_' + NameIn;
        EXIT(NameIn);
    end;

    local procedure GetFileDialogFilter(): Text
    begin
        EXIT(FileDialogFilterTxt);
    end;

    local procedure UploadXMLPackage(ServerFileName: Text): Boolean
    begin
        EXIT(UPLOAD('Import project', '', GetFileDialogFilter, '', ServerFileName));
    end;
}

