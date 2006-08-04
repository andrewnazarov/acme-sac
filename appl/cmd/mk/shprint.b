#
#	initially generated by c2l
#


shprint(s: array of byte, env: array of Envy, buf: ref Bufblock)
{
	n: int;
	r: int;

	while(int s[0]){
		(r, n, nil) = sys->byte2char(s, 0);
		if(r == '$')
			s = vexpand(s, env, buf);
		else{
			rinsert(buf, r);
			s = s[n: ];
			s = copyq(s, r, buf);	# handle quoted strings
		}
	}
	insert(buf, 0);
}

mygetenv(name: array of byte, env: array of Envy): array of byte
{
	if(env == nil)
		return nil;
	if(symlooki(name, S_WESET, 0) == nil && symlooki(name, S_INTERNAL, 0) == nil)
		return nil;
	#  only resolve internal variables and variables we've set 
	for(e := 0; env[e].name != nil; e++){
		if(libc0->strcmp(env[e].name, name) == 0)
			return wtos(env[e].values, ' ');
	}
	return nil;
}

vexpand(w: array of byte, env: array of Envy, buf: ref Bufblock): array of byte
{
	s: array of byte;
	carry: byte;
	p, q: array of byte;

	assert(libc0->s2ab("vexpand no $"), w[0] == byte '$');
	p = w[1: ];	#  skip dollar sign 
	if(p[0] == byte '{'){
		p = p[1: ];
		q = libc0->strchr(p, '}');
		if(q == nil)
			q = libc0->strchr(p, 0);
	}
	else
		q = shname(p);
	carry = q[0];
	q[0] = byte 0;
	s = mygetenv(p, env);
	q[0] = carry;
	if(carry == byte '}')
		q = q[1: ];
	if(s != nil){
		bufcpy(buf, s, libc0->strlen(s));
		s = nil;
	}
	else
		#  copy name intact
		bufcpy(buf, w, libc0->strlen(w)-libc0->strlen(q));	# q-w
	return q;
}

front(s: array of byte)
{
	t, q: array of byte;
	i, j: int;
	# flds := array[512] of array of byte;
	fields: list of string;

	q = libc0->strdup(s);
	(i, fields) = sys->tokenize(libc0->ab2s(q), " \t\n");
	flds := array[len fields] of array of byte;
	for(j = 0; j < len flds; j++){
		flds[j] = libc0->s2ab(hd fields);
		fields = tl fields;
	}
	if(i > 5){
		flds[4] = flds[i-1];
		flds[3] = libc0->s2ab("...");
		i = 5;
	}
	t = s;
	for(j = 0; j < i; j++){
		for(s = flds[j]; int s[0]; ){
			t[0] = s[0];
			s = s[1: ];
			t = t[1: ];
		}
		t[0] = byte ' ';
		t = t[1: ];
	}
	t[0] = byte 0;
	q = nil;
}

