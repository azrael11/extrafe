unit uSoundplayer_Mouse;

interface

uses
  System.Classes,
  System.UITypes,
  System.UIConsts,
  System.SysUtils,
  FMX.Graphics,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Dialogs,
  FMX.Types,
  FMX.Edit,
  FMX.Platform,
  FMX.Grid,
  FMX.Listbox,
  FMX.Menus,
  ALFmxStdCtrls;

type
  TSOUNDPLAYER_IMAGE = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TSOUNDPLAYER_TEXT = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TSOUNDPLAYER_BUTTON = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TSOUNDPLAYER_STRINGGRID = class(TObject)
    procedure OnSelectSell(Sender: TObject; const ACol, ARow: Integer; var CanSelect: Boolean);
    procedure OnDoubleClick(const Column: TColumn; const Row: Integer);
    procedure OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  end;

type
  TSOUNDPLAYER_TRACKBAR = class(TObject)
    procedure OnChange(Sender: TObject);
    procedure OnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  end;

type
  TSOUNDPLAYER_TRACKBAR_THUMB = class(TObject)
    procedure OnChange(Sender: TObject);
    procedure OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
    procedure OnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  end;

type
  TSOUNDPLAYER_RADIOBUTTON = class(TObject)
    procedure OnMouseClick(Sender: TObject);
  end;

type
  TSOUNDPLAYER_MENUITEM = class(TObject)
    procedure OnMouseClick(Sender: TObject);
  end;

type
  TSOUNDPLAYER_CHECKBOX = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;


type
  TSOUNDPLAYER_MOUSE_ACTIONS = record
    Image: TSOUNDPLAYER_IMAGE;
    Text: TSOUNDPLAYER_TEXT;
    Button: TSOUNDPLAYER_BUTTON;
    Stringgrid: TSOUNDPLAYER_STRINGGRID;
    Trackbar: TSOUNDPLAYER_TRACKBAR;
    Trackbar_Thumb: TSOUNDPLAYER_TRACKBAR_THUMB;
    RadioButton: TSOUNDPLAYER_RADIOBUTTON;
    Menuitem: TSOUNDPLAYER_MENUITEM;
    Checkbox: TSOUNDPLAYER_CHECKBOX;
  end;

implementation

uses
  uLoad_AllTypes,
  main,
  uSnippet_Text,
  uSoundplayer_SetAll,
  uSoundplayer_AllTypes,
  uSoundplayer_Actions,
  uSoundplayer_Player_Actions,
  uSoundplayer_Info_Actions,
  uSoundplayer_Playlist_Actions,
  uSoundplayer_Playlist_Manage,
  uSoundplayer_Playlist_Remove,
  uSoundplayer_Playlist_Create,
  uSoundplayer_Player_Volume,
  uSoundplayer_Settings_SetAll;

{ TSOUNDPLAYER_IMAGE }
procedure TSOUNDPLAYER_IMAGE.OnMouseClick(Sender: TObject);
begin
  if not Assigned(vSoundplayer.scene.First.Panel) then
  begin
    if extrafe.prog.State = 'addon_soundplayer' then
    begin
      if TImage(Sender).Name = 'A_SP_Player_Play_Image' then
        uSoundPlayer_Player_Actions.StartOrPause
      else if TImage(Sender).Name = 'A_SP_Player_Stop_Image' then
        uSoundPlayer_Player_Actions.Stop
      else if TImage(Sender).Name = 'A_SP_Player_Previous_Image' then
        uSoundPlayer_Player_Actions.Previous
      else if TImage(Sender).Name = 'A_SP_Player_Next_Image' then
        uSoundPlayer_Player_Actions.Next
      else if TImage(Sender).Name = 'A_SP_Player_Eject_Image' then
      begin
        vSoundplayer.scene.OpenDialog.Name := 'A_SP_OpenDialog_AddSongs';
        vSoundplayer.scene.OpenDialog.Execute
      end
      else if TImage(Sender).Name = 'A_SP_Player_Suffle_Image' then
        uSoundPlayer_Player_Actions.Suffle
      else if TImage(Sender).Name = 'A_SP_Player_Loop_Image' then
        uSoundplayer_Player_Actions_SetRepeat(addons.soundplayer.Player.VRepeat)
      else if TImage(Sender).Name = 'A_SP_Player_Tag_Image' then
        uSoundPlayer_Player_Actions_ShowTag(addons.soundplayer.Playlist.List.Songs.Strings
          [addons.soundplayer.Player.Playing_Now], vSoundplayer.Playlist.List.Selected)
      else if TImage(Sender).Name = 'A_SP_Info_Cover_Fullscreen' then
      begin
        if addons.soundplayer.Info.isCoverInFullscreen then
          uSoundplayer_Info_Actions_StartAnimationCoverExitFullscreen
        else
        begin
          vSoundplayer.Info.Back_Right_Ani.Enabled := False;
          uSoundplayer_Info_Actions_StartAnimationCoverFullscreen
        end;
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Edit_Songs_Lock' then
        uSoundplayer_Playlist_Actions_EditPlaylist(not addons.soundplayer.Playlist.Edit)
      else if TImage(Sender).Name = 'A_SP_Playlist_Edit_Songs_Edit' then
      begin
        uSoundPlayer_Playlist_Actions_OnLeave(vSoundplayer.Playlist.Songs_Edit.Edit,
          vSoundplayer.Playlist.Songs_Edit.Edit_Glow);
        uSoundPlayer_Player_Actions_ShowTag(addons.soundplayer.Playlist.List.Songs.Strings
          [vSoundplayer.Playlist.List.Selected], vSoundplayer.Playlist.List.Selected)
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Edit_Songs_Up' then
        uSoundplayer_Playlist_Actions_Edit_MoveUp
      else if TImage(Sender).Name = 'A_SP_Playlist_Edit_Songs_Down' then
        uSoundplayer_Playlist_Actions_Edit_MoveDown
      else if TImage(Sender).Name = 'A_SP_Playlist_Edit_Songs_Delete' then
        uSoundplayer_Playlist_Actions_Edit_Delete
      else if TImage(Sender).Name = 'A_SP_Playlist_Manage_Image' then
        uSoundPlayer_Playlist_Manage_Panel
      else if TImage(Sender).Name = 'A_SP_Playlist_Add_Image' then
        uSoundPlayer_Playlist_Create_Panel
      else if TImage(Sender).Name = 'A_SP_Playlist_Remove_Image' then
        uSoundplayer_Playlist_Remove_Panel
      else if TImage(Sender).Name = 'A_SP_Player_Speaker_Left_Image' then
        uSoundplayer_Player_Volume_Mute
      else if TImage(Sender).Name = 'A_SP_Player_Speaker_Right_Image' then
        uSoundplayer_Player_Volume_Mute
      else if TImage(Sender).Name = 'A_SP_Settings_Image' then
        uSoundplayer_Settings_Set
    end
    else if extrafe.prog.State = 'addon_soundplayer_manage_playlists' then
    begin
      if TImage(Sender).Name = 'A_SP_Playlist_Manage_Edit' then
        uSoundPlayer_Playlist_Manage_Lock(not addons.soundplayer.Playlist.Manage_Lock)
      else if TImage(Sender).Name = 'A_SP_Playlist_Manage_Up' then
      begin
        if vSoundplayer.Playlist.Manage.main.Up_Grey.Enabled = False then
          uSoundplayer_Playlist_Manage_MoveUp(vSoundplayer.Playlist.Manage.main.Grid.Selected);
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Manage_Down' then
      begin
        if vSoundplayer.Playlist.Manage.main.Down_Grey.Enabled = False then
          uSoundplayer_Playlist_Manage_MoveDown(vSoundplayer.Playlist.Manage.main.Grid.Selected);
      end;
    end;
  end;
end;

procedure TSOUNDPLAYER_IMAGE.OnMouseEnter(Sender: TObject);
begin
  if not Assigned(vSoundplayer.scene.First.Panel) then
  begin
    if extrafe.prog.State = 'addon_soundplayer' then
    begin
      if TImage(Sender).Name = 'A_SP_Player_Play_Image' then
      begin
        if vSoundplayer.Player.Play_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnOver(vSoundplayer.Player.Play, vSoundplayer.Player.Play_Glow);
      end
      else if TImage(Sender).Name = 'A_SP_Player_Stop_Image' then
      begin
        if vSoundplayer.Player.Stop_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnOver(vSoundplayer.Player.Stop, vSoundplayer.Player.Stop_Glow);
      end
      else if TImage(Sender).Name = 'A_SP_Player_Previous_Image' then
      begin
        if vSoundplayer.Player.Previous_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnOver(vSoundplayer.Player.Previous, vSoundplayer.Player.Previous_Glow)
      end
      else if TImage(Sender).Name = 'A_SP_Player_Next_Image' then
      begin
        if vSoundplayer.Player.Next_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnOver(vSoundplayer.Player.Next, vSoundplayer.Player.Next_Glow);
      end
      else if TImage(Sender).Name = 'A_SP_Player_Eject_Image' then
        uSoundPlayer_Player_Actions.OnOver(vSoundplayer.Player.Eject, vSoundplayer.Player.Eject_Glow)
      else if TImage(Sender).Name = 'A_SP_Player_Loop_Image' then
      begin
        if vSoundplayer.Player.Loop_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnOver(vSoundplayer.Player.Loop, vSoundplayer.Player.Loop_Glow);
      end
      else if TImage(Sender).Name = 'A_SP_Player_Suffle_Image' then
      begin
        if vSoundplayer.Player.Suffle_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnOver(vSoundplayer.Player.Suffle, vSoundplayer.Player.Suffle_Glow);
      end
      else if TImage(Sender).Name = 'A_SP_Player_Tag_Image' then
        uSoundPlayer_Player_Actions.OnOver(vSoundplayer.Player.Song_Tag, vSoundplayer.Player.Song_Tag_Glow)
      else if TImage(Sender).Name = 'A_SP_Player_Speaker_Lock_Left_Volume' then
        vSoundplayer.Player.Speaker_Left_Lock_Volume_Glow.Enabled := True
      else if TImage(Sender).Name = 'A_SP_Player_Speaker_Lock_Right_Volume' then
        vSoundplayer.Player.Speaker_Right_Lock_Volume_Glow.Enabled := True
      else if TImage(Sender).Name = 'A_SP_Info_Cover_Fullscreen' then
        uSoundPlayer_Player_Actions.OnOver(vSoundplayer.Info.Cover_Fullscreen,
          vSoundplayer.Info.Cover_Fullscreen_Glow)
      else if TImage(Sender).Name = 'A_SP_Playlist_Edit_Songs_Lock' then
        uSoundPlayer_Player_Actions.OnOver(vSoundplayer.Playlist.Songs_Edit.Lock,
          vSoundplayer.Playlist.Songs_Edit.Lock_Glow)
      else if TImage(Sender).Name = 'A_SP_Playlist_Edit_Songs_Edit' then
      begin
        if vSoundplayer.Playlist.Songs_Edit.Edit_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnOver(vSoundplayer.Playlist.Songs_Edit.Edit,
            vSoundplayer.Playlist.Songs_Edit.Edit_Glow)
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Edit_Songs_Up' then
      begin
        if vSoundplayer.Playlist.Songs_Edit.Up_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnOver(vSoundplayer.Playlist.Songs_Edit.Up,
            vSoundplayer.Playlist.Songs_Edit.Up_Glow)
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Edit_Songs_Down' then
      begin
        if vSoundplayer.Playlist.Songs_Edit.Down_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnOver(vSoundplayer.Playlist.Songs_Edit.Down,
            vSoundplayer.Playlist.Songs_Edit.Down_Glow)
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Edit_Songs_Delete' then
      begin
        if vSoundplayer.Playlist.Songs_Edit.Delete_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnOver(vSoundplayer.Playlist.Songs_Edit.Delete,
            vSoundplayer.Playlist.Songs_Edit.Delete_Glow)
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Manage_Image' then
      begin
        if vSoundplayer.Playlist.Manage_Icon_Grey.Enabled = False then
          uSoundPlayer_Playlist_Actions_OnOver(vSoundplayer.Playlist.Manage_Icon,
            vSoundplayer.Playlist.Manage_Icon_Glow);
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Add_Image' then
        uSoundPlayer_Playlist_Actions_OnOver(vSoundplayer.Playlist.Create_Icon,
          vSoundplayer.Playlist.Create_Icon_Glow)
      else if TImage(Sender).Name = 'A_SP_Playlist_Remove_Image' then
      begin
        if vSoundplayer.Playlist.Remove_Icon_Grey.Enabled = False then
          uSoundPlayer_Playlist_Actions_OnOver(vSoundplayer.Playlist.Remove_Icon,
            vSoundplayer.Playlist.Remove_Icon_Glow);
      end
      else if TImage(Sender).Name = 'A_SP_Settings_Image' then
        vSoundplayer.scene.Settings_Glow.Enabled := True
      else if TImage(Sender).Name = 'A_SP_BackInfo_BackLeft_Image' then
      begin
        vSoundplayer.Info.Back_Left_Ani.Enabled := False;
        vSoundplayer.Info.Back_Left.Position.X := 2;
      end
      else if TImage(Sender).Name = 'A_SP_BackInfo_BackRight_Image' then
      begin
        if addons.soundplayer.Info.isCoverInFullscreen = False then
        begin
          vSoundplayer.Info.Back_Right_Ani.Enabled := False;
          vSoundplayer.Info.Back_Right.Position.X := vSoundplayer.scene.Back_Info.Width - 602;
        end;
      end
      else if TImage(Sender).Name = 'A_SP_Player_Speaker_Left_Image' then
        uSoundplayer_Player_Volume_Speakers_OnMouseAbove(True)
      else if TImage(Sender).Name = 'A_SP_Player_Speaker_Right_Image' then
        uSoundplayer_Player_Volume_Speakers_OnMouseAbove(True)
    end
    else if extrafe.prog.State = 'addon_soundplayer_manage_playlists' then
    begin
      if TImage(Sender).Name = 'A_SP_Playlist_Manage_Edit' then
        vSoundplayer.Playlist.Manage.main.Edit_Glow.Enabled := True
      else if TImage(Sender).Name = 'A_SP_Playlist_Manage_Up' then
      begin
        if vSoundplayer.Playlist.Manage.main.Up_Grey.Enabled = False then
          vSoundplayer.Playlist.Manage.main.Up_Glow.Enabled := True;
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Manage_Down' then
      begin
        if vSoundplayer.Playlist.Manage.main.Down_Grey.Enabled = False then
          vSoundplayer.Playlist.Manage.main.Down_Glow.Enabled := True;
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Manage_Merge' then
      begin
        if vSoundplayer.Playlist.Manage.main.Merge_Grey.Enabled = False then
          vSoundplayer.Playlist.Manage.main.Merge_Glow.Enabled := True
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Manage_Split' then
      begin
        if vSoundplayer.Playlist.Manage.main.Split_Grey.Enabled = False then
          vSoundplayer.Playlist.Manage.main.Split_Glow.Enabled := True;
      end;
    end;
  end;
end;

procedure TSOUNDPLAYER_IMAGE.OnMouseLeave(Sender: TObject);
begin
  if not Assigned(vSoundplayer.scene.First.Panel) then
  begin
    if extrafe.prog.State = 'addon_soundplayer' then
    begin
      if TImage(Sender).Name = 'A_SP_Player_Play_Image' then
      begin
        if vSoundplayer.Player.Play_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnLeave(vSoundplayer.Player.Play, vSoundplayer.Player.Play_Glow)
      end
      else if TImage(Sender).Name = 'A_SP_Player_Stop_Image' then
      begin
        if vSoundplayer.Player.Stop_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnLeave(vSoundplayer.Player.Stop, vSoundplayer.Player.Stop_Glow);
      end
      else if TImage(Sender).Name = 'A_SP_Player_Previous_Image' then
      begin
        if vSoundplayer.Player.Previous_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnLeave(vSoundplayer.Player.Previous,
            vSoundplayer.Player.Previous_Glow);
      end
      else if TImage(Sender).Name = 'A_SP_Player_Next_Image' then
      begin
        if vSoundplayer.Player.Next_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnLeave(vSoundplayer.Player.Next, vSoundplayer.Player.Next_Glow);
      end
      else if TImage(Sender).Name = 'A_SP_Player_Eject_Image' then
        uSoundPlayer_Player_Actions.OnLeave(vSoundplayer.Player.Eject, vSoundplayer.Player.Eject_Glow)
      else if TImage(Sender).Name = 'A_SP_Player_Loop_Image' then
      begin
        if vSoundplayer.Player.Loop_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnLeave(vSoundplayer.Player.Loop, vSoundplayer.Player.Loop_Glow);
      end
      else if TImage(Sender).Name = 'A_SP_Player_Suffle_Image' then
      begin
        if vSoundplayer.Player.Suffle_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnLeave(vSoundplayer.Player.Suffle, vSoundplayer.Player.Suffle_Glow);
      end
      else if TImage(Sender).Name = 'A_SP_Player_Tag_Image' then
        uSoundPlayer_Player_Actions.OnLeave(vSoundplayer.Player.Song_Tag, vSoundplayer.Player.Song_Tag_Glow)
      else if TImage(Sender).Name = 'A_SP_Player_Speaker_Lock_Left_Volume' then
        vSoundplayer.Player.Speaker_Left_Lock_Volume_Glow.Enabled := False
      else if TImage(Sender).Name = 'A_SP_Player_Speaker_Lock_Right_Volume' then
        vSoundplayer.Player.Speaker_Right_Lock_Volume_Glow.Enabled := False
      else if TImage(Sender).Name = 'A_SP_Info_Cover_Fullscreen' then
        uSoundPlayer_Player_Actions.OnLeave(vSoundplayer.Info.Cover_Fullscreen,
          vSoundplayer.Info.Cover_Fullscreen_Glow)
      else if TImage(Sender).Name = 'A_SP_Playlist_Edit_Songs_Lock' then
        uSoundPlayer_Player_Actions.OnLeave(vSoundplayer.Playlist.Songs_Edit.Lock,
          vSoundplayer.Playlist.Songs_Edit.Lock_Glow)
      else if TImage(Sender).Name = 'A_SP_Playlist_Edit_Songs_Edit' then
      begin
        if vSoundplayer.Playlist.Songs_Edit.Edit_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnLeave(vSoundplayer.Playlist.Songs_Edit.Edit,
            vSoundplayer.Playlist.Songs_Edit.Edit_Glow)
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Edit_Songs_Up' then
      begin
        if vSoundplayer.Playlist.Songs_Edit.Up_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnLeave(vSoundplayer.Playlist.Songs_Edit.Up,
            vSoundplayer.Playlist.Songs_Edit.Up_Glow)
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Edit_Songs_Down' then
      begin
        if vSoundplayer.Playlist.Songs_Edit.Down_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnLeave(vSoundplayer.Playlist.Songs_Edit.Down,
            vSoundplayer.Playlist.Songs_Edit.Down_Glow)
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Edit_Songs_Delete' then
      begin
        if vSoundplayer.Playlist.Songs_Edit.Delete_Grey.Enabled = False then
          uSoundPlayer_Player_Actions.OnLeave(vSoundplayer.Playlist.Songs_Edit.Delete,
            vSoundplayer.Playlist.Songs_Edit.Delete_Glow)
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Manage_Image' then
      begin
        if vSoundplayer.Playlist.Manage_Icon_Grey.Enabled = False then
          uSoundPlayer_Playlist_Actions_OnLeave(vSoundplayer.Playlist.Manage_Icon,
            vSoundplayer.Playlist.Manage_Icon_Glow);
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Add_Image' then
        uSoundPlayer_Playlist_Actions_OnLeave(vSoundplayer.Playlist.Create_Icon,
          vSoundplayer.Playlist.Create_Icon_Glow)
      else if TImage(Sender).Name = 'A_SP_Playlist_Remove_Image' then
      begin
        if vSoundplayer.Playlist.Remove_Icon_Grey.Enabled = False then
          uSoundPlayer_Playlist_Actions_OnLeave(vSoundplayer.Playlist.Remove_Icon,
            vSoundplayer.Playlist.Remove_Icon_Glow);
      end
      else if TImage(Sender).Name = 'A_SP_Settings_Image' then
        vSoundplayer.scene.Settings_Glow.Enabled := False
      else if TImage(Sender).Name = 'A_SP_BackInfo_BackLeft_Image' then
        vSoundplayer.Info.Back_Left_Ani.Enabled := True
      else if TImage(Sender).Name = 'A_SP_BackInfo_BackRight_Image' then
      begin
        if addons.soundplayer.Info.isCoverInFullscreen = False then
          vSoundplayer.Info.Back_Right_Ani.Enabled := True
      end
      else if TImage(Sender).Name = 'A_SP_Player_Speaker_Left_Image' then
        uSoundplayer_Player_Volume_Speakers_OnMouseAbove(False)
      else if TImage(Sender).Name = 'A_SP_Player_Speaker_Right_Image' then
        uSoundplayer_Player_Volume_Speakers_OnMouseAbove(False)
    end
    else if extrafe.prog.State = 'addon_soundplayer_manage_playlists' then
    begin
      if TImage(Sender).Name = 'A_SP_Playlist_Manage_Edit' then
        vSoundplayer.Playlist.Manage.main.Edit_Glow.Enabled := False
      else if TImage(Sender).Name = 'A_SP_Playlist_Manage_Up' then
      begin
        if vSoundplayer.Playlist.Manage.main.Up_Grey.Enabled = False then
          vSoundplayer.Playlist.Manage.main.Up_Glow.Enabled := False
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Manage_Down' then
      begin
        if vSoundplayer.Playlist.Manage.main.Down_Grey.Enabled = False then
          vSoundplayer.Playlist.Manage.main.Down_Glow.Enabled := False;
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Manage_Merge' then
      begin
        if vSoundplayer.Playlist.Manage.main.Merge_Grey.Enabled = False then
          vSoundplayer.Playlist.Manage.main.Merge_Glow.Enabled := False;
      end
      else if TImage(Sender).Name = 'A_SP_Playlist_Manage_Split' then
      begin
        if vSoundplayer.Playlist.Manage.main.Split_Grey.Enabled = False then
          vSoundplayer.Playlist.Manage.main.Split_Glow.Enabled := False;
      end;
    end;
  end;
end;

{ TSOUNDPLAYER_TEXT }

procedure TSOUNDPLAYER_TEXT.OnMouseClick(Sender: TObject);
begin
  if extrafe.prog.State = 'addon_soundplayer' then
  begin
    if TText(Sender).Name = 'A_SP_SongTime_Play' then
      addons.soundplayer.Player.Time_Negative := not addons.soundplayer.Player.Time_Negative;
  end
end;

procedure TSOUNDPLAYER_TEXT.OnMouseEnter(Sender: TObject);
begin
  if extrafe.prog.State = 'addon_soundplayer' then
  begin
    if TText(Sender).Name = 'A_SP_SongTime_Play' then
      uSnippet_Text_ChangeColor_OnMouseEnter(Sender, claDeepskyblue);
  end
  else if extrafe.prog.State = 'addon_soundplayer_tag_mp3' then
  begin
    if TText(Sender).Name = 'A_SP_Tag_Mp3_ID3v1_Transfer' then
      uSnippet_Text_HyperLink_OnMouseEnter(Sender)
    else if TText(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Transfer' then
      uSnippet_Text_HyperLink_OnMouseEnter(Sender);
  end;
end;

procedure TSOUNDPLAYER_TEXT.OnMouseLeave(Sender: TObject);
begin
  if extrafe.prog.State = 'addon_soundplayer' then
  begin
    if TText(Sender).Name = 'A_SP_SongTime_Play' then
      uSnippet_Text_ChangeColor_OnMouseLeave(Sender, claWhiteSmoke);
  end
  else if extrafe.prog.State = 'addon_soundplayer_tag_mp3' then
  begin
    if TText(Sender).Name = 'A_SP_Tag_Mp3_ID3v1_Transfer' then
      uSnippet_Text_HyperLink_OnMouseLeave(Sender)
    else if TText(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Transfer' then
      uSnippet_Text_HyperLink_OnMouseLeave(Sender);
  end;
end;

{ TSOUNDPLAYER_BUTTON }
procedure TSOUNDPLAYER_BUTTON.OnMouseClick(Sender: TObject);
begin
  if extrafe.prog.State = 'addon_soundplayer' then
  begin
    if TButton(Sender).Name= 'A_SP_First_Main_Done' then
      begin
        FreeAndNil(vSoundplayer.scene.First.Panel);
        vSoundplayer.scene.Back_Blur.Enabled:= False;
      end;
  end
  else if extrafe.prog.State = 'addon_soundplayer_manage_playlists' then
  begin
    if TButton(Sender).Name = 'A_SP_Playlist_Manage_CancelButton' then
      uSoundPlayer_Playlist_Manage_Free
    else if TButton(Sender).Name = 'A_SP_Playlist_Manage_LoadButton' then
      uSoundplayer_Playlist_Manage_LoadPlaylist(vSoundplayer.Playlist.Manage.main.Grid.Selected);
  end
  else if extrafe.prog.State = 'addon_soundplayer_create_playlist' then
  begin
    if TButton(Sender).Name = 'A_SP_Playlist_Create_CreateButton' then
      uSoundPlayer_Playlist_Create_NewPlaylist(vSoundplayer.Playlist.Create.main.Edit.Text,
        vSoundplayer.Playlist.Create.main.Main_Type.Items.Strings
        [vSoundplayer.Playlist.Create.main.Main_Type.ItemIndex])
    else if TButton(Sender).Name = 'A_SP_Playlist_Create_CancelButton' then
      uSoundPlayer_Playlist_Create_Free;
  end
  else if extrafe.prog.State = 'addon_soundplayer_playlist_remove' then
  begin
    if TButton(Sender).Name = 'A_SP_Playlist_Remove_Remove' then
      uSoundPlayer_Playlist_Remove_RemoveAndDeletePlaylist
    else if TButton(Sender).Name = 'A_SP_Playlist_Remove_Cancel' then
      uSoundPlayer_Playlist_Remove_Free;
  end
  else if extrafe.prog.State = 'addon_soundplayer_playlist_edit' then
  begin
    if TButton(Sender).Name = 'A_SP_Playlist_Edit_Song_Remove_Erase' then
      uSoundplayer_Playlist_Actions_Edit_Delete_Song
    else if TButton(Sender).Name = 'A_SP_Playlist_Edit_Song_Remove_Cancel' then
      uSoundplayer_Playlist_Actions_Edit_Delete_Cancel;
  end;

end;

procedure TSOUNDPLAYER_BUTTON.OnMouseEnter(Sender: TObject);
begin

end;

procedure TSOUNDPLAYER_BUTTON.OnMouseLeave(Sender: TObject);
begin

end;

{ TSOUNDPLAYER_STRINGGRID }
procedure TSOUNDPLAYER_STRINGGRID.OnDoubleClick(const Column: TColumn; const Row: Integer);
begin
  if not Assigned(vSoundplayer.scene.First.Panel) then
  begin
    if extrafe.prog.State = 'addon_soundplayer' then
    begin
      if addons.soundplayer.Player.Playing_Now <> Row then
        uSoundPlayer_Playlist_Actions_OnDoubleClick(Column, Row);
    end;
  end;
end;

procedure TSOUNDPLAYER_STRINGGRID.OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
var
  vRowNum: Integer;
begin
  if not Assigned(vSoundplayer.scene.First.Panel) then
  begin
    if extrafe.prog.State = 'addon_soundplayer' then
    begin
      if TStringGrid(Sender).Name = 'A_SP_Playlist' then
        uSoundplayer_Playlist_Actions_List_ShowPopup(Button, X, Y);
    end;
  end;
end;

procedure TSOUNDPLAYER_STRINGGRID.OnSelectSell(Sender: TObject; const ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if not Assigned(vSoundplayer.scene.First.Panel) then
  begin
    if extrafe.prog.State = 'addon_soundplayer' then
    begin
      if TStringGrid(Sender).Name = 'A_SP_Playlist' then
        uSoundPlayer_Playlist_Actions_OnSelectCell(Sender, ACol, ARow, CanSelect);
    end
    else if extrafe.prog.State = 'addon_soundplayer_manage_playlists' then
    begin
      if TStringGrid(Sender).Name = 'A_SP_Playlist_Manage_Grid' then
      begin
        if addons.soundplayer.Playlist.Manage_CtrlKey then
          uSoundPlayer_Playlist_Manage_Grid_SelectForMerge(ARow)
        else
          uSoundPlayer_Playlist_Manage_Grid_SelectCell(ARow);
      end;
    end;
  end;
end;

{ TSOUNDPLAYER_TRACKBAR }
procedure TSOUNDPLAYER_TRACKBAR.OnChange(Sender: TObject);
begin
 if not Assigned(vSoundplayer.scene.First.Panel) then
  begin
    if extrafe.prog.State = 'addon_soundplayer' then
    begin
      if TTrackBar(Sender).Name = 'A_SP_Player_Speaker_Left_VolumePos' then
      begin
        if addons.soundplayer.Volume.State = 'Master' then
          uSoundplayer_Player_Volume_Update(TALTrackBar(Sender).Value, 'Both')
        else
          uSoundplayer_Player_Volume_Update(TALTrackBar(Sender).Value, 'Left');
      end
      else if TTrackBar(Sender).Name = 'A_SP_Player_Speaker_Right_VolumePos' then
      begin
        if addons.soundplayer.Volume.State = 'Master' then
          uSoundplayer_Player_Volume_Update(TALTrackBar(Sender).Value, 'Both')
        else
          uSoundplayer_Player_Volume_Update(TALTrackBar(Sender).Value, 'Right');
      end
    end;
  end;
end;

procedure TSOUNDPLAYER_TRACKBAR.OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
begin
  if not Assigned(vSoundplayer.scene.First.Panel) then
  begin
    if extrafe.prog.State = 'addon_soundplayer' then
    begin
      if TTrackBar(Sender).Name = 'A_SP_Player_Speaker_Left_VolumePos' then
        uSoundplayer_Player_Volume_Show
      else if TTrackBar(Sender).Name = 'A_SP_Player_Speaker_Right_VolumePos' then
        uSoundplayer_Player_Volume_Show;
    end;
  end;
end;

procedure TSOUNDPLAYER_TRACKBAR.OnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
begin
  if not Assigned(vSoundplayer.scene.First.Panel) then
  begin
    if extrafe.prog.State = 'addon_soundplayer' then
    begin
      if TTrackBar(Sender).Name = 'A_SP_Player_Speaker_Left_VolumePos' then
        uSoundplayer_Player_Volume_Ani
      else if TTrackBar(Sender).Name = 'A_SP_Player_Speaker_Right_VolumePos' then
        uSoundplayer_Player_Volume_Ani
    end;
  end;
end;

{ TSOUNDPLAYER_TRACKBAR_THUMB }

procedure TSOUNDPLAYER_TRACKBAR_THUMB.OnChange(Sender: TObject);
begin

end;

procedure TSOUNDPLAYER_TRACKBAR_THUMB.OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
begin
  if not Assigned(vSoundplayer.scene.First.Panel) then
  begin
    if extrafe.prog.State = 'addon_soundplayer' then
    begin
      if TALTrackBar(Sender).Name = 'A_SP_SongPos_Thumb' then
        addons.soundplayer.Player.Thumb_Active := True;
    end
  end;
end;

procedure TSOUNDPLAYER_TRACKBAR_THUMB.OnMouseEnter(Sender: TObject);
begin
  if not Assigned(vSoundplayer.scene.First.Panel) then
  begin
    if extrafe.prog.State = 'addon_soundplayer' then
    begin
      if TALTrackBar(Sender).Name = 'A_SP_SongPos_Thumb' then
        vSoundplayer.Player.Song_Pos.Thumb.Fill.Color := TAlphaColorRec.Deepskyblue
      else if TALTrackBar(Sender).Name = 'A_SP_Player_Speaker_Right_VolumePos_Thumb' then
        vSoundplayer.Player.Speaker_Right_Volume_Pos.Thumb.Fill.Color := TAlphaColorRec.Deepskyblue
      else if TALTrackBar(Sender).Name = 'A_SP_Player_Speaker_Left_VolumePos_Thumb' then
        vSoundplayer.Player.Speaker_Left_Volume_Pos.Thumb.Fill.Color := TAlphaColorRec.Deepskyblue;
    end;
  end;
end;

procedure TSOUNDPLAYER_TRACKBAR_THUMB.OnMouseLeave(Sender: TObject);
begin
  if not Assigned(vSoundplayer.scene.First.Panel) then
  begin
    if extrafe.prog.State = 'addon_soundplayer' then
    begin
      if TALTrackBar(Sender).Name = 'A_SP_SongPos_Thumb' then
        vSoundplayer.Player.Song_Pos.Thumb.Fill.Color := TAlphaColorRec.White
      else if TALTrackBar(Sender).Name = 'A_SP_Player_Speaker_Right_VolumePos_Thumb' then
        vSoundplayer.Player.Speaker_Right_Volume_Pos.Thumb.Fill.Color := TAlphaColorRec.White
      else if TALTrackBar(Sender).Name = 'A_SP_Player_Speaker_Left_VolumePos_Thumb' then
        vSoundplayer.Player.Speaker_Left_Volume_Pos.Thumb.Fill.Color := TAlphaColorRec.White;
    end;
  end;
end;

procedure TSOUNDPLAYER_TRACKBAR_THUMB.OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
  if not Assigned(vSoundplayer.scene.First.Panel) then
  begin
    if TALTrackBar(Sender).Name = 'A_SP_SongPos_Thumb' then
      if addons.soundplayer.Player.Thumb_Active then
        uSoundplayer_Player_Actions_UpdateSongPosition(Sender, vSoundplayer.Player.Song_Pos.Value, False);
  end;

end;

procedure TSOUNDPLAYER_TRACKBAR_THUMB.OnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
begin
  if not Assigned(vSoundplayer.scene.First.Panel) then
  begin
    if extrafe.prog.State = 'addon_soundplayer' then
    begin
      if TALTrackBar(Sender).Name = 'A_SP_SongPos_Thumb' then
        uSoundplayer_Player_Actions_UpdateSongPosition(Sender, vSoundplayer.Player.Song_Pos.Value, True);
    end;
  end;
end;

{ TSOUNDPLAYER_RADIOBUTTON }

procedure TSOUNDPLAYER_RADIOBUTTON.OnMouseClick(Sender: TObject);
begin

end;

{ TSOUNDPLAYER_MENUITEM }

procedure TSOUNDPLAYER_MENUITEM.OnMouseClick(Sender: TObject);
begin
  if extrafe.prog.State = 'addon_soundplayer' then
  begin
    if TMenuItem(Sender).Name = 'A_SP_Playlist_List_Popup_Item_0' then
      uSoundPlayer_Player_Actions_ShowTag(addons.soundplayer.Playlist.List.Songs.Strings
        [vSoundplayer.Playlist.List.Selected], vSoundplayer.Playlist.List.Selected)
    else if TMenuItem(Sender).Name = 'A_SP_Playlist_List_Popup_Item_1' then
      uSoundplayer_Playlist_Actions_Edit_MoveUp
    else if TMenuItem(Sender).Name = 'A_SP_Playlist_List_Popup_Item_2' then
    begin

    end
    else if TMenuItem(Sender).Name = 'A_SP_Playlist_List_Popup_Item_4' then
      uSoundplayer_Playlist_Actions_Edit_Delete
  end;
end;

{ TSOUNDPLAYER_CHECKBOX }

procedure TSOUNDPLAYER_CHECKBOX.OnMouseClick(Sender: TObject);
begin
  if TCheckBox(Sender).Name= 'A_SP_First_Main_Check' then
    uSoundplayer_Actions.CheckFirst(not addons.soundplayer.Actions.First);
end;

procedure TSOUNDPLAYER_CHECKBOX.OnMouseEnter(Sender: TObject);
begin

end;

procedure TSOUNDPLAYER_CHECKBOX.OnMouseLeave(Sender: TObject);
begin

end;

initialization

addons.soundplayer.Input.mouse.Image := TSOUNDPLAYER_IMAGE.Create;
addons.soundplayer.Input.mouse.Text := TSOUNDPLAYER_TEXT.Create;
addons.soundplayer.Input.mouse.Button := TSOUNDPLAYER_BUTTON.Create;
addons.soundplayer.Input.mouse.Stringgrid := TSOUNDPLAYER_STRINGGRID.Create;
addons.soundplayer.Input.mouse.Trackbar := TSOUNDPLAYER_TRACKBAR.Create;
addons.soundplayer.Input.mouse.Trackbar_Thumb := TSOUNDPLAYER_TRACKBAR_THUMB.Create;
addons.soundplayer.Input.mouse.RadioButton := TSOUNDPLAYER_RADIOBUTTON.Create;
addons.soundplayer.Input.mouse.Menuitem := TSOUNDPLAYER_MENUITEM.Create;
addons.soundplayer.Input.mouse.Checkbox:= TSOUNDPLAYER_CHECKBOX.Create;

finalization

addons.soundplayer.Input.mouse.Image.Free;
addons.soundplayer.Input.mouse.Text.Free;
addons.soundplayer.Input.mouse.Button.Free;
addons.soundplayer.Input.mouse.Stringgrid.Free;
addons.soundplayer.Input.mouse.Trackbar.Free;
addons.soundplayer.Input.mouse.Trackbar_Thumb.Free;
addons.soundplayer.Input.mouse.RadioButton.Free;
addons.soundplayer.Input.mouse.Menuitem.Free;
addons.soundplayer.Input.mouse.Checkbox.Free;

end.
