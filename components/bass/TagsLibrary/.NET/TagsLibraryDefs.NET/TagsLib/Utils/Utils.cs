using System;
using System.Runtime.InteropServices;
using System.Security;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;

namespace TagsLib_API.Utils
{
  ///<summary>
  ///various Utils
  ///</summary>
  [SuppressUnmanagedCodeSecurity]
  public sealed class Utils
  {
    ///<summary>
    /// Get a Pointer from Byte Array in Memory
    ///</summary>
    ///<returns>
    /// IntPointer
    ///</returns>      
    public unsafe static IntPtr GetPointerfromByteArray(byte[] Pointer)
    {
      fixed (byte* p = Pointer)
      {
        IntPtr IntPointer = (IntPtr)p;
        return IntPointer;
      }
    }
    ///<summary>
    /// Get Time Format in minutes
    ///</summary>
    ///<returns>
    /// Time Format min:sec
    ///</returns>  
    public static string GetTimeString(double numSeconds)
    {
      TimeSpan time = TimeSpan.FromSeconds(numSeconds);
      try
      {
        return (String.Format("{1}:{2}", Math.Floor(time.TotalHours).ToString().PadLeft(2, '0'),
          time.Minutes.ToString().PadLeft(2, '0'), time.Seconds.ToString().PadLeft(2, '0')));
      }
      catch (OverflowException ex)
        {
          return "Time length from File is corrupt." + ex.ToString();
        }
    }
  }

  ///<summary>
  ///Graphics related funcs
  ///</summary>
  [SuppressUnmanagedCodeSecurity]
  public sealed class PicFromMem
  {

    private static bool GetImageFromBytes(byte[] data, out Image image)
    {
      try
      {
        using (var ms = new MemoryStream(data))
        {
          image = Image.FromStream(ms);
        }
      }
      catch (ArgumentException)
      {
        image = null;

        return false;
      }

      return true;
    }

    private static Image RemoveMetadata(byte[] data)
    {
      Image image;

      if (GetImageFromBytes(data, out image))
      {
        Bitmap bitmap = new Bitmap(image);

        using (var graphics = Graphics.FromImage(bitmap))
        {
          graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
          graphics.CompositingMode = CompositingMode.SourceCopy;
          graphics.PixelOffsetMode = PixelOffsetMode.HighQuality;

          graphics.DrawImage(image, 0, 0);
        }
        return image;
      }

      return null;
    }
    ///<summary>
    /// Get Image from Memory Pointer
    ///</summary>
    ///<returns>
    ///Image from Byte Array without MetaData
    ///</returns>  
    public static Image GetImageFromMemPtr(IntPtr DataPtr, long Size)
    {
      byte[] bArray = new byte[Size];

      Marshal.Copy(DataPtr, bArray, 0, (int)Size);

      // Remove MetaData from File
      return RemoveMetadata(bArray);

    }
  }
}
