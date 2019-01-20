unit uWeather_Config_Towns;

interface

uses
  System.Classes,
  System.SysUtils,
  System.DateUtils,
  System.UITypes,
  FMX.Effects,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Graphics,
  FMX.Types,
  FMX.Grid,
  FMX.Edit,
  FMX.Layouts,
  FMX.Filter.Effects,
  OXmlPDOM,
  ALFmxTabControl,
  uWeather_AllTypes,
  Bass;

type
  TSEARCHTOWN_RESULTS = record
    woeid: string;
    name: string;
    state_1: string;
    country: string;
    country_code: string;
  end;

const
  cTemp_Towns = 'data\addons\weather\temp\Towns.xml';
  cTemp_Forcast = 'data\addons\weather\temp\ChoosenTown.xml';

const
  cPengui_Icons_Path = '\icons\pengui\';
  cClear_Icons_Path = '\icons\clear\';
  cIcy_Icons_Path = '\icons\icy\';

procedure uWeather_Config_Towns_Show;
procedure uWeather_Config_Towns_Free;

procedure uWeather_Config_Towns_Load;

procedure uWeather_Config_Towns_Edit(vLock: Boolean);
procedure uWeather_Config_Towns_Edit_SelectTown(vSelected: Integer);
procedure uWeather_Config_Towns_Edit_DeleteTown(vSelected: Integer);

procedure uWeather_Config_Towns_TownGoUp;
procedure uWeather_Config_Towns_TownGoDown;

procedure uWeather_Config_Towns_RefreshTown(mNum: Integer);
procedure uWeather_Config_Towsn_RefreshTownAll;

procedure uWeather_Config_Towns_AddNewTown_Panel;

procedure uWeather_Config_Towns_AddNewTown(vNum: Integer; mWoeid, country_code: string);

procedure uWeather_Config_Towns_CreateTown_Panel(mNum: Integer;
  mTownResults: TADDON_WEATHER_CONFIG_CREATE_PANEL);

var
  vSelected_Panel: TImage;
  vSelectedTown: Integer;
  vLoading_Integer: Integer;
  vNTXML: IXMLDocument;
  vNTRoot: PXMLNode;
  vNTNode: PXMLNode;
  vNTNode_1: PXMLNode;
  vNTNode_2: PXMLNode;
  vNTNode_3: PXMLNode;
  vNTAttribute: PXMLNode;

implementation

uses
  uLoad,
  uLoad_AllTypes,
  uWeather_Actions,
  uWeather_Convert,
  uWeather_SetAll,
  uWeather_Mouse,
  uWeather_Sounds,
  uWeather_Providers_Yahoo,
  main;

procedure uWeather_Config_Towns_Show;
var
  vi: Integer;
begin
  if addons.weather.Action.Provider <> '' then
  begin
    vWeather.Config.main.Right.Panels[1] := TPanel.Create(vWeather.Config.main.Right.Panel);
    vWeather.Config.main.Right.Panels[1].name := 'A_W_Config_Panels_1';
    vWeather.Config.main.Right.Panels[1].Parent := vWeather.Config.main.Right.Panel;
    vWeather.Config.main.Right.Panels[1].Align := TAlignLayout.Client;
    vWeather.Config.main.Right.Panels[1].Visible := True;

    vWeather.Config.main.Right.Towns.CityList := TVertScrollBox.Create(vWeather.Config.main.Right.Panels[1]);
    vWeather.Config.main.Right.Towns.CityList.name := 'A_W_Config_Towns_CityList_VerticalBox';
    vWeather.Config.main.Right.Towns.CityList.Parent := vWeather.Config.main.Right.Panels[1];
    vWeather.Config.main.Right.Towns.CityList.Width := vWeather.Config.main.Right.Panels[1].Width - 60;
    vWeather.Config.main.Right.Towns.CityList.Height := vWeather.Config.main.Right.Panels[1].Height - 20;
    vWeather.Config.main.Right.Towns.CityList.Position.X := 10;
    vWeather.Config.main.Right.Towns.CityList.Position.Y := 10;
    vWeather.Config.main.Right.Towns.CityList.Visible := True;

    vWeather.Config.main.Right.Towns.Add_Town := TImage.Create(vWeather.Config.main.Right.Panels[1]);
    vWeather.Config.main.Right.Towns.Add_Town.name := 'A_W_Config_Towns_Add';
    vWeather.Config.main.Right.Towns.Add_Town.Parent := vWeather.Config.main.Right.Panels[1];
    vWeather.Config.main.Right.Towns.Add_Town.Width := 34;
    vWeather.Config.main.Right.Towns.Add_Town.Height := 34;
    vWeather.Config.main.Right.Towns.Add_Town.Position.X := vWeather.Config.main.Right.Panels[1].Width - 43;
    vWeather.Config.main.Right.Towns.Add_Town.Position.Y := 30;
    vWeather.Config.main.Right.Towns.Add_Town.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_add.png');
    vWeather.Config.main.Right.Towns.Add_Town.OnClick := addons.weather.Input.mouse.Image.OnMouseClick;
    vWeather.Config.main.Right.Towns.Add_Town.OnMouseEnter := addons.weather.Input.mouse.Image.OnMouseEnter;
    vWeather.Config.main.Right.Towns.Add_Town.OnMouseLeave := addons.weather.Input.mouse.Image.OnMouseLeave;
    vWeather.Config.main.Right.Towns.Add_Town.Visible := True;

    vWeather.Config.main.Right.Towns.Add_Town_Glow :=
      TGlowEffect.Create(vWeather.Config.main.Right.Towns.Add_Town);
    vWeather.Config.main.Right.Towns.Add_Town_Glow.name := 'A_W_Config_Towns_Add_Glow';
    vWeather.Config.main.Right.Towns.Add_Town_Glow.Parent := vWeather.Config.main.Right.Towns.Add_Town;
    vWeather.Config.main.Right.Towns.Add_Town_Glow.Softness := 0.4;
    vWeather.Config.main.Right.Towns.Add_Town_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    vWeather.Config.main.Right.Towns.Add_Town_Glow.Opacity := 0.9;
    vWeather.Config.main.Right.Towns.Add_Town_Glow.Enabled := False;

    vWeather.Config.main.Right.Towns.Add_Town_Grey :=
      TMonochromeEffect.Create(vWeather.Config.main.Right.Towns.Add_Town);
    vWeather.Config.main.Right.Towns.Add_Town_Grey.name := 'A_W_Config_Towns_Add_Grey';
    vWeather.Config.main.Right.Towns.Add_Town_Grey.Parent := vWeather.Config.main.Right.Towns.Add_Town;
    vWeather.Config.main.Right.Towns.Add_Town_Grey.Enabled := False;

    vWeather.Config.main.Right.Towns.EditLock := TImage.Create(vWeather.Config.main.Right.Panels[1]);
    vWeather.Config.main.Right.Towns.EditLock.name := 'A_W_Config_Towns_Lock';
    vWeather.Config.main.Right.Towns.EditLock.Parent := vWeather.Config.main.Right.Panels[1];
    vWeather.Config.main.Right.Towns.EditLock.Width := 40;
    vWeather.Config.main.Right.Towns.EditLock.Height := 40;
    vWeather.Config.main.Right.Towns.EditLock.Position.X := vWeather.Config.main.Right.Panels[1].Width - 46;
    vWeather.Config.main.Right.Towns.EditLock.Position.Y := vWeather.Config.main.Right.Panels[1].Height - 280;
    vWeather.Config.main.Right.Towns.EditLock.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_lock.png');
    vWeather.Config.main.Right.Towns.EditLock.OnClick := addons.weather.Input.mouse.Image.OnMouseClick;
    vWeather.Config.main.Right.Towns.EditLock.OnMouseEnter := addons.weather.Input.mouse.Image.OnMouseEnter;
    vWeather.Config.main.Right.Towns.EditLock.OnMouseLeave := addons.weather.Input.mouse.Image.OnMouseLeave;
    vWeather.Config.main.Right.Towns.EditLock.Visible := True;

    vWeather.Config.main.Right.Towns.EditLock_Glow :=
      TGlowEffect.Create(vWeather.Config.main.Right.Towns.EditLock);
    vWeather.Config.main.Right.Towns.EditLock_Glow.name := 'A_W_Config_Towns_Lock_Glow';
    vWeather.Config.main.Right.Towns.EditLock_Glow.Parent := vWeather.Config.main.Right.Towns.EditLock;
    vWeather.Config.main.Right.Towns.EditLock_Glow.Softness := 0.4;
    vWeather.Config.main.Right.Towns.EditLock_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    vWeather.Config.main.Right.Towns.EditLock_Glow.Opacity := 0.9;
    vWeather.Config.main.Right.Towns.EditLock_Glow.Enabled := False;

    vWeather.Config.main.Right.Towns.GoUp := TImage.Create(vWeather.Config.main.Right.Panels[1]);
    vWeather.Config.main.Right.Towns.GoUp.name := 'A_W_Config_Towns_PosUp';
    vWeather.Config.main.Right.Towns.GoUp.Parent := vWeather.Config.main.Right.Panels[1];
    vWeather.Config.main.Right.Towns.GoUp.Width := 34;
    vWeather.Config.main.Right.Towns.GoUp.Height := 34;
    vWeather.Config.main.Right.Towns.GoUp.Position.X := vWeather.Config.main.Right.Panels[1].Width - 43;
    vWeather.Config.main.Right.Towns.GoUp.Position.Y := vWeather.Config.main.Right.Panels[1].Height - 220;
    vWeather.Config.main.Right.Towns.GoUp.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_up.png');
    vWeather.Config.main.Right.Towns.GoUp.OnClick := addons.weather.Input.mouse.Image.OnMouseClick;
    vWeather.Config.main.Right.Towns.GoUp.OnMouseEnter := addons.weather.Input.mouse.Image.OnMouseEnter;
    vWeather.Config.main.Right.Towns.GoUp.OnMouseLeave := addons.weather.Input.mouse.Image.OnMouseLeave;
    vWeather.Config.main.Right.Towns.GoUp.Visible := True;

    vWeather.Config.main.Right.Towns.GoUp_Glow := TGlowEffect.Create(vWeather.Config.main.Right.Towns.GoUp);
    vWeather.Config.main.Right.Towns.GoUp_Glow.name := 'A_W_Config_Towns_PosUp_Glow';
    vWeather.Config.main.Right.Towns.GoUp_Glow.Parent := vWeather.Config.main.Right.Towns.GoUp;
    vWeather.Config.main.Right.Towns.GoUp_Glow.Softness := 0.4;
    vWeather.Config.main.Right.Towns.GoUp_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    vWeather.Config.main.Right.Towns.GoUp_Glow.Opacity := 0.9;
    vWeather.Config.main.Right.Towns.GoUp_Glow.Enabled := False;

    vWeather.Config.main.Right.Towns.GoUp_Grey :=
      TMonochromeEffect.Create(vWeather.Config.main.Right.Towns.GoUp);
    vWeather.Config.main.Right.Towns.GoUp_Grey.name := 'A_W_Config_Towns_PosUp_Grey';
    vWeather.Config.main.Right.Towns.GoUp_Grey.Parent := vWeather.Config.main.Right.Towns.GoUp;
    vWeather.Config.main.Right.Towns.GoUp_Grey.Enabled := True;

    vWeather.Config.main.Right.Towns.GoDown := TImage.Create(vWeather.Config.main.Right.Panels[1]);
    vWeather.Config.main.Right.Towns.GoDown.name := 'A_W_Config_Towns_PosDown';
    vWeather.Config.main.Right.Towns.GoDown.Parent := vWeather.Config.main.Right.Panels[1];
    vWeather.Config.main.Right.Towns.GoDown.Width := 34;
    vWeather.Config.main.Right.Towns.GoDown.Height := 34;
    vWeather.Config.main.Right.Towns.GoDown.Position.X := vWeather.Config.main.Right.Panels[1].Width - 43;
    vWeather.Config.main.Right.Towns.GoDown.Position.Y := vWeather.Config.main.Right.Panels[1].Height - 190;
    vWeather.Config.main.Right.Towns.GoDown.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_down.png');
    vWeather.Config.main.Right.Towns.GoDown.OnClick := addons.weather.Input.mouse.Image.OnMouseClick;
    vWeather.Config.main.Right.Towns.GoDown.OnMouseEnter := addons.weather.Input.mouse.Image.OnMouseEnter;
    vWeather.Config.main.Right.Towns.GoDown.OnMouseLeave := addons.weather.Input.mouse.Image.OnMouseLeave;
    vWeather.Config.main.Right.Towns.GoDown.Visible := True;

    vWeather.Config.main.Right.Towns.GoDown_Glow :=
      TGlowEffect.Create(vWeather.Config.main.Right.Towns.GoDown);
    vWeather.Config.main.Right.Towns.GoDown_Glow.name := 'A_W_Config_Towns_PosDown_Glow';
    vWeather.Config.main.Right.Towns.GoDown_Glow.Parent := vWeather.Config.main.Right.Towns.GoDown;
    vWeather.Config.main.Right.Towns.GoDown_Glow.Softness := 0.4;
    vWeather.Config.main.Right.Towns.GoDown_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    vWeather.Config.main.Right.Towns.GoDown_Glow.Opacity := 0.9;
    vWeather.Config.main.Right.Towns.GoDown_Glow.Enabled := False;

    vWeather.Config.main.Right.Towns.GoDown_Grey :=
      TMonochromeEffect.Create(vWeather.Config.main.Right.Towns.GoDown);
    vWeather.Config.main.Right.Towns.GoDown_Grey.name := 'A_W_Config_Towns_PosDown_Grey';
    vWeather.Config.main.Right.Towns.GoDown_Grey.Parent := vWeather.Config.main.Right.Towns.GoDown;
    vWeather.Config.main.Right.Towns.GoDown_Grey.Enabled := True;

    vWeather.Config.main.Right.Towns.Refresh_Icon := TImage.Create(vWeather.Config.main.Right.Panels[1]);
    vWeather.Config.main.Right.Towns.Refresh_Icon.name := 'A_W_Config_Towns_Refresh';
    vWeather.Config.main.Right.Towns.Refresh_Icon.Parent := vWeather.Config.main.Right.Panels[1];
    vWeather.Config.main.Right.Towns.Refresh_Icon.Width := 34;
    vWeather.Config.main.Right.Towns.Refresh_Icon.Height := 34;
    vWeather.Config.main.Right.Towns.Refresh_Icon.Position.X := vWeather.Config.main.Right.Panels[1]
      .Width - 43;
    vWeather.Config.main.Right.Towns.Refresh_Icon.Position.Y := vWeather.Config.main.Right.Panels[1]
      .Height - 120;
    vWeather.Config.main.Right.Towns.Refresh_Icon.Bitmap.LoadFromFile
      (addons.weather.Path.Images + 'w_refresh.png');
    vWeather.Config.main.Right.Towns.Refresh_Icon.OnClick := addons.weather.Input.mouse.Image.OnMouseClick;
    vWeather.Config.main.Right.Towns.Refresh_Icon.OnMouseEnter :=
      addons.weather.Input.mouse.Image.OnMouseEnter;
    vWeather.Config.main.Right.Towns.Refresh_Icon.OnMouseLeave :=
      addons.weather.Input.mouse.Image.OnMouseLeave;
    vWeather.Config.main.Right.Towns.Refresh_Icon.Visible := True;

    vWeather.Config.main.Right.Towns.Refresh_Glow :=
      TGlowEffect.Create(vWeather.Config.main.Right.Towns.Refresh_Icon);
    vWeather.Config.main.Right.Towns.Refresh_Glow.name := 'A_W_Config_Towns_Refresh_Glow';
    vWeather.Config.main.Right.Towns.Refresh_Glow.Parent := vWeather.Config.main.Right.Towns.Refresh_Icon;
    vWeather.Config.main.Right.Towns.Refresh_Glow.Softness := 0.4;
    vWeather.Config.main.Right.Towns.Refresh_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    vWeather.Config.main.Right.Towns.Refresh_Glow.Opacity := 0.9;
    vWeather.Config.main.Right.Towns.Refresh_Glow.Enabled := False;

    vWeather.Config.main.Right.Towns.Refresh_Grey :=
      TMonochromeEffect.Create(vWeather.Config.main.Right.Towns.Refresh_Icon);
    vWeather.Config.main.Right.Towns.Refresh_Grey.name := 'A_W_Config_Towns_Refresh_Grey';
    vWeather.Config.main.Right.Towns.Refresh_Grey.Parent := vWeather.Config.main.Right.Towns.Refresh_Icon;
    vWeather.Config.main.Right.Towns.Refresh_Grey.Enabled := True;

    vWeather.Config.main.Right.Towns.Delete_Icon := TImage.Create(vWeather.Config.main.Right.Panels[1]);
    vWeather.Config.main.Right.Towns.Delete_Icon.name := 'A_W_Config_Towns_Delete';
    vWeather.Config.main.Right.Towns.Delete_Icon.Parent := vWeather.Config.main.Right.Panels[1];
    vWeather.Config.main.Right.Towns.Delete_Icon.Width := 34;
    vWeather.Config.main.Right.Towns.Delete_Icon.Height := 35;
    vWeather.Config.main.Right.Towns.Delete_Icon.Position.X := vWeather.Config.main.Right.Panels[1]
      .Width - 43;
    vWeather.Config.main.Right.Towns.Delete_Icon.Position.Y := vWeather.Config.main.Right.Panels[1]
      .Height - 60;
    vWeather.Config.main.Right.Towns.Delete_Icon.Bitmap.LoadFromFile
      (addons.weather.Path.Images + 'w_delete.png');
    vWeather.Config.main.Right.Towns.Delete_Icon.OnClick := addons.weather.Input.mouse.Image.OnMouseClick;
    vWeather.Config.main.Right.Towns.Delete_Icon.OnMouseEnter :=
      addons.weather.Input.mouse.Image.OnMouseEnter;
    vWeather.Config.main.Right.Towns.Delete_Icon.OnMouseLeave :=
      addons.weather.Input.mouse.Image.OnMouseLeave;
    vWeather.Config.main.Right.Towns.Delete_Icon.Visible := True;

    vWeather.Config.main.Right.Towns.Delete_Glow :=
      TGlowEffect.Create(vWeather.Config.main.Right.Towns.Delete_Icon);
    vWeather.Config.main.Right.Towns.Delete_Glow.name := 'A_W_Config_Towns_Delete_Glow';
    vWeather.Config.main.Right.Towns.Delete_Glow.Parent := vWeather.Config.main.Right.Towns.Delete_Icon;
    vWeather.Config.main.Right.Towns.Delete_Glow.Softness := 0.4;
    vWeather.Config.main.Right.Towns.Delete_Glow.GlowColor := TAlphaColorRec.Red;
    vWeather.Config.main.Right.Towns.Delete_Glow.Opacity := 0.9;
    vWeather.Config.main.Right.Towns.Delete_Glow.Enabled := False;

    vWeather.Config.main.Right.Towns.Delete_Grey :=
      TMonochromeEffect.Create(vWeather.Config.main.Right.Towns.Delete_Icon);
    vWeather.Config.main.Right.Towns.Delete_Grey.name := 'A_W_Config_Towns_Delete_Grey';
    vWeather.Config.main.Right.Towns.Delete_Grey.Parent := vWeather.Config.main.Right.Towns.Delete_Icon;
    vWeather.Config.main.Right.Towns.Delete_Grey.Enabled := True;

    uWeather_Config_Towns_Load;
  end
  else
  begin

  end;
end;

procedure uWeather_Config_Towns_Free;
begin
  FreeAndNil(vWeather.Config.main.Right.Panels[1]);
end;

procedure uWeather_Config_Towns_Load;
var
  vi: Integer;
begin
  // for vi := 0 to addons.weather.Action.Active_Total do
  // uWeather_Config_Towns_CreateTown_Panel(vi, addons.weather.Action.Choosen[vi]);
end;

procedure uWeather_Config_Towns_AddNewTown_Panel;
begin
  // uWeather_Config_Towns_AddNewTown(addons.weather.Action.Active_Total + 1,
  // vCTTempResults[vSelectedTown].woeid, vCTTempResults[vSelectedTown].country_code);
end;
/// /////////////////////////////////////////////////////////////////////////////
// Add New town Panel Actions

procedure uWeather_Config_Towns_AddNewTown(vNum: Integer; mWoeid, country_code: string);
var
  vForcast_Resutls: TStringList;
  vDegree: String;
  vDay: byte;
begin
  vForcast_Resutls := TStringList.Create;

  if addons.weather.Action.Degree = 'Celcius' then
    vDegree := 'c'
  else if addons.weather.Action.Degree = 'Fahrenheit' then
    vDegree := 'f';

  vForcast_Resutls.Add(Main_Form.Main_IdHttp.Get
    ('http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D' +
    mWoeid + '%20and%20u%3D%27' + vDegree +
    '%27&format=xml&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys%20HTTP/1.1'));
  vForcast_Resutls.SaveToFile(extrafe.prog.Path + cTemp_Forcast);

  vNTXML := CreateXMLDoc;
  vNTXML.LoadFromFile(extrafe.prog.Path + cTemp_Forcast);
  vNTRoot := vNTXML.DocumentElement;

  SetLength(addons.weather.Action.Choosen, vNum + 1);

  addons.weather.Action.Choosen[vNum].Provider := addons.weather.Action.Provider;
  addons.weather.Action.Choosen[vNum].woeid := mWoeid;
  addons.weather.Action.Choosen[vNum].Country_FlagCode := LowerCase(country_code);
  vDay := 0;

  vNTNode := nil;

  while vNTRoot.GetNextChild(vNTNode) do
    while vNTNode.GetNextChild(vNTNode_1) do
      while vNTNode_1.GetNextChild(vNTNode_2) do
      begin
        vNTAttribute := nil;
        if vNTNode_2.NodeName = 'yweather:location' then
        begin
          vNTNode_2.FindAttribute('city', vNTAttribute);
          addons.weather.Action.Choosen[vNum].City := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('country', vNTAttribute);
          addons.weather.Action.Choosen[vNum].country := vNTAttribute.NodeValue;
        end
        else if vNTNode_2.NodeName = 'lastBuildDate' then
        begin
          addons.weather.Action.Choosen[vNum].LastUpdate := vNTNode_2.Text;
        end
        else if vNTNode_2.NodeName = 'yweather:units' then
        begin
          vNTNode_2.FindAttribute('temperature', vNTAttribute);
          addons.weather.Action.Choosen[vNum].UnitV.Temperature := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('speed', vNTAttribute);
          addons.weather.Action.Choosen[vNum].UnitV.Speed := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('pressure', vNTAttribute);
          addons.weather.Action.Choosen[vNum].UnitV.Pressure := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('distance', vNTAttribute);
          addons.weather.Action.Choosen[vNum].UnitV.Distance := vNTAttribute.NodeValue;
        end
        else if vNTNode_2.NodeName = 'yweather:wind' then
        begin
          vNTNode_2.FindAttribute('speed', vNTAttribute);
          addons.weather.Action.Choosen[vNum].Wind.Speed := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('direction', vNTAttribute);
          addons.weather.Action.Choosen[vNum].Wind.Direction := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('chill', vNTAttribute);
          addons.weather.Action.Choosen[vNum].Wind.Chill := vNTAttribute.NodeValue;
        end
        else if vNTNode_2.NodeName = 'yweather:atmosphere' then
        begin
          vNTNode_2.FindAttribute('pressure', vNTAttribute);
          addons.weather.Action.Choosen[vNum].Atmosphere.Pressure := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('visibility', vNTAttribute);
          addons.weather.Action.Choosen[vNum].Atmosphere.Visibility := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('rising', vNTAttribute);
          addons.weather.Action.Choosen[vNum].Atmosphere.Rising := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('humidity', vNTAttribute);
          addons.weather.Action.Choosen[vNum].Atmosphere.Humidity := vNTAttribute.NodeValue;
        end
        else if vNTNode_2.NodeName = 'yweather:astronomy' then
        begin
          vNTNode_2.FindAttribute('sunset', vNTAttribute);
          addons.weather.Action.Choosen[vNum].Astronomy.Sunset :=
            uWeather_Convert_FixAstronomy(vNTAttribute.NodeValue);
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('sunrise', vNTAttribute);
          addons.weather.Action.Choosen[vNum].Astronomy.Sunrise :=
            uWeather_Convert_FixAstronomy(vNTAttribute.NodeValue);
        end
        else if vNTNode_2.NodeName = 'item' then
        begin
          while vNTNode_2.GetNextChild(vNTNode_3) do
          begin
            vNTAttribute := nil;
            if vNTNode_3.NodeName = 'yweather:condition' then
            begin
              vNTNode_3.FindAttribute('temp', vNTAttribute);
              addons.weather.Action.Choosen[vNum].Temp_Condition := vNTAttribute.NodeValue;
              vNTAttribute := nil;
              vNTNode_3.FindAttribute('date', vNTAttribute);
              addons.weather.Action.Choosen[vNum].LastChecked := vNTAttribute.NodeValue;
              vNTAttribute := nil;
              vNTNode_3.FindAttribute('code', vNTAttribute);
              addons.weather.Action.Choosen[vNum].Code := vNTAttribute.NodeValue;
              vNTAttribute := nil;
              vNTNode_3.FindAttribute('text', vNTAttribute);
              addons.weather.Action.Choosen[vNum].Text_Condtition := vNTAttribute.NodeValue;
            end
            else if vNTNode_3.NodeName = 'yweather:forecast' then
            begin
              case vDay of
                0:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Current.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Current.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Current.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Current.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Current.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Current.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                1:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_1.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_1.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_1.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_1.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_1.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_1.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                2:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_2.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_2.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_2.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_2.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_2.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_2.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                3:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_3.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_3.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_3.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_3.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_3.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_3.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                4:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_4.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_4.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_4.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_4.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_4.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_4.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                5:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_5.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_5.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_5.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_5.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_5.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_5.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                6:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_6.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_6.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_6.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_6.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_6.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_6.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                7:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_7.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_7.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_7.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_7.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_7.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_7.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                8:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_8.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_8.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_8.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_8.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_8.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_8.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                9:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_9.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_9.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_9.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_9.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_9.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    addons.weather.Action.Choosen[vNum].Day_9.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
              end;
            end;
          end;
        end;
      end;

  addons.weather.Action.Active_Total := vNum;
  addons.weather.Ini.Ini.WriteInteger('Active', 'Active_Total', addons.weather.Action.Active_Total);
  addons.weather.Ini.Ini.WriteString(addons.weather.Action.Provider,
    addons.weather.Action.Active_Total.ToString + '_WoeID', addons.weather.Action.Choosen[vNum].woeid + '{' +
    addons.weather.Action.Choosen[vNum].Country_FlagCode + '}');
  // uWeather_Config_Towns_CreateTown_Panel(vNum, addons.weather.Action.Choosen[vNum]);
  uWeather_Provider_Yahoo_CreateTab(addons.weather.Action.Choosen[vNum], vNum);
  DeleteFile(extrafe.prog.Path + cTemp_Forcast);
end;

procedure uWeather_Config_Towns_CreateTown_Panel(mNum: Integer;
  mTownResults: TADDON_WEATHER_CONFIG_CREATE_PANEL);
begin
  SetLength(vWeather.Config.main.Right.Towns.Town, mNum + 1);

  vWeather.Config.main.Right.Towns.Town[mNum].Panel :=
    TPanel.Create(vWeather.Config.main.Right.Towns.CityList);
  vWeather.Config.main.Right.Towns.Town[mNum].Panel.name := 'Weather_Config_Towns_CityNum_' + IntToStr(mNum);
  vWeather.Config.main.Right.Towns.Town[mNum].Panel.Parent := vWeather.Config.main.Right.Towns.CityList;
  vWeather.Config.main.Right.Towns.Town[mNum].Panel.SetBounds(6, 6 + (mNum * 86),
    vWeather.Config.main.Right.Towns.CityList.Width - 24, 80);
  vWeather.Config.main.Right.Towns.Town[mNum].Panel.OnClick := addons.weather.Input.mouse.Panel.OnMouseClick;
  vWeather.Config.main.Right.Towns.Town[mNum].Panel.OnMouseEnter :=
    addons.weather.Input.mouse.Panel.OnMouseEnter;
  vWeather.Config.main.Right.Towns.Town[mNum].Panel.OnMouseLeave :=
    addons.weather.Input.mouse.Panel.OnMouseLeave;
  vWeather.Config.main.Right.Towns.Town[mNum].Panel.Tag := mNum;
  vWeather.Config.main.Right.Towns.Town[mNum].Panel.TagFloat := 1000;
  vWeather.Config.main.Right.Towns.Town[mNum].Panel.Visible := True;

  vWeather.Config.main.Right.Towns.Town[mNum].Glow_Panel :=
    TGlowEffect.Create(vWeather.Config.main.Right.Towns.Town[mNum].Panel);
  vWeather.Config.main.Right.Towns.Town[mNum].Glow_Panel.name := 'Weather_Config_Towns_CityNum_' +
    IntToStr(mNum) + '_Glow';
  vWeather.Config.main.Right.Towns.Town[mNum].Glow_Panel.Parent := vWeather.Config.main.Right.Towns.Town
    [mNum].Panel;
  vWeather.Config.main.Right.Towns.Town[mNum].Glow_Panel.GlowColor := TAlphaColorRec.Deepskyblue;
  vWeather.Config.main.Right.Towns.Town[mNum].Glow_Panel.Enabled := False;
  vWeather.Config.main.Right.Towns.Town[mNum].Glow_Panel.Opacity := 0.9;
  vWeather.Config.main.Right.Towns.Town[mNum].Glow_Panel.Softness := 0.4;
  vWeather.Config.main.Right.Towns.Town[mNum].Glow_Panel.Tag := mNum;

  vWeather.Config.main.Right.Towns.Town[mNum].Date :=
    TLabel.Create(vWeather.Config.main.Right.Towns.Town[mNum].Panel);
  vWeather.Config.main.Right.Towns.Town[mNum].Date.name := 'Weather_Config_Towns_CityNum_' + IntToStr(mNum)
    + '_Date';
  vWeather.Config.main.Right.Towns.Town[mNum].Date.Parent := vWeather.Config.main.Right.Towns.Town
    [mNum].Panel;
  vWeather.Config.main.Right.Towns.Town[mNum].Date.SetBounds
    ((vWeather.Config.main.Right.Towns.Town[mNum].Panel.Width / 2) - 120, 3, 240, 17);
  vWeather.Config.main.Right.Towns.Town[mNum].Date.Text := mTownResults.Last_Checked;
  vWeather.Config.main.Right.Towns.Town[mNum].Date.TextSettings.HorzAlign := TTextAlign.Center;
  vWeather.Config.main.Right.Towns.Town[mNum].Date.OnMouseEnter :=
    addons.weather.Input.mouse.VLabel.OnMouseEnter;
  vWeather.Config.main.Right.Towns.Town[mNum].Date.OnMouseLeave :=
    addons.weather.Input.mouse.VLabel.OnMouseLeave;
  vWeather.Config.main.Right.Towns.Town[mNum].Date.OnClick := addons.weather.Input.mouse.VLabel.OnMouseClick;
  vWeather.Config.main.Right.Towns.Town[mNum].Date.Tag := mNum;
  vWeather.Config.main.Right.Towns.Town[mNum].Date.TagFloat := 1000;
  vWeather.Config.main.Right.Towns.Town[mNum].Date.Visible := True;

  vWeather.Config.main.Right.Towns.Town[mNum].Image :=
    TImage.Create(vWeather.Config.main.Right.Towns.Town[mNum].Panel);
  vWeather.Config.main.Right.Towns.Town[mNum].Image.name := 'Weather_Config_Towns_CityNum_' + IntToStr(mNum)
    + '_Image';
  vWeather.Config.main.Right.Towns.Town[mNum].Image.Parent := vWeather.Config.main.Right.Towns.Town
    [mNum].Panel;
  vWeather.Config.main.Right.Towns.Town[mNum].Image.SetBounds(6,6, 60, 60);
  vWeather.Config.main.Right.Towns.Town[mNum].Image.Bitmap.LoadFromFile(addons.weather.Path.Iconsets +
    addons.weather.Config.Iconset.name + '\w_w_' + mTownResults.Temp_Icon + '.png');
  vWeather.Config.main.Right.Towns.Town[mNum].Image.OnMouseEnter :=
    addons.weather.Input.mouse.Image.OnMouseEnter;
  vWeather.Config.main.Right.Towns.Town[mNum].Image.OnMouseLeave :=
    addons.weather.Input.mouse.Image.OnMouseLeave;
  vWeather.Config.main.Right.Towns.Town[mNum].Image.OnClick := addons.weather.Input.mouse.Image.OnMouseClick;
  vWeather.Config.main.Right.Towns.Town[mNum].Image.Tag := mNum;
  vWeather.Config.main.Right.Towns.Town[mNum].Image.TagFloat := 1000;
  vWeather.Config.main.Right.Towns.Town[mNum].Image.Visible := True;

  vWeather.Config.main.Right.Towns.Town[mNum].Temp :=
    TLabel.Create(vWeather.Config.main.Right.Towns.Town[mNum].Panel);
  vWeather.Config.main.Right.Towns.Town[mNum].Temp.name := 'Weather_Config_Towns_CityNum_' + IntToStr(mNum)
    + '_Temp';
  vWeather.Config.main.Right.Towns.Town[mNum].Temp.Parent := vWeather.Config.main.Right.Towns.Town
    [mNum].Panel;
  vWeather.Config.main.Right.Towns.Town[mNum].Temp.SetBounds(80, 32, 150, 17);
  vWeather.Config.main.Right.Towns.Town[mNum].Temp.Font.Size := 24;
  vWeather.Config.main.Right.Towns.Town[mNum].Temp.Text := mTownResults.Temp + ' ͦ ' + mTownResults.Temp_Unit;
  vWeather.Config.main.Right.Towns.Town[mNum].Temp.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Config.main.Right.Towns.Town[mNum].Temp.OnMouseEnter :=
    addons.weather.Input.mouse.VLabel.OnMouseEnter;
  vWeather.Config.main.Right.Towns.Town[mNum].Temp.OnMouseLeave :=
    addons.weather.Input.mouse.VLabel.OnMouseLeave;
  vWeather.Config.main.Right.Towns.Town[mNum].Temp.OnClick := addons.weather.Input.mouse.VLabel.OnMouseClick;
  vWeather.Config.main.Right.Towns.Town[mNum].Temp.Tag := mNum;
  vWeather.Config.main.Right.Towns.Town[mNum].Temp.TagFloat := 1000;
  vWeather.Config.main.Right.Towns.Town[mNum].Temp.Visible := True;

  vWeather.Config.main.Right.Towns.Town[mNum].Temp_Comment :=
    TLabel.Create(vWeather.Config.main.Right.Towns.Town[mNum].Panel);
  vWeather.Config.main.Right.Towns.Town[mNum].Temp_Comment.name := 'Weather_Config_Towns_CityNum_' +
    IntToStr(mNum) + '_Temp_Comment';
  vWeather.Config.main.Right.Towns.Town[mNum].Temp_Comment.Parent := vWeather.Config.main.Right.Towns.Town
    [mNum].Panel;
  vWeather.Config.main.Right.Towns.Town[mNum].Temp_Comment.SetBounds(6, 60, 300, 17);
  vWeather.Config.main.Right.Towns.Town[mNum].Temp_Comment.Text := mTownResults.Temp_Description;
  vWeather.Config.main.Right.Towns.Town[mNum].Temp_Comment.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Config.main.Right.Towns.Town[mNum].Temp_Comment.OnMouseEnter :=
    addons.weather.Input.mouse.VLabel.OnMouseEnter;
  vWeather.Config.main.Right.Towns.Town[mNum].Temp_Comment.OnMouseLeave :=
    addons.weather.Input.mouse.VLabel.OnMouseLeave;
  vWeather.Config.main.Right.Towns.Town[mNum].Temp_Comment.OnClick :=
    addons.weather.Input.mouse.VLabel.OnMouseClick;
  vWeather.Config.main.Right.Towns.Town[mNum].Temp_Comment.Tag := mNum;
  vWeather.Config.main.Right.Towns.Town[mNum].Temp_Comment.TagFloat := 1000;
  vWeather.Config.main.Right.Towns.Town[mNum].Temp_Comment.Visible := True;

  vWeather.Config.main.Right.Towns.Town[mNum].City_Name :=
    TLabel.Create(vWeather.Config.main.Right.Towns.Town[mNum].Panel);
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name.name := 'Weather_Config_Towns_CityNum_' +
    IntToStr(mNum) + '_CityName';
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name.Parent := vWeather.Config.main.Right.Towns.Town
    [mNum].Panel;
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name.SetBounds(140, 32, 200, 17);
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name.Text := 'City Name : ';
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name.OnMouseEnter :=
    addons.weather.Input.mouse.VLabel.OnMouseEnter;
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name.OnMouseLeave :=
    addons.weather.Input.mouse.VLabel.OnMouseLeave;
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name.OnClick :=
    addons.weather.Input.mouse.VLabel.OnMouseClick;
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name.Tag := mNum;
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name.TagFloat := 1000;
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name.Visible := True;

  vWeather.Config.main.Right.Towns.Town[mNum].City_Name_V :=
    TLabel.Create(vWeather.Config.main.Right.Towns.Town[mNum].Panel);
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name_V.name := 'Weather_Config_Towns_CityNum_V_' +
    IntToStr(mNum) + '_CityName';
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name_V.Parent := vWeather.Config.main.Right.Towns.Town
    [mNum].Panel;
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name_V.SetBounds(210, 32, 200, 17);
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name_V.Text := mTownResults.City_Name;
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name_V.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name_V.OnMouseEnter :=
    addons.weather.Input.mouse.VLabel.OnMouseEnter;
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name_V.OnMouseLeave :=
    addons.weather.Input.mouse.VLabel.OnMouseLeave;
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name_V.OnClick :=
    addons.weather.Input.mouse.VLabel.OnMouseClick;
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name_V.Tag := mNum;
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name_V.TagFloat := 1000;
  vWeather.Config.main.Right.Towns.Town[mNum].City_Name_V.Visible := True;

  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name :=
    TLabel.Create(vWeather.Config.main.Right.Towns.Town[mNum].Panel);
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name.name := 'Weather_Config_Towns_CityNum_' +
    IntToStr(mNum) + '_CCountryName';
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name.Parent := vWeather.Config.main.Right.Towns.Town
    [mNum].Panel;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name.SetBounds(140, 60, 300, 17);
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name.Text := 'Country Name : ';
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name.OnMouseEnter :=
    addons.weather.Input.mouse.VLabel.OnMouseEnter;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name.OnMouseLeave :=
    addons.weather.Input.mouse.VLabel.OnMouseLeave;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name.OnClick :=
    addons.weather.Input.mouse.VLabel.OnMouseClick;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name.Tag := mNum;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name.TagFloat := 1000;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name.Visible := True;

  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name_V :=
    TLabel.Create(vWeather.Config.main.Right.Towns.Town[mNum].Panel);
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name_V.name := 'Weather_Config_Towns_CityNum_V_' +
    IntToStr(mNum) + '_CCountryName';
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name_V.Parent := vWeather.Config.main.Right.Towns.Town
    [mNum].Panel;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name_V.SetBounds(240, 60, 300, 17);
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name_V.Text := mTownResults.Country_Name;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name_V.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name_V.OnMouseEnter :=
    addons.weather.Input.mouse.VLabel.OnMouseEnter;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name_V.OnMouseLeave :=
    addons.weather.Input.mouse.VLabel.OnMouseLeave;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name_V.OnClick :=
    addons.weather.Input.mouse.VLabel.OnMouseClick;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name_V.Tag := mNum;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name_V.TagFloat := 1000;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Name_V.Visible := True;

  vWeather.Config.main.Right.Towns.Town[mNum].Country_Flag :=
    TImage.Create(vWeather.Config.main.Right.Towns.Town[mNum].Panel);
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Flag.name := 'Weather_Config_Towns_CityNum_' +
    IntToStr(mNum) + '_CountryFlag';
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Flag.Parent := vWeather.Config.main.Right.Towns.Town
    [mNum].Panel;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Flag.Width := 50;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Flag.Height := 40;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Flag.Position.X := 350;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Flag.Position.Y := 20;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Flag.Bitmap.LoadFromFile
    (ex_main.Paths.Flags_Images + mTownResults.Country_Flag + '.png');
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Flag.OnMouseEnter :=
    addons.weather.Input.mouse.Image.OnMouseEnter;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Flag.OnMouseLeave :=
    addons.weather.Input.mouse.Image.OnMouseLeave;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Flag.OnClick :=
    addons.weather.Input.mouse.Image.OnMouseClick;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Flag.Tag := mNum;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Flag.TagFloat := 1000;
  vWeather.Config.main.Right.Towns.Town[mNum].Country_Flag.Visible := True;
end;

procedure uWeather_Config_Towns_TownGoUp;
var
  vGoto: Integer;
  vCurrentTown, vChangedTown: TADDON_WEATHER_CHOOSENTOWN;
  vi: Integer;
begin
  vGoto := addons.weather.Config.Selected_Town - 1;

  // Change the string record
  vCurrentTown := addons.weather.Action.Choosen[addons.weather.Config.Selected_Town];
  vChangedTown := addons.weather.Action.Choosen[vGoto];

  addons.weather.Action.Choosen[vGoto] := vCurrentTown;
  addons.weather.Action.Choosen[addons.weather.Config.Selected_Town] := vChangedTown;

  // Change the places of the panels in town config
  for vi := 0 to addons.weather.Action.Active_Total do
    FreeAndNil(vWeather.Config.main.Right.Towns.Town[vi]);

  // for vi := 0 to addons.weather.Action.Active_Total do
  // uWeather_Config_Towns_CreateTown_Panel(vi, addons.weather.Action.Choosen[vi]);

  // Change the main
  FreeAndNil(vWeather.Scene.Control);

  uWeather_SetAll_Create_Control;
  for vi := 0 to addons.weather.Action.Active_Total do
    uWeather_Provider_Yahoo_CreateTab(addons.weather.Action.Choosen[vi], vi);

  for vi := 0 to addons.weather.Action.Active_Total do
    vWeather.Scene.Tab[vi].Tab.Visible := True;

  vWeather.Scene.Blur.Enabled := False;
  vWeather.Scene.Control.TabIndex := 0;
  vWeather.Scene.Blur.Enabled := True;

  // Change in ini
  for vi := 0 to addons.weather.Action.Active_Total do
    addons.weather.Ini.Ini.DeleteKey(addons.weather.Action.Provider, vi.ToString + '_WoeID');

  for vi := 0 to addons.weather.Action.Active_Total do
    addons.weather.Ini.Ini.WriteString(addons.weather.Action.Provider, vi.ToString + '_WoeID',
      addons.weather.Action.Choosen[vi].woeid + '{' + addons.weather.Action.Choosen[vi]
      .Country_FlagCode + '}');

  if vGoto = 0 then
  begin
    vWeather.Config.main.Right.Towns.GoUp_Glow.Enabled := False;
    vWeather.Config.main.Right.Towns.GoUp_Grey.Enabled := True;
  end;

  for vi := 0 to addons.weather.Action.Active_Total do
    vWeather.Config.main.Right.Towns.Town[vi].Glow_Panel.Enabled := False;

  // Yparxei problima edo
  vWeather.Config.main.Right.Towns.Town[vGoto].Glow_Panel.Enabled := True;
  vWeather.Config.main.Right.Towns.Town[vGoto].Glow_Panel.GlowColor := TAlphaColorRec.Red;

  Dec(addons.weather.Config.Selected_Town, 1);
end;

procedure uWeather_Config_Towns_TownGoDown;
var
  vGoto: Integer;
  vCurrentTown, vChangedTown: TADDON_WEATHER_CHOOSENTOWN;
  vi: Integer;
begin
  vGoto := addons.weather.Config.Selected_Town + 1;

  // Change the string record
  vCurrentTown := addons.weather.Action.Choosen[addons.weather.Config.Selected_Town];
  vChangedTown := addons.weather.Action.Choosen[vGoto];

  addons.weather.Action.Choosen[vGoto] := vCurrentTown;
  addons.weather.Action.Choosen[addons.weather.Config.Selected_Town] := vChangedTown;

  // Change the places of the panels in town config
  for vi := 0 to addons.weather.Action.Active_Total do
    FreeAndNil(vWeather.Config.main.Right.Towns.Town[vi]);

  // for vi := 0 to addons.weather.Action.Active_Total do
  // uWeather_Config_Towns_CreateTown_Panel(vi, addons.weather.Action.Choosen[vi]);

  // Change the main
  FreeAndNil(vWeather.Scene.Control);

  uWeather_SetAll_Create_Control;
  for vi := 0 to addons.weather.Action.Active_Total do
    uWeather_Provider_Yahoo_CreateTab(addons.weather.Action.Choosen[vi], vi);

  for vi := 0 to addons.weather.Action.Active_Total do
    vWeather.Scene.Tab[vi].Tab.Visible := True;

  vWeather.Scene.Blur.Enabled := False;
  vWeather.Scene.Control.TabIndex := 0;
  vWeather.Scene.Blur.Enabled := True;

  // Change in ini
  for vi := 0 to addons.weather.Action.Active_Total do
    addons.weather.Ini.Ini.DeleteKey(addons.weather.Action.Provider, vi.ToString + '_WoeID');

  for vi := 0 to addons.weather.Action.Active_Total do
    addons.weather.Ini.Ini.WriteString(addons.weather.Action.Provider, vi.ToString + '_WoeID',
      addons.weather.Action.Choosen[vi].woeid + '{' + addons.weather.Action.Choosen[vi]
      .Country_FlagCode + '}');

  if vGoto = addons.weather.Action.Active_Total then
  begin
    vWeather.Config.main.Right.Towns.GoDown_Glow.Enabled := False;
    vWeather.Config.main.Right.Towns.GoDown_Grey.Enabled := True;
  end;

  for vi := 0 to addons.weather.Action.Active_Total do
    vWeather.Config.main.Right.Towns.Town[vi].Glow_Panel.Enabled := False;

  // Yparxei problima edo
  vWeather.Config.main.Right.Towns.Town[vGoto].Glow_Panel.Enabled := True;
  vWeather.Config.main.Right.Towns.Town[vGoto].Glow_Panel.GlowColor := TAlphaColorRec.Red;

  inc(addons.weather.Config.Selected_Town, 1);
end;

procedure uWeather_Config_Towns_RefreshTown(mNum: Integer);
var
  vForcast_Resutls: TStringList;
  vString_Provider: string;
  vString_Woeid: String;
  vString_Temp_Unit: WideString;
  viPos: Integer;
begin
  vForcast_Resutls := TStringList.Create;

  vString_Provider := addons.weather.Ini.Ini.ReadString('Provider', 'Name', vString_Provider);
  vString_Woeid := addons.weather.Ini.Ini.ReadString(vString_Provider, IntToStr(mNum) + '_WoeID',
    vString_Woeid);
  viPos := Pos('{', vString_Woeid);
  vString_Woeid := Trim(Copy(vString_Woeid, 0, viPos - 1));

  vForcast_Resutls.Add(Main_Form.Main_IdHttp.Get
    ('http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D' +
    vString_Woeid +
    '%20and%20u%3D%27c%27&format=xml&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys%20HTTP/1.1'));
  vForcast_Resutls.SaveToFile(extrafe.prog.Path + cTemp_Forcast);

  vNTXML := CreateXMLDoc;
  vNTXML.LoadFromFile(extrafe.prog.Path + cTemp_Forcast);
  vNTRoot := vNTXML.DocumentElement;
  vNTNode := nil;

  while vNTRoot.GetNextChild(vNTNode) do
    while vNTNode.GetNextChild(vNTNode_1) do
      while vNTNode_1.GetNextChild(vNTNode_2) do
      begin
        vNTAttribute := nil;
        if vNTNode_2.NodeName = 'yweather:units' then
        begin
          vNTNode_2.FindAttribute('temperature', vNTAttribute);
          vString_Temp_Unit := vNTAttribute.NodeValue;
        end
        else if vNTNode_2.NodeName = 'item' then
        begin
          while vNTNode_2.GetNextChild(vNTNode_3) do
          begin
            vNTAttribute := nil;
            if vNTNode_3.NodeName = 'yweather:condition' then
            begin
              vNTNode_3.FindAttribute('temp', vNTAttribute);
              vNTAttribute := nil;
              vNTNode_3.FindAttribute('date', vNTAttribute);
              vNTAttribute := nil;
              vNTNode_3.FindAttribute('code', vNTAttribute);
              vNTAttribute := nil;
              vNTNode_3.FindAttribute('text', vNTAttribute);
            end;
          end;
        end;
      end;
  DeleteFile(extrafe.prog.Path + cTemp_Forcast);
end;

///

procedure uWeather_Config_Towns_Edit(vLock: Boolean);
var
  vi: Integer;
begin
  if addons.weather.Action.Active_Total > -1 then
  begin
    if vLock then
    begin
      vWeather.Config.main.Right.Towns.EditLock.Bitmap.LoadFromFile(addons.weather.Path.Images +
        'w_unlock.png');
      vWeather.Config.main.Right.Towns.Refresh_Grey.Enabled := False;
      vWeather.Config.main.Right.Towns.Delete_Grey.Enabled := False;
      addons.weather.Config.Selected_Town := 0;
      vWeather.Config.main.Right.Towns.Town[0].Glow_Panel.Enabled := True;
      vWeather.Config.main.Right.Towns.Town[0].Glow_Panel.GlowColor := TAlphaColorRec.Red;
      vWeather.Config.main.Right.Towns.GoUp_Grey.Enabled := True;
      if addons.weather.Action.Active_Total > 0 then
        vWeather.Config.main.Right.Towns.GoDown_Grey.Enabled := False
      else
        vWeather.Config.main.Right.Towns.GoDown_Grey.Enabled := True;
      vWeather.Config.main.Right.Towns.Add_Town_Grey.Enabled := True;
      uWeather_Sounds_PlayMouse('Lock');
    end
    else
    begin
      vWeather.Config.main.Right.Towns.EditLock.Bitmap.LoadFromFile(addons.weather.Path.Images +
        'w_lock.png');
      vWeather.Config.main.Right.Towns.GoUp_Grey.Enabled := True;
      vWeather.Config.main.Right.Towns.GoDown_Grey.Enabled := True;
      vWeather.Config.main.Right.Towns.Refresh_Grey.Enabled := True;
      vWeather.Config.main.Right.Towns.Delete_Grey.Enabled := True;
      for vi := 0 to addons.weather.Action.Active_Total do
      begin
        vWeather.Config.main.Right.Towns.Town[vi].Glow_Panel.GlowColor := TAlphaColorRec.Deepskyblue;
        vWeather.Config.main.Right.Towns.Town[vi].Glow_Panel.Enabled := False;
      end;
      vWeather.Config.main.Right.Towns.Add_Town_Grey.Enabled := False;
      uWeather_Sounds_PlayMouse('Unlock');
    end;
    addons.weather.Config.Edit_Lock := vLock;
  end;
end;

procedure uWeather_Config_Towns_Edit_SelectTown(vSelected: Integer);
var
  vi: Integer;
begin
  for vi := 0 to addons.weather.Action.Active_Total do
  begin
    vWeather.Config.main.Right.Towns.Town[vi].Glow_Panel.GlowColor := TAlphaColorRec.Deepskyblue;
    vWeather.Config.main.Right.Towns.Town[vi].Glow_Panel.Enabled := False;
  end;

  vWeather.Config.main.Right.Towns.Town[vSelected].Glow_Panel.GlowColor := TAlphaColorRec.Red;
  vWeather.Config.main.Right.Towns.Town[vSelected].Glow_Panel.Enabled := True;
  addons.weather.Config.Selected_Town := vSelected;

  vWeather.Config.main.Right.Towns.GoUp_Grey.Enabled := False;
  vWeather.Config.main.Right.Towns.GoDown_Grey.Enabled := False;
  if vSelected = 0 then
    vWeather.Config.main.Right.Towns.GoUp_Grey.Enabled := True
  else if vSelected = addons.weather.Action.Active_Total then
    vWeather.Config.main.Right.Towns.GoDown_Grey.Enabled := True;
end;

procedure uWeather_Config_Towns_Edit_DeleteTown(vSelected: Integer);
begin

end;

procedure uWeather_Config_Towsn_RefreshTownAll;
var
  vi: Integer;
begin
  for vi := 0 to addons.weather.Action.Active_Total do
    uWeather_Config_Towns_RefreshTown(vi);
end;

end.
