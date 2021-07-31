const NUMS = [1, 2, 3, 4, 5];

Array.prototype.myEach = function(callback)
{
    for (let i = 0; i < this.length; i++)
    { callback(this[i]); }
}

NUMS.myEach(
    (num) => {console.log(`square of ${num} is ${num * num}`)}
    );

Array.prototype.myMap = function(callback)
{
    ret = []
    this.myEach(e => ret.push(callback(e)));
    return ret;
}

console.log(NUMS.myMap( num => num * num ));

Array.prototype.myReduce = function(callback, base)
{
    arr = this;
    if (base === undefined){
        base = ret[0];
        arr = arr.slice(1);
    }

    let result = base;
    arr.myEach(e => result = callback(result, e));
    return result;
}

// without initialValue
console.log([1, 2, 3].myReduce(function(acc, el) {
  return acc + el;
})); // => 6

// with initialValue
console.log([1, 2, 3].myReduce(function(acc, el) {
  return acc + el;
}, 25)); // => 31
