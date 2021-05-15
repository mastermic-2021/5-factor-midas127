encode(m)=fromdigits(Vec(Vecsmall(m)),128);
[n,c] = readvec("input.txt");

\\print(n);

\\g(x) = {
\\	p = x*x +1;
\\	pmod = p%n;
\\	return(pmod);
\\}
\\
\\pollard_rho_try(a) = {
\\	x = a;
\\	y = a;
\\	d = 1;
\\	while( (d == 1), x = g(x); y=g(g(y)); b = sign(x-y)*(x-y); d = gcd(b, n););
\\	return(d);
\\}

v(x, B) = { \\log en base x de B, inutile
	a = 1;
	while( (a*x < B), a = a*x;);
	return(a);
}

M(B) = {\\exposant dans pollard p-1, inutile
	a = 1;
	forprime(x = 2, B, a = a*v(x, B));
	return(a);
}

modexp(a, e, mod) = { \\exponentielle modulaire
	b = Mod(a, mod);
	k = b^e;
	r = lift(k);
	return(r);
}

pollard_factor(x, B) = { \\pollard p-1
	k = 2;
	for(x=2, B, k = modexp(k, x, n););
	g = gcd(k-1, n);
	return(g);
}

p = pollard_factor(n, 3400); \\apres quelques tests visiblement le facteur premier le plus grand est juste au dessous de 3400
ep = (p+1)/4;
q = n/p;
eq = (q+1)/4;

mp = modexp(c[1], ep, p);
mq = modexp(c[1], eq, q);

u = bezout(p, q)[1];
v = bezout(p, q)[2];

m_big = u*mq*p - v*q*mp;

m = -m_big%n;

decode(a)=Strchr(digits(a, 128));

message = decode(m);

print(message);
