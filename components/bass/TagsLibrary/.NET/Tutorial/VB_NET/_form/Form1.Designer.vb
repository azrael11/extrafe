<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Form1
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Me.lblVarious = New System.Windows.Forms.Label()
        Me.txtAlbum = New System.Windows.Forms.TextBox()
        Me.txtTitle = New System.Windows.Forms.TextBox()
        Me.txtArtist = New System.Windows.Forms.TextBox()
        Me.lblAlbum = New System.Windows.Forms.Label()
        Me.txtBitRate = New System.Windows.Forms.TextBox()
        Me.txtSampleCount = New System.Windows.Forms.TextBox()
        Me.txtPlayTime = New System.Windows.Forms.TextBox()
        Me.txtBitsPerSample = New System.Windows.Forms.TextBox()
        Me.txtSamplesPerSec = New System.Windows.Forms.TextBox()
        Me.txtChannels = New System.Windows.Forms.TextBox()
        Me.lblBitRate = New System.Windows.Forms.Label()
        Me.lblSampleCount = New System.Windows.Forms.Label()
        Me.lblPlayTime = New System.Windows.Forms.Label()
        Me.lblBitsPerSample = New System.Windows.Forms.Label()
        Me.lblTitle = New System.Windows.Forms.Label()
        Me.lblArtist = New System.Windows.Forms.Label()
        Me.OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog()
        Me.lvThumb = New System.Windows.Forms.ListView()
        Me.ColumnHeader5 = CType(New System.Windows.Forms.ColumnHeader(), System.Windows.Forms.ColumnHeader)
        Me.ColumnHeader6 = CType(New System.Windows.Forms.ColumnHeader(), System.Windows.Forms.ColumnHeader)
        Me.ImageListThumbs = New System.Windows.Forms.ImageList(Me.components)
        Me.btnRemove = New System.Windows.Forms.Button()
        Me.btnSave = New System.Windows.Forms.Button()
        Me.btnOpen = New System.Windows.Forms.Button()
        Me.txtFilename = New System.Windows.Forms.TextBox()
        Me.lblFilename = New System.Windows.Forms.Label()
        Me.grpAllTags = New System.Windows.Forms.GroupBox()
        Me.ListView2 = New System.Windows.Forms.ListView()
        Me.columnHeader3 = CType(New System.Windows.Forms.ColumnHeader(), System.Windows.Forms.ColumnHeader)
        Me.columnHeader4 = CType(New System.Windows.Forms.ColumnHeader(), System.Windows.Forms.ColumnHeader)
        Me.ListView1 = New System.Windows.Forms.ListView()
        Me.ColumnHeader1 = CType(New System.Windows.Forms.ColumnHeader(), System.Windows.Forms.ColumnHeader)
        Me.ColumnHeader2 = CType(New System.Windows.Forms.ColumnHeader(), System.Windows.Forms.ColumnHeader)
        Me.lblAttrib = New System.Windows.Forms.Label()
        Me.grpCoverTypes = New System.Windows.Forms.GroupBox()
        Me.rbOther = New System.Windows.Forms.RadioButton()
        Me.rbBandLogo = New System.Windows.Forms.RadioButton()
        Me.rbComposer = New System.Windows.Forms.RadioButton()
        Me.rbPerformance = New System.Windows.Forms.RadioButton()
        Me.rbBand = New System.Windows.Forms.RadioButton()
        Me.rbConductor = New System.Windows.Forms.RadioButton()
        Me.rbCoverback = New System.Windows.Forms.RadioButton()
        Me.rbLabel = New System.Windows.Forms.RadioButton()
        Me.rbArtist = New System.Windows.Forms.RadioButton()
        Me.rbCoverfront = New System.Windows.Forms.RadioButton()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.saveFileDialog1 = New System.Windows.Forms.SaveFileDialog()
        Me.lblSamplesPerSec = New System.Windows.Forms.Label()
        Me.btnAttribute = New System.Windows.Forms.Button()
        Me.btnExport = New System.Windows.Forms.Button()
        Me.lblChannels = New System.Windows.Forms.Label()
        Me.grpCoverarts = New System.Windows.Forms.GroupBox()
        Me.btnDelete = New System.Windows.Forms.Button()
        Me.grpAllTags.SuspendLayout()
        Me.grpCoverTypes.SuspendLayout()
        Me.GroupBox1.SuspendLayout()
        Me.grpCoverarts.SuspendLayout()
        Me.SuspendLayout()
        '
        'lblVarious
        '
        Me.lblVarious.AutoSize = True
        Me.lblVarious.Location = New System.Drawing.Point(470, 0)
        Me.lblVarious.Name = "lblVarious"
        Me.lblVarious.Size = New System.Drawing.Size(116, 13)
        Me.lblVarious.TabIndex = 8
        Me.lblVarious.Text = "Various Tags Attributes"
        '
        'txtAlbum
        '
        Me.txtAlbum.Location = New System.Drawing.Point(53, 67)
        Me.txtAlbum.Name = "txtAlbum"
        Me.txtAlbum.Size = New System.Drawing.Size(397, 20)
        Me.txtAlbum.TabIndex = 5
        '
        'txtTitle
        '
        Me.txtTitle.Location = New System.Drawing.Point(53, 43)
        Me.txtTitle.Name = "txtTitle"
        Me.txtTitle.Size = New System.Drawing.Size(397, 20)
        Me.txtTitle.TabIndex = 4
        '
        'txtArtist
        '
        Me.txtArtist.Location = New System.Drawing.Point(53, 19)
        Me.txtArtist.Name = "txtArtist"
        Me.txtArtist.Size = New System.Drawing.Size(397, 20)
        Me.txtArtist.TabIndex = 3
        '
        'lblAlbum
        '
        Me.lblAlbum.AutoSize = True
        Me.lblAlbum.Location = New System.Drawing.Point(14, 70)
        Me.lblAlbum.Name = "lblAlbum"
        Me.lblAlbum.Size = New System.Drawing.Size(39, 13)
        Me.lblAlbum.TabIndex = 2
        Me.lblAlbum.Text = "Album:"
        '
        'txtBitRate
        '
        Me.txtBitRate.Location = New System.Drawing.Point(666, 149)
        Me.txtBitRate.Name = "txtBitRate"
        Me.txtBitRate.Size = New System.Drawing.Size(145, 20)
        Me.txtBitRate.TabIndex = 19
        '
        'txtSampleCount
        '
        Me.txtSampleCount.Location = New System.Drawing.Point(666, 124)
        Me.txtSampleCount.Name = "txtSampleCount"
        Me.txtSampleCount.Size = New System.Drawing.Size(145, 20)
        Me.txtSampleCount.TabIndex = 18
        '
        'txtPlayTime
        '
        Me.txtPlayTime.Location = New System.Drawing.Point(666, 98)
        Me.txtPlayTime.Name = "txtPlayTime"
        Me.txtPlayTime.Size = New System.Drawing.Size(145, 20)
        Me.txtPlayTime.TabIndex = 17
        '
        'txtBitsPerSample
        '
        Me.txtBitsPerSample.Location = New System.Drawing.Point(666, 72)
        Me.txtBitsPerSample.Name = "txtBitsPerSample"
        Me.txtBitsPerSample.Size = New System.Drawing.Size(145, 20)
        Me.txtBitsPerSample.TabIndex = 16
        '
        'txtSamplesPerSec
        '
        Me.txtSamplesPerSec.Location = New System.Drawing.Point(666, 45)
        Me.txtSamplesPerSec.Name = "txtSamplesPerSec"
        Me.txtSamplesPerSec.Size = New System.Drawing.Size(145, 20)
        Me.txtSamplesPerSec.TabIndex = 15
        '
        'txtChannels
        '
        Me.txtChannels.Location = New System.Drawing.Point(666, 19)
        Me.txtChannels.Name = "txtChannels"
        Me.txtChannels.Size = New System.Drawing.Size(145, 20)
        Me.txtChannels.TabIndex = 14
        '
        'lblBitRate
        '
        Me.lblBitRate.AutoSize = True
        Me.lblBitRate.Location = New System.Drawing.Point(570, 152)
        Me.lblBitRate.Name = "lblBitRate"
        Me.lblBitRate.Size = New System.Drawing.Size(45, 13)
        Me.lblBitRate.TabIndex = 13
        Me.lblBitRate.Text = "BitRate:"
        '
        'lblSampleCount
        '
        Me.lblSampleCount.AutoSize = True
        Me.lblSampleCount.Location = New System.Drawing.Point(570, 127)
        Me.lblSampleCount.Name = "lblSampleCount"
        Me.lblSampleCount.Size = New System.Drawing.Size(73, 13)
        Me.lblSampleCount.TabIndex = 12
        Me.lblSampleCount.Text = "SampleCount:"
        '
        'lblPlayTime
        '
        Me.lblPlayTime.AutoSize = True
        Me.lblPlayTime.Location = New System.Drawing.Point(570, 101)
        Me.lblPlayTime.Name = "lblPlayTime"
        Me.lblPlayTime.Size = New System.Drawing.Size(53, 13)
        Me.lblPlayTime.TabIndex = 11
        Me.lblPlayTime.Text = "PlayTime:"
        '
        'lblBitsPerSample
        '
        Me.lblBitsPerSample.AutoSize = True
        Me.lblBitsPerSample.Location = New System.Drawing.Point(570, 75)
        Me.lblBitsPerSample.Name = "lblBitsPerSample"
        Me.lblBitsPerSample.Size = New System.Drawing.Size(78, 13)
        Me.lblBitsPerSample.TabIndex = 10
        Me.lblBitsPerSample.Text = "BitsPerSample:"
        '
        'lblTitle
        '
        Me.lblTitle.AutoSize = True
        Me.lblTitle.Location = New System.Drawing.Point(14, 46)
        Me.lblTitle.Name = "lblTitle"
        Me.lblTitle.Size = New System.Drawing.Size(30, 13)
        Me.lblTitle.TabIndex = 1
        Me.lblTitle.Text = "Title:"
        '
        'lblArtist
        '
        Me.lblArtist.AutoSize = True
        Me.lblArtist.Location = New System.Drawing.Point(14, 22)
        Me.lblArtist.Name = "lblArtist"
        Me.lblArtist.Size = New System.Drawing.Size(33, 13)
        Me.lblArtist.TabIndex = 0
        Me.lblArtist.Text = "Artist:"
        '
        'OpenFileDialog1
        '
        Me.OpenFileDialog1.FileName = "OpenFileDialog1"
        '
        'lvThumb
        '
        Me.lvThumb.Alignment = System.Windows.Forms.ListViewAlignment.Left
        Me.lvThumb.Columns.AddRange(New System.Windows.Forms.ColumnHeader() {Me.ColumnHeader5, Me.ColumnHeader6})
        Me.lvThumb.GridLines = True
        Me.lvThumb.LabelEdit = True
        Me.lvThumb.LargeImageList = Me.ImageListThumbs
        Me.lvThumb.Location = New System.Drawing.Point(8, 16)
        Me.lvThumb.MultiSelect = False
        Me.lvThumb.Name = "lvThumb"
        Me.lvThumb.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lvThumb.Size = New System.Drawing.Size(346, 155)
        Me.lvThumb.TabIndex = 22
        Me.lvThumb.UseCompatibleStateImageBehavior = False
        '
        'ColumnHeader5
        '
        Me.ColumnHeader5.Text = "Name"
        Me.ColumnHeader5.Width = 100
        '
        'ColumnHeader6
        '
        Me.ColumnHeader6.Text = "Value"
        Me.ColumnHeader6.Width = 100
        '
        'ImageListThumbs
        '
        Me.ImageListThumbs.ColorDepth = System.Windows.Forms.ColorDepth.Depth24Bit
        Me.ImageListThumbs.ImageSize = New System.Drawing.Size(150, 110)
        Me.ImageListThumbs.TransparentColor = System.Drawing.Color.Transparent
        '
        'btnRemove
        '
        Me.btnRemove.Location = New System.Drawing.Point(283, 44)
        Me.btnRemove.Name = "btnRemove"
        Me.btnRemove.Size = New System.Drawing.Size(96, 23)
        Me.btnRemove.TabIndex = 40
        Me.btnRemove.Text = "Remove ID3v2"
        Me.btnRemove.UseVisualStyleBackColor = True
        '
        'btnSave
        '
        Me.btnSave.Location = New System.Drawing.Point(385, 44)
        Me.btnSave.Name = "btnSave"
        Me.btnSave.Size = New System.Drawing.Size(81, 23)
        Me.btnSave.TabIndex = 39
        Me.btnSave.Text = "Save"
        Me.btnSave.UseVisualStyleBackColor = True
        '
        'btnOpen
        '
        Me.btnOpen.Location = New System.Drawing.Point(433, 15)
        Me.btnOpen.Name = "btnOpen"
        Me.btnOpen.Size = New System.Drawing.Size(33, 23)
        Me.btnOpen.TabIndex = 38
        Me.btnOpen.Text = "..."
        Me.btnOpen.UseVisualStyleBackColor = True
        '
        'txtFilename
        '
        Me.txtFilename.Location = New System.Drawing.Point(69, 17)
        Me.txtFilename.Name = "txtFilename"
        Me.txtFilename.Size = New System.Drawing.Size(357, 20)
        Me.txtFilename.TabIndex = 37
        '
        'lblFilename
        '
        Me.lblFilename.AutoSize = True
        Me.lblFilename.Location = New System.Drawing.Point(13, 17)
        Me.lblFilename.Name = "lblFilename"
        Me.lblFilename.Size = New System.Drawing.Size(52, 13)
        Me.lblFilename.TabIndex = 36
        Me.lblFilename.Text = "Filename:"
        '
        'grpAllTags
        '
        Me.grpAllTags.Controls.Add(Me.ListView2)
        Me.grpAllTags.Controls.Add(Me.ListView1)
        Me.grpAllTags.Controls.Add(Me.lblVarious)
        Me.grpAllTags.Controls.Add(Me.lblAttrib)
        Me.grpAllTags.Location = New System.Drawing.Point(16, 185)
        Me.grpAllTags.Name = "grpAllTags"
        Me.grpAllTags.Size = New System.Drawing.Size(918, 321)
        Me.grpAllTags.TabIndex = 42
        Me.grpAllTags.TabStop = False
        '
        'ListView2
        '
        Me.ListView2.Columns.AddRange(New System.Windows.Forms.ColumnHeader() {Me.columnHeader3, Me.columnHeader4})
        Me.ListView2.FullRowSelect = True
        Me.ListView2.GridLines = True
        Me.ListView2.Location = New System.Drawing.Point(462, 16)
        Me.ListView2.Name = "ListView2"
        Me.ListView2.Size = New System.Drawing.Size(445, 295)
        Me.ListView2.TabIndex = 11
        Me.ListView2.UseCompatibleStateImageBehavior = False
        '
        'columnHeader3
        '
        Me.columnHeader3.Text = "Tags Name"
        Me.columnHeader3.Width = 100
        '
        'columnHeader4
        '
        Me.columnHeader4.Text = "Tags Value"
        Me.columnHeader4.Width = 190
        '
        'ListView1
        '
        Me.ListView1.Columns.AddRange(New System.Windows.Forms.ColumnHeader() {Me.ColumnHeader1, Me.ColumnHeader2})
        Me.ListView1.FullRowSelect = True
        Me.ListView1.GridLines = True
        Me.ListView1.Location = New System.Drawing.Point(11, 16)
        Me.ListView1.Name = "ListView1"
        Me.ListView1.Size = New System.Drawing.Size(445, 295)
        Me.ListView1.TabIndex = 10
        Me.ListView1.UseCompatibleStateImageBehavior = False
        '
        'ColumnHeader1
        '
        Me.ColumnHeader1.Text = "Name"
        Me.ColumnHeader1.Width = 100
        '
        'ColumnHeader2
        '
        Me.ColumnHeader2.Text = "Value"
        Me.ColumnHeader2.Width = 175
        '
        'lblAttrib
        '
        Me.lblAttrib.AutoSize = True
        Me.lblAttrib.Location = New System.Drawing.Point(14, 0)
        Me.lblAttrib.Name = "lblAttrib"
        Me.lblAttrib.Size = New System.Drawing.Size(116, 13)
        Me.lblAttrib.TabIndex = 7
        Me.lblAttrib.Text = "Various AudioAttributes"
        '
        'grpCoverTypes
        '
        Me.grpCoverTypes.Controls.Add(Me.rbOther)
        Me.grpCoverTypes.Controls.Add(Me.rbBandLogo)
        Me.grpCoverTypes.Controls.Add(Me.rbComposer)
        Me.grpCoverTypes.Controls.Add(Me.rbPerformance)
        Me.grpCoverTypes.Controls.Add(Me.rbBand)
        Me.grpCoverTypes.Controls.Add(Me.rbConductor)
        Me.grpCoverTypes.Controls.Add(Me.rbCoverback)
        Me.grpCoverTypes.Controls.Add(Me.rbLabel)
        Me.grpCoverTypes.Controls.Add(Me.rbArtist)
        Me.grpCoverTypes.Controls.Add(Me.rbCoverfront)
        Me.grpCoverTypes.Location = New System.Drawing.Point(364, 11)
        Me.grpCoverTypes.Name = "grpCoverTypes"
        Me.grpCoverTypes.Size = New System.Drawing.Size(200, 160)
        Me.grpCoverTypes.TabIndex = 28
        Me.grpCoverTypes.TabStop = False
        Me.grpCoverTypes.Text = "Cover Types"
        '
        'rbOther
        '
        Me.rbOther.AutoCheck = False
        Me.rbOther.AutoSize = True
        Me.rbOther.Location = New System.Drawing.Point(109, 124)
        Me.rbOther.Name = "rbOther"
        Me.rbOther.Size = New System.Drawing.Size(51, 17)
        Me.rbOther.TabIndex = 37
        Me.rbOther.Text = "Other"
        Me.rbOther.UseVisualStyleBackColor = True
        '
        'rbBandLogo
        '
        Me.rbBandLogo.AutoCheck = False
        Me.rbBandLogo.AutoSize = True
        Me.rbBandLogo.Location = New System.Drawing.Point(109, 101)
        Me.rbBandLogo.Name = "rbBandLogo"
        Me.rbBandLogo.Size = New System.Drawing.Size(73, 17)
        Me.rbBandLogo.TabIndex = 36
        Me.rbBandLogo.Text = "Band logo"
        Me.rbBandLogo.UseVisualStyleBackColor = True
        '
        'rbComposer
        '
        Me.rbComposer.AutoCheck = False
        Me.rbComposer.AutoSize = True
        Me.rbComposer.Location = New System.Drawing.Point(109, 78)
        Me.rbComposer.Name = "rbComposer"
        Me.rbComposer.Size = New System.Drawing.Size(72, 17)
        Me.rbComposer.TabIndex = 35
        Me.rbComposer.Tag = ""
        Me.rbComposer.Text = "Composer"
        Me.rbComposer.UseVisualStyleBackColor = True
        '
        'rbPerformance
        '
        Me.rbPerformance.AutoCheck = False
        Me.rbPerformance.AutoSize = True
        Me.rbPerformance.Location = New System.Drawing.Point(109, 55)
        Me.rbPerformance.Name = "rbPerformance"
        Me.rbPerformance.Size = New System.Drawing.Size(85, 17)
        Me.rbPerformance.TabIndex = 34
        Me.rbPerformance.Tag = ""
        Me.rbPerformance.Text = "Performance"
        Me.rbPerformance.UseVisualStyleBackColor = True
        '
        'rbBand
        '
        Me.rbBand.AutoCheck = False
        Me.rbBand.AutoSize = True
        Me.rbBand.Location = New System.Drawing.Point(109, 32)
        Me.rbBand.Name = "rbBand"
        Me.rbBand.Size = New System.Drawing.Size(50, 17)
        Me.rbBand.TabIndex = 33
        Me.rbBand.Tag = ""
        Me.rbBand.Text = "Band"
        Me.rbBand.UseVisualStyleBackColor = True
        '
        'rbConductor
        '
        Me.rbConductor.AutoCheck = False
        Me.rbConductor.AutoSize = True
        Me.rbConductor.Location = New System.Drawing.Point(14, 124)
        Me.rbConductor.Name = "rbConductor"
        Me.rbConductor.Size = New System.Drawing.Size(74, 17)
        Me.rbConductor.TabIndex = 32
        Me.rbConductor.Tag = ""
        Me.rbConductor.Text = "Conductor"
        Me.rbConductor.UseVisualStyleBackColor = True
        '
        'rbCoverback
        '
        Me.rbCoverback.AutoCheck = False
        Me.rbCoverback.AutoSize = True
        Me.rbCoverback.Location = New System.Drawing.Point(14, 55)
        Me.rbCoverback.Name = "rbCoverback"
        Me.rbCoverback.Size = New System.Drawing.Size(86, 17)
        Me.rbCoverback.TabIndex = 31
        Me.rbCoverback.Tag = ""
        Me.rbCoverback.Text = "Cover (back)"
        Me.rbCoverback.UseVisualStyleBackColor = True
        '
        'rbLabel
        '
        Me.rbLabel.AutoCheck = False
        Me.rbLabel.AutoSize = True
        Me.rbLabel.Location = New System.Drawing.Point(14, 78)
        Me.rbLabel.Name = "rbLabel"
        Me.rbLabel.Size = New System.Drawing.Size(51, 17)
        Me.rbLabel.TabIndex = 30
        Me.rbLabel.Tag = ""
        Me.rbLabel.Text = "Label"
        Me.rbLabel.UseVisualStyleBackColor = True
        '
        'rbArtist
        '
        Me.rbArtist.AutoCheck = False
        Me.rbArtist.AutoSize = True
        Me.rbArtist.Location = New System.Drawing.Point(14, 101)
        Me.rbArtist.Name = "rbArtist"
        Me.rbArtist.Size = New System.Drawing.Size(48, 17)
        Me.rbArtist.TabIndex = 29
        Me.rbArtist.Tag = ""
        Me.rbArtist.Text = "Artist"
        Me.rbArtist.UseVisualStyleBackColor = True
        '
        'rbCoverfront
        '
        Me.rbCoverfront.AutoCheck = False
        Me.rbCoverfront.AutoSize = True
        Me.rbCoverfront.Location = New System.Drawing.Point(14, 32)
        Me.rbCoverfront.Name = "rbCoverfront"
        Me.rbCoverfront.Size = New System.Drawing.Size(83, 17)
        Me.rbCoverfront.TabIndex = 28
        Me.rbCoverfront.Tag = ""
        Me.rbCoverfront.Text = "Cover (front)"
        Me.rbCoverfront.UseVisualStyleBackColor = True
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.txtAlbum)
        Me.GroupBox1.Controls.Add(Me.txtTitle)
        Me.GroupBox1.Controls.Add(Me.txtArtist)
        Me.GroupBox1.Controls.Add(Me.lblAlbum)
        Me.GroupBox1.Controls.Add(Me.lblTitle)
        Me.GroupBox1.Controls.Add(Me.lblArtist)
        Me.GroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox1.Location = New System.Drawing.Point(16, 79)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(456, 100)
        Me.GroupBox1.TabIndex = 41
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Tags"
        '
        'lblSamplesPerSec
        '
        Me.lblSamplesPerSec.AutoSize = True
        Me.lblSamplesPerSec.Location = New System.Drawing.Point(570, 46)
        Me.lblSamplesPerSec.Name = "lblSamplesPerSec"
        Me.lblSamplesPerSec.Size = New System.Drawing.Size(85, 13)
        Me.lblSamplesPerSec.TabIndex = 9
        Me.lblSamplesPerSec.Text = "SamplesPerSec:"
        '
        'btnAttribute
        '
        Me.btnAttribute.Location = New System.Drawing.Point(859, 617)
        Me.btnAttribute.Name = "btnAttribute"
        Me.btnAttribute.Size = New System.Drawing.Size(75, 61)
        Me.btnAttribute.TabIndex = 46
        Me.btnAttribute.Text = "Attribute instead of Attributes"
        Me.btnAttribute.UseVisualStyleBackColor = True
        '
        'btnExport
        '
        Me.btnExport.Location = New System.Drawing.Point(859, 550)
        Me.btnExport.Name = "btnExport"
        Me.btnExport.Size = New System.Drawing.Size(75, 23)
        Me.btnExport.TabIndex = 45
        Me.btnExport.Text = "Export"
        Me.btnExport.UseVisualStyleBackColor = True
        '
        'lblChannels
        '
        Me.lblChannels.AutoSize = True
        Me.lblChannels.Location = New System.Drawing.Point(570, 19)
        Me.lblChannels.Name = "lblChannels"
        Me.lblChannels.Size = New System.Drawing.Size(54, 13)
        Me.lblChannels.TabIndex = 8
        Me.lblChannels.Text = "Channels:"
        '
        'grpCoverarts
        '
        Me.grpCoverarts.Controls.Add(Me.grpCoverTypes)
        Me.grpCoverarts.Controls.Add(Me.lvThumb)
        Me.grpCoverarts.Controls.Add(Me.txtBitRate)
        Me.grpCoverarts.Controls.Add(Me.txtSampleCount)
        Me.grpCoverarts.Controls.Add(Me.txtPlayTime)
        Me.grpCoverarts.Controls.Add(Me.txtBitsPerSample)
        Me.grpCoverarts.Controls.Add(Me.txtSamplesPerSec)
        Me.grpCoverarts.Controls.Add(Me.txtChannels)
        Me.grpCoverarts.Controls.Add(Me.lblBitRate)
        Me.grpCoverarts.Controls.Add(Me.lblSampleCount)
        Me.grpCoverarts.Controls.Add(Me.lblPlayTime)
        Me.grpCoverarts.Controls.Add(Me.lblBitsPerSample)
        Me.grpCoverarts.Controls.Add(Me.lblSamplesPerSec)
        Me.grpCoverarts.Controls.Add(Me.lblChannels)
        Me.grpCoverarts.Location = New System.Drawing.Point(16, 512)
        Me.grpCoverarts.Name = "grpCoverarts"
        Me.grpCoverarts.Size = New System.Drawing.Size(826, 177)
        Me.grpCoverarts.TabIndex = 43
        Me.grpCoverarts.TabStop = False
        Me.grpCoverarts.Text = "Cover arts:"
        '
        'btnDelete
        '
        Me.btnDelete.Location = New System.Drawing.Point(859, 521)
        Me.btnDelete.Name = "btnDelete"
        Me.btnDelete.Size = New System.Drawing.Size(75, 23)
        Me.btnDelete.TabIndex = 44
        Me.btnDelete.Text = "Delete"
        Me.btnDelete.UseVisualStyleBackColor = True
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(947, 705)
        Me.Controls.Add(Me.btnRemove)
        Me.Controls.Add(Me.btnSave)
        Me.Controls.Add(Me.btnOpen)
        Me.Controls.Add(Me.txtFilename)
        Me.Controls.Add(Me.lblFilename)
        Me.Controls.Add(Me.grpAllTags)
        Me.Controls.Add(Me.GroupBox1)
        Me.Controls.Add(Me.btnAttribute)
        Me.Controls.Add(Me.btnExport)
        Me.Controls.Add(Me.grpCoverarts)
        Me.Controls.Add(Me.btnDelete)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow
        Me.Name = "Form1"
        Me.Text = "Tags Library Tutorial for VB_NET"
        Me.grpAllTags.ResumeLayout(False)
        Me.grpAllTags.PerformLayout()
        Me.grpCoverTypes.ResumeLayout(False)
        Me.grpCoverTypes.PerformLayout()
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        Me.grpCoverarts.ResumeLayout(False)
        Me.grpCoverarts.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents lblVarious As System.Windows.Forms.Label
    Friend WithEvents txtAlbum As System.Windows.Forms.TextBox
    Friend WithEvents txtTitle As System.Windows.Forms.TextBox
    Friend WithEvents txtArtist As System.Windows.Forms.TextBox
    Friend WithEvents lblAlbum As System.Windows.Forms.Label
    Friend WithEvents txtBitRate As System.Windows.Forms.TextBox
    Friend WithEvents txtSampleCount As System.Windows.Forms.TextBox
    Friend WithEvents txtPlayTime As System.Windows.Forms.TextBox
    Friend WithEvents txtBitsPerSample As System.Windows.Forms.TextBox
    Friend WithEvents txtSamplesPerSec As System.Windows.Forms.TextBox
    Friend WithEvents txtChannels As System.Windows.Forms.TextBox
    Friend WithEvents lblBitRate As System.Windows.Forms.Label
    Friend WithEvents lblSampleCount As System.Windows.Forms.Label
    Friend WithEvents lblPlayTime As System.Windows.Forms.Label
    Friend WithEvents lblBitsPerSample As System.Windows.Forms.Label
    Friend WithEvents lblTitle As System.Windows.Forms.Label
    Friend WithEvents lblArtist As System.Windows.Forms.Label
    Friend WithEvents OpenFileDialog1 As System.Windows.Forms.OpenFileDialog
    Friend WithEvents lvThumb As System.Windows.Forms.ListView
    Friend WithEvents ColumnHeader5 As System.Windows.Forms.ColumnHeader
    Friend WithEvents ColumnHeader6 As System.Windows.Forms.ColumnHeader
    Private WithEvents ImageListThumbs As System.Windows.Forms.ImageList
    Friend WithEvents btnRemove As System.Windows.Forms.Button
    Friend WithEvents btnSave As System.Windows.Forms.Button
    Friend WithEvents btnOpen As System.Windows.Forms.Button
    Friend WithEvents txtFilename As System.Windows.Forms.TextBox
    Friend WithEvents lblFilename As System.Windows.Forms.Label
    Friend WithEvents grpAllTags As System.Windows.Forms.GroupBox
    Friend WithEvents ListView2 As System.Windows.Forms.ListView
    Friend WithEvents columnHeader3 As System.Windows.Forms.ColumnHeader
    Friend WithEvents columnHeader4 As System.Windows.Forms.ColumnHeader
    Friend WithEvents ListView1 As System.Windows.Forms.ListView
    Friend WithEvents ColumnHeader1 As System.Windows.Forms.ColumnHeader
    Friend WithEvents ColumnHeader2 As System.Windows.Forms.ColumnHeader
    Friend WithEvents lblAttrib As System.Windows.Forms.Label
    Private WithEvents grpCoverTypes As System.Windows.Forms.GroupBox
    Private WithEvents rbOther As System.Windows.Forms.RadioButton
    Private WithEvents rbBandLogo As System.Windows.Forms.RadioButton
    Private WithEvents rbComposer As System.Windows.Forms.RadioButton
    Private WithEvents rbPerformance As System.Windows.Forms.RadioButton
    Private WithEvents rbBand As System.Windows.Forms.RadioButton
    Private WithEvents rbConductor As System.Windows.Forms.RadioButton
    Private WithEvents rbCoverback As System.Windows.Forms.RadioButton
    Private WithEvents rbLabel As System.Windows.Forms.RadioButton
    Private WithEvents rbArtist As System.Windows.Forms.RadioButton
    Private WithEvents rbCoverfront As System.Windows.Forms.RadioButton
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Private WithEvents saveFileDialog1 As System.Windows.Forms.SaveFileDialog
    Friend WithEvents lblSamplesPerSec As System.Windows.Forms.Label
    Friend WithEvents btnAttribute As System.Windows.Forms.Button
    Friend WithEvents btnExport As System.Windows.Forms.Button
    Friend WithEvents lblChannels As System.Windows.Forms.Label
    Friend WithEvents grpCoverarts As System.Windows.Forms.GroupBox
    Friend WithEvents btnDelete As System.Windows.Forms.Button
End Class
