// Visualize the solid of revolution and calculate its volume

import graph3;
import solids;
settings.outformat="html";

real alpha = 300;
unitsize(1cm);
currentprojection=perspective(0,0,10,up=Y);
real opacity = 0.4;
pen color = green+opacity(opacity);
//usersetting();
// let the user define functions
string s = getstring("Define f1", "2*x^2");
s = "real f1(real x){return " + s;
s += ";}";
eval(s,true);
s = getstring("Define f2", "x^3)");
s = "real f2(real x){return " + s;
s += ";}";
eval(s,true);

// get axis of rotation
string s = getstring("Axis of rotation (Upper case, no space)", "X=-1");
int input_len = length(s);
string[] b = split(s,"=");
real shift_distance = 0;

real ymargin = 1;
real xmargin = 2;

string axis_orientation = b[0];
triple axis_of_rotation = (0,0,0);
triple shift = (0,0,0);
triple negative_shift = (0,0,0);

// when the axis of rotation is not exactly the X axis or the Y axis 
if (input_len!= 1){
    shift_distance = (real) b[1];
}

if (axis_orientation== 'X'){
  axis_of_rotation = (input_len==1) ? X : Y;
  shift = (shift_distance,0,0);
  negative_shift = (-shift_distance,0,0);
}
if (axis_orientation== 'Y'){
  axis_of_rotation = (input_len==1) ? Y : X;
  shift = (0,shift_distance,0);
  negative_shift = (0,-shift_distance,0);
}

// get the upper and lower bound of x
real xmin = getreal("Lower bound", 0);
real xmax = getreal("Upper bound", 10);

// check that both functions are defined at zero
if (0>=xmin&&0<=xmax){
  assert(f1(0)!=-inf&&f1(0)!=inf, "f1 not defined at zero");
  assert(f2(0)!=-inf&&f2(0)!=inf, "f2 not defined at zero");
}

path p = graph(f1, xmin, xmax);
path q = graph(f2, xmin, xmax);
real [][] isections = intersections(p,q);

path p1 = subpath(p, isections[0][0], isections[1][0]);
path q1 = subpath(q, isections[0][1], isections[1][0]);
// get the outline of the bounded area between the two functions
path bounded = (p1 .. reverse(q1) .. cycle); // without reverse(): cycle will try to go to the beging of a path
real ymin = min(bounded).y;
path3 p3 = path3(bounded); // turn 2D path into 3D path

// perform revolution with the bounded area
revolution a=revolution(shift(negative_shift)*p3,axis_of_rotation,-alpha,0);
draw(shift(shift)*surface(a),color);
surface s=surface(p3);
draw(s,color);
draw(p3, red);

arrowbar axisarrow = Arrow(TeXHead);

xaxis3(Label("$x$"),xmin - xmargin, Arrow3);
yaxis3(Label("$y$"),ymin-ymargin,Arrow3);

write("*Solid of Revolution Visualizer Output*");
//using Simpson integration and the cylindrical shell method to calculate the volume of solid of revolution
// if the axist of rotation is Y or parallel to Y
if(axis_of_rotation == Y) {
  real fvolume(real x) {
    return 2*pi*abs(x-xpart(shift))*abs(f1(x)-f2(x));
  }

  real a = xpart(point(p,isections[0][1])); // intersections return time not point
  real b = xpart(point(p,isections[1][1]));
  write("Limits of integration:");
  write(a);
  write(b);
  real dxmax=b-a;
  real volume = simpson(fvolume, a, b, realEpsilon, dxmax);
  write("Volume:", volume);
} 
// if the axist of rotation is X or parallel to X
if(axis_of_rotation == X) {
  real fvolume(real x) {
    return pi*abs((f1(x)-ypart(shift))^2-(f2(x)-ypart(shift))^2);
  }
  real a = xpart(point(p,isections[0][1])); // intersections return time not point
  real b = xpart(point(p,isections[1][1]));
  write("Limits of integration:");
  write(a);
  write(b);
  real dxmax=b-a;
  real volume = simpson(fvolume, a, b, realEpsilon, dxmax);
  write("Volume:", volume);
}