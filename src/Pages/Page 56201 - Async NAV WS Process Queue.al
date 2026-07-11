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
                field("Process Code"; "Process Code")
                {
                }
                field("Process Status"; "Process Status")
                {
                }
                field("Process End Date & Time"; "Process End Date & Time")
                {
                }
                field("Process User Id"; "Process User Id")
                {
                }
                field("URL Web Service"; "URL Web Service")
                {
                }
                field("Soap Action"; "Soap Action")
                {
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

