object FrmMain: TFrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Software Gerenciador Abastecimento'
  ClientHeight = 682
  ClientWidth = 817
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object PnLateralAcoes: TPanel
    Left = 0
    Top = 622
    Width = 817
    Height = 60
    Align = alBottom
    TabOrder = 0
    object BtnRelatorio: TBitBtn
      Left = 489
      Top = 12
      Width = 150
      Height = 35
      Caption = 'Relat'#243'rio'
      TabOrder = 0
      OnClick = BtnRelatorioClick
    end
    object BtnSair: TBitBtn
      Left = 653
      Top = 11
      Width = 150
      Height = 35
      Caption = 'Sair'
      TabOrder = 1
      OnClick = BtnSairClick
    end
  end
  object PnAreaTrabalho: TPanel
    Left = 0
    Top = 30
    Width = 817
    Height = 592
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    StyleElements = [seFont, seBorder]
  end
  object PnTopo: TPanel
    Left = 0
    Top = 0
    Width = 817
    Height = 30
    Align = alTop
    Color = clInfoBk
    ParentBackground = False
    TabOrder = 2
    StyleElements = [seFont, seBorder]
    object Label3: TLabel
      Left = 1
      Top = 1
      Width = 815
      Height = 28
      Align = alClient
      Alignment = taCenter
      Caption = 'Clique sobre a bomba desejada para registrar o abastecimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 342
      ExplicitHeight = 15
    end
  end
end
