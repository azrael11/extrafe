namespace TagsLibraryTutorialDLLC
{
  partial class Form1
  {
    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
    protected override void Dispose(bool disposing)
    {
      if (disposing && (components != null))
      {
        components.Dispose();
      }
      base.Dispose(disposing);
    }

    #region Windows Form Designer generated code

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
      this.components = new System.ComponentModel.Container();
      this.grpCoverarts = new System.Windows.Forms.GroupBox();
      this.grpCoverTypes = new System.Windows.Forms.GroupBox();
      this.rbOther = new System.Windows.Forms.RadioButton();
      this.rbBandLogo = new System.Windows.Forms.RadioButton();
      this.rbComposer = new System.Windows.Forms.RadioButton();
      this.rbPerformance = new System.Windows.Forms.RadioButton();
      this.rbBand = new System.Windows.Forms.RadioButton();
      this.rbConductor = new System.Windows.Forms.RadioButton();
      this.rbCoverback = new System.Windows.Forms.RadioButton();
      this.rbLabel = new System.Windows.Forms.RadioButton();
      this.rbArtist = new System.Windows.Forms.RadioButton();
      this.rbCoverfront = new System.Windows.Forms.RadioButton();
      this.lvThumb = new System.Windows.Forms.ListView();
      this.ColumnHeader5 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
      this.ColumnHeader6 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
      this.ImageListThumbs = new System.Windows.Forms.ImageList(this.components);
      this.txtBitRate = new System.Windows.Forms.TextBox();
      this.txtSampleCount = new System.Windows.Forms.TextBox();
      this.txtPlayTime = new System.Windows.Forms.TextBox();
      this.txtBitsPerSample = new System.Windows.Forms.TextBox();
      this.txtSamplesPerSec = new System.Windows.Forms.TextBox();
      this.txtChannels = new System.Windows.Forms.TextBox();
      this.lblBitRate = new System.Windows.Forms.Label();
      this.lblSampleCount = new System.Windows.Forms.Label();
      this.lblPlayTime = new System.Windows.Forms.Label();
      this.lblBitsPerSample = new System.Windows.Forms.Label();
      this.lblSamplesPerSec = new System.Windows.Forms.Label();
      this.lblChannels = new System.Windows.Forms.Label();
      this.ListView1 = new System.Windows.Forms.ListView();
      this.ColumnHeader1 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
      this.ColumnHeader2 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
      this.btnDelete = new System.Windows.Forms.Button();
      this.btnAttribute = new System.Windows.Forms.Button();
      this.lblVarious = new System.Windows.Forms.Label();
      this.GroupBox1 = new System.Windows.Forms.GroupBox();
      this.txtAlbum = new System.Windows.Forms.TextBox();
      this.txtTitle = new System.Windows.Forms.TextBox();
      this.txtArtist = new System.Windows.Forms.TextBox();
      this.lblAlbum = new System.Windows.Forms.Label();
      this.lblTitle = new System.Windows.Forms.Label();
      this.lblArtist = new System.Windows.Forms.Label();
      this.OpenFileDialog1 = new System.Windows.Forms.OpenFileDialog();
      this.btnRemove = new System.Windows.Forms.Button();
      this.btnSave = new System.Windows.Forms.Button();
      this.btnOpen = new System.Windows.Forms.Button();
      this.txtFilename = new System.Windows.Forms.TextBox();
      this.lblFilename = new System.Windows.Forms.Label();
      this.grpAllTags = new System.Windows.Forms.GroupBox();
      this.ListView2 = new System.Windows.Forms.ListView();
      this.columnHeader3 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
      this.columnHeader4 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
      this.lblAttrib = new System.Windows.Forms.Label();
      this.btnExport = new System.Windows.Forms.Button();
      this.saveFileDialog1 = new System.Windows.Forms.SaveFileDialog();
      this.grpCoverarts.SuspendLayout();
      this.grpCoverTypes.SuspendLayout();
      this.GroupBox1.SuspendLayout();
      this.grpAllTags.SuspendLayout();
      this.SuspendLayout();
      // 
      // grpCoverarts
      // 
      this.grpCoverarts.Controls.Add(this.grpCoverTypes);
      this.grpCoverarts.Controls.Add(this.lvThumb);
      this.grpCoverarts.Controls.Add(this.txtBitRate);
      this.grpCoverarts.Controls.Add(this.txtSampleCount);
      this.grpCoverarts.Controls.Add(this.txtPlayTime);
      this.grpCoverarts.Controls.Add(this.txtBitsPerSample);
      this.grpCoverarts.Controls.Add(this.txtSamplesPerSec);
      this.grpCoverarts.Controls.Add(this.txtChannels);
      this.grpCoverarts.Controls.Add(this.lblBitRate);
      this.grpCoverarts.Controls.Add(this.lblSampleCount);
      this.grpCoverarts.Controls.Add(this.lblPlayTime);
      this.grpCoverarts.Controls.Add(this.lblBitsPerSample);
      this.grpCoverarts.Controls.Add(this.lblSamplesPerSec);
      this.grpCoverarts.Controls.Add(this.lblChannels);
      this.grpCoverarts.Location = new System.Drawing.Point(17, 520);
      this.grpCoverarts.Name = "grpCoverarts";
      this.grpCoverarts.Size = new System.Drawing.Size(826, 177);
      this.grpCoverarts.TabIndex = 31;
      this.grpCoverarts.TabStop = false;
      this.grpCoverarts.Text = "Cover arts:";
      // 
      // grpCoverTypes
      // 
      this.grpCoverTypes.Controls.Add(this.rbOther);
      this.grpCoverTypes.Controls.Add(this.rbBandLogo);
      this.grpCoverTypes.Controls.Add(this.rbComposer);
      this.grpCoverTypes.Controls.Add(this.rbPerformance);
      this.grpCoverTypes.Controls.Add(this.rbBand);
      this.grpCoverTypes.Controls.Add(this.rbConductor);
      this.grpCoverTypes.Controls.Add(this.rbCoverback);
      this.grpCoverTypes.Controls.Add(this.rbLabel);
      this.grpCoverTypes.Controls.Add(this.rbArtist);
      this.grpCoverTypes.Controls.Add(this.rbCoverfront);
      this.grpCoverTypes.Location = new System.Drawing.Point(364, 11);
      this.grpCoverTypes.Name = "grpCoverTypes";
      this.grpCoverTypes.Size = new System.Drawing.Size(200, 160);
      this.grpCoverTypes.TabIndex = 28;
      this.grpCoverTypes.TabStop = false;
      this.grpCoverTypes.Text = "Cover Types";
      // 
      // rbOther
      // 
      this.rbOther.AutoCheck = false;
      this.rbOther.AutoSize = true;
      this.rbOther.Location = new System.Drawing.Point(109, 124);
      this.rbOther.Name = "rbOther";
      this.rbOther.Size = new System.Drawing.Size(51, 17);
      this.rbOther.TabIndex = 37;
      this.rbOther.Text = "Other";
      this.rbOther.UseVisualStyleBackColor = true;
      this.rbOther.MouseDown += new System.Windows.Forms.MouseEventHandler(this.rbOther_MouseDown);
      // 
      // rbBandLogo
      // 
      this.rbBandLogo.AutoCheck = false;
      this.rbBandLogo.AutoSize = true;
      this.rbBandLogo.Location = new System.Drawing.Point(109, 101);
      this.rbBandLogo.Name = "rbBandLogo";
      this.rbBandLogo.Size = new System.Drawing.Size(73, 17);
      this.rbBandLogo.TabIndex = 36;
      this.rbBandLogo.Text = "Band logo";
      this.rbBandLogo.UseVisualStyleBackColor = true;
      this.rbBandLogo.MouseDown += new System.Windows.Forms.MouseEventHandler(this.rbBandLogo_MouseDown);
      // 
      // rbComposer
      // 
      this.rbComposer.AutoCheck = false;
      this.rbComposer.AutoSize = true;
      this.rbComposer.Location = new System.Drawing.Point(109, 78);
      this.rbComposer.Name = "rbComposer";
      this.rbComposer.Size = new System.Drawing.Size(72, 17);
      this.rbComposer.TabIndex = 35;
      this.rbComposer.Tag = "";
      this.rbComposer.Text = "Composer";
      this.rbComposer.UseVisualStyleBackColor = true;
      this.rbComposer.MouseDown += new System.Windows.Forms.MouseEventHandler(this.rbComposer_MouseDown);
      // 
      // rbPerformance
      // 
      this.rbPerformance.AutoCheck = false;
      this.rbPerformance.AutoSize = true;
      this.rbPerformance.Location = new System.Drawing.Point(109, 55);
      this.rbPerformance.Name = "rbPerformance";
      this.rbPerformance.Size = new System.Drawing.Size(85, 17);
      this.rbPerformance.TabIndex = 34;
      this.rbPerformance.Tag = "";
      this.rbPerformance.Text = "Performance";
      this.rbPerformance.UseVisualStyleBackColor = true;
      this.rbPerformance.MouseDown += new System.Windows.Forms.MouseEventHandler(this.rbPerformance_MouseDown);
      // 
      // rbBand
      // 
      this.rbBand.AutoCheck = false;
      this.rbBand.AutoSize = true;
      this.rbBand.Location = new System.Drawing.Point(109, 32);
      this.rbBand.Name = "rbBand";
      this.rbBand.Size = new System.Drawing.Size(50, 17);
      this.rbBand.TabIndex = 33;
      this.rbBand.Tag = "";
      this.rbBand.Text = "Band";
      this.rbBand.UseVisualStyleBackColor = true;
      this.rbBand.MouseDown += new System.Windows.Forms.MouseEventHandler(this.rbBand_MouseDown);
      // 
      // rbConductor
      // 
      this.rbConductor.AutoCheck = false;
      this.rbConductor.AutoSize = true;
      this.rbConductor.Location = new System.Drawing.Point(14, 124);
      this.rbConductor.Name = "rbConductor";
      this.rbConductor.Size = new System.Drawing.Size(74, 17);
      this.rbConductor.TabIndex = 32;
      this.rbConductor.Tag = "";
      this.rbConductor.Text = "Conductor";
      this.rbConductor.UseVisualStyleBackColor = true;
      this.rbConductor.MouseDown += new System.Windows.Forms.MouseEventHandler(this.rbConductor_MouseDown);
      // 
      // rbCoverback
      // 
      this.rbCoverback.AutoCheck = false;
      this.rbCoverback.AutoSize = true;
      this.rbCoverback.Location = new System.Drawing.Point(14, 55);
      this.rbCoverback.Name = "rbCoverback";
      this.rbCoverback.Size = new System.Drawing.Size(86, 17);
      this.rbCoverback.TabIndex = 31;
      this.rbCoverback.Tag = "";
      this.rbCoverback.Text = "Cover (back)";
      this.rbCoverback.UseVisualStyleBackColor = true;
      this.rbCoverback.MouseDown += new System.Windows.Forms.MouseEventHandler(this.rbCoverback_MouseDown);
      // 
      // rbLabel
      // 
      this.rbLabel.AutoCheck = false;
      this.rbLabel.AutoSize = true;
      this.rbLabel.Location = new System.Drawing.Point(14, 78);
      this.rbLabel.Name = "rbLabel";
      this.rbLabel.Size = new System.Drawing.Size(51, 17);
      this.rbLabel.TabIndex = 30;
      this.rbLabel.Tag = "";
      this.rbLabel.Text = "Label";
      this.rbLabel.UseVisualStyleBackColor = true;
      this.rbLabel.MouseDown += new System.Windows.Forms.MouseEventHandler(this.rbLabel_MouseDown);
      // 
      // rbArtist
      // 
      this.rbArtist.AutoCheck = false;
      this.rbArtist.AutoSize = true;
      this.rbArtist.Location = new System.Drawing.Point(14, 101);
      this.rbArtist.Name = "rbArtist";
      this.rbArtist.Size = new System.Drawing.Size(48, 17);
      this.rbArtist.TabIndex = 29;
      this.rbArtist.Tag = "";
      this.rbArtist.Text = "Artist";
      this.rbArtist.UseVisualStyleBackColor = true;
      this.rbArtist.MouseDown += new System.Windows.Forms.MouseEventHandler(this.rbArtist_MouseDown);
      // 
      // rbCoverfront
      // 
      this.rbCoverfront.AutoCheck = false;
      this.rbCoverfront.AutoSize = true;
      this.rbCoverfront.Location = new System.Drawing.Point(14, 32);
      this.rbCoverfront.Name = "rbCoverfront";
      this.rbCoverfront.Size = new System.Drawing.Size(83, 17);
      this.rbCoverfront.TabIndex = 28;
      this.rbCoverfront.Tag = "";
      this.rbCoverfront.Text = "Cover (front)";
      this.rbCoverfront.UseVisualStyleBackColor = true;
      this.rbCoverfront.MouseDown += new System.Windows.Forms.MouseEventHandler(this.rbCoverfront_MouseDown);
      // 
      // lvThumb
      // 
      this.lvThumb.Alignment = System.Windows.Forms.ListViewAlignment.Left;
      this.lvThumb.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.ColumnHeader5,
            this.ColumnHeader6});
      this.lvThumb.GridLines = true;
      this.lvThumb.LabelEdit = true;
      this.lvThumb.LargeImageList = this.ImageListThumbs;
      this.lvThumb.Location = new System.Drawing.Point(8, 16);
      this.lvThumb.MultiSelect = false;
      this.lvThumb.Name = "lvThumb";
      this.lvThumb.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.lvThumb.Size = new System.Drawing.Size(346, 155);
      this.lvThumb.TabIndex = 22;
      this.lvThumb.UseCompatibleStateImageBehavior = false;
      // 
      // ColumnHeader5
      // 
      this.ColumnHeader5.Text = "Name";
      this.ColumnHeader5.Width = 100;
      // 
      // ColumnHeader6
      // 
      this.ColumnHeader6.Text = "Value";
      this.ColumnHeader6.Width = 100;
      // 
      // ImageListThumbs
      // 
      this.ImageListThumbs.ColorDepth = System.Windows.Forms.ColorDepth.Depth24Bit;
      this.ImageListThumbs.ImageSize = new System.Drawing.Size(150, 110);
      this.ImageListThumbs.TransparentColor = System.Drawing.Color.Transparent;
      // 
      // txtBitRate
      // 
      this.txtBitRate.Location = new System.Drawing.Point(666, 149);
      this.txtBitRate.Name = "txtBitRate";
      this.txtBitRate.Size = new System.Drawing.Size(145, 20);
      this.txtBitRate.TabIndex = 19;
      // 
      // txtSampleCount
      // 
      this.txtSampleCount.Location = new System.Drawing.Point(666, 124);
      this.txtSampleCount.Name = "txtSampleCount";
      this.txtSampleCount.Size = new System.Drawing.Size(145, 20);
      this.txtSampleCount.TabIndex = 18;
      // 
      // txtPlayTime
      // 
      this.txtPlayTime.Location = new System.Drawing.Point(666, 98);
      this.txtPlayTime.Name = "txtPlayTime";
      this.txtPlayTime.Size = new System.Drawing.Size(145, 20);
      this.txtPlayTime.TabIndex = 17;
      // 
      // txtBitsPerSample
      // 
      this.txtBitsPerSample.Location = new System.Drawing.Point(666, 72);
      this.txtBitsPerSample.Name = "txtBitsPerSample";
      this.txtBitsPerSample.Size = new System.Drawing.Size(145, 20);
      this.txtBitsPerSample.TabIndex = 16;
      // 
      // txtSamplesPerSec
      // 
      this.txtSamplesPerSec.Location = new System.Drawing.Point(666, 45);
      this.txtSamplesPerSec.Name = "txtSamplesPerSec";
      this.txtSamplesPerSec.Size = new System.Drawing.Size(145, 20);
      this.txtSamplesPerSec.TabIndex = 15;
      // 
      // txtChannels
      // 
      this.txtChannels.Location = new System.Drawing.Point(666, 19);
      this.txtChannels.Name = "txtChannels";
      this.txtChannels.Size = new System.Drawing.Size(145, 20);
      this.txtChannels.TabIndex = 14;
      // 
      // lblBitRate
      // 
      this.lblBitRate.AutoSize = true;
      this.lblBitRate.Location = new System.Drawing.Point(570, 152);
      this.lblBitRate.Name = "lblBitRate";
      this.lblBitRate.Size = new System.Drawing.Size(45, 13);
      this.lblBitRate.TabIndex = 13;
      this.lblBitRate.Text = "BitRate:";
      // 
      // lblSampleCount
      // 
      this.lblSampleCount.AutoSize = true;
      this.lblSampleCount.Location = new System.Drawing.Point(570, 127);
      this.lblSampleCount.Name = "lblSampleCount";
      this.lblSampleCount.Size = new System.Drawing.Size(73, 13);
      this.lblSampleCount.TabIndex = 12;
      this.lblSampleCount.Text = "SampleCount:";
      // 
      // lblPlayTime
      // 
      this.lblPlayTime.AutoSize = true;
      this.lblPlayTime.Location = new System.Drawing.Point(570, 101);
      this.lblPlayTime.Name = "lblPlayTime";
      this.lblPlayTime.Size = new System.Drawing.Size(53, 13);
      this.lblPlayTime.TabIndex = 11;
      this.lblPlayTime.Text = "PlayTime:";
      // 
      // lblBitsPerSample
      // 
      this.lblBitsPerSample.AutoSize = true;
      this.lblBitsPerSample.Location = new System.Drawing.Point(570, 75);
      this.lblBitsPerSample.Name = "lblBitsPerSample";
      this.lblBitsPerSample.Size = new System.Drawing.Size(78, 13);
      this.lblBitsPerSample.TabIndex = 10;
      this.lblBitsPerSample.Text = "BitsPerSample:";
      // 
      // lblSamplesPerSec
      // 
      this.lblSamplesPerSec.AutoSize = true;
      this.lblSamplesPerSec.Location = new System.Drawing.Point(570, 46);
      this.lblSamplesPerSec.Name = "lblSamplesPerSec";
      this.lblSamplesPerSec.Size = new System.Drawing.Size(85, 13);
      this.lblSamplesPerSec.TabIndex = 9;
      this.lblSamplesPerSec.Text = "SamplesPerSec:";
      // 
      // lblChannels
      // 
      this.lblChannels.AutoSize = true;
      this.lblChannels.Location = new System.Drawing.Point(570, 19);
      this.lblChannels.Name = "lblChannels";
      this.lblChannels.Size = new System.Drawing.Size(54, 13);
      this.lblChannels.TabIndex = 8;
      this.lblChannels.Text = "Channels:";
      // 
      // ListView1
      // 
      this.ListView1.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.ColumnHeader1,
            this.ColumnHeader2});
      this.ListView1.FullRowSelect = true;
      this.ListView1.GridLines = true;
      this.ListView1.Location = new System.Drawing.Point(11, 16);
      this.ListView1.Name = "ListView1";
      this.ListView1.Size = new System.Drawing.Size(445, 295);
      this.ListView1.TabIndex = 10;
      this.ListView1.UseCompatibleStateImageBehavior = false;
      // 
      // ColumnHeader1
      // 
      this.ColumnHeader1.Text = "Name";
      this.ColumnHeader1.Width = 100;
      // 
      // ColumnHeader2
      // 
      this.ColumnHeader2.Text = "Value";
      this.ColumnHeader2.Width = 175;
      // 
      // btnDelete
      // 
      this.btnDelete.Location = new System.Drawing.Point(860, 529);
      this.btnDelete.Name = "btnDelete";
      this.btnDelete.Size = new System.Drawing.Size(75, 23);
      this.btnDelete.TabIndex = 33;
      this.btnDelete.Text = "Delete";
      this.btnDelete.UseVisualStyleBackColor = true;
      this.btnDelete.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnDelete_MouseDown);
      // 
      // btnAttribute
      // 
      this.btnAttribute.Location = new System.Drawing.Point(860, 625);
      this.btnAttribute.Name = "btnAttribute";
      this.btnAttribute.Size = new System.Drawing.Size(75, 61);
      this.btnAttribute.TabIndex = 35;
      this.btnAttribute.Text = "Attribute instead of Attributes";
      this.btnAttribute.UseVisualStyleBackColor = true;
      this.btnAttribute.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnAttribute_MouseDown);
      // 
      // lblVarious
      // 
      this.lblVarious.AutoSize = true;
      this.lblVarious.Location = new System.Drawing.Point(470, 0);
      this.lblVarious.Name = "lblVarious";
      this.lblVarious.Size = new System.Drawing.Size(116, 13);
      this.lblVarious.TabIndex = 8;
      this.lblVarious.Text = "Various Tags Attributes";
      // 
      // GroupBox1
      // 
      this.GroupBox1.Controls.Add(this.txtAlbum);
      this.GroupBox1.Controls.Add(this.txtTitle);
      this.GroupBox1.Controls.Add(this.txtArtist);
      this.GroupBox1.Controls.Add(this.lblAlbum);
      this.GroupBox1.Controls.Add(this.lblTitle);
      this.GroupBox1.Controls.Add(this.lblArtist);
      this.GroupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.GroupBox1.Location = new System.Drawing.Point(17, 87);
      this.GroupBox1.Name = "GroupBox1";
      this.GroupBox1.Size = new System.Drawing.Size(456, 100);
      this.GroupBox1.TabIndex = 29;
      this.GroupBox1.TabStop = false;
      this.GroupBox1.Text = "Tags";
      // 
      // txtAlbum
      // 
      this.txtAlbum.Location = new System.Drawing.Point(53, 67);
      this.txtAlbum.Name = "txtAlbum";
      this.txtAlbum.Size = new System.Drawing.Size(397, 20);
      this.txtAlbum.TabIndex = 5;
      // 
      // txtTitle
      // 
      this.txtTitle.Location = new System.Drawing.Point(53, 43);
      this.txtTitle.Name = "txtTitle";
      this.txtTitle.Size = new System.Drawing.Size(397, 20);
      this.txtTitle.TabIndex = 4;
      // 
      // txtArtist
      // 
      this.txtArtist.Location = new System.Drawing.Point(53, 19);
      this.txtArtist.Name = "txtArtist";
      this.txtArtist.Size = new System.Drawing.Size(397, 20);
      this.txtArtist.TabIndex = 3;
      // 
      // lblAlbum
      // 
      this.lblAlbum.AutoSize = true;
      this.lblAlbum.Location = new System.Drawing.Point(14, 70);
      this.lblAlbum.Name = "lblAlbum";
      this.lblAlbum.Size = new System.Drawing.Size(39, 13);
      this.lblAlbum.TabIndex = 2;
      this.lblAlbum.Text = "Album:";
      // 
      // lblTitle
      // 
      this.lblTitle.AutoSize = true;
      this.lblTitle.Location = new System.Drawing.Point(14, 46);
      this.lblTitle.Name = "lblTitle";
      this.lblTitle.Size = new System.Drawing.Size(30, 13);
      this.lblTitle.TabIndex = 1;
      this.lblTitle.Text = "Title:";
      // 
      // lblArtist
      // 
      this.lblArtist.AutoSize = true;
      this.lblArtist.Location = new System.Drawing.Point(14, 22);
      this.lblArtist.Name = "lblArtist";
      this.lblArtist.Size = new System.Drawing.Size(33, 13);
      this.lblArtist.TabIndex = 0;
      this.lblArtist.Text = "Artist:";
      // 
      // OpenFileDialog1
      // 
      this.OpenFileDialog1.FileName = "OpenFileDialog1";
      // 
      // btnRemove
      // 
      this.btnRemove.Location = new System.Drawing.Point(284, 52);
      this.btnRemove.Name = "btnRemove";
      this.btnRemove.Size = new System.Drawing.Size(96, 23);
      this.btnRemove.TabIndex = 28;
      this.btnRemove.Text = "Remove ID3v2";
      this.btnRemove.UseVisualStyleBackColor = true;
      this.btnRemove.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnRemove_MouseDown);
      // 
      // btnSave
      // 
      this.btnSave.Location = new System.Drawing.Point(386, 52);
      this.btnSave.Name = "btnSave";
      this.btnSave.Size = new System.Drawing.Size(81, 23);
      this.btnSave.TabIndex = 27;
      this.btnSave.Text = "Save";
      this.btnSave.UseVisualStyleBackColor = true;
      this.btnSave.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnSave_MouseDown);
      // 
      // btnOpen
      // 
      this.btnOpen.Location = new System.Drawing.Point(434, 23);
      this.btnOpen.Name = "btnOpen";
      this.btnOpen.Size = new System.Drawing.Size(33, 23);
      this.btnOpen.TabIndex = 26;
      this.btnOpen.Text = "...";
      this.btnOpen.UseVisualStyleBackColor = true;
      this.btnOpen.Click += new System.EventHandler(this.btnOpen_Click);
      // 
      // txtFilename
      // 
      this.txtFilename.Location = new System.Drawing.Point(70, 25);
      this.txtFilename.Name = "txtFilename";
      this.txtFilename.Size = new System.Drawing.Size(357, 20);
      this.txtFilename.TabIndex = 25;
      // 
      // lblFilename
      // 
      this.lblFilename.AutoSize = true;
      this.lblFilename.Location = new System.Drawing.Point(14, 25);
      this.lblFilename.Name = "lblFilename";
      this.lblFilename.Size = new System.Drawing.Size(52, 13);
      this.lblFilename.TabIndex = 24;
      this.lblFilename.Text = "Filename:";
      // 
      // grpAllTags
      // 
      this.grpAllTags.Controls.Add(this.ListView2);
      this.grpAllTags.Controls.Add(this.ListView1);
      this.grpAllTags.Controls.Add(this.lblVarious);
      this.grpAllTags.Controls.Add(this.lblAttrib);
      this.grpAllTags.Location = new System.Drawing.Point(17, 193);
      this.grpAllTags.Name = "grpAllTags";
      this.grpAllTags.Size = new System.Drawing.Size(918, 321);
      this.grpAllTags.TabIndex = 30;
      this.grpAllTags.TabStop = false;
      // 
      // ListView2
      // 
      this.ListView2.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader3,
            this.columnHeader4});
      this.ListView2.FullRowSelect = true;
      this.ListView2.GridLines = true;
      this.ListView2.Location = new System.Drawing.Point(462, 16);
      this.ListView2.Name = "ListView2";
      this.ListView2.Size = new System.Drawing.Size(445, 295);
      this.ListView2.TabIndex = 11;
      this.ListView2.UseCompatibleStateImageBehavior = false;
      // 
      // columnHeader3
      // 
      this.columnHeader3.Text = "Tags Name";
      this.columnHeader3.Width = 100;
      // 
      // columnHeader4
      // 
      this.columnHeader4.Text = "Tags Value";
      this.columnHeader4.Width = 190;
      // 
      // lblAttrib
      // 
      this.lblAttrib.AutoSize = true;
      this.lblAttrib.Location = new System.Drawing.Point(14, 0);
      this.lblAttrib.Name = "lblAttrib";
      this.lblAttrib.Size = new System.Drawing.Size(116, 13);
      this.lblAttrib.TabIndex = 7;
      this.lblAttrib.Text = "Various AudioAttributes";
      // 
      // btnExport
      // 
      this.btnExport.Location = new System.Drawing.Point(860, 558);
      this.btnExport.Name = "btnExport";
      this.btnExport.Size = new System.Drawing.Size(75, 23);
      this.btnExport.TabIndex = 34;
      this.btnExport.Text = "Export";
      this.btnExport.UseVisualStyleBackColor = true;
      this.btnExport.MouseDown += new System.Windows.Forms.MouseEventHandler(this.btnExport_MouseDown);
      // 
      // Form1
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(947, 705);
      this.Controls.Add(this.grpCoverarts);
      this.Controls.Add(this.btnDelete);
      this.Controls.Add(this.btnAttribute);
      this.Controls.Add(this.GroupBox1);
      this.Controls.Add(this.btnRemove);
      this.Controls.Add(this.btnSave);
      this.Controls.Add(this.btnOpen);
      this.Controls.Add(this.txtFilename);
      this.Controls.Add(this.lblFilename);
      this.Controls.Add(this.grpAllTags);
      this.Controls.Add(this.btnExport);
      this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
      this.Name = "Form1";
      this.Text = "Tags Library Tutorial for C#";
      this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_FormClosing);
      this.grpCoverarts.ResumeLayout(false);
      this.grpCoverarts.PerformLayout();
      this.grpCoverTypes.ResumeLayout(false);
      this.grpCoverTypes.PerformLayout();
      this.GroupBox1.ResumeLayout(false);
      this.GroupBox1.PerformLayout();
      this.grpAllTags.ResumeLayout(false);
      this.grpAllTags.PerformLayout();
      this.ResumeLayout(false);
      this.PerformLayout();

    }

    #endregion

    internal System.Windows.Forms.GroupBox grpCoverarts;
    internal System.Windows.Forms.TextBox txtBitRate;
    internal System.Windows.Forms.TextBox txtSampleCount;
    internal System.Windows.Forms.TextBox txtPlayTime;
    internal System.Windows.Forms.TextBox txtBitsPerSample;
    internal System.Windows.Forms.TextBox txtSamplesPerSec;
    internal System.Windows.Forms.TextBox txtChannels;
    internal System.Windows.Forms.Label lblBitRate;
    internal System.Windows.Forms.Label lblSampleCount;
    internal System.Windows.Forms.Label lblPlayTime;
    internal System.Windows.Forms.Label lblBitsPerSample;
    internal System.Windows.Forms.Label lblSamplesPerSec;
    internal System.Windows.Forms.Label lblChannels;
    internal System.Windows.Forms.ListView ListView1;
    internal System.Windows.Forms.ColumnHeader ColumnHeader1;
    internal System.Windows.Forms.ColumnHeader ColumnHeader2;
    internal System.Windows.Forms.Button btnDelete;
    internal System.Windows.Forms.Button btnAttribute;
    internal System.Windows.Forms.Label lblVarious;
    internal System.Windows.Forms.GroupBox GroupBox1;
    internal System.Windows.Forms.TextBox txtAlbum;
    internal System.Windows.Forms.TextBox txtTitle;
    internal System.Windows.Forms.TextBox txtArtist;
    internal System.Windows.Forms.Label lblAlbum;
    internal System.Windows.Forms.Label lblTitle;
    internal System.Windows.Forms.Label lblArtist;
    internal System.Windows.Forms.OpenFileDialog OpenFileDialog1;
    internal System.Windows.Forms.Button btnRemove;
    internal System.Windows.Forms.Button btnSave;
    internal System.Windows.Forms.Button btnOpen;
    internal System.Windows.Forms.TextBox txtFilename;
    internal System.Windows.Forms.Label lblFilename;
    internal System.Windows.Forms.GroupBox grpAllTags;
    internal System.Windows.Forms.Label lblAttrib;
    internal System.Windows.Forms.Button btnExport;
    internal System.Windows.Forms.ListView ListView2;
    internal System.Windows.Forms.ColumnHeader columnHeader3;
    internal System.Windows.Forms.ColumnHeader columnHeader4;
    internal System.Windows.Forms.ListView lvThumb;
    internal System.Windows.Forms.ColumnHeader ColumnHeader5;
    internal System.Windows.Forms.ColumnHeader ColumnHeader6;
    private System.Windows.Forms.ImageList ImageListThumbs;
    private System.Windows.Forms.SaveFileDialog saveFileDialog1;
    private System.Windows.Forms.GroupBox grpCoverTypes;
    private System.Windows.Forms.RadioButton rbOther;
    private System.Windows.Forms.RadioButton rbBandLogo;
    private System.Windows.Forms.RadioButton rbComposer;
    private System.Windows.Forms.RadioButton rbPerformance;
    private System.Windows.Forms.RadioButton rbBand;
    private System.Windows.Forms.RadioButton rbConductor;
    private System.Windows.Forms.RadioButton rbCoverback;
    private System.Windows.Forms.RadioButton rbLabel;
    private System.Windows.Forms.RadioButton rbArtist;
    private System.Windows.Forms.RadioButton rbCoverfront;
  }
}

