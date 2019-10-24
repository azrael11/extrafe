namespace TagsLib_API
{

  public enum TCoverTypes
  {
    ctOther = 0x00,              // Other
    ctIcon  = 0x01,              // 32x32 pixels 'file icon' (PNG only)
    ctOtherIcon = 0x02,          // Other file icon
    ctCoverFront = 0x03,         // Cover (front)
    ctCoverback = 0x04,          // Cover (back)
    ctLeaflet = 0x05,            // Leaflet page
    ctLabel = 0x06,              // Media (e.g. label side of CD)
    ctLead = 0x07,               // Lead artist/lead performer/soloist
    ctArtist = 0x08,             // Artist/performer
    ctConductor = 0x09,          // Conductor
    ctBand = 0x0A,               // Band/Orchestra
    ctComposer = 0x0B,           // Composer
    ctLyricist = 0x0C,           // Lyricist/text writer
    ctRecordingLocation =  0x0D, // Recording Location
    ctDuringRecording = 0x0E,    // During recording
    ctPerformance = 0x0F,        // During performance
    ctMovie = 0x10,              // Movie/video screen capture
    ctcoloured = 0x11,           // A bright coloured fish
    ctIllustration = 0x12,       // Illustration
    ctBandLogo = 0x13,           // Band/artist logotype
    ctPublisher = 0x14           // Publisher/Studio logotype
  }

}