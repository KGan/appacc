// directed graph cycles
function detect_cycles(rootNode) {
  if (rootNode.color === 'red') return true;
  rootNode.color = 'red';
  for(var i = 0; i < rootNode.chidren.length; i++) {
    var child = rootNode.children[i];
    if (detect_cycle(child)) return true;
  }
  rootNode.color = 'grey';
  return false;
}

function astar(source, target) {
  var priority_queue = new PriorityQueue(source, 0);
  var visited = {};
  var found = false;
  while (!priority_queue.isEmpty() && !found) {
    var curr = priority_queue.pop();
    for (var i = 0; i < curr.children.length; i++ ) {
      var child = curr.children[i];
      visited[child] = curr;
      priority_queue.push(child, current_cost(source, child)+heuristic_cost(child, target));
      if ( child === target ) found = true;
    }
  } 

}

function heuristic_cost(node, target) {

}

function current_cost(source, node) {
  
}

function dist(n1, n2) {
  return Math.sqrt(Math.pow(n2[0] - n1[0], 2) + Math.pow(n2[1] - n1[1], 2));
}

function common_subsets(arr1, arr2) {
  var intersected_elems = intersection(arr1, arr2);
  return subsets(intersected_elems);
}

function intersection(arr1, arr2) {
  var seen_hash = {};
  var intersects = [];
  arr1.forEach(function(el) {
    if(seen_hash[el] === undefined) {
      seen_hash[el] = 0;
    } else {
      seen_hash[el]++;
    }
  });
  arr2.forEach(function(el) {
    if (seen_hash[el]) {
      intersects.concat(el);
      seen_hash[el]--;
    }
  });
  return instersects;
}

function subsets(arr) {
  if (arr.length < 1) return [[]];
  var prev = subsets(arr.slice(1));
  var new_el = arr.slice(0);
  var with_new = prev.map(function(subset) {
    return subset.concat(new_el);
  });
  return prev.concat(with_new);
}

function Node(val, parent, right, left) {
  this.value = val;
  this.parent = parent;
  this.right = right;
  this.left = left;
}

function build_cartesian_tree(array) {
  var tree, el, left_subtree;
  var stack = [];
  for(var i = 0; i < array.length; i++) {
    
    for( var j = stack.length - 1; j >= 0; j-- ) {
      if(arr[stack[j]] < arr[i]) {
        arr.push(i);
        el = new Node(arr[i], null);
        el.left = left_subtree;
        left_subtree = null;
        break;
      } else {
        left_subtree = build_up_subtree(stack.pop(), left_subtree);
      }
    }
  }
  while(stack.length > 0) {
    left_subtree = build_up_subtree(stack.pop(), left_subtree);
  }

  return el;
}

function build_up_subtree(elem, tree) {
  var par = new Node(elem, null, tree);
  tree.parent = par;
}



// AVL trees












