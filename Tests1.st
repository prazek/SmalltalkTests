Smalltalk at: #L put: (C % nil).
t := L % 1, (V @ 2 % 3).
self assert: [t car car value isNil].
self assert: [t car cdr value = 1].
self assert: [t car value car isNil].
self assert: [t car value cdr = 1].
self assert: [t cdr cdr value = 3].

a := V @ 1.
b := V @ 2.
c := V @ 1.
self assert: [a ~= b].
self assert: [a == c].

t := C % 1 @ #z.
self assert: [t car value = 1].
w := 0.
[t value] on: Error do: [:ex | w := w + 1].
self assert: [w = 1].

C % 1 go: C % 2 do: [self assert: [false]].

w := 0.
C % 1 go: C % 1 do: [w := w + 1].
self assert: [w = 1].


x := V @ #x.
y := V @ #y.
x setValue: nil.
y setValue: nil.
w := 0.
x % 1 go: C % 2, y do:
    [w := w + 1.
    self assert: [x value = 2].
    self assert: [y value = 1]].
self assert: [w = 1].
w := 0.
[x value] on: Error do: [:ex | w := w + 1].
[y value] on: Error do: [:ex | w := w + 1].
self assert: [w = 2].

x setValue: nil.
w := 0.
C % 1 % 2 go: x do:
    [w := w + 1.
    self assert: [x value car = 1].
    self assert: [x cdr value = 2]].
self assert: [w = 1].

w := 0.
x go: C % $a do:
    [w := w + 1.
    x go: C % $b do: [self assert: [false]]].
x go: C % $b do: [w := w + 1].
self assert: [w = 2].


w := 0.
x % 1 go: y, y do:
    [w := w + 1.
    self assert: [x value = 1].
    self assert: [y value = 1]].
self assert: [w = 1].

w := 0.
z := V @ #z.
x % 1, x go: y, y, z do:
    [w := w + 1.
    self assert: [x value = 1].
    self assert: [y value = 1].
    self assert: [z value = 1]].
self assert: [w = 1].

x setValue: nil.
x go: L, x do: [self assert: [false]].


"external"
w := 0.
x, y % 1 go: z, x, y do: [
	w := w + 1.
	 self assert: [x value = 1].
	self assert: [y value = 1].
	self assert: [z value = 1]
].
self assert: [w = 1].

x := V @ #x.
y := V @ #y.
w := 0.
x go: y do: [
	x, y go: C % 1 % 1 do: [
	w := 1.
	self assert: [x value = 1].
	self assert: [y value = 1]
]
]

w := 0.
x := V @ #x.
y := V @ #y.
z := V @ #z.
d := V @ #d.
w := 0.
e := 0.
o := 0.
(x, y), (z, y) go: d do: [
	d go: (y, z), (x % 1) do: [
		w := 1.
		self assert: [x value = 1].
		self assert: [y value = 1].
		self assert: [z value = 1].
		self assert: [d value cdr cdr = 1].
		self assert: [d value cdr car = 1].
		self assert: [d value car cdr = 1].
		self assert: [d value car car = 1].

		self assert: [d cdr value cdr = 1].
		self assert: [d cdr value car = 1].
		self assert: [d car value cdr = 1].
		self assert: [d car value car = 1].
		
		self assert: [d cdr cdr value  = 1].
		self assert: [d cdr car value = 1].
		self assert: [d car cdr value = 1].
		self assert: [d car car value = 1].
		
		[x car] on: Error do: [:ex | e := e + 1].
		[x cdr] on: Error do: [:ex | e := e + 1].
	].
	[x value] on: Error do: [:ex | o := o + 1].
	[y value] on: Error do: [:ex | o := o + 1].
	[z value] on: Error do: [:ex | o := o + 1].
	[d value] on: Error do: [:ex | o := o + 1].
].
self assert: [w = 1].
self assert: [e = 2].
self assert: [o = 4].


x := V @ #x.
y := V @ #y.
w := 0.
x go: y do: [
y go: x do: [
x, y go: C % 1 % 2 do: [
w := w + 1.
].
].
].
self assert: [w = 0].


x := C % nil.
self assert: [x value = nil].
self assert: [L value = nil].

x := V @ nil.
y := V @ nil.
self assert: [x == y].
 

