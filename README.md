[![Build Status](https://travis-ci.org/FCO/Heap.svg?branch=master)](https://travis-ci.org/FCO/Heap)



Impleementation of Heap data structure

### has Callable &.cmp

The comparator function

### has Positional[Any] @.data

The array with the heap data

### method new

```raku
method new(
    +@arr is copy
) returns Mu
```

Receives a array and transforms that array in a Heap (O(n))

### method push

```raku
method push(
    $new
) returns Mu
```

Add a ney value on the Heap

### method pop

```raku
method pop() returns Mu
```

Removes and returns the first element of the heap

### method peek

```raku
method peek() returns Mu
```

Returns the first element of the heap

### method all

```raku
method all() returns Mu
```

Pops the Heap until its empty

Heap
====

A simple perl6 module implementing the heap data structure.

```raku
my Heap $heap .= new: 9, 7, 5, 3, 1;
$heap.push: 8;
say $heap.pop;		# 1
say $heap.pop;		# 3
say $heap.pop;		# 5

say $heap.all		# (7, 8, 9)
```

```raku
my Heap[-*] $heap .= new: <9 7 5 3 1>;
$heap.push: 8;
say $heap.pop;		# 9
say $heap.pop;		# 8
say $heap.pop;		# 7
```

```raku
my Heap[{$^b <=> $^a}] $heap .= new: <9 7 5 3 1>;
$heap.push: 8;
say $heap.pop;		# 9
say $heap.pop;		# 8
say $heap.pop;		# 7
```

```raku
my Heap[*<order>] $heap .= new:
	{:something<ble>, :order<2>},
	{:something<bla>, :order<1>},
	{:something<bli>, :order<3>},
	{:something<blu>, :order<5>},
;
$heap.push: {:something<blo>, :order<4>},
say $heap.pop;		# {:something<bla>, :order<1>}
say $heap.pop;		# {:something<ble>, :order<2>}
say $heap.pop;		# {:something<bli>, :order<3>}
```

