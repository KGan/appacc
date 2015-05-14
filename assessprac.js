'use strict';


Function.prototype.myBind = function(context) {
  var fn = this
  var args = Array.prototype.slice.call(arguments, 1)
  return function() {
    var calltime_args = Array.prototype.slice.call(arguments)
    fn.apply(context, Array.prototype.concat.call(args, calltime_args))
  }
};

(function () {
  if (window.THING === 'undefined') {
    window.THING = {};
  }


})();


function myinherits(child, parent) {
  function Surrogate(){};
  Surrogate.prototype = parent.prototype;
  child.prototype = new Surrogate();
}

Function.prototype.mycurry = function(numArgs) {
  var fn = this;
  var _args = Array.prototype.slice.call(arguments,1)
  if (_args.length >= numArgs) {
    return fn.apply(null, _args);
  }

  return function _curry(arg) {
    _args.push(arg)
    if(_args.length >= numArgs) {
      return fn.apply(null, _args);
    } else {
      return _curry;
    }


  }
}

function sum() {
  var sum = 0;
  for(var i = 0; i < arguments.length; i++) {
    sum += arguments[i];
  }
  return sum;
}

// console.log(sum.mycurry(4)(1)(3)(2)(10))

function bsearch(arr, target) {
  var idx = (arr.length / 2 | 0);
  var saved_idx = Array.prototype.slice.call(arguments,2)[0] || 0
  if(arr.length < 2) {
    return arr[0] == target ? saved_idx : -1
  }

  if(arr[idx] == target) {
    return saved_idx + idx;
  }

  if(arr[idx] < target) {
    return bsearch(arr.slice(0,idx), target);
  }
  return bsearch(arr.slice(idx+1), target, saved_idx + idx + 1)
}

//console.log(bsearch([1,3,5,12,18,22,345], 12))

function subsets(arr) {
  if (arr.length < 1) {
    return [[], arr];
  }

  var el = arr.pop();
  var prev = subsets(arr);
  var retarr = [];

}