unit uSoundplayer_Scrapers_Lastfm;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  IPPeerClient,
  REST.Client,
  REST.Types,
  Data.Bind.Components,
  Data.Bind.ObjectScope;

procedure Artist_Company;
procedure Album;

implementation

uses
  uLoad_AllTypes,
  uInternet_Files,
  uSoundplayer_SetAll,
  uSoundplayer_AllTypes;

procedure Artist_Company;
var
  vRESTClient: TRESTClient;
  vRESTRequest: TRESTRequest;
  vRESTResponse: TRESTResponse;
  vJSONValue: TJSONValue;
  vAPI: String;
  vOutValue: String;
  vArtist, vImageUrl, vSummary, vComment: String;
begin
  vAPI := '17d1261b9ed4b209902d9167320e3663';
  vRESTClient := TRESTClient.Create('');
  vRESTClient.Name := 'Soundplayer_BandInfo_RestClient';
  vRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTClient.BaseURL := 'http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=' + addons.soundplayer.Playlist.List.Song_Info
    [addons.soundplayer.Player.Playing_Now].Artist + '&api_key=' + vAPI + '&format=json';
  vRESTClient.FallbackCharsetEncoding := 'UTF-8';

  vRESTResponse := TRESTResponse.Create(vRESTClient);
  vRESTResponse.Name := 'Soundplayer_BandInfo_Response';

  vRESTRequest := TRESTRequest.Create(vRESTClient);
  vRESTRequest.Name := 'Soundplayer_BandInfo_Request';
  vRESTRequest.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTRequest.Client := vRESTClient;
  vRESTRequest.Method := TRESTRequestMethod.rmGET;
  vRESTRequest.Response := vRESTResponse;
  vRESTRequest.Timeout := 30000;

  vRESTRequest.Execute;
  vJSONValue := vRESTResponse.JSONValue;
  /// Here is the response to format

  vArtist := vJSONValue.GetValue<String>('artist.name');
  vSoundplayer.Player.Band_Info_Press.Name.Text := vArtist;
  vImageUrl := '';
  if vJSONValue.TryGetValue('artist.image[4].#text', vOutValue) then
    vImageUrl := vOutValue;
  if vImageUrl = '' then
    if vJSONValue.TryGetValue('artist.image[3].#text', vOutValue) then
      vImageUrl := vOutValue;
  if vImageUrl = '' then
    if vJSONValue.TryGetValue('artist.image[2].#text', vOutValue) then
      vImageUrl := vOutValue;
  if vImageUrl <> '' then
    vSoundplayer.Player.Band_Info_Press.Image.Bitmap := uInternet_Files.Get_Image(vImageUrl);
  vSummary := vJSONValue.GetValue<String>('artist.bio.summary');
  vSoundplayer.Player.Band_Info_Press.Memo_Sum.Lines.Text := vSummary;
  vComment := vJSONValue.GetValue<String>('artist.bio.content');
  vSoundplayer.Player.Band_Info_Press.Memo_Comm.Lines.Text := vComment;
  FreeAndNil(vJSONValue);
  FreeAndNil(vRESTRequest);
end;

procedure Album;
var
  vRESTClient: TRESTClient;
  vRESTRequest: TRESTRequest;
  vRESTResponse: TRESTResponse;
  vJSONValue: TJSONValue;
  vAPI: String;
  vOutValue: String;
  vAlbumName, vArtist, vImageUrl, vSummary: String;
  vTrackName, vTrackDuratiion, vTrackPlace: String;
  vFound: Boolean;
  vK: String;
  vI: Integer;
begin
  vAPI := '17d1261b9ed4b209902d9167320e3663';
  vRESTClient := TRESTClient.Create('');
  vArtist := addons.soundplayer.Playlist.List.Song_Info[addons.soundplayer.Player.Playing_Now].Artist;
  vAlbumName := addons.soundplayer.Playlist.List.Song_Info[addons.soundplayer.Player.Playing_Now].Album;
  vRESTClient.Name := 'Soundplayer_Album_RestClient';
  vRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTClient.BaseURL := 'http://ws.audioscrobbler.com/2.0/?method=album.getinfo&artist=' + vArtist + '&album=' + vAlbumName + '&api_key=' + vAPI +
    '&format=json';
  vRESTClient.FallbackCharsetEncoding := 'UTF-8';

  vRESTResponse := TRESTResponse.Create(vRESTClient);
  vRESTResponse.Name := 'Soundplayer_Album_Response';

  vRESTRequest := TRESTRequest.Create(vRESTClient);
  vRESTRequest.Name := 'Soundplayer_Album_Request';
  vRESTRequest.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTRequest.Client := vRESTClient;
  vRESTRequest.Method := TRESTRequestMethod.rmGET;
  vRESTRequest.Response := vRESTResponse;
  vRESTRequest.Timeout := 30000;

  vRESTRequest.Execute;
  vJSONValue := vRESTResponse.JSONValue;
  /// Here is the response to format

  vAlbumName := vJSONValue.GetValue<String>('album.name');
  vArtist := vJSONValue.GetValue<String>('album.artist');
  vSoundplayer.Player.Album_Info_Press.Name.Text := vAlbumName + ' by "' + vArtist + '"';

  vImageUrl := '';
  if vJSONValue.TryGetValue('album.image[4].#text', vOutValue) then
    vImageUrl := vOutValue;
  if vImageUrl = '' then
    if vJSONValue.TryGetValue('album.image[3].#text', vOutValue) then
      vImageUrl := vOutValue;
  if vImageUrl = '' then
    if vJSONValue.TryGetValue('album.image[2].#text', vOutValue) then
      vImageUrl := vOutValue;
  if vImageUrl <> '' then
    vSoundplayer.Player.Album_Info_Press.Image.Bitmap := uInternet_Files.Get_Image(vImageUrl);
  vK := '0';
  repeat
    if vJSONValue.TryGetValue('album.tracks.track[' + vK + '].name', vOutValue) then
    begin
      vTrackName := vOutValue;
      vFound := True;
    end
    else
      vFound := False;

    if vFound then
    begin
      vTrackDuratiion := vJSONValue.GetValue<String>('album.tracks.track[' + vK + '].duration');
      vTrackPlace := vJSONValue.GetValue<String>('album.tracks.track[' + vK + '].@attr.rank');
      vI := vK.ToInteger;
      Inc(vI, 1);
      vK := vI.ToString;
    end;
  until vFound = False;

  vSummary := vJSONValue.GetValue<String>('album.wiki.content');
  vSoundplayer.Player.Album_Info_Press.Memo_Sum.Lines.Text := vSummary;
  FreeAndNil(vJSONValue);
  FreeAndNil(vRESTRequest);
end;

end.
