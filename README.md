ColdFunctional
==============

ColdFunctional is a core language extension for Railo, inspired by Underscore, Ruby, 
Scala, and Clojure. It adds more *functional* programming language support to the 
ColdFusion language, by providing more built-in higher-order functions. Just 
install the extension and restart Railo and you can start using this new 
functionality.

Check out the [documentation](http://www.litnak.com/coldfunctional).

RoadMap
--------------
* functionOnce(fn) returns a function that will only execute once (kind of like caching)
* groupBy
* pluck
* invoke()
* functionCompose(fns...) returns a function that is the composition of all the functions provided, if fn1 and fn2 are provided, this will return a function that will execute fn1(fn2())
* functionMemoize(fn,
* functionPartial(fn,args...) creates a function that will execute the function with the provided args defaulted plus whatever arguments that are provided 
* map(fn, collection) (allows reversal of arguments)
* map(fn, collections...) calls  fn(col1[1],col1[2]) and creates one collection
* constantly(x) returns an fn that returns x no matter what is passed in as arguments


