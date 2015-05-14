
function bP(symbols, evls) {

  if (evls.length < symbols.length - 1) return;

  var mat = [];
  for(var i = 0; i < symbols.length - 1; i++ ) {
    mat[i] = new Array(symbols.length); 
    var b = symbols[i];
    var b1 = symbols[i + 1];
    switch(evls[i]) {
      case '^':
        mat[i][i+1] = (b !== b1) ? [1, 0] : [0, 1];
        break;
      case '|':
        mat[i][i+1] = (b || b1) ? [1, 0] : [0, 1];
        break;
      case '&':
        mat[i][i+1] = (b && b1) ? [1, 0] : [0, 1];
        break;
      default:
        return;
    }
    //done initializing our 2d matrix 1 above the diagonal.
  }

  for (var k = 2; k < mat.length; k++) {
    for (var j = k - 2; j >= 0; j--) {
      var sum_left = matsum(mat[j][k-1], symbols[j], evls[j-1]);
      var sum_right = matsum(mat[j+1][k], symbols[k], evls[k]);
      mat[j][k] = [sum_left + sum_right, Math.pow(2, k - j - 1) - sum_left - sum_right];
    }
  }


}

function matsum(cumul, newsym, evaluator) {
  try {
    switch(evaluator) {
      case '^':
        return newsym ? cumul[1] : cumul[0];
      case '|':
        return newsym ? cumul[0] + cumul[1] : cumul[0];
      case '&':
        return newsym ? cumul[0] : cumul[1];
      default:
        throw {name : "Unrecognized Evaluator", message : evaluator + ' is not a recognized eval symbol'}; 
    }
  } catch (ex1) {
    console.log(ex1);
  }
}
