struct St1 {
	val     int = 5
	another chan f64
}

fn fn1(c chan St1) string {
	println('1')
	println(c)
	x := <-c
	println(x)
	return x.str()
}

fn test_printing_of_channels() {
	ch := chan St1{cap: 10}
	fch := chan f64{cap: 100}
	ch <- St1{
		val: 1000
		another: fch
	}
	res := (go fn1(ch)).wait()
	println(res)
	println(ch)
	assert res.str().contains('another: ')
	assert ch.str() == 'chan St1{cap: 10, closed: 0}'
	assert fch.str() == 'chan f64{cap: 100, closed: 0}'
	fch.close()
	assert fch.str() == 'chan f64{cap: 100, closed: 1}'
}
