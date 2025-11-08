object FrmAbastecimento: TFrmAbastecimento
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Registrar Abastecimento'
  ClientHeight = 229
  ClientWidth = 448
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 21
  object PnFundo: TPanel
    Left = 0
    Top = 0
    Width = 448
    Height = 179
    Align = alClient
    ParentColor = True
    TabOrder = 0
    StyleElements = [seFont, seBorder]
    object LabQtde: TLabel
      Left = 72
      Top = 72
      Width = 137
      Height = 21
      Caption = 'Quantidade (Litros):'
    end
    object LabValor: TLabel
      Left = 137
      Top = 112
      Width = 72
      Height = 21
      Caption = 'Valor (R$):'
    end
    object EdtQtde: TEdit
      Left = 215
      Top = 69
      Width = 120
      Height = 29
      TabOrder = 0
      OnExit = EdtQtdeExit
      OnKeyPress = EdtQtdeKeyPress
    end
    object EdtValor: TEdit
      Left = 215
      Top = 109
      Width = 120
      Height = 29
      TabOrder = 1
      OnExit = EdtValorExit
      OnKeyPress = EdtValorKeyPress
    end
    object PnInfoBomba: TPanel
      Left = 1
      Top = 1
      Width = 446
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Color = clSkyBlue
      Padding.Left = 10
      ParentBackground = False
      TabOrder = 2
      StyleElements = [seFont, seBorder]
      object LabInfoBomba: TLabel
        Left = 10
        Top = 0
        Width = 436
        Height = 41
        Align = alClient
        AutoSize = False
        Caption = 'Informa'#231#227'o da Bomba escolhida'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitLeft = 0
        ExplicitTop = 8
        ExplicitWidth = 446
        ExplicitHeight = 25
      end
    end
  end
  object PnAcoes: TPanel
    Left = 0
    Top = 179
    Width = 448
    Height = 50
    Align = alBottom
    ParentColor = True
    TabOrder = 1
    StyleElements = [seFont, seBorder]
    object BtnConfirmar: TBitBtn
      Left = 92
      Top = 9
      Width = 120
      Height = 30
      Caption = 'Confirmar'
      TabOrder = 0
      OnClick = BtnConfirmarClick
    end
    object BtnCancelar: TBitBtn
      Left = 226
      Top = 9
      Width = 120
      Height = 30
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = BtnCancelarClick
    end
  end
end
