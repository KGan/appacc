object Test {
  def fib(start: Int = 0) = {
    var a:BigInt = 0
    var b:BigInt = 1
    def qfunc() = () ⇒ {
      val t = a
      a = b
      b = t + a
      b
    }
    for( a ← 1 to start ) {
      qfunc()
    }
    qfunc
  }

  def main(args: Array[String]) {
    var fibIter = fib()
    for( i ← 1 to 100 ) {
      println(fibIter())
    }
  }

}
