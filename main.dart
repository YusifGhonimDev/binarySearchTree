void main() {
  BinarySearchTree tree = BinarySearchTree();
  tree.insert(5);
  tree.insert(3);
  tree.insert(2);
  tree.insert(4);
  tree.insert(8);
  tree.remove(9);
  tree.remove(2);
  tree.display();
}

class Node {
  Node? left;
  Node? right;
  final int value;

  Node(this.value);
}

class BinarySearchTree {
  Node? root;

  void insert(int value) {
    if (root == null) {
      root = Node(value);
      return;
    }
    Node currentNode = root!;
    while (true) {
      if (value < currentNode.value) {
        if (currentNode.left == null) {
          currentNode.left = Node(value);
          return;
        }
        currentNode = currentNode.left!;
      } else {
        if (currentNode.right == null) {
          currentNode.right = Node(value);
          return;
        }
        currentNode = currentNode.right!;
      }
    }
  }

  void lookup(int value) {
    if (root == null) {
      print('Tree is empty');
      return;
    }
    Node currentNode = root!;
    while (true) {
      if (value < currentNode.value) {
        if (currentNode.left == null) {
          print('Value not found');
          return;
        }
        currentNode = currentNode.left!;
      } else if (value > currentNode.value) {
        if (currentNode.right == null) {
          print('Value not found');
          return;
        }
        currentNode = currentNode.right!;
      } else {
        print('Value found');
        return;
      }
    }
  }

  void remove(int value) {
    if (root == null) {
      print('Tree is empty');
      return;
    }
    Node? currentNode = root!;
    Node parentNode = root!;
    bool isLeftChild = true;
    while (currentNode!.value != value) {
      parentNode = currentNode;
      if (value < currentNode.value) {
        isLeftChild = true;
        currentNode = currentNode.left!;
      } else {
        isLeftChild = false;
        currentNode = currentNode.right;
      }
      if (currentNode == null) {
        print('Value not found');
        return;
      }
    }
    if (currentNode.left == null && currentNode.right == null) {
      if (currentNode == root) {
        root = null;
      } else if (isLeftChild) {
        parentNode.left = null;
      } else {
        parentNode.right = null;
      }
    } else if (currentNode.right == null) {
      if (currentNode == root) {
        root = currentNode.left!;
      } else if (isLeftChild) {
        parentNode.left = currentNode.left;
      } else {
        parentNode.right = currentNode.left;
      }
    } else if (currentNode.left == null) {
      if (currentNode == root) {
        root = currentNode.right!;
      } else if (isLeftChild) {
        parentNode.left = currentNode.right;
      } else {
        parentNode.right = currentNode.right;
      }
    } else {
      Node successorParent = currentNode;
      Node successor2 = currentNode;
      Node? current = currentNode.right!;
      while (current != null) {
        successorParent = successor2;
        successor2 = current;
        current = current.left;
      }
      if (successor2 != currentNode.right) {
        successorParent.left = successor2.right;
        successor2.right = currentNode.right;
      }
      Node successor = successor2;
      if (currentNode == root) {
        root = successor;
      } else if (isLeftChild) {
        parentNode.left = successor;
      } else {
        parentNode.right = successor;
      }
      successor.left = currentNode.left;
    }
  }

  void display() {
    if (root == null) {
      print('Empty tree');
      return;
    }

    print('Root: ${root!.value}');
    print('Left subtree:');
    printSubtree(root!.left);
    print('Right subtree:');
    printSubtree(root!.right);
  }

  void printSubtree(Node? node) {
    if (node == null) {
      print('Empty subtree');
      return;
    }

    print(node.value);
    printSubtree(node.left);
    printSubtree(node.right);
  }
}
