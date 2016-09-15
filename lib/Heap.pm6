role Heap[$heap_cmp = * cmp *] {
	has &.cmp = do given $heap_cmp {
		when Callable	{$_					}
		when Whatever	{ -> $val {$val}	}
		default			{ -> | {$heap_cmp}	}
	};
	has Any @!data;

	method !cmp($a, $b) {
		do if &!cmp.signature.params.elems == 1 {
			&!cmp($a) <=> &!cmp($b)
		} else {
			&!cmp($a, $b)
		}
	}

	method new(+@arr) {
		my $obj = self.bless;
		$obj!build(@arr);
		$obj
	}

	method !build(@!data) {
		for self!get-parent(+@!data) ... 0 -> Int \i {
			self!down(i);
		}
	}

	method !get-parent(Int \node)    {  (node - 1) div 2 }
	method !get-left(Int \node)      {  (node * 2) + 1 }
	method !get-right(Int \node)     {  (node * 2) + 2 }

	method !swap(Int \i, Int \j) {
		@!data[i, j] = @!data[j, i]
	}

	method !up(Int \i where 0 < * < @!data) {
		my \parent = self!get-parent:	i;
		if self!cmp(@!data[i], @!data[parent]) < 0 {
			self!swap:	i, parent;
			self!up:	parent if parent
		}
	}

	method !down(Int \i where -1 < * < @!data) {
		my \left	= self!get-left:	i;
		my \right	= self!get-right:	i;

		return if left >= @!data;

		if right >= @!data or self!cmp(@!data[left], @!data[right]) < 0 {
			if self!cmp(@!data[left], @!data[i]) < 0 {
				self!swap: i, left;
				self!down: left;
			}
		} elsif right >= @!data {
			return
		} elsif self!cmp(@!data[right], @!data[i]) < 0 {
			self!swap: i, right;
			self!down: right
		}
	}

	method gist {
		::?CLASS.^name ~ ".new: {@!data.gist}";
	}

	method Array {
		@!data
	}

	method Bag {
		@!data.Bag
	}

	method Set {
		@!data.Set
	}

	method Bool {
		?@!data
	}

	method add($new) {
		@!data.push: $new;
		self!up: @!data.elems - 1
	}

	method pop {
		return Any unless @!data;
		my \ret = @!data.shift;
		if self {
			@!data.unshift: @!data.pop;
			self!down: 0;
		}
		ret
	}

	method all {
		gather take $.pop while self
	}
}
multi infix:<eqv>(Heap $l, Heap $r) is export {$l.Array.sort($l.cmp) == $r.Array.sort($r.cmp) }

