page 56201 "Async NAV WS Process Queue"
{
    ApplicationArea = Basic, Suite, Service;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 56200;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Process Code"; Rec."Process Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Process Code';
                }
                field("Process Status"; Rec."Process Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Process Status';
                }
                field("Process End Date & Time"; Rec."Process End Date & Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Process End Date & Time';
                }
                field("Process User Id"; Rec."Process User Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Process User Id';
                }
                field("URL Web Service"; Rec."URL Web Service")
                {
                    ApplicationArea = All;
                    ToolTip = 'URL Web Service';
                }
                field("Soap Action"; Rec."Soap Action")
                {
                    ApplicationArea = All;
                    ToolTip = 'Soap Action';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Ver XML recibido")
            {
                Caption = 'Ver XML recibido';
                Image = XMLFile;

                trigger OnAction()
                begin
                    ProcessData := GetReceivedData;
                    MESSAGE(ProcessData);
                end;
            }
            action("Ver XML enviado")
            {
                Caption = 'Ver XML enviado';
                Image = XMLFile;

                trigger OnAction()
                begin
                    ProcessData := GetProcessData;
                    MESSAGE(ProcessData);
                end;
            }
            action("Ver respuesta recibida")
            {
                Caption = 'Ver respuesta recibida';
                Image = XMLFile;

                trigger OnAction()
                begin
                    ResponseData := GetProcessResponse;
                    MESSAGE(ResponseData);
                end;
            }
        }
    }

    var
        ProcessData: Text;
        ResponseData: Text;
}

