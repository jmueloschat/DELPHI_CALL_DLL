unit ufrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TCalcPlus = function (n1,n2: double): Double; stdcall;
  TStrRepeat = function (const s1: PChar; const n: Integer): PChar; stdcall;

var
  Form1: TForm1;

implementation


{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  loCalcPlus: TCalcPlus;
  loHandle: THandle;
  ldResult: Double;
  ldN1,ldN2: Double;
begin
  loHandle := LoadLibrary(PChar('C:\repojm\DELPHI_DLL\FSample.dll'));

  if   loHandle > HINSTANCE_ERROR then
       begin
         @loCalcPlus := GetProcAddress(loHandle, 'calcPlus');

         if   @loCalcPlus <> nil then
              begin
                ldN1 := 10;
                ldN2 := 20.6;
                ldResult := loCalcPlus(ldN1,ldN2);
                ShowMessage(FloatToStr(ldResult));
              end
         else
              raise Exception.Create('Method not found');

         FreeLibrary(loHandle)
       end
  else
       raise Exception.Create('DLL not found');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  loStrRepeat: TStrRepeat;
  loHandle: THandle;
  lsResult: PChar;
  lsName: PChar;
  liRepeat: Integer;
begin
  loHandle := LoadLibrary(PChar('C:\repojm\DELPHI_DLL\FSample.dll'));

  if   loHandle > HINSTANCE_ERROR then
       begin
         @loStrRepeat := GetProcAddress(loHandle, 'StrRepeat');

         if   @loStrRepeat <> nil then
              begin
                lsName := 'Jonh';
                liRepeat := 2;
                lsResult := loStrRepeat(lsName,liRepeat);
                ShowMessage(lsResult);
              end
         else
              raise Exception.Create('Method not found');

         FreeLibrary(loHandle)
       end
  else
       raise Exception.Create('DLL not found');
end;

end.
