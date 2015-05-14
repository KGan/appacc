'use strict'

function printmatrix(m) {
  m.forEach(function(row, idx) {
    var rowstr = "";
    row.forEach(function(el, jdx) {
      var cand = el;
      if(typeof el === 'boolean'){
        cand = el ? 'T' : 'F';
      }
      rowstr += cand + '  ';
    })
    console.log(rowstr)
  })
}

function editdistance(first, second) {
  var mat = new Array(first.length + 1);
  for(var i = 0; i < mat.length; i++) {
    mat[i] = new Array(second.length + 1);
  }
  for(i = 0; i < mat.length; i++) {
    mat[i][0] = i;
  }
  for(i = 0; i < mat[0].length; i++) {
    mat[0][i] = i;
  }

  for(var j = 1; j < mat.length; j++) {
    for(var k = 1; k < mat[0].length; k++) {
      if(first[j-1] == second[k-1]) {
        mat[j][k] = mat[j-1][k-1]
      } else {
        mat[j][k] = Math.min.apply(null, [mat[j-1][k-1], mat[j-1][k], mat[j][k-1]]) + 1
      }
    }
  }



  printmatrix(mat)
  return mat[first.length][second.length];
}

// console.log(editdistance('chips', 'chocolate'))

function chocodistance(target, first, second) {
  var mat = new Array(first.length + 1);
  for(var i = 0; i < mat.length; i++) {
    mat[i] = new Array(second.length + 1);
  }

  target = " " + target

  mat[0][0] = true;

  for(i = 0; i < mat.length; i++) {
    for(var j = 0; j < mat[0].length; j++) {
      if (i == 0 && j == 0) {
        continue;
      }
      if(target[i+j] === first[i - 1] || target[i+j] === second[j - 1]) {
        mat[i][j] = (!!(mat[i-1] && mat[i-1][j] ) || !!mat[i][j-1]);
      } else {
        mat[i][j] = false;
      }
    }
  }

  printmatrix(mat);

  return mat[first.length][second.length];
}

// Dijkstra's algorithm

function PriorityQueue(comp) {
  this.comp = comp || function(a,b) { return a < b; };
  this.pq = [];
  this._hash = {};
}

PriorityQueue.prototype = {
  add: function(el){

  },
  update: function(el, val) {

  },
  has: function(el) {

  },
  upheap: function() {
  },
  downheap: function() {
  }
};

function PQElem(key, val) {
  this.key = key;
  this.val = val;
}

function dijkstra(source) {
  var cur,children,locked = {};
  var pq = new PriorityQueue();
  pq.add(source);
  while (cur = pq.pop()) {
    children = cur.outEdges();
    children.forEach(function(e) {
      var v = e.to();
      if (locked[v]) return;
      if (pq.has(v)) {
        pq.update(v, e.cost);
      } else {
        pq.add(v, e.cost);
      }
      locked[cur] = true;
    });
  }
}




// console.log(chocodistance('chocolatechips', 'chocolate', 'chips'));
console.log(chocodistance('cchohicopslate', 'chocolate', 'chips'));


//NOT SO DBP//

