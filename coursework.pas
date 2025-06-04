program DateInput;

uses App, Objects, Drivers, Views, Dialogs, MsgBox;

type
  PMyApp = ^TMyApp;
  TMyApp = object(TApplication)
    procedure Run; virtual;
    procedure HandleEvent(var Event: TEvent); virtual;
    procedure ShowDateDialog;
  end;


procedure TMyApp.HandleEvent(var Event: TEvent);
begin
  TApplication.HandleEvent(Event);
  if Event.What = evCommand then
  begin
    case Event.Command of
      cmNew: ShowDateDialog;
    else
      Exit;
    end;
    ClearEvent(Event);
  end;
end;

procedure answ_printer(ct:integer; first_num:string; second_num:string);
var inf,er: integer;
begin
    Val(first_num, inf, er);
    if (er != 0) then
    MessageBox('INVALID ERROR', nil,  mfOkButton or mfinformation)
    else begin
    if (ct=1) then
    MessageBox('First part: '+ first_num+ ' second part: '+ second_num, nil,  mfOkButton or mfinformation)
    else
    MessageBox('First part: '+ first_num+ ' second part: '+ '0', nil,  mfOkButton or mfinformation);
end;
end;

procedure TMyApp.ShowDateDialog;
var
  D: PDialog;
  R: TRect;
  InputLine: PInputLine;
  my_pointer,us_input, first_num,second_num: string;
  us_data: array [1..30] of string;
  i,er,ct:integer;
begin
    
  R.Assign(0, 0, 60, 10);
  R.Move(10, 2);
  D := New(PDialog, Init(R, 'work with irrational num'));

  R.Assign(8, 3, 35, 4);
  D^.Insert(New(PStaticText,Init(R,'example: 19.25')));

  R.Assign(8, 4, 35, 5);
  D^.Insert(New(PStaticText,Init(R,'Enter your irrational num:')));

  R.Assign(8, 5, 35, 6);
  InputLine := New(PInputLine, Init(R, 255));
  D^.Insert(InputLine);

  R.Assign(36, 5, 50, 7);
  D^.Insert(New(PButton, Init(R, '~O~K', cmOk, bfDefault)));

  if Desktop^.ExecView(D) = cmOk then
  begin
    us_input := InputLine^.Data^;
       my_pointer:='';
       ct:=0;

    for  i := 1 to length(us_input) do begin
          if (us_input[i]='.') then begin
          ct:=ct+1;
          first_num:=my_pointer;
          my_pointer:='';
          end
          else my_pointer:=my_pointer+us_input[i]
        end;
        if (ct=1) then second_num:=my_pointer
        else first_num:=my_pointer
    
    end;

  answ_printer(ct,first_num,second_num);
  Dispose(D, Done);
end;

procedure TMyApp.Run;
begin
  ShowDateDialog;
end;

var
  MyApp: TMyApp;

begin
  MyApp.Init;
  MyApp.Run;
  MyApp.Done;
end.
