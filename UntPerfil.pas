unit UntPerfil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UntPadrao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.ImageList,
  Vcl.ImgList, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.DBCtrls, Vcl.Mask;

type
  TFrmPerfil = class(TFrmPadrao)
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label11: TLabel;
    Pedido: TLabel;
    Label12: TLabel;
    Cliente: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox11: TDBCheckBox;
    DBCheckBox12: TDBCheckBox;
    DBCheckBox13: TDBCheckBox;
    DBCheckBox14: TDBCheckBox;
    DBCheckBox16: TDBCheckBox;
    DBCheckBox17: TDBCheckBox;
    DBCheckBox19: TDBCheckBox;
    DBCheckBox20: TDBCheckBox;
    DBCheckBox22: TDBCheckBox;
    DBCheckBox23: TDBCheckBox;
    DBCheckBox25: TDBCheckBox;
    DBCheckBox28: TDBCheckBox;
    DBCheckBox31: TDBCheckBox;
    DBCheckBox34: TDBCheckBox;
    DBCheckBox37: TDBCheckBox;
    DBCheckBox38: TDBCheckBox;
    DBCheckBox40: TDBCheckBox;
    DBCheckBox41: TDBCheckBox;
    DBCheckBox43: TDBCheckBox;
    DBCheckBox44: TDBCheckBox;
    DBCheckBox46: TDBCheckBox;
    DBCheckBox47: TDBCheckBox;
    Panel1: TPanel;
    Label20: TLabel;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    FDTabelaID: TIntegerField;
    FDTabelaDESCRICAO: TStringField;
    FDTabelaCADASTRO_I: TStringField;
    FDTabelaCADASTRO_A: TStringField;
    FDTabelaCADASTRO_E: TStringField;
    FDTabelaCATEGORIA_I: TStringField;
    FDTabelaCATEGORIA_A: TStringField;
    FDTabelaCATEGORIA_E: TStringField;
    FDTabelaDESENV_EDIT_I: TStringField;
    FDTabelaDESENV_EDIT_A: TStringField;
    FDTabelaDESENV_EDIT_E: TStringField;
    FDTabelaPRODUTO_I: TStringField;
    FDTabelaPRODUTO_A: TStringField;
    FDTabelaPRODUTO_E: TStringField;
    FDTabelaPEDIDO_I: TStringField;
    FDTabelaPEDIDO_A: TStringField;
    FDTabelaPEDIDO_E: TStringField;
    FDTabelaUSUARIO_I: TStringField;
    FDTabelaUSUARIO_A: TStringField;
    FDTabelaUSUARIO_E: TStringField;
    FDTabelaPERFIL_I: TStringField;
    FDTabelaPERFIL_A: TStringField;
    FDTabelaPERFIL_E: TStringField;
    FDTabelaDATA_CADASTRO: TSQLTimeStampField;
    FDTabelaDATA_ALTERACAO: TSQLTimeStampField;
    FDTabelaCADASTRO: TStringField;
    FDTabelaCATEGORIA: TStringField;
    FDTabelaDESENV_EDIT: TStringField;
    FDTabelaPRODUTO: TStringField;
    FDTabelaPEDIDO: TStringField;
    FDTabelaUSUARIO: TStringField;
    FDTabelaPERFIL: TStringField;
    FDTabelaSTATUS: TStringField;
    FDTabelaFK_USUARIO_ALT: TIntegerField;
    procedure FormActivate(Sender: TObject);
    procedure FDTabelaBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPerfil: TFrmPerfil;

implementation

{$R *.dfm}

uses UntCadastro, UntMain;

procedure TFrmPerfil.FDTabelaBeforePost(DataSet: TDataSet);
begin
  inherited;
  if FDTabelaDESCRICAO.AsString = '' then
    raise Exception.Create('Por favor, insira uma descri��o do perfil.');
end;

procedure TFrmPerfil.FormActivate(Sender: TObject);
begin
   modoEdicao := FrmMain.FQry_Login.FieldByName('PEDIDO_I').AsString +
                FrmMain.FQry_Login.FieldByName('PEDIDO_A').AsString +
                FrmMain.FQry_Login.FieldByName('PEDIDO_E').AsString;
  Executar := exibePanels;
  inherited;
  FDTabela.Open();
  Executar := habilitaBotoes;
  FQuery.Close;
  FQuery.Open();

end;

end.
