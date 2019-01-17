unit uWeather_Providers_OpenWeatherMap;

interface

uses
  System.Classes,
  System.JSON,
  IPPeerClient,
  REST.Client,
  REST.Types,
  Data.Bind.Components,
  Data.Bind.ObjectScope;
//  ALJsonDoc;


  function  uWeather_Providers_OpenWeatherMap_GetForcast(): Boolean;

var
  vRESTClient: TRESTClient;
  vRESTRequest: TRESTRequest;
  vRESTResponse: TRESTResponse;
  vJSONValue: TJSONValue;

implementation

function  uWeather_Providers_OpenWeatherMap_GetForcast(): Boolean;
var
  vCity: String;
begin

  vJSONValue:= TJSONValue.Create;

  vRESTClient:= TRESTClient.Create('');
  vRESTClient.Name:= 'OpenWeatherMap_RestClient';
  vRESTClient.Accept:= 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTClient.AcceptCharset:= 'UTF-8, *;q=0.8';
  vRESTClient.BaseURL:= 'http://api.openweathermap.org/data/2.5/weather?q=Trikala&APPID=5f1cc9b837706de78648b1de3443ccce';
  vRESTClient.FallbackCharsetEncoding:= 'UTF-8';

  vRESTResponse:= TRESTResponse.Create(vRESTClient);
  vRESTResponse.Name:= 'OpenWeatherMap_Response';

  vRESTRequest:= TRESTRequest.Create(vRESTClient);
  vRESTRequest.Name:= 'OpenWeatherMap_Request';
  vRESTRequest.Accept:= 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTRequest.AcceptCharset:= 'UTF-8, *;q=0.8';
  vRESTRequest.Client:= vRESTClient;
  vRESTRequest.Method:=  TRESTRequestMethod.rmGET;
  vRESTRequest.Response:= vRESTResponse;
  vRESTRequest.Timeout:= 30000;

  vRESTRequest.Execute;
  vJSONValue:= vRESTResponse.JSONValue;


  vCity:= vJSONValue.GetValue<String>('name');
end;

end.