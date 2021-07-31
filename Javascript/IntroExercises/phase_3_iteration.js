Array.prototype.bubbleSort = function() {
    ret = this;
    let sorted = false;
    while (!sorted){
        sorted = true;

        for (let i = 0; i < ret.length - 1; i++){
            if (ret[i] > ret[i + 1]){
                let tmp = ret[i];
                ret[i] = ret[i + 1];
                ret[i + 1] = tmp;
                sorted = false;
                break;
            }
        }
    }
    return ret;
}
console.log([1,4,5,3,6,2].bubbleSort());

String.prototype.substrings = function () {
    let substrings = [];
  
    for (let start = 0; start < this.length; start++) {
      for (let end = start + 1; end <= this.length; end++) {
        substrings.push(this.slice(start, end));
      }
    }
  
    return substrings;
  };
  
  console.log("abc".substrings());