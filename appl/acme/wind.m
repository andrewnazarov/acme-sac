Windowm : module {
	PATH : con "/dis/acme/wind.dis";

	init : fn(mods : ref Dat->Mods);

	Window : adt {
		qlock : ref Dat->Lock;
		refx : ref Dat->Ref;
		tag : 	cyclic ref Textm->Text;
		body : cyclic ref Textm->Text;
		r : Draw->Rect;
		isdir : int;
		isscratch : int;
		filemenu : int;
		dirty : int;
		id : int;
		addr : Dat->Range;
		limit : Dat->Range;
		nopen : array of byte;
		nomark : int;
		noscroll : int;
		echomode : int;
		wrselrange : Dat->Range;
		rdselfd : ref Sys->FD;
		col : cyclic ref Columnm->Column;
		eventx : cyclic ref Xfidm->Xfid;
		events : string;
		nevents : int;
		owner : int;
		maxlines :	int;
		dlp : array of ref Dat->Dirlist;
		ndl : int;
		putseq : int;
		nincl : int;
		incl : array of string;
		reffont : ref Dat->Reffont;
		ctllock : ref Dat->Lock;
		ctlfid : int;
		dumpstr : string;
		dumpdir : string;
		dumpid : int;
		utflastqid : int;
		utflastboff : int;
		utflastq : int;

		init : fn(w : self ref Window, w0 : ref Window, r : Draw->Rect);
		lock : fn(w : self ref Window, n : int);
		lock1 : fn(w : self ref Window, n : int);
		unlock : fn(w : self ref Window);
		typex : fn(w : self ref Window, t : ref Textm->Text, r : int);
		undo : fn(w : self ref Window, n : int);
		setname : fn(w : self ref Window, r : string, n : int);
		settag : fn(w : self ref Window);
		settag1 : fn(w : self ref Window);
		commit : fn(w : self ref Window, t : ref Textm->Text);
		reshape : fn(w : self ref Window, r : Draw->Rect, n : int) : int;
		close : fn(w : self ref Window);
		delete : fn(w : self ref Window);
		clean : fn(w : self ref Window, n : int, exiting : int) : int;
		dirfree : fn(w : self ref Window);
		event : fn(w : self ref Window, b : string);
		mousebut : fn(w : self ref Window);
		addincl : fn(w : self ref Window, r : string, n : int);
		cleartag : fn(w : self ref Window);
		ctlprint : fn(w : self ref Window) : string;
	};
};
