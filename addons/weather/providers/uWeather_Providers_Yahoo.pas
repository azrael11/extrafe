unit uWeather_Providers_Yahoo;

interface
uses
  System.Classes,
  uWeather_AllTypes;

  function uWeather_Provider_Yahoo_GerForcast(vNum: Integer; vWoeid, vCountry_Code: String): TADDON_WEATHER_CHOOSENTOWN;

implementation

function uWeather_Provider_Yahoo_GerForcast(vNum: Integer; vWoeid, vCountry_Code: String): TADDON_WEATHER_CHOOSENTOWN;
begin

end;

end.
