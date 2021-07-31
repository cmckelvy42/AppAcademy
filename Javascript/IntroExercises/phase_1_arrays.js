Array.prototype.uniq = function() {
    let ret = [];
    this.forEach(el => {if (!ret.includes(el)) ret.push(el)});
    return ret;
}
console.log([1,1,2,2,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,0,0].uniq())

Array.prototype.twoSum = function() {   
    let pairs = [];
    let indexHash = {};
    this.forEach((el, i) => {
        if (indexHash[-el]) {
            newPairs = indexHash[-el].map(j => [j, i]);
            pairs = pairs.concat(newPairs);
        }
        indexHash[el] ? indexHash[el].push(i) : indexHash[el] = [i];
    });
    return pairs;
}

console.log([-1, 0, 2, -2, 1].twoSum());

Array.prototype.transpose = function() {
    ret = Array.from({length: this[0].length}, () => Array.from({length: this.length}));

    for (let i = 0; i < ret.length; i++) {
        for (let j = 0; j < ret[i].length; j++) {
            ret[i][j] = this[j][i];
        }
    }
    return ret;
}
console.log([[0, 1, 2], [3, 4, 5], [6, 7, 8]].transpose());