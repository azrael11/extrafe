unit uWeather_Forcast;

interface

uses
  System.Classes,
  System.SysUtils,
  uWeather_AllTypes,
  uWeather_Config_Towns_Add,
  OXmlPDOM;

function uWeather_Forcast_Get(vNum: Integer; vWoeid, vCountry_Code: String): TADDON_WEATHER_CHOOSENTOWN;

var
  vNTXML: IXMLDocument;
  vNTRoot: PXMLNode;
  vNTNode: PXMLNode;
  vNTNode_1: PXMLNode;
  vNTNode_2: PXMLNode;
  vNTNode_3: PXMLNode;
  vNTAttribute: PXMLNode;

implementation

uses
  main,
  uLoad_AllTypes,
  uWeather_Convert;

function uWeather_Forcast_Get(vNum: Integer; vWoeid, vCountry_Code: String): TADDON_WEATHER_CHOOSENTOWN;
const
  cTemp_Forcast = 'data\addons\weather\temp\ChoosenTown.xml';
var
  vForcast_Resutls: Tstringlist;
  vDay: byte;
  vDegree: String;
begin
  vForcast_Resutls := Tstringlist.Create;

  if addons.weather.Action.Degree = 'Celcius' then
    vDegree := 'c'
  else if addons.weather.Action.Degree = 'Fahrenheit' then
    vDegree := 'f';

  vForcast_Resutls.Add(Main_Form.Main_IdHttp.Get
    ('http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D' +
    vWoeid + '%20and%20u%3D%27' + vDegree +
    '%27&format=xml&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys%20HTTP/1.1'));
  vForcast_Resutls.SaveToFile(extrafe.prog.Path + cTemp_Forcast);

  vNTXML := CreateXMLDoc;
  vNTXML.LoadFromFile(extrafe.prog.Path + cTemp_Forcast);
  vNTRoot := vNTXML.DocumentElement;

  SetLength(addons.Weather.Action.Choosen, vNum + 1);

  Result.Provider := addons.Weather.Action.Provider;
  Result.woeid := vWoeid;
  Result.Country_FlagCode := LowerCase(vCountry_Code);
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
          Result.City := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('country', vNTAttribute);
          Result.country := vNTAttribute.NodeValue;
        end
        else if vNTNode_2.NodeName = 'lastBuildDate' then
        begin
          Result.LastUpdate := vNTNode_2.Text;
        end
        else if vNTNode_2.NodeName = 'yweather:units' then
        begin
          vNTNode_2.FindAttribute('temperature', vNTAttribute);
          Result.UnitV.Temperature := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('speed', vNTAttribute);
          Result.UnitV.Speed := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('pressure', vNTAttribute);
          Result.UnitV.Pressure := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('distance', vNTAttribute);
          Result.UnitV.Distance := vNTAttribute.NodeValue;
        end
        else if vNTNode_2.NodeName = 'yweather:wind' then
        begin
          vNTNode_2.FindAttribute('speed', vNTAttribute);
          Result.Wind.Speed := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('direction', vNTAttribute);
          Result.Wind.Direction := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('chill', vNTAttribute);
          Result.Wind.Chill := vNTAttribute.NodeValue;
        end
        else if vNTNode_2.NodeName = 'yweather:atmosphere' then
        begin
          vNTNode_2.FindAttribute('pressure', vNTAttribute);
          Result.Atmosphere.Pressure := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('visibility', vNTAttribute);
          Result.Atmosphere.Visibility := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('rising', vNTAttribute);
          Result.Atmosphere.Rising := vNTAttribute.NodeValue;
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('humidity', vNTAttribute);
          Result.Atmosphere.Humidity := vNTAttribute.NodeValue;
        end
        else if vNTNode_2.NodeName = 'yweather:astronomy' then
        begin
          vNTNode_2.FindAttribute('sunset', vNTAttribute);
          Result.Astronomy.Sunset := uWeather_Convert_FixAstronomy(vNTAttribute.NodeValue);
          vNTAttribute := nil;
          vNTNode_2.FindAttribute('sunrise', vNTAttribute);
          Result.Astronomy.Sunrise := uWeather_Convert_FixAstronomy(vNTAttribute.NodeValue);
        end
        else if vNTNode_2.NodeName = 'item' then
        begin
          while vNTNode_2.GetNextChild(vNTNode_3) do
          begin
            vNTAttribute := nil;
            if vNTNode_3.NodeName = 'yweather:condition' then
            begin
              vNTNode_3.FindAttribute('temp', vNTAttribute);
              Result.Temp_Condition := vNTAttribute.NodeValue;
              vNTAttribute := nil;
              vNTNode_3.FindAttribute('date', vNTAttribute);
              Result.LastChecked := vNTAttribute.NodeValue;
              vNTAttribute := nil;
              vNTNode_3.FindAttribute('code', vNTAttribute);
              Result.Code := vNTAttribute.NodeValue;
              vNTAttribute := nil;
              vNTNode_3.FindAttribute('text', vNTAttribute);
              Result.Text_Condtition := vNTAttribute.NodeValue;
            end
            else if vNTNode_3.NodeName = 'yweather:forecast' then
            begin
              case vDay of
                0:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    Result.Current.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    Result.Current.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    Result.Current.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    Result.Current.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    Result.Current.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    Result.Current.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                1:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    Result.Day_1.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    Result.Day_1.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    Result.Day_1.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    Result.Day_1.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    Result.Day_1.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    Result.Day_1.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                2:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    Result.Day_2.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    Result.Day_2.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    Result.Day_2.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    Result.Day_2.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    Result.Day_2.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    Result.Day_2.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                3:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    Result.Day_3.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    Result.Day_3.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    Result.Day_3.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    Result.Day_3.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    Result.Day_3.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    Result.Day_3.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                4:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    Result.Day_4.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    Result.Day_4.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    Result.Day_4.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    Result.Day_4.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    Result.Day_4.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    Result.Day_4.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                5:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    Result.Day_5.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    Result.Day_5.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    Result.Day_5.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    Result.Day_5.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    Result.Day_5.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    Result.Day_5.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                6:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    Result.Day_6.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    Result.Day_6.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    Result.Day_6.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    Result.Day_6.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    Result.Day_6.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    Result.Day_6.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                7:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    Result.Day_7.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    Result.Day_7.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    Result.Day_7.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    Result.Day_7.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    Result.Day_7.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    Result.Day_7.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                8:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    Result.Day_8.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    Result.Day_8.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    Result.Day_8.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    Result.Day_8.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    Result.Day_8.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    Result.Day_8.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
                9:
                  begin
                    vNTNode_3.FindAttribute('day', vNTAttribute);
                    Result.Day_9.Text := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('date', vNTAttribute);
                    Result.Day_9.Date := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('text', vNTAttribute);
                    Result.Day_9.Forcast := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('code', vNTAttribute);
                    Result.Day_9.Code := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('low', vNTAttribute);
                    Result.Day_9.Low := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    vNTNode_3.FindAttribute('high', vNTAttribute);
                    Result.Day_9.High := vNTAttribute.NodeValue;
                    vNTAttribute := nil;
                    inc(vDay, 1);
                  end;
              end;
            end;
          end;
        end;
      end;

  DeleteFile(extrafe.prog.Path + cTemp_Forcast);
end;

end.
