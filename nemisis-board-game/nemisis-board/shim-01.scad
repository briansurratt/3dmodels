module shim() {
    polyhedron(
  points=[ 
  [0,0,0],   // 0
  [4,0,0],  // 1
  [1, 2, 0], // 2
  [3,2,0],  // 3
  [1,2,2], // 4
  [3,2,2], // 5
  [0,0,3],
  [4,0,3]

  ],                                  
  faces=[ 
    [0,1,2], [1,2,3], // bottom
    [2,3,4], [3,4,5],  // face
    [4,6,7], [4,5,7], // pitch
    [0,1,7], [0,6,7],  // back
    [0,2,4], [0,4,6], // left
    [1,3,5], [1,5,7] // right
    ]                         
 );
 
 }
 
 shim();
 translate([1,2,0]) cube ([2,4,2]);
 mirror ([0,1,0]) translate([0,-8,0]) shim(); 
 
 

 
   //faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],[1,0,3],[2,1,3] ]  