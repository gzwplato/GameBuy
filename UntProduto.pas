unit UntProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UntPadrao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.Mask, Vcl.DBCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.ExtDlgs, Vcl.Menus;

type
  TFrmProduto = class(TFrmPadrao)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    DBEd_Preco: TDBEdit;
    FDTabelaID: TIntegerField;
    FDTabelaTITULO: TStringField;
    FDTabelaDESCRICAO: TStringField;
    FDTabelaFK_CATEGORIA: TIntegerField;
    FDTabelaDATA_LANCAMENTO: TSQLTimeStampField;
    FDTabelaSTATUS: TStringField;
    FDTabelaPRECO: TFloatField;
    FDTabelaDATA_CADASTRO: TSQLTimeStampField;
    FDTabelaDATA_ALTERACAO: TSQLTimeStampField;
    FDTabelaFK_USUARIO_ALT: TIntegerField;
    Label5: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    FDQryCategoria: TFDQuery;
    DSCategoria: TDataSource;
    DBImage1: TDBImage;
    Button1: TButton;
    DBMemo1: TDBMemo;
    Label6: TLabel;
    DBEdit3: TDBEdit;
    Label7: TLabel;
    FDTabelaFOTO: TMemoField;
    OpenPictureDialog1: TOpenPictureDialog;
    Label11: TLabel;
    DBEdit2: TDBEdit;
    DBChk_Ativo: TDBCheckBox;
    tulo1: TMenuItem;
    Categoria1: TMenuItem;
    PrecoAsc1: TMenuItem;
    DatadeAlterao1: TMenuItem;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    FDQueryDev: TFDQuery;
    FDQueryEdt: TFDQuery;
    DSDev: TDataSource;
    DSEdt: TDataSource;
    FDTabelaFK_EDITORA: TIntegerField;
    FDTabelaFK_DESENVOLVEDORA: TIntegerField;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FDTabelaNewRecord(DataSet: TDataSet);
    procedure FDTabelaBeforePost(DataSet: TDataSet);
    procedure Categoria1Click(Sender: TObject);
    procedure tulo1Click(Sender: TObject);
    procedure PrecoAsc1Click(Sender: TObject);
    procedure DatadeAlterao1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmProduto: TFrmProduto;

implementation

{$R *.dfm}

uses UntLogin, UntMain, UntDM, Jpeg, Clipbrd;

procedure TFrmProduto.Button1Click(Sender: TObject);
var
  jpg: TJPegImage;
  Stm: TStream;
begin
  inherited;
  if OpenPictureDialog1.Execute then
    if FileExists(OpenPictureDialog1.FileName) then
    begin
      jpg := TJpegImage.Create;
      jpg.LoadFromFile(OpenPictureDialog1.FileName);
      clipboard.Assign(jpg);
      DBImage1.PasteFromClipboard;
      jpg.Free;
    end
    else
      raise Exception.Create('Arquivo Inexistente !');
end;

procedure TFrmProduto.Categoria1Click(Sender: TObject);
begin
  inherited;
  FDTabela.IndexFieldNames := 'FK_CATEGORIA';
end;

procedure TFrmProduto.DatadeAlterao1Click(Sender: TObject);
begin
  inherited;
  FDTabela.IndexFieldNames := 'DATA_ALTERACAO';
end;

procedure TFrmProduto.FDTabelaBeforePost(DataSet: TDataSet);
begin //
  inherited;
  if (FDTabelaTITULO.AsString = '') or (VarIsNull(FDTabelaTITULO.AsVariant))
  then
  begin
    dbedit1.SetFocus;
    raise Exception.Create('Por favor, insira o T?tulo.');
  end
  else
  begin  //
    if (FDTabelaDESCRICAO.AsString = '') or
    (VarIsNull(FDTabelaDESCRICAO.AsVariant)) then
    begin
      DBMemo1.SetFocus;
      raise Exception.Create('Por favor, insira a Descri??o.');
    end
    else
    begin           //
      if (FDTabelaPRECO.Value = 0) or (VarIsNull(FDTabelaPRECO.AsVariant)) then
      begin
        DBEd_Preco.SetFocus;
        raise Exception.Create('Por favor, insira o Pre?o.');
      end
      else
      begin
        if (FDTabelaDATA_LANCAMENTO.AsString = '  /  /    ') or
        (VarIsNull(FDTabelaDATA_LANCAMENTO.AsVariant)) then
        begin
          dbedit3.SetFocus;
          raise Exception.Create('Por favor, insira a Data de Lan?amento.');
        end
        else
        begin
          if (FDTabelaSTATUS.AsString = '') or
          (VarIsNull(FDTabelaSTATUS.AsVariant)) then
          begin
            DBChk_Ativo.SetFocus;
            raise Exception.Create('Por favor, insira o Status.');
          end
          else
          begin
            if (DBLookupComboBox2.text = '') then
            begin
              DBLookupComboBox2.SetFocus;
              raise Exception.Create('Por favor, escolha uma editora.');
            end
            else
            begin
              if DBLookupComboBox3.Text = '' then
              begin
                DBLookupComboBox3.SetFocus;
                raise Exception.Create('Por favor, escolha uma editora.');
              end
            end
          end;

        end;

      end;
    end;
  end;








  end;

procedure TFrmProduto.FDTabelaNewRecord(DataSet: TDataSet);
begin
  inherited;
  FDTabelaPRECO.Value := 0;
  FDTabelaSTATUS.AsString := 'S';
end;

procedure TFrmProduto.FormActivate(Sender: TObject);
begin
  FDTabela.TableName := 'PRODUTO';
  modoEdicao := FrmMain.FQry_Login.FieldByName('PRODUTO_I').AsString +
                FrmMain.FQry_Login.FieldByName('PRODUTO_A').AsString +
                FrmMain.FQry_Login.FieldByName('PRODUTO_E').AsString;

  Executar := exibePanels;
  inherited;

  FdTabela.Open();

  FDQueryDev.Close;
  FDQueryDev.Open();


  FDQueryEdt.Close;
  FDQueryEdt.Open();


  FDQryCategoria.Close;
  FDQryCategoria.Open();

  FQuery.Close;
  FQuery.Open();

  Executar := habilitaBotoes;
end;

procedure TFrmProduto.PrecoAsc1Click(Sender: TObject);
begin
  inherited;
  FDTabela.IndexFieldNames := 'PRECO';
end;

procedure TFrmProduto.tulo1Click(Sender: TObject);
begin
  inherited;
  FDTabela.IndexFieldNames := 'TITULO';

end;

end.
