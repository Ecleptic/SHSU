
// This file has been generated by the GUI designer. Do not modify.

public partial class MainWindow
{
	private global::Gtk.Fixed fixed1;

	private global::Gtk.Entry entry1;

	private global::Gtk.Label Name;

	private global::Gtk.Label Doctor;

	private global::Gtk.ComboBox combobox1;

	protected virtual void Build()
	{
		global::Stetic.Gui.Initialize(this);
		// Widget MainWindow
		this.Name = "MainWindow";
		this.Title = global::Mono.Unix.Catalog.GetString("MainWindow");
		this.WindowPosition = ((global::Gtk.WindowPosition)(4));
		// Container child MainWindow.Gtk.Container+ContainerChild
		this.fixed1 = new global::Gtk.Fixed();
		this.fixed1.Name = "fixed1";
		this.fixed1.HasWindow = false;
		// Container child fixed1.Gtk.Fixed+FixedChild
		this.entry1 = new global::Gtk.Entry();
		this.entry1.CanFocus = true;
		this.entry1.Name = "entry1";
		this.entry1.IsEditable = true;
		this.entry1.InvisibleChar = '●';
		this.fixed1.Add(this.entry1);
		global::Gtk.Fixed.FixedChild w1 = ((global::Gtk.Fixed.FixedChild)(this.fixed1[this.entry1]));
		w1.X = 104;
		w1.Y = 38;
		// Container child fixed1.Gtk.Fixed+FixedChild
		this.Name = new global::Gtk.Label();
		this.Name.Name = "Name";
		this.Name.LabelProp = global::Mono.Unix.Catalog.GetString("Full Name");
		this.fixed1.Add(this.Name);
		global::Gtk.Fixed.FixedChild w2 = ((global::Gtk.Fixed.FixedChild)(this.fixed1[this.Name]));
		w2.X = 32;
		w2.Y = 41;
		// Container child fixed1.Gtk.Fixed+FixedChild
		this.Doctor = new global::Gtk.Label();
		this.Doctor.Name = "Doctor";
		this.Doctor.LabelProp = global::Mono.Unix.Catalog.GetString("Doctor Name");
		this.fixed1.Add(this.Doctor);
		global::Gtk.Fixed.FixedChild w3 = ((global::Gtk.Fixed.FixedChild)(this.fixed1[this.Doctor]));
		w3.X = 39;
		w3.Y = 84;
		// Container child fixed1.Gtk.Fixed+FixedChild
		this.combobox1 = global::Gtk.ComboBox.NewText();
		this.combobox1.AppendText(global::Mono.Unix.Catalog.GetString("Doctor 1"));
		this.combobox1.AppendText(global::Mono.Unix.Catalog.GetString("Doctor 2"));
		this.combobox1.Name = "combobox1";
		this.combobox1.Active = 0;
		this.fixed1.Add(this.combobox1);
		global::Gtk.Fixed.FixedChild w4 = ((global::Gtk.Fixed.FixedChild)(this.fixed1[this.combobox1]));
		w4.X = 119;
		w4.Y = 82;
		this.Add(this.fixed1);
		if ((this.Child != null))
		{
			this.Child.ShowAll();
		}
		this.DefaultWidth = 724;
		this.DefaultHeight = 553;
		this.Show();
		this.DeleteEvent += new global::Gtk.DeleteEventHandler(this.OnDeleteEvent);
	}
}
