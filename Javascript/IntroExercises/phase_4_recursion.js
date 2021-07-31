function range(start, end){
    if (start === end) return [];
    if (start > end) return range(end, start);
    let ret = range(start, end - 1);
    ret.push(end - 1);
    return ret;
}
console.log(`range(3, 10) = ${range(3, 10)}`);

function sumRec(arr){
    if (arr.length === 0) return 0;

    return sumRec(arr.slice(1)) + arr[0];
}

console.log(`sumRec([1,2,3,4,5]) = ${sumRec([1,2,3,4,5])}`);

function exponent1(base, exp){
    if (exp === 0) return 1;
    return base * exponent1(base, exp - 1);
}

function exponent2(base, exp){
    if (exp === 0) return 1;
    if (exp === 1) return base;
    if (exp% 2)
    {
        return base * (exponent2(base, (exp - 1) / 2) ** 2);
    }
    else
    {
        return exponent2(base, exp / 2) ** 2;
    }
}
console.log(`exponent1(2, 4) =  ${exponent1(2, 4)}`);
console.log(`exponent1(2, 5) =  ${exponent1(2, 5)}`);
console.log(`exponent2(2, 4) =  ${exponent2(2, 4)}`);
console.log(`exponent2(2, 5) =  ${exponent2(2, 5)}`);

function fibonacci(n){
    if (n < 3) return [0,1].slice(0,n);
    let fibs = fibonacci(n - 1);
    fibs.push(fibs[fibs.length - 1] + fibs[fibs.length - 2]);
    return fibs;
}

console.log(`fibonacci(10) = ${fibonacci(10)}`);


function deepDup(arr){
    if (!(arr instanceof Array)) return arr;
    return arr.map(e => deepDup(e));
}

const array = [[2],3];
const dupedArray = deepDup(array);
console.log(`deepDup original = ${JSON.stringify(array)}`);

dupedArray[0].push(4);

console.log(`deepDup original = ${JSON.stringify(array)} (should not be mutated)`);
console.log(`deepDup duped = ${JSON.stringify(dupedArray)} (should be mutated)`);

function bsearch(arr, target){
    if (arr.length === 0) return -1;

    let i = Math.floor(arr.length / 2);
    if (arr[i] === target) return i;
    if (arr[i] > target) return bsearch(arr.slice(0,i));
    let test = arr.slice(i + 1);
    let partial = bsearch(arr.slice(i + 1), target);
    return partial === -1 ? -1 : partial + i + 1; 
}

console.log(`bsearch([1, 2, 3], 3) = ${bsearch([1, 2, 3], 3)}`);
console.log(`bsearch([1, 2, 3], 2.5) = ${bsearch([1, 2, 3], 2.5)}`);

function merge(left, right){
    let ret = [];
    while (left.length && right.length){
        let nextItem = (left[0] < right[0]) ? left.shift() : right.shift();
        ret.push(nextItem);
    }
    return ret.concat(left, right);
}

function mergeSort(arr){
    if (arr.length < 2) return arr;
    let middle = Math.floor(arr.length/ 2);
    let left = mergeSort(arr.slice(0, middle));
    let right = mergeSort(arr.slice(middle));
    return merge(left, right);
}
console.log(`mergeSort([4, 5, 2, 3, 1]) = ${mergeSort([4, 5, 2, 3, 1])}`);

function subsets(arr){
    if (arr.length === 0) return [[]];
    let first = [arr[0]];
    let everythingElse = subsets(arr.slice(1));
    return everythingElse.concat(everythingElse.map(e =>first.concat(e)));
}

console.log(`subsets([1, 3, 5]) = ${JSON.stringify(subsets([1, 3, 5]))}`);
